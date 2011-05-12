unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dxRibbonForm, dxSkinsCore, dxSkinsdxBarPainter,
  dxSkinsDefaultPainters, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsdxRibbonPainter, dxBar, ImgList, cxClasses,
  dxRibbon, nxllComponent, nxlgEventLog, nxdb, nxsdServerEngine, nxseAllEngines,
  nxsrServerEngine, DB, uIniSettings, EbayConnect, ShoppingServiceXMLClasses,
  dxStatusBar, dxRibbonStatusBar, AdvSmoothSplashScreen, StdCtrls, Contnrs,
  nxsrSqlEngineBase, nxsqlEngine, ExtCtrls, cxStyles, dxSkinscxPCPainter,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxGridCustomView, cxGrid, CommonTypes;

type

  TOperation = (opIdle,opCheckCategories,opLoadDetails,opLoadcategories,opGetSuggestedcategories);

  TfmMain = class(TdxRibbonForm)
    dxbrmngr1: TdxBarManager;
    dxRibbon1: TdxRibbon;
    cxmglstLargeImages: TcxImageList;
    cxmglstSmallImages: TcxImageList;
    dxbrlrgbtn1: TdxBarLargeButton;
    dxbrlrgbtn2: TdxBarLargeButton;
    dxbrlrgbtn3: TdxBarLargeButton;
    dxbrmngr1Bar2: TdxBar;
    dxbrlrgbtn4: TdxBarLargeButton;
    dxrbntbRibbon1Tab2: TdxRibbonTab;
    dxrbntbRibbon1Tab4: TdxRibbonTab;
    nxdtbs1: TnxDatabase;
    nxvntlg1: TnxEventLog;
    nxtblSites: TnxTable;
    nxsn1: TnxSession;
    nxsrvrngn1: TnxServerEngine;
    dxbrmngr1Bar4: TdxBar;
    dxBarLargeButton1: TdxBarLargeButton;
    nxTable1: TnxTable;
    dxRibbon1Tab1: TdxRibbonTab;
    dxRibbon1Tab2: TdxRibbonTab;
    dxBarLargeButton2: TdxBarLargeButton;
    dxBarLargeButton3: TdxBarLargeButton;
    dxbrmngr1Bar3: TdxBar;
    dxBarLargeButton4: TdxBarLargeButton;
    EbayShoppingConnect2: TEbayShoppingConnect;
    GetCategoryInfo1: TGetCategoryInfo;
    dxRibbonStatusBar1: TdxRibbonStatusBar;
    nxsqlngn1: TnxSqlEngine;
    nxqry1: TnxQuery;
    tmrSpeed: TTimer;
    nxtblItems: TnxTable;
    dsItems: TDataSource;
    dxbrmngr1Bar5: TdxBar;
    dxbrlrgbtn5: TdxBarLargeButton;
    dxbrmngr1Bar6: TdxBar;
    dxbrbtn1: TdxBarButton;
    nxqryItems: TnxQuery;
    cxgrdbtblvwGrid1DBTableView1: TcxGridDBTableView;
    cxgrdlvlGrid1Level1: TcxGridLevel;
    cxgrd1: TcxGrid;
    ds2: TDataSource;
    cxgrdbclmnGrid1DBTableView1Title: TcxGridDBColumn;
    cxgrdbclmnGrid1DBTableView1Price: TcxGridDBColumn;
    cxgrdbclmnGrid1DBTableView1Currency: TcxGridDBColumn;
    cxgrdbclmnGrid1DBTableView1Comment: TcxGridDBColumn;
    cxgrdbclmnGrid1DBTableView1CategoryName: TcxGridDBColumn;
    dxbrbtn2: TdxBarButton;
    dxbrlrgbtn6: TdxBarLargeButton;
    dxbrmngr1Bar1: TdxBar;
    dxbrmngr1Bar7: TdxBar;
    dxbrlrgbtn7: TdxBarLargeButton;
    dxbrlrgbtn8: TdxBarLargeButton;
    dxbrlrgbtn9: TdxBarLargeButton;
    dxbrlrgbtn10: TdxBarLargeButton;
    dxbrlrgbtn11: TdxBarLargeButton;
    dxbrbtn3: TdxBarButton;
    nxtblItemsid: TUnsignedAutoIncField;
    nxtblItemsSiteID: TStringField;
    nxtblItemsTitle: TStringField;
    nxtblItemsSubTitle: TStringField;
    nxtblItemsPrimaryCategory: TLargeintField;
    nxtblItemsSecondaryCategory: TLargeintField;
    nxtblItemsCurrency: TStringField;
    nxtblItemsPrice: TExtendedField;
    nxtblItemsReservePrice: TExtendedField;
    nxtblItemsBuyItNowPrice: TExtendedField;
    nxtblItemsListingType: TStringField;
    nxtblItemsQuantity: TIntegerField;
    nxtblItemsLotSize: TIntegerField;
    nxtblItemsAuctionDuration: TStringField;
    nxtblItemsPrivateListing: TBooleanField;
    nxtblItemsShippingService1: TIntegerField;
    nxtblItemsSS1Price: TExtendedField;
    nxtblItemsShippingService2: TIntegerField;
    nxtblItemsSS2Price: TExtendedField;
    nxtblItemsShippingService3: TIntegerField;
    nxtblItemsSS3Price: TExtendedField;
    nxtblItemsSS1Insurance: TExtendedField;
    nxtblItemsSS2Insurance: TExtendedField;
    nxtblItemsSS3Insurance: TExtendedField;
    nxtblItemsInShippingService1: TIntegerField;
    nxtblItemsISS1Price: TExtendedField;
    nxtblItemsInShippingService2: TIntegerField;
    nxtblItemsISS2Price: TExtendedField;
    nxtblItemsInShippingService3: TIntegerField;
    nxtblItemsISS3Price: TExtendedField;
    nxtblItemsISS1Insurance: TExtendedField;
    nxtblItemsISS2Insurance: TExtendedField;
    nxtblItemsISS3Insurance: TExtendedField;
    nxtblItemsInsuranceOptions: TStringField;
    nxtblItemsDescription: TnxMemoField;
    nxtblItemsPaymentMethods: TStringField;
    nxtblItemsShipToLocations: TStringField;
    nxtblItemsPaymentPolicy: TnxMemoField;
    nxtblItemsRP_Description: TnxMemoField;
    nxtblItemsPR_Refund: TStringField;
    nxtblItemsRP_ReturnsWithin: TStringField;
    nxtblItemsRP_ReturnsAccepted: TStringField;
    nxtblItemsRP_ShippingCostPaidBy: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dxBarLargeButton1Click(Sender: TObject);
    Procedure SelectLeafcategories(root: string);
    procedure CheckCategoryVersion(SiteID : SiteCodeType; Fetch:Boolean);
    procedure tmrSpeedTimer(Sender: TObject);
    procedure dxBarLargeButton4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dxBarLargeButton3Click(Sender: TObject);
    procedure dxbrbtn1Click(Sender: TObject);
    procedure dxbrbtn2Click(Sender: TObject);
    procedure dxbrlrgbtn7Click(Sender: TObject);
    procedure dxbrlrgbtn8Click(Sender: TObject);
    procedure dxbrlrgbtn9Click(Sender: TObject);
    procedure dxbrlrgbtn10Click(Sender: TObject);
    procedure dxbrbtn3Click(Sender: TObject);
  private
    { Private declarations }
    CatList : TStringList;
    TimeShift : TDateTime;
    TimeShiftSet : boolean;
//    ThreadObjList : TObjectList;
    procedure ShowSplashScreen(text:string);
  public
    { Public declarations }
    BasePath: string;
    IniSettings: Tinisettings;
    CurrentOperation : TOperation;
    RxCounter : Integer;
    TxCounter : Integer;
    RxCounterDelta : Integer;
    TxCounterDelta : Integer;
    FTCount : Integer;
    ApiUsage : Integer;
    procedure SetOperation(op:TOperation);
    procedure GetAllCategories(SiteID : SiteCodeType);
    procedure GetDetails(SiteID : SiteCodeType);
    procedure OnGetCategoriesThreadTerminate(Sender: TObject);
    procedure OnGetDetailshreadTerminate(Sender: TObject);
    procedure IncApiUsage;
    procedure SetColorScheme(const AName: string);
  end;

var
  fmMain: TfmMain;

implementation

uses uUserSettings, uLog, TypInfo, functions, AdvStyleIF, uGetCategories, IdThread,
  uGetDetails, uEbayProfile, uItemEditor, uSiteSelector, HotLog;

{$R *.dfm}

procedure TfmMain.FormDestroy(Sender: TObject);
begin
  IniSettings.Free;
  CatList.Free;
//  ThreadObjList.Free;
end;

procedure TfmMain.dxBarLargeButton1Click(Sender: TObject);
begin
  fmUserSettings.ShowModal;
end;

procedure TfmMain.dxBarLargeButton3Click(Sender: TObject);
begin
  fmEbayProfiles.ShowModal;
end;

procedure TfmMain.dxBarLargeButton4Click(Sender: TObject);
begin
  if fmLog.Visible then begin
    fmLog.Close;
  end
  else begin
    fmLog.Show;
  end;
  dxBarLargeButton4.Down := fmLog.Visible;
end;

procedure TfmMain.dxbrbtn1Click(Sender: TObject);
begin
  nxtblItems.Insert;
  if fmSiteSelector.ShowModal = mrOk then begin
    nxtblItems.Refresh;
    if fmItemEditor.ShowModal = mrOk then begin
      nxqryItems.Close;
      nxqryItems.Open;
    end;
  end
end;

procedure TfmMain.dxbrbtn2Click(Sender: TObject);
begin
  if fmItemEditor.ShowModal = mrOk then begin
    nxqryItems.Close;
    nxqryItems.Open;
  end;
end;

procedure TfmMain.dxbrbtn3Click(Sender: TObject);
begin
  if MessageDlg('Delete item? Sure?',mtWarning,mbOKCancel,0)=mrOk then nxtblItems.Delete;
  nxqryItems.Close;
  nxqryItems.Open;
end;

procedure TfmMain.dxbrlrgbtn10Click(Sender: TObject);
begin
  with dxRibbon1 do
  begin
    SupportNonClientDrawing := not SupportNonClientDrawing;
    dxbrlrgbtn10.Enabled := SupportNonClientDrawing;
  end;
end;

procedure TfmMain.SetColorScheme(const AName: string);
begin
  dxRibbon1.ColorSchemeName := AName;
  //pgc1.Color := dxrbnRibbon.ColorScheme.GetPartColor(rfspRibbonForm);
  dxRibbonStatusBar1.Invalidate;
end;

procedure TfmMain.dxbrlrgbtn7Click(Sender: TObject);
begin
SetColorScheme('Silver');
end;

procedure TfmMain.dxbrlrgbtn8Click(Sender: TObject);
begin
SetColorScheme('Blue');
end;

procedure TfmMain.dxbrlrgbtn9Click(Sender: TObject);
begin
SetColorScheme('Black');
end;

procedure TfmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if fmLog.Visible then fmLog.Close;
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
  BasePath := ExtractFileDir(Paramstr(0));
  hLog.hlWriter.hlFileDef.path := BasePath+'\log';
  hLog.hlWriter.hlFileDef.UseFileSizeLimit := true;
  hLog.hlWriter.hlFileDef.LogFileMaxSize := OneMegabyte;
  hLog.hlWriter.hlFileDef.UseSafeFilenames := true;
  if hLog.hlWriter.hlFileDef.UseSafeFilenames then
  begin
      hLog.hlWriter.hlFileDef.BuildSafeFilename;
      hLog.hlWriter.hlFileDef.SafegdgMax := 5;
  end else
  begin
      hLog.hlWriter.hlFileDef.ddname :='Applog';
      hLog.hlWriter.hlFileDef.gdgMax := 5;
  end;
  hlog.SetLogFileTimerInterval(OneMinute);
  hlog.StartLogging;

  hLog.Add('{hms} Start form creation');
  IniSettings := TIniSettings.Create;
  IniSettings.PBasePath := BasePath;
  IniSettings.Load(BasePath+'/settings.ini');
  hLog.Add('{hms} Ini loaded');
  CatList := TStringList.Create;
//  ThreadObjList := TObjectList.Create;
//  ThreadObjList.OwnsObjects := True;
  nxsrvrngn1.Open;
  nxsn1.Open;
  nxdtbs1.AliasPath := 'data';
  nxdtbs1.Open;
  nxtblSites.Open;
  nxtblItems.Open;
  nxqryItems.Open;
end;

procedure TfmMain.SelectLeafcategories(root: string);
var
qry: TnxQuery;
begin
  if CatList<> nil then begin
    try
      qry:= TnxQuery.Create(Self);
      qry.Database := nxdtbs1;
      qry.Session := nxsn1;
      qry.SQL.Clear;
      qry.SQL.Add(Format('Select CategoryID , LeafCategory from categories where CategoryParentID = %s',[QuotedStr(root)]));
      try
        qry.Open;
        while not qry.Eof do begin
          if qry.FieldValues['LeafCategory'] then SelectLeafcategories(qry.FieldValues['CategoryID'])
          else CatList.Add(qry.FieldValues['CategoryID']);
          qry.Next;
        end;
      except
        on E : Exception do hlog.AddException(E);
      end;
    finally
      qry.Free;
    end;
  end;
end;

procedure TfmMain.ShowSplashScreen(text: string);
begin

end;

procedure TfmMain.tmrSpeedTimer(Sender: TObject);
begin
  if Assigned(dxRibbonStatusBar1) then dxRibbonStatusBar1.Panels[4].Text := Format('Rx %d bytes Tx %d bytes speed %8.3f kbytes/sec',[RxCounter,TxCounter,(RxCounterDelta+TxCounterDelta)/1000]);
  RxCounterDelta:=0;
  TxCounterDelta:=0;
end;

procedure TfmMain.SetOperation(op:TOperation);
var text: string;
begin
  //opIdle,opCheckCategories
  CurrentOperation := op;
  case op of
     opIdle: text := 'Idle';
     opCheckCategories: text := 'Check Categories';
     opLoadDetails: text := 'Load Details';
     opLoadcategories: text := 'Load Categories';
  end;
  dxRibbonStatusBar1.Panels[1].Text := text;
end;

procedure TfmMain.CheckCategoryVersion(SiteID : SiteCodeType; Fetch:Boolean);
var EbayTime : TDateTime;
    OperationResult : AckCodeType;
    categoriescnt :Integer;
    categoriesver :Integer;
    tmpstr : string;
    qr1,qr2: TnxQuery;
    TmpStrSiteID : string;
begin
  TmpStrSiteID := GetEnumName(TypeInfo(SiteCodeType),ord(SiteID));
  with IniSettings.ebay do if (Length(AppID)=0) or (Length(DevID)=0) or (Length(CertID)=0) or (Length(token)=0) then
  begin
    MessageDlg('Please set your developers keys and token in settings dialog',mtWarning,[mbOK],0);
    Exception.Create('Missing Developers keys and token');
    Exit;
  end;
  try
    qr1 := TnxQuery.Create(Self);
    qr2 := TnxQuery.Create(Self);
    qr1.Database := nxdtbs1;
    qr2.Database := nxdtbs1;
    qr1.Session := nxsn1;
    qr2.Session := nxsn1;
    tmpstr := Format('Check for %s categories begin',[TmpStrSiteID]);
    hLog.Add(tmpstr);
    SetOperation(opCheckCategories);
    GetCategoryInfo1.IncludeSelector := [];
    EbayShoppingConnect2.SiteID := SiteID;
    OperationResult := GetCategoryInfo1.DoRequestEx;
    try
      if OperationResult in [Success, Warning] then
      begin
        EbayTime := eBayTimeStrConvert(GetCategoryInfo1.Timestamp);
        TimeShift := Now - EbayTime;
        TimeShiftSet := True;
        dxRibbonStatusBar1.Panels[3].Text := 'Time shift: '+TimeToStr(TimeShift);
        qr1.Close;
        qr1.SQL.Clear;
        qr1.SQL.Add('select count(*) as cnt from categories where SiteCode = '+QuotedStr(TmpStrSiteID));
        qr1.Open;
        categoriescnt := qr1.FieldValues['cnt'];
        qr1.Close;
        qr1.SQL.Clear;
        qr1.SQL.Add('select Version from Sites where SiteCode = '+QuotedStr(TmpStrSiteID));
        qr1.Open;
        if qr1.FieldByName('Version').IsNull then categoriesver := 0 else categoriesver := qr1.FieldValues['Version'];
        qr1.Close;
        if (StrToInt(GetCategoryInfo1.CategoryVersion) > categoriesver) or
          (categoriescnt = 0) or Fetch then
        begin
          if StrToInt(GetCategoryInfo1.CategoryVersion) > categoriesver then
            tmpstr := Format(
              'Categories version mismatch for %s. Local %d , actual %s. Updating',
              [TmpStrSiteID, categoriesver,
              GetCategoryInfo1.CategoryVersion]);
          //ShowSplashScreen(tmpstr);
          if categoriescnt = 0 then
            tmpstr := 'Categories table is empty for ' + TmpStrSiteID;
          if Fetch then
            tmpstr := 'User forced categories download'
          else
            tmpstr := 'Auto categories download';
          hLog.Add(tmpstr);
          //ShowSplashScreen(tmpstr);
          qr2.SQL.Clear;
          qr2.SQL.Add('delete from categories where SiteCode = ' + QuotedStr
              (TmpStrSiteID));
          qr2.ExecSQL;
          GetAllCategories(SiteID);
        end
        else
        begin
          hLog.Add(Format('%s: Check categories for %s end - %s',
              [DateTimeToStr(Now), TmpStrSiteID,
              GetEnumName(TypeInfo(AckCodeType), ord(OperationResult))]));
          hLog.Add('Categories version is actual');
          categoriesver := StrToInt(GetCategoryInfo1.CategoryVersion);
          { qr2.SQL.Clear;
            qr2.SQL.Add(Format('update Sites set Version = %d, LastUpdated = %s where  GlobalSiteID = %s',[categoriesver, QuotedStr(DateTimeToStr(now)), QuotedStr(TmpStrGlobalID)]));
            qr2.ExecSQL; }
          SetOperation(opIdle);
          // MessageDlg(Format('Current categories version %d',[inisettings.CategoryVersion]),mtInformation,[mbOK],0);
        end;
      end;
    except
      hLog.Add(Format('%s: Exception during categories check',[DateTimeToStr(now)]));
    end;
  finally
    qr1.Free;
    qr2.Free;
  end;
end;

procedure TfmMain.GetAllCategories(SiteID : SiteCodeType);
var thread : TGetCategoriesThread;
begin
  SetOperation(opLoadCategories);
  thread := TGetCategoriesThread.Create(fmMain);
  RxCounter := 0;
  TxCounter := 0;
  RxCounterDelta := 0;
  TxCounterDelta := 0;
  with thread do begin
    OnTerminate:=OnGetCategoriesThreadTerminate;
    with inisettings.ebay do begin
      FDevID         := DevID;
      FAppID         := AppID;
      FCertID        := CertID;
      FToken         := Token;
      FSiteID        := SiteID;
      FBasePath      := BasePath;
      FHost             := Host;
      FServiceURL       := ServiceURL;
    end;
    with inisettings.SSLSettings do begin
      FSSLCertFile      := SSLCertFile;
      FSSLKeyFile       := SSLKeyFile;
      FSSLRootCertFile  := SSLRootCertFile;
      FSSLPassword      := SSLPassword;
    end;
    Start;
  end;
end;

procedure TfmMain.GetDetails(SiteID: SiteCodeType);
var thread : TGetDetailsThread;
begin
  SetOperation(opLoadDetails);
  thread := TGetDetailsThread.Create(fmMain);
  RxCounter := 0;
  TxCounter := 0;
  RxCounterDelta := 0;
  TxCounterDelta := 0;
  with thread do begin
    OnTerminate:=OnGetDetailshreadTerminate;
    with inisettings.ebay do begin
      FDevID         := DevID;
      FAppID         := AppID;
      FCertID        := CertID;
      FToken         := Token;
      FSiteID        := SiteID;
      FBasePath      := BasePath;
      FHost             := Host;
      FServiceURL       := ServiceURL;
    end;
    with inisettings.SSLSettings do begin
      FSSLCertFile      := SSLCertFile;
      FSSLKeyFile       := SSLKeyFile;
      FSSLRootCertFile  := SSLRootCertFile;
      FSSLPassword      := SSLPassword;
    end;
    Start;
  end;
end;

procedure TfmMain.IncApiUsage;
begin
  inc(ApiUsage);
  dxRibbonStatusBar1.Panels[2].Text := Format('API usage - %d calls',[ApiUsage]);
end;

procedure TfmMain.OnGetCategoriesThreadTerminate(Sender: TObject);
var tmpstr : string;
    i : Integer;
    qrx : TnxQuery;
begin
//  for i:=0 to ThreadObjList.Count-1 do if ThreadObjList[i] = Sender then begin
//    ThreadObjList.Delete(i);
//    Break;
//  end;
  i:=(Sender as TGetCategoriesThread).FCategoryVersion;
  tmpstr := Format('%s: Categories Updated. Version %d',[DateTimeToStr(now),i]);
  hLog.Add(tmpstr);
  //tmpstr := GetEnumName(TypeInfo(Global_ID),ord((Sender as TGetCategoriesThread).FGlobalSiteID)) ;
  SetOperation(opIdle);
  dxRibbonStatusBar1.Panels[4].Text := '';
  qrx := TnxQuery.Create(Self);
  with qrx do begin
    Database := nxdtbs1;
    Session := nxsn1;
    SQL.Clear;
    SQL.Add('update Sites set Version = :Version , LastUpdated = :LastUpdated where SiteCode = :SiteCode');
    Prepared := True;
    ParamByName('Version').DataType := ftInteger;
    ParamByName('LastUpdated').DataType := ftDateTime;
    ParamByName('SiteCode').DataType := ftString;
    ParamByName('Version').Value := i;
    ParamByName('LastUpdated').Value := now;
    ParamByName('SiteCode').Value := GetEnumName(TypeInfo(SiteCodeType),ord((Sender as TGetCategoriesThread).FSiteID));
    ExecSQL;
  end;
  nxtblSites.Close;
  nxtblSites.Open
end;

procedure TfmMain.OnGetDetailshreadTerminate(Sender: TObject);
var tmpstr : string;
    i : Integer;
    qrx : TnxQuery;
begin
  tmpstr := 'Details Updated.';
  hLog.Add(tmpstr);
  SetOperation(opIdle);
  dxRibbonStatusBar1.Panels[4].Text := '';
  qrx := TnxQuery.Create(Self);
  with qrx do begin
    Database := nxdtbs1;
    Session := nxsn1;
    SQL.Clear;
    SQL.Add('update Sites set DetailsUpdated = :DetailsUpdated where SiteCode = :SiteCode');
    Prepared := True;
    ParamByName('DetailsUpdated').DataType := ftDateTime;
    ParamByName('SiteCode').DataType := ftString;
    ParamByName('DetailsUpdated').Value := now;
    ParamByName('SiteCode').Value := GetEnumName(TypeInfo(SiteCodeType),ord((Sender as TGetDetailsThread).FSiteID));
    ExecSQL;
  end;
  nxtblSites.Close;
  nxtblSites.Open;
end;

end.


