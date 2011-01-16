object fmSiteSelector: TfmSiteSelector
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Select Ebay site'
  ClientHeight = 205
  ClientWidth = 250
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object btn1: TButton
    Left = 32
    Top = 168
    Width = 75
    Height = 25
    Caption = 'Select'
    ModalResult = 1
    TabOrder = 0
    OnClick = btn1Click
  end
  object btn2: TButton
    Left = 144
    Top = 168
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object cxrdgrp1: TcxRadioGroup
    Left = 8
    Top = 8
    Caption = 'Available sites'
    Properties.Items = <>
    TabOrder = 2
    Height = 154
    Width = 234
  end
  object nxqryActiveSites: TnxQuery
    Database = fmMain.nxdtbs1
    SQL.Strings = (
      'select * from Sites where Enabled=true')
    Left = 16
  end
  object ds1: TDataSource
    DataSet = nxqryActiveSites
    Left = 104
  end
  object nxqrySitePref: TnxQuery
    Database = fmMain.nxdtbs1
    DataSource = ds1
    SQL.Strings = (
      'SELECT * FROM "ebaypreferences" where SiteID=:SiteCode')
    Left = 80
    Top = 56
    ParamData = <
      item
        DataType = ftString
        Name = 'SiteCode'
        ParamType = ptInput
      end>
  end
  object ds2: TDataSource
    DataSet = nxqrySitePref
    Left = 144
    Top = 56
  end
end
