unit uGetCategories;
interface
{$I definitions.inc}
uses
  Classes,
  SysUtils,
  TypInfo,
  Variants,
  XMLDoc,
  EbayConnect,
  IdThread,
  IdComponent,
  IdSync,
  DB,
  nxdb,
  Forms;

  type

  TCatRec = record
    CategoryID : string;
    CategoryLevel : Integer;
    CategoryName: string;
    CategoryParentID : string;
    LeafCategory : Boolean;
    CategoryID_d : Integer;
    CategoryParentID_d : Integer;
  end;

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

  TGetCategoriesThread =  class(TidThread)
  private
     // Private declarations
     FForm          : TForm;
     FOperationResult : AckCodeType;
     FErrorRecord   : eBayAPIError;
     FEbayTradingConnect : TEbayTradingConnect;
     OpResult       : string;
     FCategory      : TCatRec;
     FSavedCategoriesCnt : Integer;
     FRxDelta       : Integer;
     FTxDelta       : Integer;
     CatCount : Integer;
  protected
     // Protected declarations
     procedure SaveCategory(Category:TCatRec);
     procedure GetAllCategories;
     procedure WriteEbayApiExceptionLog(E : Exception);
     procedure WriteExceptionLog(E : Exception);
     procedure EbayTradingConnectWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
  public
     // Public declarations
     FDevID         : ShortString;
     FAppID         : ShortString;
     FCertID        : ShortString;
     FToken         : WideString;
     FSiteID        : SiteCodeType;

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

constructor TGetCategoriesThread.Create(Form: TForm);
begin
  inherited Create(true);
  FForm := Form;
  FreeOnTerminate := True;
  FSyncObj := TFTSync.Create(Self);
end;

destructor TGetCategoriesThread.Destroy;
begin
  inherited;
end;

procedure TGetCategoriesThread.Run;
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
    FQuery1 := TnxQuery.Create(nil);
    FQuery2 := TnxQuery.Create(nil);
    FQuery1.Database := fmMain.nxdtbs1;
    FQuery2.Database := fmMain.nxdtbs1;
    FQuery1.Session := fmMain.nxsn1;
    FQuery2.Session := fmMain.nxsn1;
    FQuery1.Prepared := False;
    FQuery1.SQL.Clear;
    FQuery1.SQL.Add(' insert into categories (CategoryID,  CategoryLevel, CategoryName, CategoryParentID, LeafCategory, SiteCode) ');
    FQuery1.SQL.Add(' values (:CategoryID, :CategoryLevel, :CategoryName, :CategoryParentID, :LeafCategory, :SiteCode)');
    FQuery1.Prepared := True;
    FQuery1.ParamByName('CategoryID').DataType := ftInteger;
    FQuery1.ParamByName('CategoryLevel').DataType := ftInteger;
    FQuery1.ParamByName('CategoryName').DataType := ftString;
    FQuery1.ParamByName('CategoryParentID').DataType := ftInteger;
    FQuery1.ParamByName('LeafCategory').DataType := ftBoolean;
    FQuery1.ParamByName('SiteCode').DataType := ftString;
    FQuery2.Prepared := False;
    FQuery2.SQL.Clear;
    FQuery2.SQL.Add('select count(*) as cnt from categories where CategoryID=:CategoryID and SiteCode=:SiteCode');
    FQuery2.ParamByName('CategoryID').DataType  := ftString;
    FQuery2.ParamByName('SiteCode').DataType  := ftString;
    FQuery2.Prepared := True;
    GetAllCategories;
  finally
    FEbayTradingConnect.Free;
    FQuery1.Free;
    FQuery2.Free;
    CoUninitialize;
  end;
  //SplashScreen.btn1.Click;
  Stop;
end;

procedure TGetCategoriesThread.GetAllCategories;
var Request, Response : TMemoryStream;
    CXMLDoc : TXMLDocument;
    i : Integer;
    CatNode : IXMLNode;
    TMPStringList : TStringList;
begin
  try
    Request:=TMemoryStream.Create;
    Response:=TMemoryStream.Create;
    CXMLDoc := TXMLDocument.Create(FForm);
    TMPStringList := TStringList.Create;
    TMPStringList.LoadFromFile(FBasePath+'\StoredXML\GetCategories.xml');
    i := FEbayTradingConnect.GetSiteIDNum(FSiteID);
    TMPStringList.Text := StringReplace(TMPStringList.Text,'#CSID',IntToStr(i),[]);
    //Format(TMPStringList.Text,[i]);
    TMPStringList.SaveToStream(Request);
    Request.Seek(0,soFromBeginning);
    try
      FSyncObj.WriteLog(Format('%s: Request Start',[DateTimeToStr(now)]));
      FRxDelta := 0;
      FTxDelta := 0;
      FEbayTradingConnect.ExecuteRequest(Request,Response);
      FSyncObj.WriteLog(Format('%s: Response received',[DateTimeToStr(now)]));
      FSyncObj.IncApiUsage;
    except
      on E : Exception do WriteEbayApiExceptionLog(E);
    end;
    Response.Seek(0,soFromBeginning);
    CXMLDoc.XML.LoadFromStream(Response);
    CXMLDoc.Active := True;
    //CXMLDoc.SaveToFile('GetCatRes.xml');
    OpResult := CXMLDoc.DocumentElement.ChildNodes.FindNode('Ack').NodeValue;
    if OpResult = 'Success' then
    try
      FCategoryVersion := CXMLDoc.DocumentElement.ChildNodes.Nodes['CategoryVersion'].NodeValue;
      CatCount := CXMLDoc.DocumentElement.ChildNodes.Nodes['CategoryArray'].ChildNodes.Count;
      FSyncObj.WriteLog(Format('%s: Categories downloaded - %s : %d ',[DateTimeToStr(now),OpResult,CatCount]));
      if CatCount >0 then begin
        FSavedCategoriesCnt := 0;
        FSyncObj.OnSave(FSavedCategoriesCnt,CatCount);
        for i :=0 to CatCount-1 do
        begin
          CatNode := CXMLDoc.DocumentElement.ChildNodes.Nodes['CategoryArray'].ChildNodes.Get(i);
          FCategory.CategoryID := CatNode.ChildNodes.Nodes['CategoryID'].NodeValue;
          FCategory.CategoryLevel := CatNode.ChildNodes.Nodes['CategoryLevel'].NodeValue;
          FCategory.CategoryName := CatNode.ChildNodes.Nodes['CategoryName'].NodeValue;
          FCategory.CategoryParentID := CatNode.ChildNodes.Nodes['CategoryParentID'].NodeValue;
          if FCategory.CategoryLevel = 1 then FCategory.CategoryParentID := '-1';
          if CatNode.ChildNodes.Nodes['LeafCategory']<> nil then
            if CatNode.ChildNodes.Nodes['LeafCategory'].NodeValue = 'true'
              then FCategory.LeafCategory := true
              else FCategory.LeafCategory := false
          else FCategory.LeafCategory := null;
          SaveCategory(FCategory);
        end;
        FSyncObj.WriteLog(Format('%s: Categories Saved - %d',[DateTimeToStr(now),FSavedCategoriesCnt]));
        FSyncObj.OnSave(FSavedCategoriesCnt,CatCount);
      end;
    except
      on E : Exception do  WriteExceptionLog(E);
    end
    else FSyncObj.WriteLog(Format('%s: Categories downloaded - %s',[DateTimeToStr(now),OpResult]));
    FSyncObj.IncApiUsage;
    CXMLDoc.Active := false;
  finally
    if CXMLDoc <> nil then CXMLDoc.Free;
    if Request <> nil then Request.Free;
    if Response <> nil then Response.Free;
    if TMPStringList <> nil then TMPStringList.Free;
  end;
end;

procedure TGetCategoriesThread.SaveCategory(Category:TCatRec);
//var cnt : Integer;
begin
  try
    with FQuery1 , Category do
    begin
      ParamByName('CategoryID').Value :=  StrToInt(CategoryID);
      ParamByName('CategoryLevel').Value :=  CategoryLevel;
      ParamByName('CategoryName').Value :=  CategoryName;
      ParamByName('CategoryParentID').Value :=  StrToInt(CategoryParentID);
      ParamByName('LeafCategory').Value :=  LeafCategory;
      ParamByName('SiteCode').Value :=  GetEnumName(TypeInfo(SiteCodeType),ord(FSiteID));
      FQuery1.ExecSQL;
      inc(FSavedCategoriesCnt);
      if (FSavedCategoriesCnt mod 100) = 0 then FSyncObj.OnSave(FSavedCategoriesCnt,CatCount);
    end;
  except
    on E : Exception do with Category do begin
      WriteExceptionLog(E);
      FSyncObj.WriteLog(Format('CategoryID %s',[CategoryID]));
      FSyncObj.WriteLog(Format('CategoryLevel %d',[CategoryLevel]));
      FSyncObj.WriteLog(Format('CategoryName %s',[CategoryName]));
      FSyncObj.WriteLog(Format('CategoryParentID %s',[CategoryParentID]));
      FSyncObj.WriteLog(Format('SiteCode %s',[GetEnumName(TypeInfo(SiteCodeType),ord(FSiteID))]));
    end;
  end;
end;

procedure TGetCategoriesThread.WriteEbayApiExceptionLog(E : Exception);
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

procedure TGetCategoriesThread.WriteExceptionLog(E: Exception);
begin
  with FSyncObj do begin
    WriteLog(Format('%s: ThreadID %d Exception',[DateTimeToStr(now),Self.ThreadID]));
    WriteLog(Format('Exception class name: %s',[E.ClassName]));
    WriteLog(Format('Exception message: %s',[E.Message]));
    SaveLog;
  end;
end;

procedure TGetCategoriesThread.EbayTradingConnectWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
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
