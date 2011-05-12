unit uGetSuggestedCategories;
interface
{$I definitions.inc}
uses
  Classes,
  SysUtils,
  TypInfo,
  Variants,
  XMLDoc,
  EbayConnect,
  TradingServiceXMLClasses,
  IdThread,
  IdComponent,
  IdSync,
  DB,
  nxdb,
  Forms,
  TradingService,
  CommonTypes;

  type

  Operations = (OpWriteLogMes,OpIncApiUsage,OpOnSave,OpSaveLog,OpOnWork,OpOnShowResult);

  TFTSync = class(TidSync)
  public
    Operation : Operations;
    Value: String;
    SCArray : IXMLSuggestedCategoryArrayType;
    iVal : Integer;
    WorkMode: TWorkMode;
    procedure DoSynchronize; override;
    procedure IncApiUsage;
    procedure OnSave(Saved,Total : Integer);
    procedure OnHttpWork(AWorkMode: TWorkMode; const AWorkCount: Integer);
  end;

  TGetSuggestedCategoriesThread =  class(TidThread)
  private
     // Private declarations
     FForm          : TForm;
     FOperationResult : AckCodeType;
     FErrorRecord   : eBayAPIError;
     FEbayTradingConnect : TEbayTradingConnect;
     FGetSuggestedCategories : TGetSuggestedCategories;
     OpResult       : string;
     FRxDelta       : Integer;
     FTxDelta       : Integer;
  protected
     // Protected declarations
     //procedure SaveDetails(Category:TCatRec);
     procedure GetSuggestedCategoryArray;
     procedure WriteEbayApiExceptionLog(E : Exception);
     procedure GetSuggestedCategoriesAPIError(Sender: TObject; ErrorRecord: eBayAPIError);
     procedure GetSuggestedCategoriesEndRequest(Sender: TObject);
     procedure GetSuggestedCategoriesStartRequest(Sender: TObject);
     procedure EbayTradingConnectWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
  public
     // Public declarations
     FDevID         : ShortString;
     FAppID         : ShortString;
     FCertID        : ShortString;
     FToken         : WideString;
     FSiteID        : SiteCodeType;
     FGlobalSiteID  : Global_ID;

     FHost           : ShortString; // 'api.ebay.com';
     FServiceURL     : ShortString; // 'https://api.ebay.com/ws/api.dll';
     FSSLCertFile    : ShortString; // 'test_b_crt.pem';
     FSSLKeyFile     : ShortString; // 'test_b_key.pem';
     FSSLRootCertFile: ShortString; // 'test_b_ca.pem';
     FSSLPassword    : ShortString; // 'aaaa';

     FCategoryVersion : Integer;

     FBasePath      : string;
     FQuery         : string;

     FConnectString : string;
     FDataBase      : string;
     FServer        : string;
     FUser          : string;
     FPassword      : string;

     SuggestedCategoryArray : IXMLSuggestedCategoryArrayType;

     FSyncObj : TFTSync;
     // methods
     constructor  Create(Form: TForm);
     destructor Destroy; override;
     procedure Run; override;
  end;

implementation

uses XMLIntf, uMain, functions, HotLog, ActiveX, uItemEditor;

{ TGetCategoriesThread }

constructor TGetSuggestedCategoriesThread.Create(Form: TForm);
begin
  inherited Create(true);
  FForm := Form;
  FreeOnTerminate := True;
  FSyncObj := TFTSync.Create;
end;

destructor TGetSuggestedCategoriesThread.Destroy;
begin
  inherited;
end;

procedure TGetSuggestedCategoriesThread.Run;
var hr: HRESULT;
begin
  inherited;
  try
    hr := CoInitializeEx(nil, COINIT_APARTMENTTHREADED);
    FEbayTradingConnect := TEbayTradingConnect.Create(nil);
    with FEbayTradingConnect do begin
      Host := FHost;
      ServiceURL := FServiceURL;
      SSLCertFile := FSSLCertFile;
      SSLKeyFile := FSSLKeyFile;
      SSLRootCertFile := FSSLRootCertFile;
      SSLPassword := FSSLPassword;
      SiteID := FSiteID;
      AppID := FAppID;
      DevID := FDevID;
      CertID := FCertID;
      Token := FToken;
      OnWork := EbayTradingConnectWork;
    end;
    FGetSuggestedCategories := TGetSuggestedCategories.Create(nil);
    FGetSuggestedCategories.Connector := FEbayTradingConnect;
    FGetSuggestedCategories.OnAPIError := GetSuggestedCategoriesAPIError;
    FGetSuggestedCategories.OnEndRequest := GetSuggestedCategoriesEndRequest;
    FGetSuggestedCategories.OnStartRequest := GetSuggestedCategoriesStartRequest;
    FGetSuggestedCategories.Query := FQuery;
    GetSuggestedCategoryArray;
  finally
    FEbayTradingConnect.Free;
    FGetSuggestedCategories.Free;
    CoUninitialize;
  end;
  Stop;
end;

procedure TGetSuggestedCategoriesThread.GetSuggestedCategoryArray;
begin
  try
    FRxDelta := 0;
    FTxDelta := 0;
    FOperationResult := FGetSuggestedCategories.DoRequestEx;
    if (FOperationResult in [Success, Warning, PartialFailure]) then begin
      SuggestedCategoryArray := FGetSuggestedCategories.SuggestedCategoryArray;
    end;
    if (FOperationResult in [Failure, PartialFailure]) then begin
      Exception.Create('Request Failure');
    end;
  except
    on E : Exception do WriteEbayApiExceptionLog(E);
  end;
end;

procedure TGetSuggestedCategoriesThread.GetSuggestedCategoriesAPIError(Sender: TObject;
  ErrorRecord: eBayAPIError);
var i : Integer;
begin
  with ErrorRecord , FSyncObj do begin
    hlog.Add('{hms}: ApiCall: GetSuggestedCategories. API Error');
    hlog.Add(Format('Short Message %s , Error Code %s , Severity Code %s ,Error Classification %s',[ShortMessage, ErrorCode, SeverityCode, ErrorClassification]));
    hlog.Add(Format('Message %s ',[LongMessage]));
  end;
  FEbayTradingConnect.RequestXMLText.SaveToFile(hLog.hlWriter.hlFileDef.path+'\Request.xml');
  hlog.Add('Request XML saved');
  FEbayTradingConnect.RequestXMLText.SaveToFile(hLog.hlWriter.hlFileDef.path+'\Response.xml');
  hlog.Add('Response XML saved');
end;

procedure TGetSuggestedCategoriesThread.GetSuggestedCategoriesEndRequest(Sender: TObject);
begin
  FGetSuggestedCategories.SaveResponseXMLDoc(fmMain.BasePath+'\GetSuggestedCategories.xml');
  hlog.Add(Format('{hms}: ApiCall: GetSuggestedCategories. Result %s',[GetEnumName(TypeInfo(AckCodeType),ord(FGetSuggestedCategories.Ack))]));
  FSyncObj.IncApiUsage;
end;

procedure TGetSuggestedCategoriesThread.GetSuggestedCategoriesStartRequest(Sender: TObject);
begin
  hLog.Add('{hms}: ApiCall: GetSuggestedCategories. Start request');
end;

procedure TGetSuggestedCategoriesThread.WriteEbayApiExceptionLog(E : Exception);
begin
  hlog.add('{hms}: - ApiCall: GetSuggestedCategories. API Error');
  hLog.AddException(E);
  FEbayTradingConnect.RequestXMLText.SaveToFile(hLog.hlWriter.hlFileDef.path+'\Request.xml');
  hlog.Add('Request XML saved');
  FEbayTradingConnect.RequestXMLText.SaveToFile(hLog.hlWriter.hlFileDef.path+'\Response.xml');
  hlog.Add('Response XML saved');
end;

procedure TGetSuggestedCategoriesThread.EbayTradingConnectWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
begin
  case AWorkMode of
  wmRead  : begin
    FSyncObj.OnHttpWork(AWorkMode,AWorkCount-FRxDelta);
    FRxDelta := AWorkCount;
  end;
  wmWrite : begin
    FSyncObj.OnHttpWork(AWorkMode,AWorkCount-FTxDelta);
    FTxDelta := AWorkCount;
  end;
  end;
end;

{ TFTSync }

procedure TFTSync.DoSynchronize;
begin
  inherited;
  case Operation of
    OpIncApiUsage : fmMain.IncApiUsage;
    OpOnSave : fmMain.dxRibbonStatusBar1.Panels[4].Text := Value;
    OpOnWork : begin
      case WorkMode of
        wmRead : begin
          fmMain.RxCounter := fmMain.RxCounter + iVal;
          fmMain.RxCounterDelta := fmMain.RxCounterDelta + iVal;
        end;
        wmWrite : begin
          fmMain.TxCounter := fmMain.TxCounter + iVal;
          fmMain.TxCounterDelta := fmMain.TxCounterDelta + iVal;
        end
      end;
    end;
  end;
end;

procedure TFTSync.IncApiUsage;
begin
  Operation := OpIncApiUsage;
  Synchronize;
end;

procedure TFTSync.OnHttpWork(AWorkMode: TWorkMode; const AWorkCount: Integer);
begin
  WorkMode := AWorkMode;
  iVal := AWorkCount;
  Operation := OpOnWork;
  Synchronize;
end;

procedure TFTSync.OnSave(Saved, Total: Integer);
begin
  Operation := OpOnSave;
  Value := Format('Saved %d of %d items',[Saved,Total]);
  Synchronize;
end;

end.
