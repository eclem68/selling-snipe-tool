unit uEbayProfile;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter, cxPC, GridsEh,
  DBGridEh, StdCtrls, DB, nxdb, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCheckComboBox, cxDBCheckComboBox, ExtCtrls, cxLookupEdit,
  cxDBLookupEdit, cxDBLookupComboBox, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxDBData, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView, cxGrid, cxMemo,
  cxDBEdit, cxGroupBox, cxCheckGroup, cxDBCheckGroup;

type
  TfmEbayProfiles = class(TForm)
    cxtbcntrl1: TcxTabControl;
    ds1: TDataSource;
    ds2: TDataSource;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    bvl1: TBevel;
    ds3: TDataSource;
    cbb1: TcxDBLookupComboBox;
    nxtblebaypref: TnxTable;
    ds4: TDataSource;
    ds5: TDataSource;
    cbb2: TcxDBLookupComboBox;
    cbb3: TcxDBLookupComboBox;
    cbb4: TcxDBLookupComboBox;
    cbb5: TcxDBLookupComboBox;
    cbb6: TcxDBLookupComboBox;
    nxtblSites: TnxTable;
    ds6: TDataSource;
    nxtblShippingService: TnxQuery;
    nxtblShippingServiceIn: TnxQuery;
    nxtblPaymentOption: TnxTable;
    nxtblShippingLocation: TnxTable;
    cxgrpbx1: TcxGroupBox;
    cxdbm1: TcxDBMemo;
    cxgrpbx2: TcxGroupBox;
    cxdbm3: TcxDBMemo;
    cbb7: TcxDBLookupComboBox;
    lbl10: TLabel;
    lbl11: TLabel;
    lbl12: TLabel;
    lbl13: TLabel;
    lbl14: TLabel;
    lbl15: TLabel;
    nxqry1: TnxQuery;
    ds7: TDataSource;
    nxqry2: TnxQuery;
    ds8: TDataSource;
    nxqry3: TnxQuery;
    ds9: TDataSource;
    nxqry4: TnxQuery;
    ds10: TDataSource;
    cbb8: TcxDBLookupComboBox;
    cbb9: TcxDBLookupComboBox;
    cbb10: TcxDBLookupComboBox;
    pnl1: TPanel;
    btn2: TButton;
    btn3: TButton;
    cxdbchckgrp1: TcxDBCheckGroup;
    cxdbchckgrp2: TcxDBCheckGroup;
    procedure FormShow(Sender: TObject);
    procedure nxtblShippingServiceAfterOpen(DataSet: TDataSet);
    procedure cxtbcntrl1Change(Sender: TObject);
    procedure btn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmEbayProfiles: TfmEbayProfiles;

implementation

uses uMain;

{$R *.dfm}

procedure TfmEbayProfiles.btn2Click(Sender: TObject);
begin
  nxtblebaypref.Post;
end;

procedure TfmEbayProfiles.cxtbcntrl1Change(Sender: TObject);
begin
  if not nxtblSites.Active then nxtblSites.Open;
  nxtblSites.Locate('Comment',cxtbcntrl1.Tabs[cxtbcntrl1.TabIndex].Caption,[]);
  cxdbchckgrp1.Properties.Items.Clear;
  nxtblPaymentOption.First;
  while not nxtblPaymentOption.Eof do begin
    with cxdbchckgrp1.Properties.Items.Add do begin
      Caption := nxtblPaymentOption.FieldByName('name').AsString;
    end;
    nxtblPaymentOption.Next;
  end;
  cxdbchckgrp2.Properties.Items.Clear;
  nxtblShippingLocation.First;
  while not nxtblShippingLocation.Eof do begin
    with cxdbchckgrp2.Properties.Items.Add do begin
      Caption := nxtblShippingLocation.FieldByName('name').AsString;
    end;
    nxtblShippingLocation.Next;
  end;
end;

procedure TfmEbayProfiles.FormShow(Sender: TObject);
begin
  if not nxtblSites.Active then nxtblSites.Open;
  nxtblSites.First;
  if not nxtblPaymentOption.Active then nxtblPaymentOption.Open;
  if not nxtblShippingLocation.Active then nxtblShippingLocation.Open;
  if not nxtblShippingService.Active then nxtblShippingService.Open;
  if not nxtblShippingServiceIn.Active then nxtblShippingServiceIn.Open;

  if not nxqry1.Active then nxqry1.Open;
  if not nxqry2.Active then nxqry2.Open;
  if not nxqry3.Active then nxqry3.Open;
  if not nxqry4.Active then nxqry4.Open;

  if not nxtblebaypref.Active then nxtblebaypref.Open;
  cxtbcntrl1.Tabs.Clear;
  while not nxtblSites.Eof do begin
    cxtbcntrl1.Tabs.Add(nxtblSites.FieldByName('Comment').AsString);
    nxtblSites.Next;
  end;
  cxtbcntrl1Change(Sender);
end;

procedure TfmEbayProfiles.nxtblShippingServiceAfterOpen(DataSet: TDataSet);
begin
//  nxtblShippingService.First;
//  while not nxtblShippingService.Eof do begin
//    cbb8.Properties.Items.Add(
end;

end.
