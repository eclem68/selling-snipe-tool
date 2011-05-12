unit uGetDetails;
interface
{$I definitions.inc}
uses
  Classes,
  SysUtils,
  TypInfo,
  Variants,
  XMLDoc,
  EbayConnect,
  CommonTypes,
  TradingServiceXMLClasses,
  IdThread,
  IdComponent,
  IdSync,
  DB,
  nxdb,
  Forms;

  type

  Operations = (OpWriteLogMes,OpIncApiUsage,OpOnSave,OpSaveLog,OpOnWork);

  TFTSync = class(TidSync)
  public
    Operation : Operations;
    Value: String;
    iVal : Integer;
    WorkMode: TWorkMode;
    procedure DoSynchronize; override;
    procedure IncApiUsage;
    procedure OnSave(Saved,Total : Integer);
    procedure OnHttpWork(AWorkMode: TWorkMode; const AWorkCount: Integer);
  end;

  TGetDetailsThread =  class(TidThread)
  private
     // Private declarations
     FForm          : TForm;
     FOperationResult : AckCodeType;
     FErrorRecord   : eBayAPIError;
     FEbayTradingConnect : TEbayTradingConnect;
     FGeteBayDetails : TGeteBayDetails;
     OpResult       : string;
     FRxDelta       : Integer;
     FTxDelta       : Integer;
     procedure SaveDetails;
     procedure SaveCountryDetails;
     procedure SaveCurrencyDetails;
     procedure SaveDispatchTimeMaxDetails;
     procedure SavePaymentOptionDetails;
     procedure SaveRegionDetails;
     procedure SaveShippingLocationDetails;
     procedure SaveShippingServiceDetails;
     procedure SaveReturnPolicyDetails;
  protected
     // Protected declarations
     //procedure SaveDetails(Category:TCatRec);
     procedure GetAllDetails;
     procedure WriteEbayApiExceptionLog(E : Exception);
     procedure GetDetailsAPIError(Sender: TObject; ErrorRecord: eBayAPIError);
     procedure GetDetailsEndRequest(Sender: TObject);
     procedure GetDetailsStartRequest(Sender: TObject);
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

     FConnectString : string;
     FDataBase      : string;
     FServer        : string;
     FUser          : string;
     FPassword      : string;

     // Objects visible outside threads
     FQuery1       : TnxQuery;
     FQuery2       : TnxQuery;

     FSyncObj : TFTSync;
     // methods
     constructor  Create(Form: TForm);
     destructor Destroy; override;
     procedure Run; override;
  end;

implementation

uses XMLIntf, uMain, functions, hotlog, ActiveX;

{ TGetCategoriesThread }

constructor TGetDetailsThread.Create(Form: TForm);
begin
  inherited Create(true);
  FForm := Form;
  FreeOnTerminate := True;
  FSyncObj := TFTSync.Create;
end;

destructor TGetDetailsThread.Destroy;
begin
  inherited;
end;

procedure TGetDetailsThread.Run;
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
    FGeteBayDetails := TGeteBayDetails.Create(nil);
    FGeteBayDetails.Connector := FEbayTradingConnect;
    FGeteBayDetails.OnAPIError := GetDetailsAPIError;
    FGeteBayDetails.OnEndRequest := GetDetailsEndRequest;
    FGeteBayDetails.OnStartRequest := GetDetailsStartRequest;
    FGeteBayDetails.OnAPIError := GetDetailsAPIError;
    FQuery1 := TnxQuery.Create(nil);
    FQuery1.Database := fmMain.nxdtbs1;
    FQuery1.Session := fmMain.nxsn1;
    FQuery1.Prepared := False;
    GetAllDetails;
  finally
    FEbayTradingConnect.Free;
    FGeteBayDetails.Free;
    FQuery1.Free;
    CoUninitialize;
  end;
  Stop;
end;

procedure TGetDetailsThread.GetAllDetails;
begin
  try
    FRxDelta := 0;
    FTxDelta := 0;
    FOperationResult := FGeteBayDetails.DoRequestEx;
    if (FOperationResult in [Success, Warning, PartialFailure]) then begin
      SaveDetails;
    end;
    if (FOperationResult in [Failure, PartialFailure]) then begin
      //GetDetailsAPIError(FGeteBayDetails.Errors);
      Exception.Create('Request Failure');
    end;
  except
    on E : Exception do WriteEbayApiExceptionLog(E);
  end;
end;

procedure TGetDetailsThread.GetDetailsAPIError(Sender: TObject;
  ErrorRecord: eBayAPIError);
begin
  with ErrorRecord  do begin
    hlog.add('{hms}: - ApiCall: GetEbayDetails. API Error');
    hlog.add(Format('Short Message %s , Error Code %s , Severity Code %s ,Error Classification %s',[ShortMessage, ErrorCode, SeverityCode, ErrorClassification]));
    hlog.add(Format('Message %s ',[LongMessage]));
  end;
  FEbayTradingConnect.RequestXMLText.SaveToFile(hLog.hlWriter.hlFileDef.path+'\Request.xml');
  hlog.Add('Request XML saved');
  FEbayTradingConnect.RequestXMLText.SaveToFile(hLog.hlWriter.hlFileDef.path+'\Response.xml');
  hlog.Add('Response XML saved');
end;

procedure TGetDetailsThread.GetDetailsEndRequest(Sender: TObject);
begin
  //FGeteBayDetails.SaveResponseXMLDoc(fmMain.BasePath+'\GeteBayDetails.xml');
  hlog.Add(Format('{hms}: ApiCall: GetEbayDetails. Result %s',[GetEnumName(TypeInfo(AckCodeType),ord(FGetEbayDetails.Ack))]));
  FSyncObj.IncApiUsage;
end;

procedure TGetDetailsThread.GetDetailsStartRequest(Sender: TObject);
begin
  hlog.Add('{hms}: ApiCall: GetEbayDetails. Start request');
end;

procedure TGetDetailsThread.SaveCountryDetails;
var i:Integer;
    sid : string;
begin
  sid := GetEnumName(TypeInfo(SiteCodeType),Ord(FGeteBayDetails.Connector.SiteID));
  hlog.Add(Format('{hms}: Start saving Country Details for site %s',[sid]));
  with FQuery1 do
  try
    SQL.Clear;
    SQL.Add('delete from CountryDetails where SiteID = :SiteID');
    Prepared := True;
    ParamByName('SiteID').DataType :=  ftString;
    ParamByName('SiteID').Value :=  GetEnumName(TypeInfo(SiteCodeType),Ord(FGeteBayDetails.Connector.SiteID));
    ExecSQL;
    SQL.Clear;
    SQL.Add('insert into CountryDetails (Code,Name,SiteID,DetailVersion) values (:Code,:Name,:SiteID,:DetailVersion)');
    Prepared := True;
    ParamByName('Code').DataType :=  ftString;
    ParamByName('Name').DataType :=  ftString;
    ParamByName('SiteID').DataType :=  ftString;
    ParamByName('DetailVersion').DataType :=  ftInteger;
    for I := 0 to FGeteBayDetails.CountryDetails.Count - 1 do begin
      ParamByName('Code').Value :=  FGeteBayDetails.CountryDetails[i].Country;
      ParamByName('Name').Value :=  FGeteBayDetails.CountryDetails[i].Description;
      ParamByName('SiteID').Value :=  sid;
      ParamByName('DetailVersion').Value :=  FGeteBayDetails.CountryDetails[i].DetailVersion;
      ExecSQL;
    end;
    hlog.Add(Format('{hms}: End saving Country Details for site %s. Saved %d',[sid,FGeteBayDetails.CountryDetails.Count]));
  except
    on E : Exception do hlog.AddException(E);
  end;
end;

procedure TGetDetailsThread.SaveCurrencyDetails;
var i:Integer;
    sid : string;
begin
  sid := GetEnumName(TypeInfo(SiteCodeType),Ord(FGeteBayDetails.Connector.SiteID));
  hlog.Add(Format('{hms}: Start saving Currency Details for site %s',[sid]));
  with FQuery1 do
  try
    SQL.Clear;
    SQL.Add('delete from CurrencyDetails where SiteID = :SiteID');
    Prepared := True;
    ParamByName('SiteID').DataType :=  ftString;
    ParamByName('SiteID').Value :=  sid;
    ExecSQL;
    SQL.Clear;
    SQL.Add('insert into CurrencyDetails (Code,Name,SiteID,DetailVersion) values (:Code,:Name,:SiteID,:DetailVersion)');
    Prepared := True;
    ParamByName('Code').DataType :=  ftString;
    ParamByName('Name').DataType :=  ftString;
    ParamByName('SiteID').DataType :=  ftString;
    ParamByName('DetailVersion').DataType :=  ftInteger;
    for I := 0 to FGeteBayDetails.CurrencyDetails.Count - 1 do begin
      ParamByName('Code').Value :=  FGeteBayDetails.CurrencyDetails[i].Currency;
      ParamByName('Name').Value :=  FGeteBayDetails.CurrencyDetails[i].Description;
      ParamByName('SiteID').Value := sid;
      ParamByName('DetailVersion').Value :=  FGeteBayDetails.CurrencyDetails[i].DetailVersion;
      ExecSQL;
    end;
    hlog.Add(Format('{hms}: End saving Currency Details for site %s. Saved %d',[sid,FGeteBayDetails.CurrencyDetails.Count]));
  except
    on E : Exception do hlog.AddException(E);
  end;
end;

procedure TGetDetailsThread.SaveDispatchTimeMaxDetails;
var i:Integer;
    sid : string;
begin
  sid := GetEnumName(TypeInfo(SiteCodeType),Ord(FGeteBayDetails.Connector.SiteID));
  hlog.Add(Format('{hms}: Start saving Dispatch Time Max Details for site %s',[sid]));
  with FQuery1 do
  try
    SQL.Clear;
    SQL.Add('delete from DispatchTimeMaxDetails where SiteID = :SiteID');
    Prepared := True;
    ParamByName('SiteID').DataType :=  ftString;
    ParamByName('SiteID').Value :=  sid;
    ExecSQL;
    SQL.Clear;
    SQL.Add('insert into DispatchTimeMaxDetails (Code,Name,SiteID,DetailVersion) values (:Code,:Name,:SiteID,:DetailVersion)');
    Prepared := True;
    ParamByName('Code').DataType :=  ftInteger;
    ParamByName('Name').DataType :=  ftString;
    ParamByName('SiteID').DataType :=  ftString;
    ParamByName('DetailVersion').DataType :=  ftInteger;
    for I := 0 to FGeteBayDetails.DispatchTimeMaxDetails.Count - 1 do begin
      ParamByName('Code').Value :=  FGeteBayDetails.DispatchTimeMaxDetails[i].DispatchTimeMax;
      ParamByName('Name').Value :=  FGeteBayDetails.DispatchTimeMaxDetails[i].Description;
      ParamByName('SiteID').Value := sid;
      ParamByName('DetailVersion').Value := FGeteBayDetails.DispatchTimeMaxDetails[i].DetailVersion;
      ExecSQL;
    end;
    hlog.Add(Format('{hms}: End saving Dispatch Time Max Details for site %s. Saved %d',[sid,FGeteBayDetails.DispatchTimeMaxDetails.Count]));
  except
    on E : Exception do hlog.AddException(E);
  end;
end;

procedure TGetDetailsThread.SavePaymentOptionDetails;
var i:Integer;
    sid : string;
begin
  sid := GetEnumName(TypeInfo(SiteCodeType),Ord(FGeteBayDetails.Connector.SiteID));
  hlog.Add(Format('{hms}: Start saving Payment Option Details for site %s',[sid]));
  with FQuery1 do
  try
    SQL.Clear;
    SQL.Add('delete from PaymentOptionDetails where SiteID = :SiteID');
    Prepared := True;
    ParamByName('SiteID').DataType :=  ftString;
    ParamByName('SiteID').Value :=  sid;
    ExecSQL;
    SQL.Clear;
    SQL.Add('insert into PaymentOptionDetails (Code,Name,SiteID,DetailVersion) values (:Code,:Name,:SiteID,:DetailVersion)');
    Prepared := True;
    ParamByName('Code').DataType :=  ftString;
    ParamByName('Name').DataType :=  ftString;
    ParamByName('SiteID').DataType :=  ftString;
    ParamByName('DetailVersion').DataType :=  ftInteger;
    for I := 0 to FGeteBayDetails.PaymentOptionDetails.Count - 1 do begin
      ParamByName('Code').Value :=  FGeteBayDetails.PaymentOptionDetails[i].PaymentOption;
      ParamByName('Name').Value :=  FGeteBayDetails.PaymentOptionDetails[i].Description;
      ParamByName('SiteID').Value := sid;
      ParamByName('DetailVersion').Value := FGeteBayDetails.PaymentOptionDetails[i].DetailVersion;
      ExecSQL;
    end;
    hlog.Add(Format('{hms}: End saving Payment Option Details for site %s. Saved %d',[sid,FGeteBayDetails.PaymentOptionDetails.Count]));
  except
    on E : Exception do hlog.AddException(E);
  end;
end;

procedure TGetDetailsThread.SaveRegionDetails;
var i:Integer;
    sid : string;
begin
  sid := GetEnumName(TypeInfo(SiteCodeType),Ord(FGeteBayDetails.Connector.SiteID));
  hlog.Add(Format('{hms}: Start saving Region Details for site %s',[sid]));
  with FQuery1 do
  try
    SQL.Clear;
    SQL.Add('delete from RegionDetails where SiteID = :SiteID');
    Prepared := True;
    ParamByName('SiteID').DataType :=  ftString;
    ParamByName('SiteID').Value :=  sid;
    ExecSQL;
    SQL.Clear;
    SQL.Add('insert into RegionDetails (Code,Name,SiteID,DetailVersion) values (:Code,:Name,:SiteID,:DetailVersion)');
    Prepared := True;
    ParamByName('Code').DataType :=  ftInteger;
    ParamByName('Name').DataType :=  ftString;
    ParamByName('SiteID').DataType :=  ftString;
    ParamByName('DetailVersion').DataType :=  ftInteger;
    for I := 0 to FGeteBayDetails.RegionDetails.Count - 1 do begin
      ParamByName('Code').Value :=  FGeteBayDetails.RegionDetails[i].RegionID;
      ParamByName('Name').Value :=  FGeteBayDetails.RegionDetails[i].Description;
      ParamByName('SiteID').Value := sid;
      ParamByName('DetailVersion').Value := FGeteBayDetails.RegionDetails[i].DetailVersion;
      ExecSQL;
    end;
    hlog.Add(Format('{hms}: End saving Region Details for site %s. Saved %d',[sid,FGeteBayDetails.RegionDetails.Count]));
  except
    on E : Exception do hlog.AddException(E);
  end;
end;

procedure TGetDetailsThread.SaveReturnPolicyDetails;
var i:Integer;
    sid : string;
begin
  sid := GetEnumName(TypeInfo(SiteCodeType),Ord(FGeteBayDetails.Connector.SiteID));
  hlog.Add(Format('{hms}: Start saving Return policy details for site %s',[sid]));
  with FQuery1 do
  try
    SQL.Clear;
    SQL.Add('delete from ReturnPolicyDetails where SiteID = :SiteID');
    Prepared := True;
    ParamByName('SiteID').DataType :=  ftString;
    ParamByName('SiteID').Value :=  sid;
    ExecSQL;
    SQL.Clear;
    SQL.Add('insert into ReturnPolicyDetails (Type,Name,Value,SiteID,Version) values (:Type,:Name,:Value,:SiteID,:DetailVersion)');
    Prepared := True;
    ParamByName('Type').DataType :=  ftString;
    ParamByName('Name').DataType :=  ftString;
    ParamByName('Value').DataType :=  ftString;
    ParamByName('SiteID').DataType :=  ftString;
    ParamByName('DetailVersion').DataType :=  ftInteger;

    ParamByName('DetailVersion').Value := StrToInt(FGeteBayDetails.ReturnPolicyDetails.DetailVersion);

    for I := 0 to FGeteBayDetails.ReturnPolicyDetails.Refund.Count - 1 do begin
      ParamByName('Type').Value :=  'Refund';
      ParamByName('Name').Value :=  FGeteBayDetails.ReturnPolicyDetails.Refund[i].Description;
      ParamByName('Value').Value :=  FGeteBayDetails.ReturnPolicyDetails.Refund[i].RefundOption;
      ParamByName('SiteID').Value := sid;
      ExecSQL;
    end;
    hlog.Add(Format('{hms}: End saving Refund of Return policy details for site %s. Saved %d',[sid,FGeteBayDetails.ReturnPolicyDetails.Refund.Count]));

    for I := 0 to FGeteBayDetails.ReturnPolicyDetails.ReturnsWithin.Count - 1 do begin
      ParamByName('Type').Value :=  'ReturnsWithin';
      ParamByName('Name').Value :=  FGeteBayDetails.ReturnPolicyDetails.ReturnsWithin[i].Description;
      ParamByName('Value').Value :=  FGeteBayDetails.ReturnPolicyDetails.ReturnsWithin[i].ReturnsWithinOption;
      ParamByName('SiteID').Value := sid;
      ExecSQL;
    end;
    hlog.Add(Format('{hms}: End saving ReturnsWithin of Return policy details for site %s. Saved %d',[sid,FGeteBayDetails.ReturnPolicyDetails.ReturnsWithin.Count]));

    for I := 0 to FGeteBayDetails.ReturnPolicyDetails.ReturnsAccepted.Count - 1 do begin
      ParamByName('Type').Value :=  'ReturnsAccepted';
      ParamByName('Name').Value :=  FGeteBayDetails.ReturnPolicyDetails.ReturnsAccepted[i].Description;
      ParamByName('Value').Value :=  FGeteBayDetails.ReturnPolicyDetails.ReturnsAccepted[i].ReturnsAcceptedOption;
      ParamByName('SiteID').Value := sid;
      ExecSQL;
    end;
    hlog.Add(Format('{hms}: End saving ReturnsAccepted of Return policy details for site %s. Saved %d',[sid,FGeteBayDetails.ReturnPolicyDetails.ReturnsAccepted.Count]));

    for I := 0 to FGeteBayDetails.ReturnPolicyDetails.ShippingCostPaidBy.Count - 1 do begin
      ParamByName('Type').Value :=  'ShippingCostPaidBy';
      ParamByName('Name').Value :=  FGeteBayDetails.ReturnPolicyDetails.ShippingCostPaidBy[i].Description;
      ParamByName('Value').Value :=  FGeteBayDetails.ReturnPolicyDetails.ShippingCostPaidBy[i].ShippingCostPaidByOption;
      ParamByName('SiteID').Value := sid;
      ExecSQL;
    end;
    hlog.Add(Format('{hms}: End saving ShippingCostPaidBy of Return policy details for site %s. Saved %d',[sid,FGeteBayDetails.ReturnPolicyDetails.ShippingCostPaidBy.Count]));

  except
    on E : Exception do hlog.AddException(E);
  end;
end;

procedure TGetDetailsThread.SaveShippingLocationDetails;
var i:Integer;
    sid : string;
begin
  sid := GetEnumName(TypeInfo(SiteCodeType),Ord(FGeteBayDetails.Connector.SiteID));
  hlog.Add(Format('{hms}: Start saving Shipping Location Details for site %s',[sid]));
  with FQuery1 do
  try
    SQL.Clear;
    SQL.Add('delete from ShippingLocationDetails where SiteID = :SiteID');
    Prepared := True;
    ParamByName('SiteID').DataType :=  ftString;
    ParamByName('SiteID').Value :=  sid;
    ExecSQL;
    SQL.Clear;
    SQL.Add('insert into ShippingLocationDetails (Code,Name,SiteID,DetailVersion) values (:Code,:Name,:SiteID,:DetailVersion)');
    Prepared := True;
    ParamByName('Code').DataType :=  ftString;
    ParamByName('Name').DataType :=  ftString;
    ParamByName('SiteID').DataType :=  ftString;
    ParamByName('DetailVersion').DataType :=  ftInteger;
    for I := 0 to FGeteBayDetails.ShippingLocationDetails.Count - 1 do begin
      ParamByName('Code').Value :=  FGeteBayDetails.ShippingLocationDetails[i].ShippingLocation;
      ParamByName('Name').Value :=  FGeteBayDetails.ShippingLocationDetails[i].Description;
      ParamByName('SiteID').Value := sid;
      ParamByName('DetailVersion').Value := FGeteBayDetails.ShippingLocationDetails[i].DetailVersion;
      ExecSQL;
    end;
    hlog.Add(Format('{hms}: End saving Shipping Location Details for site %s. Saved %d',[sid,FGeteBayDetails.ShippingLocationDetails.Count]));
  except
    on E : Exception do hlog.AddException(E);
  end;
end;

procedure TGetDetailsThread.SaveShippingServiceDetails;
var i,j:Integer;
    sid : string;
begin
  sid := GetEnumName(TypeInfo(SiteCodeType),Ord(FGeteBayDetails.Connector.SiteID));
  hlog.Add(Format('{hms}: Start saving Shipping Services Details for site %s',[sid]));
  with FQuery1 do
  try
    SQL.Clear;
    SQL.Add('delete from ShippingServiceDetails where SiteID = :SiteID');
    Prepared := True;
    ParamByName('SiteID').DataType :=  ftString;
    ParamByName('SiteID').Value :=  sid;
    ExecSQL;
    SQL.Clear;
    SQL.Add(' insert into ShippingServiceDetails (ShippingServiceID , ShippingService , Description , ShippingTimeMax ,');
    SQL.Add(' InternationalService, ShippingTimeMin, ServiceTypeFlat , ServiceTypeCalculated , DetailVersion , SiteID)');
    SQL.Add(' values (:ShippingServiceID , :ShippingService , :Description , :ShippingTimeMax ,');
    SQL.Add(' :InternationalService , :ShippingTimeMin , :ServiceTypeFlat , :ServiceTypeCalculated , :DetailVersion , :SiteID )');
    Prepared := True;
    ParamByName('ShippingServiceID').DataType :=  ftInteger;
    ParamByName('ShippingService').DataType :=  ftString;
    ParamByName('Description').DataType :=  ftString;
    ParamByName('ShippingTimeMax').DataType :=  ftInteger;
    ParamByName('ShippingTimeMin').DataType :=  ftInteger;
    ParamByName('InternationalService').DataType :=  ftBoolean;
    ParamByName('ServiceTypeFlat').DataType :=  ftBoolean;
    ParamByName('ServiceTypeCalculated').DataType :=  ftBoolean;
    ParamByName('DetailVersion').DataType :=  ftInteger;
    ParamByName('SiteID').Value := sid;
    for I := 0 to FGeteBayDetails.ShippingServiceDetails.Count - 1 do begin
      ParamByName('ShippingServiceID').Value :=  FGeteBayDetails.ShippingServiceDetails[i].ShippingServiceID;
      ParamByName('ShippingService').Value :=  FGeteBayDetails.ShippingServiceDetails[i].ShippingService;
      ParamByName('Description').Value := FGeteBayDetails.ShippingServiceDetails[i].Description;
      if FGeteBayDetails.ShippingServiceDetails[i].ChildNodes.FindNode('ShippingTimeMax')<>nil
      then ParamByName('ShippingTimeMax').Value := FGeteBayDetails.ShippingServiceDetails[i].ShippingTimeMax
      else ParamByName('ShippingTimeMax').Value := null;
      if FGeteBayDetails.ShippingServiceDetails[i].ChildNodes.FindNode('ShippingTimeMin')<>nil
      then ParamByName('ShippingTimeMin').Value :=  FGeteBayDetails.ShippingServiceDetails[i].ShippingTimeMin
      else ParamByName('ShippingTimeMin').Value := null;
      if FGeteBayDetails.ShippingServiceDetails[i].ChildNodes.FindNode('InternationalService')<>nil
      then ParamByName('InternationalService').Value :=  FGeteBayDetails.ShippingServiceDetails[i].InternationalService
      else ParamByName('InternationalService').Value := False;
      ParamByName('ServiceTypeFlat').Value :=  False;
      ParamByName('ServiceTypeCalculated').Value :=  False;
      for J := 0 to FGeteBayDetails.ShippingServiceDetails[i].ServiceType.Count - 1 do begin
        if FGeteBayDetails.ShippingServiceDetails[i].ServiceType.Items[j]='Flat' then begin
          ParamByName('ServiceTypeFlat').Value :=  True;
        end;
        if FGeteBayDetails.ShippingServiceDetails[i].ServiceType.Items[j]='Calculated' then begin
          ParamByName('ServiceTypeCalculated').Value :=  True;
        end;
      end;
      ParamByName('DetailVersion').Value := FGeteBayDetails.ShippingServiceDetails[i].DetailVersion;
      ParamByName('SiteID').Value := sid;
      ExecSQL;
    end;
    hlog.Add(Format('{hms}: End saving Shipping Services Details for site %s. Saved %d',[sid,FGeteBayDetails.ShippingServiceDetails.Count]));
  except
    on E : Exception do hlog.AddException(E);
  end;
end;

procedure TGetDetailsThread.SaveDetails;
var Operation : string;
begin
  try
    Operation := 'SaveCountryDetails';
    SaveCountryDetails;
    Operation := 'SaveCurrencyDetails';
    SaveCurrencyDetails;
    Operation := 'SaveDispatchTimeMaxDetails';
    SaveDispatchTimeMaxDetails;
    Operation := 'SavePaymentOptionDetails';
    SavePaymentOptionDetails;
    Operation := 'SaveRegionDetails';
    SaveRegionDetails;
    Operation := 'SaveShippingLocationDetails';
    SaveShippingLocationDetails;
    Operation := 'SaveShippingServiceDetails';
    SaveShippingServiceDetails;
    Operation := 'SaveReturnPolicyDetails';
    SaveReturnPolicyDetails;
  except
    on E : Exception do begin
      hlog.AddException(E);
      hlog.Add(Format('{hms}: Operation %s',[Operation]));
    end;
  end;
end;

procedure TGetDetailsThread.WriteEbayApiExceptionLog(E : Exception);
begin
  hlog.AddException(E);
  FEbayTradingConnect.RequestXMLText.SaveToFile(hLog.hlWriter.hlFileDef.path+'\Request.xml');
  hlog.Add('Request XML saved');
  FEbayTradingConnect.RequestXMLText.SaveToFile(hLog.hlWriter.hlFileDef.path+'\Response.xml');
  hlog.Add('Response XML saved');
end;

procedure TGetDetailsThread.EbayTradingConnectWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
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
