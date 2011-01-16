unit uTst;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TradingServiceXMLClasses, EbayConnect, StdCtrls;

type
  TfmTest = class(TForm)
    ebytrdngcnct1: TEbayTradingConnect;
    gtbyfcltm1: TGeteBayOfficialTime;
    mmo1: TMemo;
    mmo2: TMemo;
    btn1: TButton;
    lbl1: TLabel;
    upldsthstdpctrs1: TUploadSiteHostedPictures;
    btn2: TButton;
    procedure btn1Click(Sender: TObject);
    procedure gtbyfcltm1EndRequest(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure upldsthstdpctrs1EndRequest(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmTest: TfmTest;

implementation

{$R *.dfm}

procedure TfmTest.btn1Click(Sender: TObject);
begin
  gtbyfcltm1.DoRequestEx;
end;

procedure TfmTest.btn2Click(Sender: TObject);
begin
  upldsthstdpctrs1.LocalPicturePath := 'images\2010-07-01_013140.jpg';
  upldsthstdpctrs1.DoRequestEx;
end;

procedure TfmTest.gtbyfcltm1EndRequest(Sender: TObject);
begin
  mmo1.Text := gtbyfcltm1.RequestXMLDoc.XML.Text;
  mmo2.Text := gtbyfcltm1.ResponseXMLDoc.XML.Text;
  lbl1.Caption := gtbyfcltm1.Timestamp;
end;

procedure TfmTest.upldsthstdpctrs1EndRequest(Sender: TObject);
begin
  mmo1.Text := upldsthstdpctrs1.RequestXMLDoc.XML.Text;
  mmo2.Text := upldsthstdpctrs1.ResponseXMLDoc.XML.Text;
end;

end.
