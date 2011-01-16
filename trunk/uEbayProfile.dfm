object fmEbayProfiles: TfmEbayProfiles
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'eBay user profile'
  ClientHeight = 541
  ClientWidth = 843
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object cxtbcntrl1: TcxTabControl
    Left = 0
    Top = 0
    Width = 843
    Height = 541
    Align = alClient
    TabIndex = 0
    TabOrder = 0
    Tabs.Strings = (
      'US')
    OnChange = cxtbcntrl1Change
    ClientRectBottom = 541
    ClientRectRight = 843
    ClientRectTop = 24
    object lbl3: TLabel
      Left = 517
      Top = 60
      Width = 86
      Height = 13
      Caption = 'Shipping service 1'
    end
    object lbl4: TLabel
      Left = 517
      Top = 90
      Width = 86
      Height = 13
      Caption = 'Shipping service 2'
    end
    object lbl5: TLabel
      Left = 517
      Top = 120
      Width = 86
      Height = 13
      Caption = 'Shipping service 3'
    end
    object lbl6: TLabel
      Left = 459
      Top = 149
      Width = 144
      Height = 13
      Caption = 'Internatinal shipping service 1'
    end
    object lbl7: TLabel
      Left = 459
      Top = 179
      Width = 144
      Height = 13
      Caption = 'Internatinal shipping service 2'
    end
    object lbl8: TLabel
      Left = 459
      Top = 209
      Width = 144
      Height = 13
      Caption = 'Internatinal shipping service 3'
    end
    object lbl9: TLabel
      Left = 599
      Top = 32
      Width = 83
      Height = 13
      Caption = 'Shipping Services'
    end
    object bvl1: TBevel
      Left = 454
      Top = 51
      Width = 386
      Height = 200
    end
    object cbb1: TcxDBLookupComboBox
      Left = 624
      Top = 57
      DataBinding.DataField = 'ShippingService1'
      DataBinding.DataSource = ds4
      Properties.ClearKey = 46
      Properties.KeyFieldNames = 'ShippingServiceID'
      Properties.ListColumns = <
        item
          FieldName = 'Description'
        end>
      Properties.ListSource = ds3
      TabOrder = 0
      Width = 209
    end
    object cbb2: TcxDBLookupComboBox
      Left = 624
      Top = 87
      DataBinding.DataField = 'ShippingService2'
      DataBinding.DataSource = ds4
      Properties.ClearKey = 46
      Properties.KeyFieldNames = 'ShippingServiceID'
      Properties.ListColumns = <
        item
          FieldName = 'Description'
        end>
      Properties.ListSource = ds3
      TabOrder = 1
      Width = 209
    end
    object cbb3: TcxDBLookupComboBox
      Left = 624
      Top = 117
      DataBinding.DataField = 'ShippingService3'
      DataBinding.DataSource = ds4
      Properties.ClearKey = 46
      Properties.KeyFieldNames = 'ShippingServiceID'
      Properties.ListColumns = <
        item
          FieldName = 'Description'
        end>
      Properties.ListSource = ds3
      TabOrder = 2
      Width = 209
    end
    object cbb4: TcxDBLookupComboBox
      Left = 624
      Top = 146
      DataBinding.DataField = 'InShippingService1'
      DataBinding.DataSource = ds4
      Properties.ClearKey = 46
      Properties.KeyFieldNames = 'ShippingServiceID'
      Properties.ListColumns = <
        item
          FieldName = 'Description'
        end>
      Properties.ListSource = ds5
      TabOrder = 3
      Width = 209
    end
    object cbb5: TcxDBLookupComboBox
      Left = 624
      Top = 176
      DataBinding.DataField = 'InShippingService2'
      DataBinding.DataSource = ds4
      Properties.ClearKey = 46
      Properties.KeyFieldNames = 'ShippingServiceID'
      Properties.ListColumns = <
        item
          FieldName = 'Description'
        end>
      Properties.ListSource = ds5
      TabOrder = 4
      Width = 209
    end
    object cbb6: TcxDBLookupComboBox
      Left = 624
      Top = 206
      DataBinding.DataField = 'InShippingService3'
      DataBinding.DataSource = ds4
      Properties.ClearKey = 46
      Properties.KeyFieldNames = 'ShippingServiceID'
      Properties.ListColumns = <
        item
          FieldName = 'Description'
        end>
      Properties.ListSource = ds5
      TabOrder = 5
      Width = 209
    end
    object cxgrpbx1: TcxGroupBox
      Left = 8
      Top = 257
      Caption = 'Payment Policy'
      TabOrder = 6
      Height = 224
      Width = 297
      object lbl15: TLabel
        Left = 107
        Top = 21
        Width = 57
        Height = 13
        Caption = 'Instructions'
      end
      object cxdbm1: TcxDBMemo
        Left = 3
        Top = 40
        DataBinding.DataField = 'PaymentPolicy'
        DataBinding.DataSource = ds4
        TabOrder = 0
        Height = 181
        Width = 286
      end
    end
    object cxgrpbx2: TcxGroupBox
      Left = 311
      Top = 257
      Caption = 'Return Policy'
      TabOrder = 7
      Height = 224
      Width = 522
      object lbl10: TLabel
        Left = 295
        Top = 37
        Width = 35
        Height = 13
        Caption = 'Refund'
      end
      object lbl11: TLabel
        Left = 295
        Top = 85
        Width = 71
        Height = 13
        Caption = 'Returns Within'
      end
      object lbl12: TLabel
        Left = 295
        Top = 133
        Width = 86
        Height = 13
        Caption = 'Returns Accepted'
      end
      object lbl13: TLabel
        Left = 295
        Top = 181
        Width = 103
        Height = 13
        Caption = 'Shipping Cost Paid By'
      end
      object lbl14: TLabel
        Left = 123
        Top = 21
        Width = 57
        Height = 13
        Caption = 'Instructions'
      end
      object cxdbm3: TcxDBMemo
        Left = 3
        Top = 40
        DataBinding.DataField = 'RP_Description'
        DataBinding.DataSource = ds4
        TabOrder = 0
        Height = 181
        Width = 286
      end
      object cbb7: TcxDBLookupComboBox
        Left = 295
        Top = 56
        DataBinding.DataField = 'RP_Refund'
        DataBinding.DataSource = ds4
        Properties.ClearKey = 46
        Properties.KeyFieldNames = 'Value'
        Properties.ListColumns = <
          item
            FieldName = 'Name'
          end>
        Properties.ListSource = ds7
        TabOrder = 1
        Width = 218
      end
      object cbb8: TcxDBLookupComboBox
        Left = 295
        Top = 104
        DataBinding.DataField = 'RP_ReturnsWithin'
        DataBinding.DataSource = ds4
        Properties.ClearKey = 46
        Properties.KeyFieldNames = 'Value'
        Properties.ListColumns = <
          item
            FieldName = 'Name'
          end>
        Properties.ListSource = ds8
        TabOrder = 2
        Width = 218
      end
      object cbb9: TcxDBLookupComboBox
        Left = 295
        Top = 154
        DataBinding.DataField = 'RP_ReturnsAccepted'
        DataBinding.DataSource = ds4
        Properties.ClearKey = 46
        Properties.KeyFieldNames = 'Value'
        Properties.ListColumns = <
          item
            FieldName = 'Name'
          end>
        Properties.ListSource = ds9
        TabOrder = 3
        Width = 218
      end
      object cbb10: TcxDBLookupComboBox
        Left = 295
        Top = 200
        DataBinding.DataField = 'RP_ShippingCostPaidBy'
        DataBinding.DataSource = ds4
        Properties.ClearKey = 46
        Properties.KeyFieldNames = 'Value'
        Properties.ListColumns = <
          item
            FieldName = 'Name'
          end>
        Properties.ListSource = ds10
        TabOrder = 4
        Width = 218
      end
    end
    object pnl1: TPanel
      Left = 0
      Top = 500
      Width = 843
      Height = 41
      Align = alBottom
      BevelInner = bvLowered
      TabOrder = 8
      object btn2: TButton
        Left = 612
        Top = 8
        Width = 97
        Height = 25
        Caption = 'Save'
        ModalResult = 1
        TabOrder = 0
        OnClick = btn2Click
      end
      object btn3: TButton
        Left = 736
        Top = 8
        Width = 97
        Height = 25
        Caption = 'Cancel'
        ModalResult = 2
        TabOrder = 1
      end
    end
    object cxdbchckgrp1: TcxDBCheckGroup
      Left = 11
      Top = 32
      Caption = 'Payment methods'
      Properties.EditValueFormat = cvfCaptions
      Properties.Items = <>
      TabOrder = 9
      DataBinding.DataField = 'PaymentOptions'
      DataBinding.DataSource = ds4
      Height = 219
      Width = 214
    end
    object cxdbchckgrp2: TcxDBCheckGroup
      Left = 231
      Top = 32
      Caption = 'Ship to locations'
      Properties.Columns = 2
      Properties.EditValueFormat = cvfCaptions
      Properties.Items = <>
      TabOrder = 10
      DataBinding.DataField = 'ShippingLocations'
      DataBinding.DataSource = ds4
      Height = 219
      Width = 217
    end
  end
  object ds1: TDataSource
    DataSet = nxtblPaymentOption
    Left = 24
    Top = 192
  end
  object ds2: TDataSource
    DataSet = nxtblShippingLocation
    Left = 192
    Top = 192
  end
  object ds3: TDataSource
    DataSet = nxtblShippingService
    Left = 368
    Top = 192
  end
  object nxtblebaypref: TnxTable
    Database = fmMain.nxdtbs1
    AfterOpen = nxtblShippingServiceAfterOpen
    TableName = 'ebaypreferences'
    IndexName = 'BySiteID'
    MasterFields = 'SiteCode'
    MasterSource = ds6
    Left = 784
    Top = 184
  end
  object ds4: TDataSource
    DataSet = nxtblebaypref
    Left = 712
    Top = 184
  end
  object ds5: TDataSource
    DataSet = nxtblShippingServiceIn
    Left = 520
    Top = 184
  end
  object nxtblSites: TnxTable
    Database = fmMain.nxdtbs1
    Filter = 'Enabled=true'
    Filtered = True
    AfterOpen = nxtblShippingServiceAfterOpen
    TableName = 'Sites'
    Left = 72
    Top = 104
  end
  object ds6: TDataSource
    DataSet = nxtblSites
    Left = 24
    Top = 104
  end
  object nxtblShippingService: TnxQuery
    Database = fmMain.nxdtbs1
    DataSource = ds6
    SQL.Strings = (
      
        'SELECT * FROM "ShippingServiceDetails"   where  InternationalSer' +
        'vice=false and SiteID=:SiteCode')
    Left = 440
    Top = 192
    ParamData = <
      item
        DataType = ftString
        Name = 'SiteCode'
        ParamType = ptUnknown
        Size = 51
      end>
  end
  object nxtblShippingServiceIn: TnxQuery
    Database = fmMain.nxdtbs1
    DataSource = ds6
    SQL.Strings = (
      
        'SELECT * FROM "ShippingServiceDetails"   where  InternationalSer' +
        'vice=false and SiteID=:SiteCode')
    Left = 600
    Top = 184
    ParamData = <
      item
        DataType = ftString
        Name = 'SiteCode'
        ParamType = ptUnknown
        Size = 51
      end>
  end
  object nxtblPaymentOption: TnxTable
    Database = fmMain.nxdtbs1
    TableName = 'PaymentOptionDetails'
    IndexFieldNames = 'SiteID'
    MasterFields = 'SiteCode'
    MasterSource = ds6
    Left = 88
    Top = 192
  end
  object nxtblShippingLocation: TnxTable
    Database = fmMain.nxdtbs1
    TableName = 'ShippingLocationDetails'
    IndexFieldNames = 'SiteID'
    MasterFields = 'SiteCode'
    MasterSource = ds6
    Left = 264
    Top = 192
  end
  object nxqry1: TnxQuery
    Database = fmMain.nxdtbs1
    DataSource = ds6
    SQL.Strings = (
      
        'SELECT * FROM "ReturnPolicyDetails" where Type='#39'Refund'#39' and Site' +
        'ID=:SiteCode')
    Left = 336
    Top = 328
    ParamData = <
      item
        DataType = ftString
        Name = 'SiteCode'
        ParamType = ptInput
      end>
  end
  object ds7: TDataSource
    DataSet = nxqry1
    Left = 376
    Top = 328
  end
  object nxqry2: TnxQuery
    Database = fmMain.nxdtbs1
    DataSource = ds6
    SQL.Strings = (
      
        'SELECT * FROM "ReturnPolicyDetails" where Type='#39'ReturnsWithin'#39' a' +
        'nd SiteID=:SiteCode')
    Left = 336
    Top = 384
    ParamData = <
      item
        DataType = ftString
        Name = 'SiteCode'
        ParamType = ptInput
      end>
  end
  object ds8: TDataSource
    DataSet = nxqry2
    Left = 376
    Top = 384
  end
  object nxqry3: TnxQuery
    Database = fmMain.nxdtbs1
    DataSource = ds6
    SQL.Strings = (
      
        'SELECT * FROM "ReturnPolicyDetails" where Type='#39'ReturnsAccepted'#39 +
        ' and SiteID=:SiteCode')
    Left = 456
    Top = 328
    ParamData = <
      item
        DataType = ftString
        Name = 'SiteCode'
        ParamType = ptInput
      end>
  end
  object ds9: TDataSource
    DataSet = nxqry3
    Left = 496
    Top = 328
  end
  object nxqry4: TnxQuery
    Database = fmMain.nxdtbs1
    DataSource = ds6
    SQL.Strings = (
      
        'SELECT * FROM "ReturnPolicyDetails" where Type='#39'ShippingCostPaid' +
        'By'#39' and SiteID=:SiteCode')
    Left = 456
    Top = 384
    ParamData = <
      item
        DataType = ftString
        Name = 'SiteCode'
        ParamType = ptInput
      end>
  end
  object ds10: TDataSource
    DataSet = nxqry4
    Left = 496
    Top = 384
  end
end
