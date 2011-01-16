unit uUserSettings;

interface
{$I definitions.inc}
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, GridsEh, DBGridEh, ExtCtrls;

type
  TfmUserSettings = class(TForm)
    lbl1: TLabel;
    edt1: TEdit;
    lbl2: TLabel;
    edt2: TEdit;
    lbl3: TLabel;
    edt3: TEdit;
    lbl4: TLabel;
    mmo1: TMemo;
    lbl5: TLabel;
    btn1: TButton;
    Button1: TButton;
    Bevel1: TBevel;
    Button2: TButton;
    Button3: TButton;
    ds1: TDataSource;
    dbgrdh1: TDBGridEh;
    procedure FormShow(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
  fmUserSettings: TfmUserSettings;

implementation

uses uMain, uIniSettings, TypInfo, EbayConnect;

{$R *.dfm}

procedure TfmUserSettings.btn1Click(Sender: TObject);
begin
  with fmMain.IniSettings do begin
    ebay.AppID := edt1.Text;
    ebay.DevID := edt2.Text;
    ebay.CertID := edt3.Text;
    ebay.Token := mmo1.Text;
    Save(fmMain.BasePath+'/settings.ini');
    if dbgrdh1.DataSource.DataSet.State in [dsEdit] then dbgrdh1.DataSource.DataSet.Post;
  end;
end;

procedure TfmUserSettings.Button1Click(Sender: TObject);
begin
  if dbgrdh1.DataSource.DataSet.State in [dsEdit] then dbgrdh1.DataSource.DataSet.Cancel;
end;

procedure TfmUserSettings.Button2Click(Sender: TObject);
var x :TBytes;
begin
  with fmMain do begin
//    nxtblSites.DisableControls;
//    x:=nxtblSites.GetBookmark;
//    nxtblSites.First;
//    while not nxtblSites.Eof do begin
//      if nxtblSites.FieldByName('Enabled').AsBoolean
//      then CheckCategoryVersion(SiteCodeType(GetEnumValue(TypeInfo(SiteCodeType),nxtblSites.FieldByName('SiteCode').AsString)),false);
//      nxtblSites.Next;
//    end;
//    nxtblSites.GotoBookmark(x);
//    nxtblSites.EnableControls;
      CheckCategoryVersion(SiteCodeType(GetEnumValue(TypeInfo(SiteCodeType),nxtblSites.FieldByName('SiteCode').AsString)),false);
  end;
end;

procedure TfmUserSettings.Button3Click(Sender: TObject);
begin
  with fmMain do GetDetails(SiteCodeType(GetEnumValue(TypeInfo(SiteCodeType),nxtblSites.FieldByName('SiteCode').AsString)));
end;

procedure TfmUserSettings.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if dbgrdh1.DataSource.DataSet.State in [dsEdit] then dbgrdh1.DataSource.DataSet.Cancel;
end;

procedure TfmUserSettings.FormCreate(Sender: TObject);
begin
  {$IFDEF DEMO}
  edt1.Enabled := false;
  edt2.Enabled := false;
  edt3.Enabled := false;
  mmo1.Enabled := false;
  {$ENDIF}
end;

procedure TfmUserSettings.FormShow(Sender: TObject);
begin
  with fmMain.IniSettings do begin
    edt1.Text := ebay.AppID;
    edt2.Text := ebay.DevID;
    edt3.Text := ebay.CertID;
    mmo1.Text := ebay.Token;
  end;
end;

end.

