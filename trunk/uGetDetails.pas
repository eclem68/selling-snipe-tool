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
    procedure WriteLog(Logmessage: string);
    procedure IncApiUsage;
    procedure OnSave(Saved,Total : Integer);
    procedure SaveLog;
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
     procedure WriteExceptionLog(E : Exception);
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

uses XMLIntf, uMain, functions, uLog, ActiveX;

{ TGetCategoriesThread }

constructor TGetDetailsThread.Create(Form: TForm);
begin
  inherited Create(true);
  FForm := Form;
  FreeOnTerminate := True;
  FSyncObj := TFTSync.Create(Self);
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
    FGeteBayDetails := TGeteBayDetails.Create(nil);
    FGeteBayDetails.Connector := FEbayTradingConnect;
    FGeteBayDetails.OnAPIError := GetDetailsAPIError;
    FGeteBayDetails.OnEndRequest := GetDetailsEndRequest;
    FGeteBayDetails.OnStartRequest := GetDetailsStartRequest;
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
      Exception.Create('Request Failure');
    end;
  except
    on E : Exception do WriteEbayApiExceptionLog(E);
  end;
end;

procedure TGetDetailsThread.GetDetailsAPIError(Sender: TObject;
  ErrorRecord: eBayAPIError);
var i : Integer;
begin
  with ErrorRecord , FSyncObj do begin
    WriteLog(Format('ThreadID %d - ApiCall: GetEbayDetails. API Error',[Self.ThreadID]));
    WriteLog(Format('Short Message %s , Error Code %s , Severity Code %s ,Error Classification %s',[ShortMessage, ErrorCode, SeverityCode, ErrorClassification]));
    WriteLog(Format('Message %s ',[LongMessage]));
  end;
  FSyncObj.WriteLog('Request XML');
  for i := 0 to FEbayTradingConnect.RequestXMLText.Count -1 do FSyncObj.WriteLog(FEbayTradingConnect.RequestXMLText.Strings[i]);
  FSyncObj.WriteLog('Response XML');
  for i := 0 to FEbayTradingConnect.ResponseXMLText.Count -1 do FSyncObj.WriteLog(FEbayTradingConnect.ResponseXMLText.Strings[i]);
  FSyncObj.SaveLog;
end;

procedure TGetDetailsThread.GetDetailsEndRequest(Sender: TObject);
begin
  //FGeteBayDetails.SaveResponseXMLDoc(fmMain.BasePath+'\GeteBayDetails.xml');
  FSyncObj.WriteLog(Format('ThreadID %d - ApiCall: GetEbayDetails. Result %s',[Self.ThreadID,GetEnumName(TypeInfo(AckCodeType),ord(FGetEbayDetails.Ack))]));
  FSyncObj.IncApiUsage;
end;

procedure TGetDetailsThread.GetDetailsStartRequest(Sender: TObject);
begin
  FSyncObj.WriteLog(Format('ThreadID %d - ApiCall: GetEbayDetails. Start request',[Self.ThreadID]));
end;

procedure TGetDetailsThread.SaveCountryDetails;
var i:Integer;
    sid : string;
begin
  sid := GetEnumName(TypeInfo(SiteCodeType),Ord(FGeteBayDetails.Connector.SiteID));
  FSyncObj.WriteLog(Format('Start saving Country Details for site %s',[sid]));
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
    FSyncObj.WriteLog(Format('End saving Country Details for site %s. Saved %d',[sid,FGeteBayDetails.CountryDetails.Count]));
  except
    on E : Exception do WriteExceptionLog(E);
  end;
end;

procedure TGetDetailsThread.SaveCurrencyDetails;
var i:Integer;
    sid : string;
begin
  sid := GetEnumName(TypeInfo(SiteCodeType),Ord(FGeteBayDetails.Connector.SiteID));
  FSyncObj.WriteLog(Format('Start saving Currency Details for site %s',[sid]));
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
    FSyncObj.WriteLog(Format('End saving Currency Details for site %s. Saved %d',[sid,FGeteBayDetails.CurrencyDetails.Count]));
  except
    on E : Exception do WriteExceptionLog(E);
  end;
end;

procedure TGetDetailsThread.SaveDispatchTimeMaxDetails;
var i:Integer;
    sid : string;
begin
  sid := GetEnumName(TypeInfo(SiteCodeType),Ord(FGeteBayDetails.Connector.SiteID));
  FSyncObj.WriteLog(Format('Start saving Dispatch Time Max Details for site %s',[sid]));
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
    FSyncObj.WriteLog(Format('End saving Dispatch Time Max Details for site %s. Saved %d',[sid,FGeteBayDetails.DispatchTimeMaxDetails.Count]));
  except
    on E : Exception do WriteExceptionLog(E);
  end;
end;

procedure TGetDetailsThread.SavePaymentOptionDetails;
var i:Integer;
    sid : string;
begin
  sid := GetEnumName(TypeInfo(SiteCodeType),Ord(FGeteBayDetails.Connector.SiteID));
  FSyncObj.WriteLog(Format('Start saving Payment Option Details for site %s',[sid]));
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
    FSyncObj.WriteLog(Format('End saving Payment Option Details for site %s. Saved %d',[sid,FGeteBayDetails.PaymentOptionDetails.Count]));
  except
    on E : Exception do WriteExceptionLog(E);
  end;
end;

procedure TGetDetailsThread.SaveRegionDetails;
var i:Integer;
    sid : string;
begin
  sid := GetEnumName(TypeInfo(SiteCodeType),Ord(FGeteBayDetails.Connector.SiteID));
  FSyncObj.WriteLog(Format('Start saving Region Details for site %s',[sid]));
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
    FSyncObj.WriteLog(Format('End saving Region Details for site %s. Saved %d',[sid,FGeteBayDetails.RegionDetails.Count]));
  except
    on E : Exception do WriteExceptionLog(E);
  end;
end;

procedure TGetDetailsThread.SaveReturnPolicyDetails;
var i:Integer;
    sid : string;
begin
  sid := GetEnumName(TypeInfo(SiteCodeType),Ord(FGeteBayDetails.Connector.SiteID));
  FSyncObj.WriteLog(Format('Start saving Return policy details for site %s',[sid]));
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
    FSyncObj.WriteLog(Format('End saving Refund of Return policy details for site %s. Saved %d',[sid,FGeteBayDetails.ReturnPolicyDetails.Refund.Count]));

    for I := 0 to FGeteBayDetails.ReturnPolicyDetails.ReturnsWithin.Count - 1 do begin
      ParamByName('Type').Value :=  'ReturnsWithin';
      ParamByName('Name').Value :=  FGeteBayDetails.ReturnPolicyDetails.ReturnsWithin[i].Description;
      ParamByName('Value').Value :=  FGeteBayDetails.ReturnPolicyDetails.ReturnsWithin[i].ReturnsWithinOption;
      ParamByName('SiteID').Value := sid;
      ExecSQL;
    end;
    FSyncObj.WriteLog(Format('End saving ReturnsWithin of Return policy details for site %s. Saved %d',[sid,FGeteBayDetails.ReturnPolicyDetails.ReturnsWithin.Count]));

    for I := 0 to FGeteBayDetails.ReturnPolicyDetails.ReturnsAccepted.Count - 1 do begin
      ParamByName('Type').Value :=  'ReturnsAccepted';
      ParamByName('Name').Value :=  FGeteBayDetails.ReturnPolicyDetails.ReturnsAccepted[i].Description;
      ParamByName('Value').Value :=  FGeteBayDetails.ReturnPolicyDetails.ReturnsAccepted[i].ReturnsAcceptedOption;
      ParamByName('SiteID').Value := sid;
      ExecSQL;
    end;
    FSyncObj.WriteLog(Format('End saving ReturnsAccepted of Return policy details for site %s. Saved %d',[sid,FGeteBayDetails.ReturnPolicyDetails.ReturnsAccepted.Count]));

    for I := 0 to FGeteBayDetails.ReturnPolicyDetails.ShippingCostPaidBy.Count - 1 do begin
      ParamByName('Type').Value :=  'ShippingCostPaidBy';
      ParamByName('Name').Value :=  FGeteBayDetails.ReturnPolicyDetails.ShippingCostPaidBy[i].Description;
      ParamByName('Value').Value :=  FGeteBayDetails.ReturnPolicyDetails.ShippingCostPaidBy[i].ShippingCostPaidByOption;
      ParamByName('SiteID').Value := sid;
      ExecSQL;
    end;
    FSyncObj.WriteLog(Format('End saving ShippingCostPaidBy of Return policy details for site %s. Saved %d',[sid,FGeteBayDetails.ReturnPolicyDetails.ShippingCostPaidBy.Count]));

  except
    on E : Exception do WriteExceptionLog(E);
  end;
end;

procedure TGetDetailsThread.SaveShippingLocationDetails;
var i:Integer;
    sid : string;
begin
  sid := GetEnumName(TypeInfo(SiteCodeType),Ord(FGeteBayDetails.Connector.SiteID));
  FSyncObj.WriteLog(Format('Start saving Shipping Location Details for site %s',[sid]));
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
    FSyncObj.WriteLog(Format('End saving Shipping Location Details for site %s. Saved %d',[sid,FGeteBayDetails.ShippingLocationDetails.Count]));
  except
    on E : Exception do WriteExceptionLog(E);
  end;
end;

procedure TGetDetailsThread.SaveShippingServiceDetails;
var i,j:Integer;
    sid : string;
begin
  sid := GetEnumName(TypeInfo(SiteCodeType),Ord(FGeteBayDetails.Connector.SiteID));
  FSyncObj.WriteLog(Format('Start saving Shipping Services Details for site %s',[sid]));
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
    FSyncObj.WriteLog(Format('End saving Shipping Services Details for site %s. Saved %d',[sid,FGeteBayDetails.ShippingServiceDetails.Count]));
  except
    on E : Exception do WriteExceptionLog(E);
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
      WriteExceptionLog(E);
      FSyncObj.WriteLog(Format('Operation %s',[Operation]));
    end;
  end;
end;

procedure TGetDetailsThread.WriteEbayApiExceptionLog(E : Exception);
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

procedure TGetDetailsThread.WriteExceptionLog(E: Exception);
begin
  with FSyncObj do begin
    WriteLog(Format('%s: ThreadID %d Exception',[DateTimeToStr(now),Self.ThreadID]));
    WriteLog(Format('Exception class name: %s',[E.ClassName]));
    WriteLog(Format('Exception message: %s',[E.Message]));
    SaveLog;
  end;
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
