object fmUserSettings: TfmUserSettings
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'User Settings'
  ClientHeight = 632
  ClientWidth = 445
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 8
    Top = 184
    Width = 68
    Height = 13
    Caption = 'Available sites'
  end
  object lbl2: TLabel
    Left = 16
    Top = 11
    Width = 30
    Height = 13
    Caption = 'AppID'
  end
  object lbl3: TLabel
    Left = 16
    Top = 38
    Width = 30
    Height = 13
    Caption = 'DevID'
  end
  object lbl4: TLabel
    Left = 14
    Top = 65
    Width = 32
    Height = 13
    Caption = 'CertID'
  end
  object lbl5: TLabel
    Left = 17
    Top = 128
    Width = 29
    Height = 13
    Caption = 'Token'
  end
  object Bevel1: TBevel
    Left = 8
    Top = 583
    Width = 429
    Height = 10
    Shape = bsTopLine
  end
  object edt1: TEdit
    Left = 52
    Top = 8
    Width = 245
    Height = 21
    TabOrder = 0
    Text = 'edt1'
  end
  object edt2: TEdit
    Left = 52
    Top = 35
    Width = 245
    Height = 21
    TabOrder = 1
    Text = 'edt1'
  end
  object edt3: TEdit
    Left = 52
    Top = 62
    Width = 245
    Height = 21
    TabOrder = 2
    Text = 'edt1'
  end
  object mmo1: TMemo
    Left = 52
    Top = 89
    Width = 381
    Height = 89
    ScrollBars = ssVertical
    TabOrder = 3
  end
  object btn1: TButton
    Left = 136
    Top = 599
    Width = 75
    Height = 25
    Caption = 'Save'
    ModalResult = 1
    TabOrder = 4
    OnClick = btn1Click
  end
  object Button1: TButton
    Left = 232
    Top = 599
    Width = 75
    Height = 25
    Caption = 'Close'
    ModalResult = 2
    TabOrder = 5
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 546
    Width = 105
    Height = 25
    Caption = 'Update categories'
    TabOrder = 6
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 119
    Top = 546
    Width = 105
    Height = 25
    Caption = 'Update ebay details'
    TabOrder = 7
    OnClick = Button3Click
  end
  object dbgrdh1: TDBGridEh
    Left = 8
    Top = 203
    Width = 429
    Height = 337
    AutoFitColWidths = True
    DataGrouping.GroupLevels = <>
    DataSource = ds1
    Flat = False
    FooterColor = clWindow
    FooterFont.Charset = DEFAULT_CHARSET
    FooterFont.Color = clWindowText
    FooterFont.Height = -11
    FooterFont.Name = 'Tahoma'
    FooterFont.Style = []
    RowDetailPanel.Color = clBtnFace
    TabOrder = 8
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    UseMultiTitle = True
    Columns = <
      item
        EditButtons = <>
        FieldName = 'Comment'
        Footers = <>
        Title.Caption = 'Site'
        Width = 280
      end
      item
        EditButtons = <>
        FieldName = 'Enabled'
        Footers = <>
        Width = 58
      end
      item
        EditButtons = <>
        FieldName = 'Version'
        Footers = <>
      end
      item
        EditButtons = <>
        FieldName = 'LastUpdated'
        Footers = <>
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object ds1: TDataSource
    DataSet = fmMain.nxtblSites
    Left = 376
    Top = 544
  end
end
