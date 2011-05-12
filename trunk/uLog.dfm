object fmLog: TfmLog
  Left = 0
  Top = 0
  Caption = 'Event log'
  ClientHeight = 556
  ClientWidth = 831
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 512
    Width = 831
    Height = 44
    Align = alBottom
    BevelInner = bvLowered
    TabOrder = 0
    object Button1: TButton
      Left = 624
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Save'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 720
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Close'
      TabOrder = 1
      OnClick = Button2Click
    end
  end
  object LogMemo: TMemo
    Left = 0
    Top = 0
    Width = 831
    Height = 512
    Align = alClient
    TabOrder = 1
    ExplicitLeft = 384
    ExplicitTop = 128
    ExplicitWidth = 185
    ExplicitHeight = 89
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = '.log'
    Title = 'Save log'
    Left = 552
    Top = 368
  end
end
