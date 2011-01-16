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
  ebaySvc;

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
    procedure WriteLog(Logmessage: string);
    procedure IncApiUsage;
    procedure OnSave(Saved,Total : Integer);
    procedure SaveLog;
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
     procedure WriteExceptionLog(E : Exception);
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

uses XMLIntf, uMain, functions, uLog, ActiveX, uItemEditor;

{ TGetCategoriesThread }

constructor TGetSuggestedCategoriesThread.Create(Form: TForm);
begin
  inherited Create(true);
  FForm := Form;
  FreeOnTerminate := True;
  FSyncObj := TFTSync.Create(Self);
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
      Host := 'api.ebay.com';
      ServiceURL := 'https://api.ebay.com/ws/api.dll';
      SSLCertFile := 'test_b_crt.pem';
      SSLKeyFile := 'test_b_key.pem';
      SSLRootCertFile := 'test_b_ca.pem';
      SSLPassword := 'aaaa';
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
    WriteLog(Format('ThreadID %d - ApiCall: GetSuggestedCategories. API Error',[Self.ThreadID]));
    WriteLog(Format('Short Message %s , Error Code %s , Severity Code %s ,Error Classification %s',[ShortMessage, ErrorCode, SeverityCode, ErrorClassification]));
    WriteLog(Format('Message %s ',[LongMessage]));
  end;
  FSyncObj.WriteLog('Request XML');
  for i := 0 to FEbayTradingConnect.RequestXMLText.Count -1 do FSyncObj.WriteLog(FEbayTradingConnect.RequestXMLText.Strings[i]);
  FSyncObj.WriteLog('Response XML');
  for i := 0 to FEbayTradingConnect.ResponseXMLText.Count -1 do FSyncObj.WriteLog(FEbayTradingConnect.ResponseXMLText.Strings[i]);
  FSyncObj.SaveLog;
end;

procedure TGetSuggestedCategoriesThread.GetSuggestedCategoriesEndRequest(Sender: TObject);
begin
  FGetSuggestedCategories.SaveResponseXMLDoc(fmMain.BasePath+'\GetSuggestedCategories.xml');
  FSyncObj.WriteLog(Format('ThreadID %d - ApiCall: GetSuggestedCategories. Result %s',[Self.ThreadID,GetEnumName(TypeInfo(AckCodeType),ord(FGetSuggestedCategories.Ack))]));
  FSyncObj.IncApiUsage;
end;

procedure TGetSuggestedCategoriesThread.GetSuggestedCategoriesStartRequest(Sender: TObject);
begin
  FSyncObj.WriteLog(Format('ThreadID %d - ApiCall: GetSuggestedCategories. Start request',[Self.ThreadID]));
end;

procedure TGetSuggestedCategoriesThread.WriteEbayApiExceptionLog(E : Exception);
var i : Integer;
begin
  with FSyncObj do begin
    WriteLog(Format('%s: ThreadID %d Exception',[DateTimeToStr(now),Self.ThreadID]));
    WriteLog(Format('Exception class name: %s',[E.ClassName]));
    WriteLog(Format('Exception message: %s',[E.Message]));
    WriteLog('Request XML');
    for i := 0 to FEbayTradingConnect.RequestXMLText.Count -1 do WriteLog(FEbayTradingConnect.RequestXMLText.Strings[i]);
    WriteLog('Response XML');
    for i := 0 to FEbayTradingConnect.ResponseXMLText.Count -1 do WriteLog(FEbayTradingConnect.ResponseXMLText.Strings[i]);
    SaveLog;
  end;
end;

procedure TGetSuggestedCategoriesThread.WriteExceptionLog(E: Exception);
begin
  with FSyncObj do begin
    WriteLog(Format('%s: ThreadID %d Exception',[DateTimeToStr(now),Self.ThreadID]));
    WriteLog(Format('Exception class name: %s',[E.ClassName]));
    WriteLog(Format('Exception message: %s',[E.Message]));
    SaveLog;
  end;
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
    OpWriteLogMes : begin
      fmMain.WriteLog(Value);
    end;
    OpIncApiUsage : fmMain.IncApiUsage;
    OpOnSave : fmMain.dxRibbonStatusBar1.Panels[4].Text := Value;
    OpSaveLog : fmLog.AdvLogMemo.Lines.SaveToFile(fmMain.BasePath+'\log\exception.log');
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

procedure TFTSync.SaveLog;
begin
  Operation := OpSaveLog;
  Synchronize;
end;

procedure TFTSync.WriteLog(Logmessage: string);
begin
  Value := Logmessage;
  Operation := OpWriteLogMes ;
  Synchronize;
end;

end.
