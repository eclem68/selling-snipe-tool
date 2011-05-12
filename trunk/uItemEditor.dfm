object fmItemEditor: TfmItemEditor
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Item Editor'
  ClientHeight = 640
  ClientWidth = 1055
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object cxpgcntrl1: TcxPageControl
    Left = 0
    Top = 0
    Width = 1055
    Height = 576
    ActivePage = cxtbsht1
    Align = alClient
    TabOrder = 0
    ClientRectBottom = 573
    ClientRectLeft = 3
    ClientRectRight = 1052
    ClientRectTop = 23
    object cxtbsht1: TcxTabSheet
      Caption = 'General info'
      ImageIndex = 0
      object lbl1: TLabel
        Left = 32
        Top = 6
        Width = 20
        Height = 13
        Caption = 'Title'
      end
      object lbl2: TLabel
        Left = 16
        Top = 33
        Width = 36
        Height = 13
        Caption = 'Subtitle'
      end
      object lbl3: TLabel
        Left = 16
        Top = 61
        Width = 52
        Height = 13
        Caption = 'Categories'
      end
      object lbl8: TLabel
        Left = 82
        Top = 270
        Width = 23
        Height = 13
        Caption = 'Price'
      end
      object lbl9: TLabel
        Left = 33
        Top = 298
        Width = 72
        Height = 13
        Caption = 'Reserved price'
      end
      object lbl10: TLabel
        Left = 32
        Top = 326
        Width = 73
        Height = 13
        Caption = 'BuyItNow price'
      end
      object lbl11: TLabel
        Left = 61
        Top = 242
        Width = 44
        Height = 13
        Caption = 'Currency'
      end
      object lbl12: TLabel
        Left = 392
        Top = 242
        Width = 42
        Height = 13
        Caption = 'Quantity'
      end
      object lbl13: TLabel
        Left = 390
        Top = 270
        Width = 36
        Height = 13
        Caption = 'Lot size'
      end
      object JvSpeedButton1: TJvSpeedButton
        Left = 500
        Top = 113
        Width = 25
        Height = 25
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FF96909696909696909696909696909696
          9096969096969096969096969096969096969096FF00FFFF00FFFF00FFFF00FF
          969096FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FF969096FF00FFFF00FFFF00FF0C02A581808BFFFFFFEFEFEFC8C8D20C02A5EC
          ECECEBEBEBEAEAEAE9E9E9E8E8E8FFFFFF969096FF00FFFF00FF0C02A53053E0
          0C02A5D3D3D4C7C7C80C02A5123AE00C02A5EDEDEDECECECEBEBEBEAEAEAFFFF
          FF969096FF00FFFF00FFDC12E50C02A52D5AFF0C02A50C02A52150FF0C02A5CA
          C9D3EFEFEFEEEEEEEDEDEDECECECFFFFFF969096FF00FFFF00FFFF00FFD300D4
          0C02A52850F4254FF40C02A5C8C8C9F1F1F1F1F1F1F0F0F0EFEFEFEEEEEEFFFF
          FF969096FF00FFFF00FFFF00FFD300D40C02A5305EFA2C57F70C02A5C9C9CBF3
          F3F3F2F2F2F1F1F1F1F1F1F0F0F0FFFFFF969096FF00FFFF00FFDC11E50C02A5
          407DFF0C02A50C02A5376CFF0C02A5CDCCD7F4F4F4F3F3F3F2F2F2F1F1F1FFFF
          FF969096FF00FFFF00FF0C02A57C93E50C02A5D3D3D4CECED00C02A54F6CE10C
          02A5F6F6F6F5F5F5F4F4F4F3F3F3F5F5F5969096FF00FFFF00FFFF00FF0C02A5
          80808BFFFFFFFBFBFBD0D0DB0C02A5F9F9F9F8F8F89690969690969690969690
          96969096FF00FFFF00FFFF00FFFF00FF969096FFFFFFFDFDFDFCFCFCFBFBFBFA
          FAFAFAFAFA969096E1E1E1E1E1E1B7B1B7969096FF00FFFF00FFFF00FFFF00FF
          969096FFFFFFFFFFFFFEFEFEFDFDFDFCFCFCFBFBFB969096E1E1E1B7B1B79690
          96FF00FFFF00FFFF00FFFF00FFFF00FF969096FFFFFFFFFFFFFFFFFFFEFEFEFE
          FEFEFDFDFD969096B7B1B7969096FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          969096969096969096969096969096969096969096969096969096FF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'Tahoma'
        HotTrackFont.Style = []
        OnClick = JvSpeedButton1Click
      end
      object JvSpeedButton2: TJvSpeedButton
        Left = 500
        Top = 140
        Width = 25
        Height = 25
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FF96909696909696909696909696909696
          9096969096969096969096969096969096969096FF00FFFF00FFFF00FFFF00FF
          969096FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FF969096FF00FFFF00FFFF00FF0C02A581808BFFFFFFEFEFEFC8C8D20C02A5EC
          ECECEBEBEBEAEAEAE9E9E9E8E8E8FFFFFF969096FF00FFFF00FF0C02A53053E0
          0C02A5D3D3D4C7C7C80C02A5123AE00C02A5EDEDEDECECECEBEBEBEAEAEAFFFF
          FF969096FF00FFFF00FFDC12E50C02A52D5AFF0C02A50C02A52150FF0C02A5CA
          C9D3EFEFEFEEEEEEEDEDEDECECECFFFFFF969096FF00FFFF00FFFF00FFD300D4
          0C02A52850F4254FF40C02A5C8C8C9F1F1F1F1F1F1F0F0F0EFEFEFEEEEEEFFFF
          FF969096FF00FFFF00FFFF00FFD300D40C02A5305EFA2C57F70C02A5C9C9CBF3
          F3F3F2F2F2F1F1F1F1F1F1F0F0F0FFFFFF969096FF00FFFF00FFDC11E50C02A5
          407DFF0C02A50C02A5376CFF0C02A5CDCCD7F4F4F4F3F3F3F2F2F2F1F1F1FFFF
          FF969096FF00FFFF00FF0C02A57C93E50C02A5D3D3D4CECED00C02A54F6CE10C
          02A5F6F6F6F5F5F5F4F4F4F3F3F3F5F5F5969096FF00FFFF00FFFF00FF0C02A5
          80808BFFFFFFFBFBFBD0D0DB0C02A5F9F9F9F8F8F89690969690969690969690
          96969096FF00FFFF00FFFF00FFFF00FF969096FFFFFFFDFDFDFCFCFCFBFBFBFA
          FAFAFAFAFA969096E1E1E1E1E1E1B7B1B7969096FF00FFFF00FFFF00FFFF00FF
          969096FFFFFFFFFFFFFEFEFEFDFDFDFCFCFCFBFBFB969096E1E1E1B7B1B79690
          96FF00FFFF00FFFF00FFFF00FFFF00FF969096FFFFFFFFFFFFFFFFFFFEFEFEFE
          FEFEFDFDFD969096B7B1B7969096FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          969096969096969096969096969096969096969096969096969096FF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'Tahoma'
        HotTrackFont.Style = []
        OnClick = JvSpeedButton2Click
      end
      object cxdbtxtdt1: TcxDBTextEdit
        Tag = 2
        Left = 58
        Top = 3
        DataBinding.DataField = 'Title'
        DataBinding.DataSource = dsItems
        Properties.ClearKey = 46
        Properties.OnChange = cxdbtxtdt1PropertiesChange
        TabOrder = 0
        Width = 468
      end
      object cxdbtxtdt2: TcxDBTextEdit
        Tag = 4
        Left = 58
        Top = 34
        DataBinding.DataField = 'SubTitle'
        DataBinding.DataSource = dsItems
        Properties.ClearKey = 46
        Properties.OnChange = cxdbtxtdt1PropertiesChange
        TabOrder = 1
        Width = 468
      end
      object cxpgcntrl2: TcxPageControl
        Left = 13
        Top = 80
        Width = 481
        Height = 89
        ActivePage = cxtbsht4
        ImageBorder = 1
        LookAndFeel.Kind = lfStandard
        TabOrder = 2
        TabSlants.Kind = skCutCorner
        TabSlants.Positions = []
        OnChange = cxpgcntrl2Change
        ClientRectBottom = 86
        ClientRectLeft = 3
        ClientRectRight = 478
        ClientRectTop = 23
        object cxtbsht4: TcxTabSheet
          Caption = 'Tree selection'
          ImageIndex = 0
          ExplicitWidth = 487
          object lbl4: TLabel
            Left = 18
            Top = 16
            Width = 84
            Height = 13
            Caption = 'Primary Category'
          end
          object lbl5: TLabel
            Left = 3
            Top = 43
            Width = 99
            Height = 13
            Caption = 'Secondary Category'
          end
          object dxdblkptrvwSecondaryCategory: TdxDBLookupTreeView
            Left = 108
            Top = 35
            Width = 370
            Height = 21
            CanSelectParents = False
            ParentColor = False
            TabOrder = 1
            TabStop = True
            Text = 'dxdblkptrvwSecondaryCategory'
            TreeViewColor = clWindow
            TreeViewCursor = crDefault
            TreeViewFont.Charset = DEFAULT_CHARSET
            TreeViewFont.Color = clWindowText
            TreeViewFont.Height = -11
            TreeViewFont.Name = 'Tahoma'
            TreeViewFont.Style = []
            TreeViewIndent = 19
            TreeViewReadOnly = False
            TreeViewShowButtons = True
            TreeViewShowHint = False
            TreeViewShowLines = True
            TreeViewShowRoot = True
            TreeViewSortType = stText
            DisplayField = 'CategoryName'
            DividedChar = '.'
            ListSource = ds1
            KeyField = 'CategoryID'
            ListField = 'CategoryName'
            Options = [trSmartRecordLoad, trSmartRecordCopy, trCheckHasChildren]
            ParentField = 'CategoryParentID'
            RootValue = -1
            TextStyle = tvtsShort
            DataField = 'SecondaryCategory'
            DataSource = dsItems
          end
          object dxdblkptrvwPrimaryCategory: TdxDBLookupTreeView
            Left = 108
            Top = 8
            Width = 370
            Height = 21
            CanSelectParents = False
            ParentColor = False
            TabOrder = 0
            TabStop = True
            Text = 'dxdblkptrvwPrimaryCategory'
            TreeViewColor = clWindow
            TreeViewCursor = crDefault
            TreeViewFont.Charset = DEFAULT_CHARSET
            TreeViewFont.Color = clWindowText
            TreeViewFont.Height = -11
            TreeViewFont.Name = 'Tahoma'
            TreeViewFont.Style = []
            TreeViewIndent = 19
            TreeViewReadOnly = False
            TreeViewShowButtons = True
            TreeViewShowHint = False
            TreeViewShowLines = True
            TreeViewShowRoot = True
            TreeViewSortType = stText
            DisplayField = 'CategoryName'
            DividedChar = '.'
            ListSource = ds1
            KeyField = 'CategoryID'
            ListField = 'CategoryName'
            Options = [trCanDBNavigate, trSmartRecordLoad, trSmartRecordCopy, trCheckHasChildren]
            ParentField = 'CategoryParentID'
            RootValue = -1
            TextStyle = tvtsShort
            DataField = 'PrimaryCategory'
            DataSource = dsItems
          end
        end
        object cxtbsht5: TcxTabSheet
          Caption = 'Keyword suggested'
          ImageIndex = 1
          ExplicitWidth = 507
          object lbl6: TLabel
            Left = 18
            Top = 16
            Width = 84
            Height = 13
            Caption = 'Primary Category'
          end
          object lbl7: TLabel
            Left = 3
            Top = 43
            Width = 99
            Height = 13
            Caption = 'Secondary Category'
          end
          object cbb1: TcxDBLookupComboBox
            Left = 108
            Top = 12
            DataBinding.DataField = 'PrimaryCategory'
            DataBinding.DataSource = dsItems
            Properties.ClearKey = 46
            Properties.KeyFieldNames = 'CategoryID'
            Properties.ListColumns = <
              item
                Caption = 'Category Name'
                FieldName = 'CategoryName'
              end
              item
                Caption = 'Percent Found'
                SortOrder = soDescending
                FieldName = 'PercentItemFound'
              end
              item
                Caption = 'ID'
                Sorting = False
                FieldName = 'CategoryID'
              end>
            Properties.ListSource = ds2
            TabOrder = 0
            Width = 365
          end
          object cbb2: TcxDBLookupComboBox
            Left = 108
            Top = 39
            DataBinding.DataField = 'SecondaryCategory'
            DataBinding.DataSource = dsItems
            Properties.ClearKey = 46
            Properties.KeyFieldNames = 'CategoryID'
            Properties.ListColumns = <
              item
                Caption = 'Category Name'
                FieldName = 'CategoryName'
              end
              item
                Caption = 'Percent Found'
                SortOrder = soDescending
                FieldName = 'PercentItemFound'
              end
              item
                Caption = 'ID'
                Sorting = False
                FieldName = 'CategoryID'
              end>
            Properties.ListSource = ds2
            TabOrder = 1
            Width = 365
          end
        end
      end
      object cbb3: TcxDBLookupComboBox
        Left = 121
        Top = 239
        DataBinding.DataField = 'Currency'
        DataBinding.DataSource = dsItems
        Properties.ClearKey = 46
        Properties.ImmediatePost = True
        Properties.KeyFieldNames = 'Code'
        Properties.ListColumns = <
          item
            FieldName = 'Name'
          end>
        Properties.ListOptions.AnsiSort = True
        Properties.ListSource = ds3
        TabOrder = 3
        Width = 121
      end
      object cxdbclcdt1: TcxDBCalcEdit
        Left = 121
        Top = 266
        DataBinding.DataField = 'Price'
        DataBinding.DataSource = dsItems
        Properties.ClearKey = 46
        TabOrder = 4
        Width = 121
      end
      object cxdbclcdt2: TcxDBCalcEdit
        Left = 121
        Top = 295
        DataBinding.DataField = 'ReservePrice'
        DataBinding.DataSource = dsItems
        Properties.ClearKey = 46
        TabOrder = 5
        Width = 121
      end
      object cxdbclcdt3: TcxDBCalcEdit
        Left = 121
        Top = 323
        DataBinding.DataField = 'BuyItNowPrice'
        DataBinding.DataSource = dsItems
        Properties.ClearKey = 46
        TabOrder = 6
        Width = 121
      end
      object cxdblbl1: TcxDBLabel
        Left = 248
        Top = 268
        DataBinding.DataField = 'Currency'
        DataBinding.DataSource = dsItems
        Height = 21
        Width = 65
      end
      object cxdblbl2: TcxDBLabel
        Left = 248
        Top = 296
        DataBinding.DataField = 'Currency'
        DataBinding.DataSource = dsItems
        Height = 21
        Width = 65
      end
      object cxdblbl3: TcxDBLabel
        Left = 248
        Top = 324
        DataBinding.DataField = 'Currency'
        DataBinding.DataSource = dsItems
        Height = 21
        Width = 65
      end
      object cxdbrdgrp1: TcxDBRadioGroup
        Left = 330
        Top = 289
        Caption = 'Listing type'
        DataBinding.DataField = 'ListingType'
        DataBinding.DataSource = dsItems
        Properties.ClearKey = 46
        Properties.Items = <
          item
            Caption = 'Auction'
            Value = 'Chinese'
          end
          item
            Caption = 'Fixed price'
            Value = 'FixedPriceItem'
          end>
        TabOrder = 10
        Height = 55
        Width = 194
      end
      object cxdbspndt1: TcxDBSpinEdit
        Left = 440
        Top = 239
        DataBinding.DataField = 'Quantity'
        DataBinding.DataSource = dsItems
        Properties.ClearKey = 46
        TabOrder = 11
        Width = 54
      end
      object cxpgcntrl3: TcxPageControl
        Left = 530
        Top = 127
        Width = 513
        Height = 218
        ActivePage = cxtbsht7
        ImageBorder = 1
        LookAndFeel.Kind = lfStandard
        TabOrder = 12
        TabSlants.Kind = skCutCorner
        TabSlants.Positions = []
        ClientRectBottom = 215
        ClientRectLeft = 3
        ClientRectRight = 510
        ClientRectTop = 23
        object cxtbsht6: TcxTabSheet
          Caption = 'Domestic shipping'
          ImageIndex = 0
          object lbl14: TLabel
            Left = 13
            Top = 29
            Width = 86
            Height = 13
            Caption = 'Shipping service 1'
          end
          object lbl17: TLabel
            Left = 36
            Top = 56
            Width = 63
            Height = 13
            Caption = 'Shipping cost'
          end
          object lbl18: TLabel
            Left = 269
            Top = 59
            Width = 71
            Height = 13
            Caption = 'Insurance cost'
          end
          object lbl15: TLabel
            Left = 13
            Top = 87
            Width = 86
            Height = 13
            Caption = 'Shipping service 2'
          end
          object lbl16: TLabel
            Left = 13
            Top = 144
            Width = 86
            Height = 13
            Caption = 'Shipping service 3'
          end
          object lbl26: TLabel
            Left = 269
            Top = 115
            Width = 71
            Height = 13
            Caption = 'Insurance cost'
          end
          object lbl27: TLabel
            Left = 269
            Top = 172
            Width = 71
            Height = 13
            Caption = 'Insurance cost'
          end
          object lbl28: TLabel
            Left = 36
            Top = 114
            Width = 63
            Height = 13
            Caption = 'Shipping cost'
          end
          object lbl29: TLabel
            Left = 36
            Top = 171
            Width = 63
            Height = 13
            Caption = 'Shipping cost'
          end
          object cxdbclcdt4: TcxDBCalcEdit
            Left = 105
            Top = 54
            DataBinding.DataField = 'SS1Price'
            DataBinding.DataSource = dsItems
            Properties.ClearKey = 46
            TabOrder = 0
            Width = 96
          end
          object cxdbclcdt7: TcxDBCalcEdit
            Left = 346
            Top = 54
            DataBinding.DataField = 'SS1Insurance'
            DataBinding.DataSource = dsItems
            Properties.ClearKey = 46
            TabOrder = 1
            Width = 96
          end
          object cxdblbl4: TcxDBLabel
            Left = 207
            Top = 54
            DataBinding.DataField = 'Currency'
            DataBinding.DataSource = dsItems
            Height = 21
            Width = 51
          end
          object cxdblbl7: TcxDBLabel
            Left = 448
            Top = 57
            DataBinding.DataField = 'Currency'
            DataBinding.DataSource = dsItems
            Height = 21
            Width = 51
          end
          object cxdbclcdt5: TcxDBCalcEdit
            Left = 105
            Top = 112
            DataBinding.DataField = 'SS2Price'
            DataBinding.DataSource = dsItems
            Properties.ClearKey = 46
            TabOrder = 4
            Width = 96
          end
          object cxdbclcdt6: TcxDBCalcEdit
            Left = 346
            Top = 112
            DataBinding.DataField = 'SS2Insurance'
            DataBinding.DataSource = dsItems
            Properties.ClearKey = 46
            TabOrder = 5
            Width = 96
          end
          object cxdblbl5: TcxDBLabel
            Left = 207
            Top = 112
            DataBinding.DataField = 'Currency'
            DataBinding.DataSource = dsItems
            Height = 21
            Width = 51
          end
          object cxdblbl6: TcxDBLabel
            Left = 448
            Top = 112
            DataBinding.DataField = 'Currency'
            DataBinding.DataSource = dsItems
            Height = 21
            Width = 51
          end
          object cxdbclcdt8: TcxDBCalcEdit
            Left = 105
            Top = 169
            DataBinding.DataField = 'SS3Price'
            DataBinding.DataSource = dsItems
            Properties.ClearKey = 46
            TabOrder = 8
            Width = 96
          end
          object cxdbclcdt9: TcxDBCalcEdit
            Left = 346
            Top = 169
            DataBinding.DataField = 'SS3Insurance'
            DataBinding.DataSource = dsItems
            Properties.ClearKey = 46
            TabOrder = 9
            Width = 96
          end
          object cxdblbl9: TcxDBLabel
            Left = 207
            Top = 169
            DataBinding.DataField = 'Currency'
            DataBinding.DataSource = dsItems
            Height = 21
            Width = 51
          end
          object cxdblbl17: TcxDBLabel
            Left = 448
            Top = 169
            DataBinding.DataField = 'Currency'
            DataBinding.DataSource = dsItems
            Height = 21
            Width = 51
          end
          object cbb4: TcxDBLookupComboBox
            Left = 105
            Top = 26
            DataBinding.DataField = 'ShippingService1'
            DataBinding.DataSource = dsItems
            Properties.ClearKey = 46
            Properties.ImmediatePost = True
            Properties.KeyFieldNames = 'ShippingServiceID'
            Properties.ListColumns = <
              item
                FieldName = 'Description'
              end>
            Properties.ListSource = ds5
            Properties.OnChange = cbb4PropertiesChange
            TabOrder = 12
            Width = 384
          end
          object cbb5: TcxDBLookupComboBox
            Left = 105
            Top = 81
            DataBinding.DataField = 'ShippingService2'
            DataBinding.DataSource = dsItems
            Properties.ClearKey = 46
            Properties.ImmediatePost = True
            Properties.KeyFieldNames = 'ShippingServiceID'
            Properties.ListColumns = <
              item
                FieldName = 'Description'
              end>
            Properties.ListSource = ds5
            Properties.OnChange = cbb5PropertiesChange
            TabOrder = 13
            Width = 384
          end
          object cbb6: TcxDBLookupComboBox
            Left = 105
            Top = 139
            DataBinding.DataField = 'ShippingService3'
            DataBinding.DataSource = dsItems
            Properties.ClearKey = 46
            Properties.ImmediatePost = True
            Properties.KeyFieldNames = 'ShippingServiceID'
            Properties.ListColumns = <
              item
                FieldName = 'Description'
              end>
            Properties.ListSource = ds5
            Properties.OnChange = cbb6PropertiesChange
            TabOrder = 14
            Width = 384
          end
        end
        object cxtbsht7: TcxTabSheet
          Caption = 'International shipping'
          ImageIndex = 1
          object lbl19: TLabel
            Left = 13
            Top = 29
            Width = 86
            Height = 13
            Caption = 'Shipping service 1'
          end
          object lbl20: TLabel
            Left = 36
            Top = 56
            Width = 63
            Height = 13
            Caption = 'Shipping cost'
          end
          object lbl21: TLabel
            Left = 269
            Top = 59
            Width = 71
            Height = 13
            Caption = 'Insurance cost'
          end
          object lbl22: TLabel
            Left = 13
            Top = 87
            Width = 86
            Height = 13
            Caption = 'Shipping service 2'
          end
          object lbl23: TLabel
            Left = 13
            Top = 144
            Width = 86
            Height = 13
            Caption = 'Shipping service 3'
          end
          object lbl30: TLabel
            Left = 269
            Top = 115
            Width = 71
            Height = 13
            Caption = 'Insurance cost'
          end
          object lbl31: TLabel
            Left = 269
            Top = 172
            Width = 71
            Height = 13
            Caption = 'Insurance cost'
          end
          object lbl32: TLabel
            Left = 36
            Top = 114
            Width = 63
            Height = 13
            Caption = 'Shipping cost'
          end
          object lbl33: TLabel
            Left = 36
            Top = 171
            Width = 63
            Height = 13
            Caption = 'Shipping cost'
          end
          object cxdbclcdt10: TcxDBCalcEdit
            Left = 105
            Top = 54
            DataBinding.DataField = 'ISS1Price'
            DataBinding.DataSource = dsItems
            Properties.ClearKey = 46
            TabOrder = 0
            Width = 96
          end
          object cxdbclcdt11: TcxDBCalcEdit
            Left = 346
            Top = 54
            DataBinding.DataField = 'ISS1Insurance'
            DataBinding.DataSource = dsItems
            Properties.ClearKey = 46
            TabOrder = 1
            Width = 96
          end
          object cxdblbl8: TcxDBLabel
            Left = 207
            Top = 53
            DataBinding.DataField = 'Currency'
            DataBinding.DataSource = dsItems
            Height = 21
            Width = 51
          end
          object cxdblbl10: TcxDBLabel
            Left = 448
            Top = 57
            DataBinding.DataField = 'Currency'
            DataBinding.DataSource = dsItems
            Height = 21
            Width = 51
          end
          object cxdbclcdt12: TcxDBCalcEdit
            Left = 105
            Top = 112
            DataBinding.DataField = 'ISS2Price'
            DataBinding.DataSource = dsItems
            Properties.ClearKey = 46
            TabOrder = 4
            Width = 96
          end
          object cxdbclcdt13: TcxDBCalcEdit
            Left = 346
            Top = 112
            DataBinding.DataField = 'ISS2Insurance'
            DataBinding.DataSource = dsItems
            Properties.ClearKey = 46
            TabOrder = 5
            Width = 96
          end
          object cxdblbl11: TcxDBLabel
            Left = 207
            Top = 112
            DataBinding.DataField = 'Currency'
            DataBinding.DataSource = dsItems
            Height = 21
            Width = 51
          end
          object cxdblbl12: TcxDBLabel
            Left = 448
            Top = 112
            DataBinding.DataField = 'Currency'
            DataBinding.DataSource = dsItems
            Height = 21
            Width = 51
          end
          object cxdbclcdt14: TcxDBCalcEdit
            Left = 105
            Top = 169
            DataBinding.DataField = 'ISS3Price'
            DataBinding.DataSource = dsItems
            Properties.ClearKey = 46
            TabOrder = 8
            Width = 96
          end
          object cxdbclcdt15: TcxDBCalcEdit
            Left = 346
            Top = 169
            DataBinding.DataField = 'ISS3Insurance'
            DataBinding.DataSource = dsItems
            Properties.ClearKey = 46
            TabOrder = 9
            Width = 96
          end
          object cxdblbl13: TcxDBLabel
            Left = 207
            Top = 169
            DataBinding.DataField = 'Currency'
            DataBinding.DataSource = dsItems
            Height = 21
            Width = 51
          end
          object cxdblbl14: TcxDBLabel
            Left = 448
            Top = 169
            DataBinding.DataField = 'Currency'
            DataBinding.DataSource = dsItems
            Height = 21
            Width = 51
          end
          object cbb7: TcxDBLookupComboBox
            Left = 105
            Top = 26
            DataBinding.DataField = 'InShippingService1'
            DataBinding.DataSource = dsItems
            Properties.ClearKey = 46
            Properties.ImmediatePost = True
            Properties.KeyFieldNames = 'ShippingServiceID'
            Properties.ListColumns = <
              item
                FieldName = 'Description'
              end>
            Properties.ListSource = ds5
            Properties.OnChange = cbb7PropertiesChange
            TabOrder = 12
            Width = 384
          end
          object cbb8: TcxDBLookupComboBox
            Left = 105
            Top = 81
            DataBinding.DataField = 'InShippingService2'
            DataBinding.DataSource = dsItems
            Properties.ClearKey = 46
            Properties.ImmediatePost = True
            Properties.KeyFieldNames = 'ShippingServiceID'
            Properties.ListColumns = <
              item
                FieldName = 'Description'
              end>
            Properties.ListSource = ds5
            Properties.OnChange = cbb8PropertiesChange
            TabOrder = 13
            Width = 384
          end
          object cbb9: TcxDBLookupComboBox
            Left = 105
            Top = 139
            DataBinding.DataField = 'InShippingService3'
            DataBinding.DataSource = dsItems
            Properties.ClearKey = 46
            Properties.ImmediatePost = True
            Properties.KeyFieldNames = 'ShippingServiceID'
            Properties.ListColumns = <
              item
                FieldName = 'Description'
              end>
            Properties.ListSource = ds5
            Properties.OnChange = cbb9PropertiesChange
            TabOrder = 14
            Width = 384
          end
        end
      end
      object cxdbspndt2: TcxDBSpinEdit
        Left = 440
        Top = 267
        DataBinding.DataField = 'LotSize'
        DataBinding.DataSource = dsItems
        Properties.ClearKey = 46
        TabOrder = 13
        Width = 54
      end
      object cxdbchckgrp1: TcxDBCheckGroup
        Left = 13
        Top = 351
        Caption = 'Payment methods'
        Properties.EditValueFormat = cvfCaptions
        Properties.Items = <>
        TabOrder = 14
        DataBinding.DataField = 'PaymentMethods'
        DataBinding.DataSource = dsItems
        Height = 197
        Width = 276
      end
      object cxdbchckgrp2: TcxDBCheckGroup
        Left = 532
        Top = 6
        Caption = 'Ship to locations'
        Properties.Columns = 3
        Properties.EditValueFormat = cvfCaptions
        Properties.Items = <>
        TabOrder = 15
        DataBinding.DataField = 'ShipToLocations'
        DataBinding.DataSource = dsItems
        Height = 115
        Width = 509
      end
      object cxgrpbx1: TcxGroupBox
        Left = 296
        Top = 360
        Caption = 'Payment Policy'
        TabOrder = 16
        Height = 189
        Width = 281
        object pnl5: TPanel
          Left = 2
          Top = 18
          Width = 277
          Height = 169
          Align = alClient
          TabOrder = 0
          object cxdbm1: TcxDBMemo
            Tag = 6
            Left = 8
            Top = 1
            DataBinding.DataField = 'PaymentPolicy'
            DataBinding.DataSource = dsItems
            Properties.OnChange = cxdbtxtdt1PropertiesChange
            TabOrder = 0
            Height = 160
            Width = 257
          end
        end
      end
      object cxgrpbx2: TcxGroupBox
        Left = 583
        Top = 360
        Caption = 'Return Policy'
        TabOrder = 17
        Height = 188
        Width = 460
        object pnl3: TPanel
          Left = 2
          Top = 18
          Width = 247
          Height = 168
          Align = alClient
          TabOrder = 0
          object cxdbm3: TcxDBMemo
            Tag = 8
            Left = 8
            Top = 1
            DataBinding.DataField = 'RP_Description'
            DataBinding.DataSource = dsItems
            Properties.OnChange = cxdbtxtdt1PropertiesChange
            TabOrder = 0
            Height = 160
            Width = 233
          end
        end
        object pnl4: TPanel
          Left = 249
          Top = 18
          Width = 209
          Height = 168
          Align = alRight
          TabOrder = 1
          object lbl35: TLabel
            Left = 7
            Top = -1
            Width = 35
            Height = 13
            Caption = 'Refund'
          end
          object lbl36: TLabel
            Left = 7
            Top = 39
            Width = 71
            Height = 13
            Caption = 'Returns Within'
          end
          object lbl37: TLabel
            Left = 7
            Top = 80
            Width = 86
            Height = 13
            Caption = 'Returns Accepted'
          end
          object lbl38: TLabel
            Left = 7
            Top = 120
            Width = 103
            Height = 13
            Caption = 'Shipping Cost Paid By'
          end
          object cbb11: TcxDBLookupComboBox
            Left = 7
            Top = 15
            DataBinding.DataField = 'PR_Refund'
            DataBinding.DataSource = dsItems
            Properties.ClearKey = 46
            Properties.KeyFieldNames = 'Value'
            Properties.ListColumns = <
              item
                FieldName = 'Name'
              end>
            Properties.ListSource = ds4
            TabOrder = 0
            Width = 193
          end
          object cbb12: TcxDBLookupComboBox
            Left = 7
            Top = 55
            DataBinding.DataField = 'RP_ReturnsWithin'
            DataBinding.DataSource = dsItems
            Properties.ClearKey = 46
            Properties.KeyFieldNames = 'Value'
            Properties.ListColumns = <
              item
                FieldName = 'Name'
              end>
            Properties.ListSource = ds11
            TabOrder = 1
            Width = 194
          end
          object cbb13: TcxDBLookupComboBox
            Left = 7
            Top = 96
            DataBinding.DataField = 'RP_ReturnsAccepted'
            DataBinding.DataSource = dsItems
            Properties.ClearKey = 46
            Properties.KeyFieldNames = 'Value'
            Properties.ListColumns = <
              item
                FieldName = 'Name'
              end>
            Properties.ListSource = ds9
            TabOrder = 2
            Width = 194
          end
          object cbb10: TcxDBLookupComboBox
            Left = 7
            Top = 136
            DataBinding.DataField = 'RP_ShippingCostPaidBy'
            DataBinding.DataSource = dsItems
            Properties.ClearKey = 46
            Properties.KeyFieldNames = 'Value'
            Properties.ListColumns = <
              item
                FieldName = 'Name'
              end>
            Properties.ListSource = ds10
            TabOrder = 3
            Width = 194
          end
        end
      end
    end
    object cxtbsht2: TcxTabSheet
      Caption = 'Description'
      ImageIndex = 1
      object dbwprchtxt1: TDBWPRichText
        Left = 0
        Top = 55
        Width = 1049
        Height = 495
        AutoDisplay = True
        DataField = 'Description'
        NoUpdateOnExit = False
        NoReloadOnEdit = True
        NoResetOnEscape = False
        RTFVariables = <>
        SpellCheckStrategie = wpspCheckInInit
        WPToolBar = wptlbr1
        WPRuler = wprlr1
        DefaultIOFormat = 'HTML'
        XOffset = 144
        YOffset = 144
        XBetween = 144
        YBetween = 144
        LayoutMode = wplayNormal
        PaperColor = clWhite
        AsWebpage = [wpFormatAsWebpage]
        ScrollBars = ssBoth
        EditOptions = [wpTableResizing, wpTableColumnResizing, wpObjectMoving, wpObjectResizingWidth, wpObjectResizingHeight, wpObjectResizingKeepRatio, wpObjectSelecting, wpObjectDeletion, wpSpreadsheetCursorMovement, wpActivateUndo, wpActivateUndoHotkey, wpMoveCPOnPageUpDown]
        ViewOptions = [wpTraditionalMisspellMarkers]
        FormatOptions = [wpDisableAutosizeTables]
        FormatOptionsEx = []
        ProtectedProp = []
        HyperLinkCursor = crArrow
        TextObjectCursor = crHandPoint
        InsertPointAttr.Bold = tsIgnore
        InsertPointAttr.Italic = tsIgnore
        InsertPointAttr.DoubleUnderline = False
        InsertPointAttr.Underline = tsIgnore
        InsertPointAttr.StrikeOut = tsIgnore
        InsertPointAttr.StrikeOutColor = clBlack
        InsertPointAttr.SuperScript = tsIgnore
        InsertPointAttr.SubScript = tsIgnore
        InsertPointAttr.Hidden = False
        InsertPointAttr.UnderlineColor = clBlack
        InsertPointAttr.TextColor = clRed
        InsertPointAttr.BackgroundColor = clBlack
        InsertPointAttr.UseUnderlineColor = False
        InsertPointAttr.UseTextColor = True
        InsertPointAttr.UseBackgroundColor = False
        HyperlinkTextAttr.Bold = tsIgnore
        HyperlinkTextAttr.Italic = tsIgnore
        HyperlinkTextAttr.DoubleUnderline = False
        HyperlinkTextAttr.Underline = tsTRUE
        HyperlinkTextAttr.StrikeOut = tsIgnore
        HyperlinkTextAttr.StrikeOutColor = clBlack
        HyperlinkTextAttr.SuperScript = tsIgnore
        HyperlinkTextAttr.SubScript = tsIgnore
        HyperlinkTextAttr.Hidden = False
        HyperlinkTextAttr.UnderlineColor = clBlue
        HyperlinkTextAttr.TextColor = clBlack
        HyperlinkTextAttr.BackgroundColor = clBlack
        HyperlinkTextAttr.UseUnderlineColor = True
        HyperlinkTextAttr.UseTextColor = False
        HyperlinkTextAttr.UseBackgroundColor = False
        HyperlinkTextAttr.HotUnderlineColor = clRed
        HyperlinkTextAttr.HotTextColor = clRed
        HyperlinkTextAttr.HotUnderline = tsTRUE
        HyperlinkTextAttr.HotStyleIsActive = True
        BookmarkTextAttr.Bold = tsIgnore
        BookmarkTextAttr.Italic = tsIgnore
        BookmarkTextAttr.DoubleUnderline = False
        BookmarkTextAttr.Underline = tsIgnore
        BookmarkTextAttr.StrikeOut = tsIgnore
        BookmarkTextAttr.StrikeOutColor = clBlack
        BookmarkTextAttr.SuperScript = tsIgnore
        BookmarkTextAttr.SubScript = tsIgnore
        BookmarkTextAttr.Hidden = False
        BookmarkTextAttr.UnderlineColor = clBlack
        BookmarkTextAttr.TextColor = clBlack
        BookmarkTextAttr.BackgroundColor = clBlack
        BookmarkTextAttr.UseUnderlineColor = False
        BookmarkTextAttr.UseTextColor = False
        BookmarkTextAttr.UseBackgroundColor = False
        SPANObjectTextAttr.Bold = tsIgnore
        SPANObjectTextAttr.Italic = tsIgnore
        SPANObjectTextAttr.DoubleUnderline = False
        SPANObjectTextAttr.Underline = tsIgnore
        SPANObjectTextAttr.StrikeOut = tsIgnore
        SPANObjectTextAttr.StrikeOutColor = clBlack
        SPANObjectTextAttr.SuperScript = tsIgnore
        SPANObjectTextAttr.SubScript = tsIgnore
        SPANObjectTextAttr.Hidden = False
        SPANObjectTextAttr.UnderlineColor = clBlack
        SPANObjectTextAttr.TextColor = clBlack
        SPANObjectTextAttr.BackgroundColor = clBlack
        SPANObjectTextAttr.UseUnderlineColor = False
        SPANObjectTextAttr.UseTextColor = False
        SPANObjectTextAttr.UseBackgroundColor = False
        HiddenTextAttr.Bold = tsIgnore
        HiddenTextAttr.Italic = tsIgnore
        HiddenTextAttr.DoubleUnderline = False
        HiddenTextAttr.Underline = tsIgnore
        HiddenTextAttr.StrikeOut = tsIgnore
        HiddenTextAttr.StrikeOutColor = clBlack
        HiddenTextAttr.SuperScript = tsIgnore
        HiddenTextAttr.SubScript = tsIgnore
        HiddenTextAttr.Hidden = True
        HiddenTextAttr.UnderlineColor = clBlack
        HiddenTextAttr.TextColor = clBlack
        HiddenTextAttr.BackgroundColor = clBlack
        HiddenTextAttr.UseUnderlineColor = False
        HiddenTextAttr.UseTextColor = False
        HiddenTextAttr.UseBackgroundColor = False
        AutomaticTextAttr.Bold = tsIgnore
        AutomaticTextAttr.Italic = tsIgnore
        AutomaticTextAttr.DoubleUnderline = False
        AutomaticTextAttr.Underline = tsIgnore
        AutomaticTextAttr.StrikeOut = tsIgnore
        AutomaticTextAttr.StrikeOutColor = clBlack
        AutomaticTextAttr.SuperScript = tsIgnore
        AutomaticTextAttr.SubScript = tsIgnore
        AutomaticTextAttr.Hidden = False
        AutomaticTextAttr.UnderlineColor = clBlack
        AutomaticTextAttr.TextColor = clBlack
        AutomaticTextAttr.BackgroundColor = clBlack
        AutomaticTextAttr.UseUnderlineColor = False
        AutomaticTextAttr.UseTextColor = False
        AutomaticTextAttr.UseBackgroundColor = False
        ProtectedTextAttr.Bold = tsIgnore
        ProtectedTextAttr.Italic = tsIgnore
        ProtectedTextAttr.DoubleUnderline = False
        ProtectedTextAttr.Underline = tsIgnore
        ProtectedTextAttr.StrikeOut = tsIgnore
        ProtectedTextAttr.StrikeOutColor = clBlack
        ProtectedTextAttr.SuperScript = tsIgnore
        ProtectedTextAttr.SubScript = tsIgnore
        ProtectedTextAttr.Hidden = False
        ProtectedTextAttr.UnderlineColor = clBlack
        ProtectedTextAttr.TextColor = clBlack
        ProtectedTextAttr.BackgroundColor = clBlack
        ProtectedTextAttr.UseUnderlineColor = False
        ProtectedTextAttr.UseTextColor = False
        ProtectedTextAttr.UseBackgroundColor = False
        FieldObjectTextAttr.Bold = tsIgnore
        FieldObjectTextAttr.Italic = tsIgnore
        FieldObjectTextAttr.DoubleUnderline = False
        FieldObjectTextAttr.Underline = tsIgnore
        FieldObjectTextAttr.StrikeOut = tsIgnore
        FieldObjectTextAttr.StrikeOutColor = clBlack
        FieldObjectTextAttr.SuperScript = tsIgnore
        FieldObjectTextAttr.SubScript = tsIgnore
        FieldObjectTextAttr.Hidden = False
        FieldObjectTextAttr.UnderlineColor = clBlack
        FieldObjectTextAttr.TextColor = clBlack
        FieldObjectTextAttr.BackgroundColor = clBlack
        FieldObjectTextAttr.UseUnderlineColor = False
        FieldObjectTextAttr.UseTextColor = False
        FieldObjectTextAttr.UseBackgroundColor = False
        WriteObjectMode = wobRTF
        OneClickHyperlink = False
        Align = alClient
        TabOrder = 0
      end
      object wptlbr1: TWPToolBar
        Left = 0
        Top = 0
        Width = 1049
        Height = 29
        UseDockManager = False
        KeepGroupsTogether = True
        Align = alTop
        BevelLines = []
        AutoEnabling = True
        WidthBetweenGroups = 4
        FontChoice = fsPrinterFonts
        sel_ListBoxes = [SelFontName, SelFontSize, SelFontColor, SelParColor]
        sel_StatusIcons = [SelBold, SelItalic, SelUnder, SelLeft, SelRight, SelBlock, SelCenter]
        sel_ActionIcons = [SelOpen, SelSave, SelPrint, SelPrintSetup]
        sel_DatabaseIcons = []
        sel_EditIcons = [SelCopy, SelCut, SelPaste, SelFind, SelReplace]
        sel_TableIcons = [SelCreateTable]
        sel_OutlineIcons = []
        FontSizeFrom = 8
        FlatButtons = False
        ButtonHeight = 0
        NoEditItemsInStyleList = False
        TrueTypeOnly = False
      end
      object wprlr1: TWPRuler
        Left = 0
        Top = 29
        Width = 1049
        Height = 26
        Units = wrCentimeter
        DrawOptions = []
        TabKind = tkLeft
        Options = [wrShowTabSelector, wrShowTabStops, wrShowIndents, wpUseIntervalls, wpNoVertRulerAttached]
        ColorMargin = clAppWorkSpace
        ColorBack = clBtnFace
        Align = alTop
      end
    end
    object cxtbsht3: TcxTabSheet
      Caption = 'Pictures && Gallery'
      ImageIndex = 2
      object pnl2: TPanel
        Left = 0
        Top = 0
        Width = 310
        Height = 550
        Align = alLeft
        BevelInner = bvLowered
        TabOrder = 0
        object img1: TImageEnMView
          Left = 2
          Top = 33
          Width = 306
          Height = 515
          ParentCtl3D = False
          OnImageSelect = img1ImageSelect
          ThumbnailsBorderColor = clBlack
          ImageEnVersion = '3.1.2'
          Align = alClient
          TabOrder = 0
        end
        object jvtlbr1: TJvToolBar
          Left = 2
          Top = 2
          Width = 306
          Height = 31
          BorderWidth = 1
          Caption = 'jvtlbr1'
          EdgeBorders = [ebLeft, ebTop, ebRight, ebBottom]
          Images = il1
          TabOrder = 1
          object btn5: TToolButton
            Left = 0
            Top = 0
            Caption = 'btn5'
            ImageIndex = 0
            OnClick = btn5Click
          end
          object btn6: TToolButton
            Left = 23
            Top = 0
            Caption = 'btn6'
            ImageIndex = 1
          end
        end
      end
      object pnl6: TPanel
        Left = 310
        Top = 0
        Width = 739
        Height = 550
        Align = alClient
        BevelInner = bvLowered
        TabOrder = 1
        object Panel1: TPanel
          Left = 488
          Top = 2
          Width = 249
          Height = 485
          Align = alRight
          TabOrder = 0
          object GroupBox2: TGroupBox
            Left = 9
            Top = 6
            Width = 232
            Height = 58
            Caption = ' Contrast '
            TabOrder = 0
            object TrackBar1: TTrackBar
              Left = 8
              Top = 19
              Width = 221
              Height = 32
              Max = 100
              Frequency = 10
              TabOrder = 0
              OnChange = TrackBar1Change
            end
          end
          object GroupBox3: TGroupBox
            Left = 6
            Top = 223
            Width = 232
            Height = 126
            Caption = ' Channels Offset '
            TabOrder = 1
            object Label2: TLabel
              Left = 8
              Top = 29
              Width = 19
              Height = 13
              Caption = 'Red'
            end
            object Label3: TLabel
              Left = 8
              Top = 61
              Width = 29
              Height = 13
              Caption = 'Green'
            end
            object Label4: TLabel
              Left = 8
              Top = 100
              Width = 20
              Height = 13
              Caption = 'Blue'
            end
            object TrackBar2: TTrackBar
              Left = 43
              Top = 21
              Width = 186
              Height = 45
              Max = 255
              Min = -255
              Frequency = 16
              TabOrder = 0
              OnChange = TrackBar2Change
            end
            object TrackBar3: TTrackBar
              Left = 43
              Top = 57
              Width = 186
              Height = 45
              Max = 255
              Min = -255
              Frequency = 16
              TabOrder = 1
              OnChange = TrackBar3Change
            end
            object TrackBar4: TTrackBar
              Left = 43
              Top = 92
              Width = 186
              Height = 33
              Max = 255
              Min = -255
              Frequency = 16
              TabOrder = 2
              OnChange = TrackBar4Change
            end
          end
          object GroupBox4: TGroupBox
            Left = 6
            Top = 354
            Width = 231
            Height = 39
            Caption = ' Show '
            TabOrder = 2
            object CheckBox1: TCheckBox
              Left = 3
              Top = 12
              Width = 54
              Height = 26
              Alignment = taLeftJustify
              Caption = 'Red'
              Checked = True
              State = cbChecked
              TabOrder = 0
              OnClick = CheckBox1Click
            end
            object CheckBox2: TCheckBox
              Left = 83
              Top = 12
              Width = 54
              Height = 26
              Alignment = taLeftJustify
              Caption = 'Green'
              Checked = True
              State = cbChecked
              TabOrder = 1
              OnClick = CheckBox2Click
            end
            object CheckBox3: TCheckBox
              Left = 163
              Top = 12
              Width = 54
              Height = 26
              Alignment = taLeftJustify
              Caption = 'Blue'
              Checked = True
              State = cbChecked
              TabOrder = 2
              OnClick = CheckBox3Click
            end
          end
          object GroupBox1: TGroupBox
            Left = 6
            Top = 398
            Width = 233
            Height = 66
            Caption = ' Zoom '
            TabOrder = 3
            object TrackBar5: TTrackBar
              Left = 3
              Top = 21
              Width = 180
              Height = 36
              Max = 1000
              Min = 1
              Frequency = 100
              Position = 100
              TabOrder = 0
              OnChange = TrackBar5Change
            end
            object CheckBox4: TCheckBox
              Left = 189
              Top = 24
              Width = 41
              Height = 17
              Caption = 'Fit'
              TabOrder = 1
              OnClick = CheckBox4Click
            end
          end
          object GroupBox5: TGroupBox
            Left = 6
            Top = 67
            Width = 232
            Height = 58
            Caption = ' Brightness '
            TabOrder = 4
            object TrackBar6: TTrackBar
              Left = 8
              Top = 18
              Width = 221
              Height = 31
              Max = 255
              Min = -255
              Frequency = 16
              TabOrder = 0
              OnChange = TrackBar6Change
            end
          end
          object GroupBox6: TGroupBox
            Left = 6
            Top = 131
            Width = 232
            Height = 86
            Caption = ' Black/White range'
            TabOrder = 5
            object Label1: TLabel
              Left = 8
              Top = 24
              Width = 24
              Height = 13
              Caption = 'Black'
            end
            object Label5: TLabel
              Left = 8
              Top = 56
              Width = 28
              Height = 13
              Caption = 'White'
            end
            object TrackBar7: TTrackBar
              Left = 43
              Top = 16
              Width = 186
              Height = 30
              Max = 65535
              Frequency = 1024
              TabOrder = 0
              OnChange = TrackBar7Change
            end
            object TrackBar8: TTrackBar
              Left = 42
              Top = 52
              Width = 186
              Height = 33
              Max = 65535
              Frequency = 1024
              Position = 65535
              TabOrder = 1
              OnChange = TrackBar7Change
            end
          end
        end
        object pnl7: TPanel
          Left = 2
          Top = 487
          Width = 735
          Height = 61
          Align = alBottom
          BevelKind = bkSoft
          TabOrder = 1
        end
        object ImageEnView1: TImageEnView
          Left = 2
          Top = 2
          Width = 486
          Height = 485
          ParentCtl3D = False
          LegacyBitmap = False
          ImageEnVersion = '3.1.2'
          EnableInteractionHints = True
          Align = alClient
          TabOrder = 2
        end
      end
    end
  end
  object pnl1: TPanel
    Left = 0
    Top = 576
    Width = 1055
    Height = 41
    Align = alBottom
    BevelInner = bvLowered
    TabOrder = 1
    object btn2: TButton
      Left = 816
      Top = 8
      Width = 97
      Height = 25
      Caption = 'Save'
      ModalResult = 1
      TabOrder = 0
      OnClick = btn2Click
    end
    object btn3: TButton
      Left = 928
      Top = 8
      Width = 97
      Height = 25
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object dxstsbr1: TdxStatusBar
    Left = 0
    Top = 617
    Width = 1055
    Height = 23
    Images = ImageList1
    Panels = <
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Text = 'Idle'
        Width = 150
      end
      item
        PanelStyleClassName = 'TdxStatusBarKeyboardStatePanelStyle'
        PanelStyle.CapsLockKeyAppearance.ActiveCaption = 'CAPS'
        PanelStyle.CapsLockKeyAppearance.InactiveCaption = 'CAPS'
        PanelStyle.NumLockKeyAppearance.ActiveCaption = 'NUM'
        PanelStyle.NumLockKeyAppearance.InactiveCaption = 'NUM'
        PanelStyle.ScrollLockKeyAppearance.ActiveCaption = 'SCRL'
        PanelStyle.ScrollLockKeyAppearance.InactiveCaption = 'SCRL'
        PanelStyle.InsertKeyAppearance.ActiveCaption = 'OVR'
        PanelStyle.InsertKeyAppearance.InactiveCaption = 'INS'
        Width = 127
      end
      item
        PanelStyleClassName = 'TdxStatusBarStateIndicatorPanelStyle'
        PanelStyle.Indicators = <
          item
          end>
      end>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
  end
  object ds1: TDataSource
    DataSet = nxqryCategories
    Left = 112
    Top = 552
  end
  object nxqryCategories: TnxQuery
    Database = fmMain.nxdtbs1
    BeforeOpen = nxqryCategoriesBeforeOpen
    SQL.Strings = (
      
        'select * from categories where SiteCode=:SiteID order by Categor' +
        'yParentID')
    Left = 48
    Top = 552
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'SiteID'
        ParamType = ptUnknown
      end>
  end
  object dxmdt1: TdxMemData
    Indexes = <>
    SortOptions = []
    Left = 168
    Top = 552
    object intgrflddxmdt1CategoryID: TIntegerField
      FieldName = 'CategoryID'
    end
    object strngflddxmdt1CategoryName: TStringField
      FieldName = 'CategoryName'
      Size = 30
    end
    object intgrflddxmdt1PercentItemFound: TIntegerField
      FieldName = 'PercentItemFound'
    end
  end
  object ds2: TDataSource
    DataSet = dxmdt1
    Left = 224
    Top = 552
  end
  object nxqryCurrency: TnxQuery
    Database = fmMain.nxdtbs1
    DataSource = fmMain.dsItems
    SQL.Strings = (
      'select * from CurrencyDetails where SiteID=:SiteID')
    Left = 288
    Top = 552
    ParamData = <
      item
        DataType = ftString
        Name = 'SiteID'
        ParamType = ptInput
      end>
  end
  object ds3: TDataSource
    DataSet = nxqryCurrency
    Left = 352
    Top = 552
  end
  object tmr1: TTimer
    Enabled = False
    Interval = 3000
    Left = 520
    Top = 80
  end
  object il1: TImageList
    Left = 224
    Top = 480
    Bitmap = {
      494C010102000500040010001000FFFFFFFFFF00FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      00000000000000000000000000000000000000000000FFFBFF00F7F3F700E7E7
      E700E7E3E700DEDBDE00CECBCE00BDBEBD00BDBEBD00CECBCE00D6D7D600E7E3
      E700E7E7E700EFEFEF00F7F7F700FFFFFF0000000000FFFBFF00CECBDE00D6D3
      DE00E7E3E700D6D7D600CECFCE00CECBCE00CECBCE00CECFCE00D6D7D600DEDF
      DE00D6D3DE00CECBDE00F7F7FF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0000000000FFFFFF00FFFF
      FF00E7E7E700BDBABD009C9E9C0094969400949694009C9E9C00BDBABD00E7E7
      E700FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00C6C7DE00424173006B6D
      9C00EFEBF700FFFFFF00FFFBFF00F7F7F700F7F7F700FFFBFF00FFFBFF00EFEB
      F7007371AD00393C9400C6C7E700FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00D6D3
      D600949A94008C8E8C008C92940094969400949694008C9294008C8E8C00949A
      9400D6D3D600FFFFFF00FFFFFF00FFFFFF00C6C7DE0039387300000052000808
      520073719C00EFEFF700FFFFFF00FFFFFF00FFFFFF00FFFFFF00EFEFF7007375
      B5000808840000007B0039389C00C6C3E7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00CECFCE00848A
      84007B828400848684008C8E8C00DEDBDE00DEDBDE008C928C008C8E8C00848A
      8C008C928C00D6D3D600FFFFFF00FFFFFF00B5B6CE002928730000004A000000
      420008085A007371A500EFEFF700FFFFFF00FFFFFF00EFEFF7007375AD00080C
      7B0000008C0000008C0029289400B5B6DE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00E7E7E700848A84007379
      730073797B007B7D7B0084868400EFEBEF00EFEBEF00848A840084868400848A
      8400848A8400949A9400EFEBEF00FFFFFF00FFFFFF00B5B6CE00292863000000
      520000005A00080C5A007375AD00EFEFF700EFEFF7007375B500080C84000000
      730000007B002928A500B5B2DE00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00B5B6B5006B716B006B71
      6B0073717300737573007B7D7B00EFEBEF00EFEBEF007B8284007B7D7B007B82
      7B007B82840084868400BDC3C600FFFFFF00FFFFFF00FFFFFF00B5B6D6002928
      7B000000520000005200080C63007371AD007371AD00080C6B0000007B00080C
      940031349400B5B2DE00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F7F7F7008C8E8C00636963007371
      7300737573007379730084868400EFEFEF00EFEFEF00848684007B7D7B007B82
      84007B827B007B7D7B009C9E9C00FFFBFF00FFFFFF00FFFFFF00FFFFFF00B5B6
      D6002928730000006300000063000808730008087B0000047300292C84006361
      B500C6C3E700FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000EFEFEF00737573006B696B00D6D7
      D600EFEBEF00EFEBEF00EFEFEF00FFFFFF00FFFFFF00EFEFEF00EFEBEF00EFEF
      EF00D6D7D6007B7D7B008C8E8C00EFEFEF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00B5B6D600292C7B000000630000006300101073004241A5007371BD00C6C3
      DE00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000EFEBEF0073716B006B696B00D6D7
      D600EFEBEF00E7E7E700E7E7E700FFFBFF00FFFBFF00E7E7E700E7E7E700E7E7
      E700D6D3D6007B797B0084868400EFEFEF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00EFEBF7006361A500181C7B0031308C00424194005255AD008C8AC600EFEB
      F700FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F7F7F70084827B0073716B007B7D
      7B007B827B007B7D7B0084868400EFEFEF00EFEFEF008C8A8C00848684008486
      84008486840084827B0094969400F7F7F700FFFFFF00FFFFFF00FFFFFF00EFEF
      F7009C9ACE006361A5006B6DAD006B69AD005255A5005255B5006B6DBD009C9E
      D600EFEFF700FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00A5A6A50073716B008482
      7B0084828400848684008C8A8400EFEBEF00EFEBEF008C8E8C008C8A8C008C8E
      8C008C8E8C0084827B00B5B2AD00FFFFFF00FFFFFF00FFFFFF00EFEFF7009C9E
      CE007B79AD007B7DBD007B7DBD008486C6007B79BD005A5DB5006B6DBD007B7D
      CE009C9EDE00EFEFF700FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00DEDFDE00736D6B008C8A
      840094928C0094928C0094929400EFEBEF00EFEBEF0094969400949694009C9A
      9400949294007B827B00E7E3E700FFFFFF00FFFFFF00EFEFF700A5A2CE008482
      CE008486BD008486BD009492CE00CECBE700CECBE7008482C6006B6DC6008482
      D6008486D600A5A2DE00EFEFF700FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00B5B6B5006B69
      630094929400A5A29C009C9A9C00DEDBDE00DEDBDE009C9E9C00A5A6A5009C9A
      9C0073797300BDBEBD00FFFFFF00FFFFFF00EFEFF700A5A6DE008C8ABD009492
      C6009492D6009C9ACE00CECFE700FFFFFF00FFFFFF00CECBE7008486D6007B7D
      D6008C8EDE008C8EE700A5A6E700EFEBF7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFBFF00B5B6
      B5006B69630084827B009C9A9400A5A29C00A5A2A5009C9E9C008C8A84007375
      7300BDBABD00FFFFFF00FFFFFF00FFFFFF00BDBEDE009496D6009C9ADE009C9A
      CE00A5A2D600CECFEF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CECBEF008C8E
      D6008C8EDE009C9AE7009C9AE700BDBEE7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00DEDFDE009C9A9C007B79730073716B0073756B007B7D7B00A5A29C00DEDF
      DE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00EFEFF700BDBADE00A5A6DE00ADAA
      E700D6D3E700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CECF
      EF009C9AE7009C9EE700BDBAE700EFEFF7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00F7F3F700E7E7E700E7E7E700F7F3F700FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00EFEFF700C6C3E700D6D7
      EF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00CECFEF00B5B6E700EFEFF700FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF0080008000000000004002000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000}
  end
  object dsEbayPref: TDataSource
    DataSet = nxqryEbayPref
    Left = 616
    Top = 568
  end
  object nxqryEbayPref: TnxQuery
    Database = fmMain.nxdtbs1
    DataSource = fmMain.dsItems
    SQL.Strings = (
      'SELECT ep.PaymentOptions ,  ep.ShippingLocations , '
      
        '(select Description from ShippingServiceDetails where ShippingSe' +
        'rviceID = ep.ShippingService1)  as ss1,  '
      
        '(select Description from ShippingServiceDetails where ShippingSe' +
        'rviceID = ep.ShippingService2)  as ss2,  '
      
        '(select Description from ShippingServiceDetails where ShippingSe' +
        'rviceID = ep.ShippingService3)  as ss3,  '
      
        '(select Description from ShippingServiceDetails where ShippingSe' +
        'rviceID = ep.InShippingService1)  as iss1,  '
      
        '(select Description from ShippingServiceDetails where ShippingSe' +
        'rviceID = ep.InShippingService2)  as iss2,  '
      
        '(select Description from ShippingServiceDetails where ShippingSe' +
        'rviceID = ep.InShippingService3)  as iss3 '
      'from ebaypreferences ep'
      'where ep.SiteID=:SiteId')
    Left = 528
    Top = 576
    ParamData = <
      item
        DataType = ftString
        Name = 'SiteId'
        ParamType = ptInput
      end>
  end
  object nxqryShippingService: TnxQuery
    Database = fmMain.nxdtbs1
    DataSource = fmMain.dsItems
    SQL.Strings = (
      
        'SELECT * FROM "ShippingServiceDetails"   where  InternationalSer' +
        'vice=false and SiteID=:SiteId')
    Left = 616
    Top = 160
    ParamData = <
      item
        DataType = ftString
        Name = 'SiteId'
        ParamType = ptInput
      end>
  end
  object ds5: TDataSource
    DataSet = nxqryShippingService
    Left = 656
    Top = 160
  end
  object ds6: TDataSource
    DataSet = nxqryShippingServiceIn
    Left = 744
    Top = 160
  end
  object nxqryShippingServiceIn: TnxQuery
    Database = fmMain.nxdtbs1
    DataSource = fmMain.dsItems
    SQL.Strings = (
      
        'SELECT * FROM "ShippingServiceDetails"   where  InternationalSer' +
        'vice=false and SiteID=:SiteId')
    Left = 712
    Top = 168
    ParamData = <
      item
        DataType = ftString
        Name = 'SiteId'
        ParamType = ptInput
      end>
  end
  object nxqryPaymentMethods: TnxQuery
    Database = fmMain.nxdtbs1
    DataSource = fmMain.dsItems
    SQL.Strings = (
      'SELECT * FROM "PaymentOptionDetails" where  SiteID=:SiteId')
    Left = 40
    Top = 392
    ParamData = <
      item
        DataType = ftString
        Name = 'SiteId'
        ParamType = ptInput
      end>
  end
  object ds7: TDataSource
    DataSet = nxqryPaymentMethods
    Left = 152
    Top = 392
  end
  object nxqryShipToLocations: TnxQuery
    Database = fmMain.nxdtbs1
    DataSource = fmMain.dsItems
    SQL.Strings = (
      'SELECT * FROM "ShippingLocationDetails" where  SiteID=:SiteId')
    Left = 696
    Top = 72
    ParamData = <
      item
        DataType = ftString
        Name = 'SiteId'
        ParamType = ptInput
      end>
  end
  object ds8: TDataSource
    DataSet = nxqryShipToLocations
    Left = 736
    Top = 72
  end
  object nxqry1: TnxQuery
    Database = fmMain.nxdtbs1
    DataSource = fmMain.dsItems
    SQL.Strings = (
      
        'SELECT * FROM "ReturnPolicyDetails" where Type='#39'Refund'#39' and Site' +
        'ID=:SiteID')
    Left = 728
    Top = 440
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'SiteID'
        ParamType = ptUnknown
      end>
  end
  object ds4: TDataSource
    DataSet = nxqry1
    Left = 768
    Top = 440
  end
  object nxqry3: TnxQuery
    Database = fmMain.nxdtbs1
    DataSource = fmMain.dsItems
    SQL.Strings = (
      
        'SELECT * FROM "ReturnPolicyDetails" where Type='#39'ReturnsAccepted'#39 +
        ' and SiteID=:SiteID')
    Left = 616
    Top = 520
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'SiteID'
        ParamType = ptUnknown
      end>
  end
  object ds9: TDataSource
    DataSet = nxqry3
    Left = 648
    Top = 520
  end
  object ds10: TDataSource
    DataSet = nxqry4
    Left = 768
    Top = 544
  end
  object nxqry4: TnxQuery
    Database = fmMain.nxdtbs1
    DataSource = fmMain.dsItems
    SQL.Strings = (
      
        'SELECT * FROM "ReturnPolicyDetails" where Type='#39'ShippingCostPaid' +
        'By'#39' and SiteID=:SiteID')
    Left = 728
    Top = 544
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'SiteID'
        ParamType = ptUnknown
      end>
  end
  object ds11: TDataSource
    DataSet = nxqry2
    Left = 768
    Top = 496
  end
  object nxqry2: TnxQuery
    Database = fmMain.nxdtbs1
    DataSource = fmMain.dsItems
    SQL.Strings = (
      
        'SELECT * FROM "ReturnPolicyDetails" where Type='#39'ReturnsWithin'#39' a' +
        'nd SiteID=:SiteID')
    Left = 728
    Top = 496
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'SiteID'
        ParamType = ptUnknown
      end>
  end
  object ImageList1: TImageList
    Left = 152
    Top = 472
    Bitmap = {
      494C010101000500040010001000FFFFFFFFFF00FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00EAEAEA004D4D4D0039393900C0C0C000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0066666600161616001C1C1C0033333300F8F8F800FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00F8F8F800C0C0C000CBCB
      CB00F8F8F800FFFFFF0022222200222222002222220022222200CCCCCC00FFFF
      FF00E3E3E300CCCCCC00F8F8F800FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00C0C0C000868686008686
      8600C0C0C000F8F8F8001C1C1C00222222002929290029292900C0C0C000E3E3
      E3008686860086868600A4A0A000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0086868600999999009999
      990080808000FFFFFF0039393900222222002929290029292900E3E3E300A4A0
      A00077777700A4A0A00096969600EAEAEA000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F8F8F80086868600D7D7D700DDDD
      DD0077777700F8F8F80099999900222222002929290066666600FFFFFF008686
      860086868600E3E3E300B2B2B200E3E3E3000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0099999900D7D7D700E3E3
      E30099999900FFFFFF00FFFFFF00A4A0A00086868600F1F1F100FFFFFF00B2B2
      B20099999900F1F1F100C0C0C000F1F1F1000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F1F1F10086868600999999009999
      9900CBCBCB00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00DDDD
      DD0086868600B2B2B20096969600F1F1F1000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B2B2B2008686860080808000B2B2
      B200FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00B2B2B2007777770086868600B2B2B2000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A4A0A000C0C0C000B2B2B200B2B2
      B200FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00B2B2B20086868600CBCBCB00B2B2B2000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B2B2B200D7D7D700DDDDDD00A4A0
      A000D7D7D700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00D7D7
      D700A4A0A000A4A0A000F8F8F800C0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E3E3E300A4A0A000999999008080
      800086868600CCCCCC00FFFFFF00EAEAEA00EAEAEA00FFFFFF00CCCCCC008686
      86008080800096969600B2B2B200DDDDDD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00F1F1F100D7D7D7008686
      8600B2B2B200B2B2B200EAEAEA008686860086868600F1F1F100A4A0A0009696
      9600A4A0A000CCCCCC00EAEAEA00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00EAEAEA00B2B2
      B200EAEAEA00B2B2B200CBCBCB008686860099999900D7D7D700B2B2B200C0C0
      C000D7D7D700E3E3E300FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00B2B2
      B200B2B2B200EAEAEA00D7D7D700B2B2B200DDDDDD00DDDDDD00EAEAEA00A4A0
      A000C0C0C000FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00F8F8
      F800F8F8F800FFFFFF00F8F8F800B2B2B200C0C0C000F8F8F800FFFFFF00F8F8
      F800F8F8F800FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000}
  end
  object JvImageDialog1: TJvImageDialog
    Title = 'Image Viewer'
    Left = 80
    Top = 296
  end
  object nxtblItems: TnxTable
    Database = fmMain.nxdtbs1
    TableName = 'Items'
    IndexFieldNames = 'id'
    MasterFields = 'id'
    MasterSource = fmMain.dsItems
    Left = 864
    Top = 64
    object nxtblItemsid: TUnsignedAutoIncField
      FieldName = 'id'
    end
    object nxtblItemsSiteID: TStringField
      FieldName = 'SiteID'
      Size = 50
    end
    object nxtblItemsTitle: TStringField
      FieldName = 'Title'
      Size = 55
    end
    object nxtblItemsSubTitle: TStringField
      FieldName = 'SubTitle'
      Size = 55
    end
    object nxtblItemsPrimaryCategory: TLargeintField
      FieldName = 'PrimaryCategory'
    end
    object nxtblItemsSecondaryCategory: TLargeintField
      FieldName = 'SecondaryCategory'
    end
    object nxtblItemsCurrency: TStringField
      FieldName = 'Currency'
      Size = 3
    end
    object nxtblItemsPrice: TExtendedField
      FieldName = 'Price'
      Precision = 19
    end
    object nxtblItemsReservePrice: TExtendedField
      FieldName = 'ReservePrice'
      Precision = 19
    end
    object nxtblItemsBuyItNowPrice: TExtendedField
      FieldName = 'BuyItNowPrice'
      Precision = 19
    end
    object nxtblItemsListingType: TStringField
      FieldName = 'ListingType'
      Size = 30
    end
    object nxtblItemsQuantity: TIntegerField
      FieldName = 'Quantity'
    end
    object nxtblItemsLotSize: TIntegerField
      FieldName = 'LotSize'
    end
    object nxtblItemsAuctionDuration: TStringField
      FieldName = 'AuctionDuration'
    end
    object nxtblItemsPrivateListing: TBooleanField
      FieldName = 'PrivateListing'
    end
    object nxtblItemsShippingService1: TIntegerField
      FieldName = 'ShippingService1'
    end
    object nxtblItemsSS1Price: TExtendedField
      FieldName = 'SS1Price'
      Precision = 19
    end
    object nxtblItemsShippingService2: TIntegerField
      FieldName = 'ShippingService2'
    end
    object nxtblItemsSS2Price: TExtendedField
      FieldName = 'SS2Price'
      Precision = 19
    end
    object nxtblItemsShippingService3: TIntegerField
      FieldName = 'ShippingService3'
    end
    object nxtblItemsSS3Price: TExtendedField
      FieldName = 'SS3Price'
      Precision = 19
    end
    object nxtblItemsSS1Insurance: TExtendedField
      FieldName = 'SS1Insurance'
      Precision = 19
    end
    object nxtblItemsSS2Insurance: TExtendedField
      FieldName = 'SS2Insurance'
      Precision = 19
    end
    object nxtblItemsSS3Insurance: TExtendedField
      FieldName = 'SS3Insurance'
      Precision = 19
    end
    object nxtblItemsInShippingService1: TIntegerField
      FieldName = 'InShippingService1'
    end
    object nxtblItemsISS1Price: TExtendedField
      FieldName = 'ISS1Price'
      Precision = 19
    end
    object nxtblItemsInShippingService2: TIntegerField
      FieldName = 'InShippingService2'
    end
    object nxtblItemsISS2Price: TExtendedField
      FieldName = 'ISS2Price'
      Precision = 19
    end
    object nxtblItemsInShippingService3: TIntegerField
      FieldName = 'InShippingService3'
    end
    object nxtblItemsISS3Price: TExtendedField
      FieldName = 'ISS3Price'
      Precision = 19
    end
    object nxtblItemsISS1Insurance: TExtendedField
      FieldName = 'ISS1Insurance'
      Precision = 19
    end
    object nxtblItemsISS2Insurance: TExtendedField
      FieldName = 'ISS2Insurance'
      Precision = 19
    end
    object nxtblItemsISS3Insurance: TExtendedField
      FieldName = 'ISS3Insurance'
      Precision = 19
    end
    object nxtblItemsInsuranceOptions: TStringField
      FieldName = 'InsuranceOptions'
      Size = 40
    end
    object nxtblItemsDescription: TnxMemoField
      FieldName = 'Description'
      BlobType = ftMemo
    end
    object nxtblItemsPaymentMethods: TStringField
      FieldName = 'PaymentMethods'
      Size = 200
    end
    object nxtblItemsShipToLocations: TStringField
      FieldName = 'ShipToLocations'
      Size = 200
    end
    object nxtblItemsPaymentPolicy: TnxMemoField
      FieldName = 'PaymentPolicy'
      BlobType = ftMemo
    end
    object nxtblItemsRP_Description: TnxMemoField
      FieldName = 'RP_Description'
      BlobType = ftMemo
    end
    object nxtblItemsPR_Refund: TStringField
      FieldName = 'PR_Refund'
    end
    object nxtblItemsRP_ReturnsWithin: TStringField
      FieldName = 'RP_ReturnsWithin'
    end
    object nxtblItemsRP_ReturnsAccepted: TStringField
      FieldName = 'RP_ReturnsAccepted'
      Size = 50
    end
    object nxtblItemsRP_ShippingCostPaidBy: TStringField
      FieldName = 'RP_ShippingCostPaidBy'
    end
  end
  object dsItems: TDataSource
    DataSet = nxtblItems
    Left = 928
    Top = 64
  end
end
