unit uSiteSelector;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, nxdb, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore,
  dxSkinsDefaultPainters, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxDBEdit,
  cxGroupBox, cxRadioGroup, StdCtrls;

type
  TfmSiteSelector = class(TForm)
    nxqryActiveSites: TnxQuery;
    ds1: TDataSource;
    btn1: TButton;
    btn2: TButton;
    cxrdgrp1: TcxRadioGroup;
    nxqrySitePref: TnxQuery;
    ds2: TDataSource;
    procedure btn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmSiteSelector: TfmSiteSelector;

implementation

uses uMain;

{$R *.dfm}

procedure TfmSiteSelector.btn1Click(Sender: TObject);
begin
  if nxqryActiveSites.Active then nxqryActiveSites.Close;
  nxqryActiveSites.SQL.Clear;
  nxqryActiveSites.SQL.Add(Format('select * from Sites where SiteCode=%s',[QuotedStr(cxrdgrp1.EditValue)]));
  if not nxqryActiveSites.Active then nxqryActiveSites.Open;
  if not nxqrySitePref.Active then nxqrySitePref.Open;

  fmMain.nxtblItems.Insert;
  fmMain.nxtblItems.FieldByName('Currency').AsString := nxqryActiveSites.FieldByName('Currency').AsString;
  fmMain.nxtblItems.FieldByName('SiteID').AsString := nxqryActiveSites.FieldByName('SiteCode').AsString;
  fmMain.nxtblItems.FieldByName('ShippingService1').AsInteger := nxqrySitePref.FieldByName('ShippingService1').AsInteger;
  fmMain.nxtblItems.FieldByName('ShippingService2').AsInteger := nxqrySitePref.FieldByName('ShippingService2').AsInteger;
  fmMain.nxtblItems.FieldByName('ShippingService3').AsInteger := nxqrySitePref.FieldByName('ShippingService3').AsInteger;
  fmMain.nxtblItems.FieldByName('InShippingService1').AsInteger := nxqrySitePref.FieldByName('InShippingService1').AsInteger;
  fmMain.nxtblItems.FieldByName('InShippingService2').AsInteger := nxqrySitePref.FieldByName('InShippingService2').AsInteger;
  fmMain.nxtblItems.FieldByName('InShippingService3').AsInteger := nxqrySitePref.FieldByName('InShippingService3').AsInteger;
  fmMain.nxtblItems.FieldByName('PaymentPolicy').AsString := nxqrySitePref.FieldByName('PaymentPolicy').AsString;
  fmMain.nxtblItems.FieldByName('RP_Description').AsString := nxqrySitePref.FieldByName('RP_Description').AsString;
  fmMain.nxtblItems.FieldByName('PR_Refund').AsString := nxqrySitePref.FieldByName('RP_Refund').AsString;
  fmMain.nxtblItems.FieldByName('RP_ReturnsWithin').AsString := nxqrySitePref.FieldByName('RP_ReturnsWithin').AsString;
  fmMain.nxtblItems.FieldByName('RP_ReturnsAccepted').AsString := nxqrySitePref.FieldByName('RP_ReturnsAccepted').AsString;
  fmMain.nxtblItems.FieldByName('RP_ShippingCostPaidBy').AsString := nxqrySitePref.FieldByName('RP_ShippingCostPaidBy').AsString;
  fmMain.nxtblItems.FieldByName('PaymentMethods').AsString := nxqrySitePref.FieldByName('PaymentOptions').AsString;
  fmMain.nxtblItems.FieldByName('ShipToLocations').AsString := nxqrySitePref.FieldByName('ShippingLocations').AsString;
  fmMain.nxtblItems.Post;
end;

procedure TfmSiteSelector.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  nxqryActiveSites.Close;
end;

procedure TfmSiteSelector.FormShow(Sender: TObject);
begin
  if nxqryActiveSites.Active then nxqryActiveSites.Close;
  nxqryActiveSites.SQL.Clear;
  nxqryActiveSites.SQL.Add('select * from Sites where Enabled=true');
  if not nxqryActiveSites.Active then nxqryActiveSites.Open;
  cxrdgrp1.Properties.Items.Clear;
  nxqryActiveSites.First;
  while not nxqryActiveSites.Eof do begin
    cxrdgrp1.Properties.Items.Add;
    cxrdgrp1.Properties.Items[cxrdgrp1.Properties.Items.Count - 1].Caption := nxqryActiveSites.FieldByName('Comment').AsString;
    cxrdgrp1.Properties.Items[cxrdgrp1.Properties.Items.Count - 1].Value := nxqryActiveSites.FieldByName('SiteCode').AsString;
    nxqryActiveSites.Next;
  end;
end;

end.
