unit uItemEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter, cxContainer, cxEdit,
  dxdbtrel, StdCtrls, cxTextEdit, cxDBEdit, cxPC, DB, nxdb, ComCtrls, dxtree,
  dxdbtree, Buttons, cxMaskEdit, cxDropDownEdit, cxCheckComboBox,
  cxDBCheckComboBox, dxmdaset, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox,
  cxCurrencyEdit, cxCalc, ExtCtrls, cxLabel, cxDBLabel, cxSpinEdit, cxGroupBox,
  cxRadioGroup, WPRTEDefs, WPCTRMemo, WPCTRRich, Wpdbrich, WPRuler, WPTbar,
  JvExStdCtrls, JvListBox, JvDriveCtrls, ieview, iemview,
  AdvToolBar, ExtDlgs, TntExtDlgs, ImgList, ToolWin, JvExComCtrls, JvToolBar,
  GridsEh, DBGridEh, HotSpotImage, cxCheckGroup, cxDBCheckGroup, cxMemo,
  dxSkinsdxStatusBarPainter, dxStatusBar, imageenview;

type
  TfmItemEditor = class(TForm)
    cxpgcntrl1: TcxPageControl;
    cxtbsht1: TcxTabSheet;
    cxtbsht2: TcxTabSheet;
    cxtbsht3: TcxTabSheet;
    cxdbtxtdt1: TcxDBTextEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    cxdbtxtdt2: TcxDBTextEdit;
    lbl3: TLabel;
    cxpgcntrl2: TcxPageControl;
    cxtbsht4: TcxTabSheet;
    cxtbsht5: TcxTabSheet;
    lbl4: TLabel;
    lbl5: TLabel;
    dxdblkptrvwSecondaryCategory: TdxDBLookupTreeView;
    ds1: TDataSource;
    nxqryCategories: TnxQuery;
    dxdblkptrvwPrimaryCategory: TdxDBLookupTreeView;
    lbl6: TLabel;
    lbl7: TLabel;
    dxmdt1: TdxMemData;
    intgrflddxmdt1CategoryID: TIntegerField;
    strngflddxmdt1CategoryName: TStringField;
    intgrflddxmdt1PercentItemFound: TIntegerField;
    ds2: TDataSource;
    cbb1: TcxDBLookupComboBox;
    cbb2: TcxDBLookupComboBox;
    lbl8: TLabel;
    lbl9: TLabel;
    lbl10: TLabel;
    nxqryCurrency: TnxQuery;
    ds3: TDataSource;
    lbl11: TLabel;
    cbb3: TcxDBLookupComboBox;
    cxdbclcdt1: TcxDBCalcEdit;
    cxdbclcdt2: TcxDBCalcEdit;
    cxdbclcdt3: TcxDBCalcEdit;
    pnl1: TPanel;
    btn2: TButton;
    btn3: TButton;
    cxdblbl1: TcxDBLabel;
    cxdblbl2: TcxDBLabel;
    cxdblbl3: TcxDBLabel;
    cxdbrdgrp1: TcxDBRadioGroup;
    lbl12: TLabel;
    lbl13: TLabel;
    cxdbspndt1: TcxDBSpinEdit;
    cxpgcntrl3: TcxPageControl;
    cxtbsht6: TcxTabSheet;
    cxtbsht7: TcxTabSheet;
    cxdbspndt2: TcxDBSpinEdit;
    lbl14: TLabel;
    cxdbclcdt4: TcxDBCalcEdit;
    lbl17: TLabel;
    cxdbclcdt7: TcxDBCalcEdit;
    lbl18: TLabel;
    cxdblbl4: TcxDBLabel;
    cxdblbl7: TcxDBLabel;
    dbwprchtxt1: TDBWPRichText;
    wptlbr1: TWPToolBar;
    wprlr1: TWPRuler;
    lbl24: TLabel;
    lbl25: TLabel;
    cxtxtdt1: TcxTextEdit;
    tmr1: TTimer;
    cxtxtdt2: TcxTextEdit;
    dlg1: TTntOpenPictureDialog;
    pnl2: TPanel;
    img1: TImageEnMView;
    jvtlbr1: TJvToolBar;
    btn5: TToolButton;
    il1: TImageList;
    btn6: TToolButton;
    dsEbayPref: TDataSource;
    lbl15: TLabel;
    cxdbclcdt5: TcxDBCalcEdit;
    cxdbclcdt6: TcxDBCalcEdit;
    cxdblbl5: TcxDBLabel;
    cxdblbl6: TcxDBLabel;
    lbl16: TLabel;
    cxdbclcdt8: TcxDBCalcEdit;
    cxdbclcdt9: TcxDBCalcEdit;
    cxdblbl9: TcxDBLabel;
    cxdblbl17: TcxDBLabel;
    nxqryEbayPref: TnxQuery;
    lbl26: TLabel;
    lbl27: TLabel;
    lbl28: TLabel;
    lbl29: TLabel;
    nxqryShippingService: TnxQuery;
    ds5: TDataSource;
    cbb4: TcxDBLookupComboBox;
    cbb5: TcxDBLookupComboBox;
    cbb6: TcxDBLookupComboBox;
    lbl19: TLabel;
    lbl20: TLabel;
    lbl21: TLabel;
    lbl22: TLabel;
    lbl23: TLabel;
    lbl30: TLabel;
    lbl31: TLabel;
    lbl32: TLabel;
    lbl33: TLabel;
    cxdbclcdt10: TcxDBCalcEdit;
    cxdbclcdt11: TcxDBCalcEdit;
    cxdblbl8: TcxDBLabel;
    cxdblbl10: TcxDBLabel;
    cxdbclcdt12: TcxDBCalcEdit;
    cxdbclcdt13: TcxDBCalcEdit;
    cxdblbl11: TcxDBLabel;
    cxdblbl12: TcxDBLabel;
    cxdbclcdt14: TcxDBCalcEdit;
    cxdbclcdt15: TcxDBCalcEdit;
    cxdblbl13: TcxDBLabel;
    cxdblbl14: TcxDBLabel;
    cbb7: TcxDBLookupComboBox;
    cbb8: TcxDBLookupComboBox;
    cbb9: TcxDBLookupComboBox;
    ds6: TDataSource;
    nxqryShippingServiceIn: TnxQuery;
    cxdbchckgrp1: TcxDBCheckGroup;
    nxqryPaymentMethods: TnxQuery;
    ds7: TDataSource;
    cxdbchckgrp2: TcxDBCheckGroup;
    nxqryShipToLocations: TnxQuery;
    ds8: TDataSource;
    nxqry1: TnxQuery;
    ds4: TDataSource;
    nxqry3: TnxQuery;
    ds9: TDataSource;
    ds10: TDataSource;
    nxqry4: TnxQuery;
    ds11: TDataSource;
    nxqry2: TnxQuery;
    cxgrpbx1: TcxGroupBox;
    cxgrpbx2: TcxGroupBox;
    pnl3: TPanel;
    cxm2: TcxMemo;
    cxdbm3: TcxDBMemo;
    pnl4: TPanel;
    lbl35: TLabel;
    lbl36: TLabel;
    lbl37: TLabel;
    lbl38: TLabel;
    cbb11: TcxDBLookupComboBox;
    cbb12: TcxDBLookupComboBox;
    cbb13: TcxDBLookupComboBox;
    cbb10: TcxDBLookupComboBox;
    pnl5: TPanel;
    cxm1: TcxMemo;
    cxdbm1: TcxDBMemo;
    dxstsbr1: TdxStatusBar;
    ImageList1: TImageList;
    pnl6: TPanel;
    Panel1: TPanel;
    GroupBox2: TGroupBox;
    TrackBar1: TTrackBar;
    GroupBox3: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    TrackBar2: TTrackBar;
    TrackBar3: TTrackBar;
    TrackBar4: TTrackBar;
    GroupBox4: TGroupBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    GroupBox1: TGroupBox;
    TrackBar5: TTrackBar;
    CheckBox4: TCheckBox;
    GroupBox5: TGroupBox;
    TrackBar6: TTrackBar;
    GroupBox6: TGroupBox;
    Label1: TLabel;
    Label5: TLabel;
    TrackBar7: TTrackBar;
    TrackBar8: TTrackBar;
    pnl7: TPanel;
    ImageEnView1: TImageEnView;
    procedure ChangeChannelsOffset;
    procedure Translator(source: string; langapir: string ; Control: TControl);
    procedure FormShow(Sender: TObject);
    procedure OnGetCategoriesSuggestTerminate(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn5Click(Sender: TObject);
    procedure nxqryCategoriesBeforeOpen(DataSet: TDataSet);
    procedure cbb4PropertiesChange(Sender: TObject);
    procedure cbb5PropertiesChange(Sender: TObject);
    procedure cbb6PropertiesChange(Sender: TObject);
    procedure cbb7PropertiesChange(Sender: TObject);
    procedure cbb8PropertiesChange(Sender: TObject);
    procedure cbb9PropertiesChange(Sender: TObject);
    procedure cxpgcntrl2Change(Sender: TObject);
    procedure tmr1Timer(Sender: TObject);
    procedure cxdbtxtdt1PropertiesChange(Sender: TObject);
    procedure img1ImageSelect(Sender: TObject; idx: Integer);
    procedure TrackBar1Change(Sender: TObject);
    procedure TrackBar6Change(Sender: TObject);
    procedure TrackBar7Change(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
    procedure TrackBar3Change(Sender: TObject);
    procedure TrackBar4Change(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure TrackBar5Change(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
  private
    { Private declarations }
    imgfoldername : string;
  public
    { Public declarations }
  end;

var
  fmItemEditor: TfmItemEditor;

implementation

uses uMain, uGetSuggestedCategories, EbayConnect, TypInfo, googleTranslator, hyieutils;

{$R *.dfm}

procedure TfmItemEditor.btn2Click(Sender: TObject);
begin
  fmMain.nxtblItems.Post;
end;

procedure TfmItemEditor.TrackBar1Change(Sender: TObject);
begin
  ImageEnView1.IEBitmap.Contrast := TrackBar1.Position;
  ImageEnView1.Update;
end;

procedure TfmItemEditor.TrackBar2Change(Sender: TObject);
begin
  ChangeChannelsOffset;
end;

procedure TfmItemEditor.TrackBar3Change(Sender: TObject);
begin
  ChangeChannelsOffset;
end;

procedure TfmItemEditor.TrackBar4Change(Sender: TObject);
begin
  ChangeChannelsOffset;
end;

procedure TfmItemEditor.TrackBar5Change(Sender: TObject);
begin
  ImageEnView1.Zoom := TrackBar5.Position;
end;

procedure TfmItemEditor.TrackBar6Change(Sender: TObject);
begin
  if CheckBox1.Checked then
    TrackBar2.Position := TrackBar6.Position;
  if CheckBox2.Checked then
    TrackBar3.Position := TrackBar6.Position;
  if CheckBox3.Checked then
    TrackBar4.Position := TrackBar6.Position;
  ChangeChannelsOffset;
end;

procedure TfmItemEditor.TrackBar7Change(Sender: TObject);
begin
  ImageEnView1.IEBitmap.BlackValue:=trackbar7.position;
  ImageEnView1.IEBitmap.WhiteValue:=trackbar8.position;
  ImageEnView1.Update;
end;

procedure TfmItemEditor.ChangeChannelsOffset;
begin
  ImageEnView1.IEBitmap.ChannelOffset[0] := TrackBar2.Position; // red
  ImageEnView1.IEBitmap.ChannelOffset[1] := TrackBar3.Position; // green
  ImageEnView1.IEBitmap.ChannelOffset[2] := TrackBar4.Position; // blue
  ImageEnView1.Update;
end;

procedure TfmItemEditor.CheckBox1Click(Sender: TObject);
begin
  TrackBar2.Enabled := CheckBox1.Checked;
  if CheckBox1.Checked then
    TrackBar2.Position := 0
  else
    TrackBar2.Position := -255;
  ChangeChannelsOffset;
end;

procedure TfmItemEditor.CheckBox2Click(Sender: TObject);
begin
  TrackBar3.Enabled := CheckBox2.Checked;
  if CheckBox2.Checked then
    TrackBar3.Position := 0
  else
    TrackBar3.Position := -255;
  ChangeChannelsOffset;
end;

procedure TfmItemEditor.CheckBox3Click(Sender: TObject);
begin
  TrackBar4.Enabled := CheckBox3.Checked;
  if CheckBox3.Checked then
    TrackBar4.Position := 0
  else
    TrackBar4.Position := -255;
  ChangeChannelsOffset;
end;

procedure TfmItemEditor.CheckBox4Click(Sender: TObject);
begin
  if CheckBox4.Checked then
  begin
    ImageEnView1.AutoFit := true;
    ImageEnView1.Fit;
    TrackBar5.Enabled := false;
  end
  else
  begin
    ImageEnView1.AutoFit := false;
    TrackBar5.Enabled := true;
    ImageEnView1.Zoom := TrackBar5.Position;
  end;
end;

procedure TfmItemEditor.Translator(source: string; langapir: string ; Control: TControl);
var tthread : TTranslateThread;
begin
  try
    tthread := TTranslateThread.Create(fmItemEditor);
    tthread.Source := source;
    tthread.LangPair := langapir;
    tthread.ControlTag := Control.Tag;
    tthread.StatusBarPanel := dxstsbr1.Panels[0];
    tthread.Run;
  finally
    tthread.Free;
  end;
end;

procedure TfmItemEditor.btn5Click(Sender: TObject);
begin
  if dlg1.Execute(fmItemEditor.Handle) then begin
    if CopyFile(PChar(dlg1.FileName),PChar(imgfoldername+'\'+ExtractFileName(dlg1.FileName)),true) then
    begin
      ShowMessage('File succesfully added!');
      img1.Clear;
      img1.FillFromDirectory(imgfoldername+'\');
      img1.SelectedImage := 0;
    end
    else ShowMessage('Fail!');
  end;
end;

procedure TfmItemEditor.cbb4PropertiesChange(Sender: TObject);
var tmp : Boolean;
begin
  with fmMain.nxtblItems do begin
    tmp := not FieldByName('ShippingService1').IsNull;
    cxdbclcdt4.Enabled := tmp;
    cxdbclcdt7.Enabled := tmp;
  end;
end;

procedure TfmItemEditor.cbb5PropertiesChange(Sender: TObject);
var tmp : Boolean;
begin
  with fmMain.nxtblItems do begin
    tmp := not FieldByName('ShippingService2').IsNull;
    cxdbclcdt5.Enabled := tmp;
    cxdbclcdt6.Enabled := tmp;
  end;
end;

procedure TfmItemEditor.cbb6PropertiesChange(Sender: TObject);
var tmp : Boolean;
begin
  with fmMain.nxtblItems do begin
    tmp := not FieldByName('ShippingService3').IsNull;
    cxdbclcdt8.Enabled := tmp;
    cxdbclcdt9.Enabled := tmp;
  end;
end;

procedure TfmItemEditor.cbb7PropertiesChange(Sender: TObject);
var tmp : Boolean;
begin
  with fmMain.nxtblItems do begin
    tmp := not FieldByName('InShippingService1').IsNull;
    cxdbclcdt10.Enabled := tmp;
    cxdbclcdt11.Enabled := tmp;
  end;
end;

procedure TfmItemEditor.cbb8PropertiesChange(Sender: TObject);
var tmp : Boolean;
begin
  with fmMain.nxtblItems do begin
    tmp := not FieldByName('InShippingService2').IsNull;
    cxdbclcdt12.Enabled := tmp;
    cxdbclcdt13.Enabled := tmp;
  end;
end;

procedure TfmItemEditor.cbb9PropertiesChange(Sender: TObject);
var tmp : Boolean;
begin
  with fmMain.nxtblItems do begin
    tmp := not FieldByName('InShippingService3').IsNull;
    cxdbclcdt14.Enabled := tmp;
    cxdbclcdt15.Enabled := tmp;
  end;
end;

procedure TfmItemEditor.cxdbtxtdt1PropertiesChange(Sender: TObject);
begin
  dxstsbr1.Panels[0].Text := 'Typing ....';
  tmr1.Enabled := False;
  tmr1.Enabled := True;
end;

procedure TfmItemEditor.cxpgcntrl2Change(Sender: TObject);
var thread : TGetSuggestedCategoriesThread;
begin
  if (cxpgcntrl2.ActivePageIndex = 1) and (length(cxdbtxtdt1.Text)>0) then  begin
    fmMain.SetOperation(opGetSuggestedcategories);
    thread := TGetSuggestedCategoriesThread.Create(fmItemEditor);
    with fmMain do begin
      RxCounter := 0;
      TxCounter := 0;
      RxCounterDelta := 0;
      TxCounterDelta := 0;
    end;
    with thread do begin
      OnTerminate:=OnGetCategoriesSuggestTerminate;
      with fmMain.inisettings.ebay do begin
        FDevID         := DevID;
        FAppID         := AppID;
        FCertID        := CertID;
        FToken         := Token;
        FSiteID        := SiteCodeType(GetEnumValue(TypeInfo(SiteCodeType),fmMain.nxtblSites.FieldByName('SiteCode').AsString));
        FBasePath      := fmMain.BasePath;
        FQuery         := cxdbtxtdt1.Text;
      end;
      Start;
    end;
  end;
end;


procedure TfmItemEditor.FormCreate(Sender: TObject);
begin
  dbwprchtxt1.TextLoadFormat := 'HTML-onlybody';
  dbwprchtxt1.TextSaveFormat := 'HTML-onlybody';
end;

procedure TfmItemEditor.FormShow(Sender: TObject);
var tmp : Boolean;
begin
  if not nxqryCategories.Active then nxqryCategories.Open;
  if not dxmdt1.Active then dxmdt1.Open;
  if not nxqryCurrency.Active then nxqryCurrency.Open;
  if not nxqryEbayPref.Active then nxqryEbayPref.Open;
  if not nxqryShippingService.Active then nxqryShippingService.Open;
  if not nxqryShippingServiceIn.Active then nxqryShippingServiceIn.Open;
  if not nxqryPaymentMethods.Active then nxqryPaymentMethods.Open;
  if not nxqryShipToLocations.Active then nxqryShipToLocations.Open;

  if not nxqry1.Active then nxqry1.Open;
  if not nxqry2.Active then nxqry2.Open;
  if not nxqry3.Active then nxqry3.Open;
  if not nxqry4.Active then nxqry4.Open;

  with fmMain.nxtblItems do begin
    tmp := not FieldByName('ShippingService1').IsNull;
    cxdbclcdt4.Enabled := tmp;
    cxdbclcdt7.Enabled := tmp;
    tmp := not FieldByName('ShippingService2').IsNull;
    cxdbclcdt5.Enabled := tmp;
    cxdbclcdt6.Enabled := tmp;
    tmp := not FieldByName('ShippingService3').IsNull;
    cxdbclcdt8.Enabled := tmp;
    cxdbclcdt9.Enabled := tmp;
    tmp := not FieldByName('InShippingService1').IsNull;
    cxdbclcdt10.Enabled := tmp;
    cxdbclcdt11.Enabled := tmp;
    tmp := not FieldByName('InShippingService2').IsNull;
    cxdbclcdt12.Enabled := tmp;
    cxdbclcdt13.Enabled := tmp;
    tmp := not FieldByName('InShippingService3').IsNull;
    cxdbclcdt14.Enabled := tmp;
    cxdbclcdt15.Enabled := tmp;
  end;
  cxdbchckgrp1.Properties.Items.Clear;
  nxqryPaymentMethods.First;
  while not nxqryPaymentMethods.Eof do begin
    with cxdbchckgrp1.Properties.Items.Add do begin
      Caption := nxqryPaymentMethods.FieldByName('name').AsString;
    end;
    nxqryPaymentMethods.Next;
  end;
  cxdbchckgrp2.Properties.Items.Clear;
  nxqryShipToLocations.First;
  while not nxqryShipToLocations.Eof do begin
    with cxdbchckgrp2.Properties.Items.Add do begin
      Caption := nxqryShipToLocations.FieldByName('name').AsString;
    end;
    nxqryShipToLocations.Next;
  end;
  imgfoldername := fmMain.BasePath+ '\images\'+fmMain.nxtblItems.FieldByName('id').AsString;
  if not DirectoryExists(imgfoldername) then CreateDir(imgfoldername);
  img1.Clear;
  img1.FillFromDirectory(imgfoldername+'\');
  img1.SelectedImage := 0;
end;

procedure TfmItemEditor.img1ImageSelect(Sender: TObject; idx: Integer);
begin
  with ImageEnView1.IO do
  begin
    NativePixelFormat:=true;
    LoadFromFile(img1.ImageFileName[idx]);
    CheckBox4.Checked := True;
    ImageEnView1.AutoFit := true;
  end;

  if ImageEnView1.IEBitmap.PixelFormat=ie16g then
  begin
    trackbar7.Max:=65535;
    trackbar7.Position:=0;
    trackbar7.Enabled:=true;
    trackbar8.Max:=65535;
    trackbar8.Position:=65535;
    trackbar8.Enabled:=true;
  end
  else if ImageEnView1.IEBitmap.PixelFormat=ie8g then
  begin
    trackbar7.Max:=255;
    trackbar7.Position:=0;
    trackbar7.Enabled:=true;
    trackbar8.Max:=255;
    trackbar8.Position:=255;
    trackbar8.Enabled:=true;
  end
  else
  begin
    trackbar7.Enabled:=false;
    trackbar8.Enabled:=false;
  end;
end;

procedure TfmItemEditor.nxqryCategoriesBeforeOpen(DataSet: TDataSet);
begin
  nxqryCategories.ParamByName('SiteID').AsString := fmMain.nxtblItems.FieldByName('SiteID').AsString;
end;

procedure TfmItemEditor.OnGetCategoriesSuggestTerminate(Sender: TObject);
var tmpstr : string;
    i : Integer;
begin
  tmpstr := 'Categories Suggest loaded.';
  with fmMain do begin
    WriteLog(tmpstr);
    SetOperation(opIdle);
    dxRibbonStatusBar1.Panels[4].Text := '';
  end;
  for I := 0 to (Sender as TGetSuggestedCategoriesThread).SuggestedCategoryArray.Count - 1 do begin
    dxmdt1.Insert;
    dxmdt1.FieldByName('CategoryID').AsInteger := StrToInt((Sender as TGetSuggestedCategoriesThread).SuggestedCategoryArray.SuggestedCategory[i].Category.CategoryID);
    dxmdt1.FieldByName('CategoryName').AsString := (Sender as TGetSuggestedCategoriesThread).SuggestedCategoryArray.SuggestedCategory[i].Category.CategoryName;
    dxmdt1.FieldByName('PercentItemFound').AsInteger := (Sender as TGetSuggestedCategoriesThread).SuggestedCategoryArray.SuggestedCategory[i].PercentItemFound;
  end;
end;

procedure TfmItemEditor.tmr1Timer(Sender: TObject);
begin
  dxstsbr1.Panels[0].Text := 'Translate ....';
  // Title
  if cxdbtxtdt1.Focused  then Translator(cxdbtxtdt1.Text,'en|ja',cxtxtdt1);
  if cxtxtdt1.Focused  then Translator(cxtxtdt1.Text,'ja|en',cxdbtxtdt1);
  // SubTitle
  if cxdbtxtdt2.Focused  then Translator(cxdbtxtdt2.Text,'en|ja',cxtxtdt2);
  if cxtxtdt2.Focused  then Translator(cxtxtdt2.Text,'ja|en',cxdbtxtdt2);
  // payment instructions
  if cxm1.Focused then Translator(cxm1.Text,'ja|en',cxdbm1);
  if cxdbm1.Focused then Translator(cxdbm1.Text,'en|ja',cxm1);
  // Return policy
  if cxm2.Focused then Translator(cxm2.Text,'ja|en',cxdbm3);
  if cxdbm3.Focused then Translator(cxdbm3.Text,'en|ja',cxm2);
  tmr1.Enabled := False;
end;

end.
