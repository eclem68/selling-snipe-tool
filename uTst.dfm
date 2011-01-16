object fmTest: TfmTest
  Left = 0
  Top = 0
  Caption = 'Test ebay components'
  ClientHeight = 473
  ClientWidth = 613
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 8
    Top = 448
    Width = 3
    Height = 13
  end
  object mmo1: TMemo
    Left = 8
    Top = 8
    Width = 597
    Height = 209
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object mmo2: TMemo
    Left = 8
    Top = 223
    Width = 597
    Height = 209
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object btn1: TButton
    Left = 530
    Top = 438
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 2
    OnClick = btn1Click
  end
  object btn2: TButton
    Left = 449
    Top = 438
    Width = 75
    Height = 25
    Caption = 'Start picture'
    TabOrder = 3
    OnClick = btn2Click
  end
  object ebytrdngcnct1: TEbayTradingConnect
    AppID = 'PRESTOF9X3CEW4XLI6916831H4172R'
    ProxyParameters.BasicAuthentication = False
    ProxyParameters.ProxyPort = 0
    ServiceURL = 'https://api.sandbox.ebay.com/ws/api.dll'
    SiteID = US
    InterceptActive = False
    SSLCertFile = 'test_b_crt.pem'
    SSLKeyFile = 'test_b_key.pem'
    SSLRootCertFile = 'test_b_ca.pem'
    SSLMethod = sslvSSLv23
    Port = 0
    SSLPassword = 'aaaa'
    DevID = 'Z1AIRF6G7HKMN75UO8FHQ5JJW4C58W'
    CertID = '3ec6e912-16c6-4294-a11a-4eb04779769e'
    Token = 
      'AgAAAA**AQAAAA**aAAAAA**Dfo9TA**nY+sHZ2PrBmdj6wVnY+sEZ2PrA2dj6wJ' +
      'nY+kCJKKqQSdj6x9nY+seQ**MokAAA**AAMAAA**FUkh9KmyrLz9ViSmDvUsGVwW' +
      'sB4A7l2cBira5zkO9BcpI7NC86pJoZReT0yhlUjhgVE/zUwkTWfZiURA7whW1HD1' +
      'HHtnacg9wTP/hgabfc6xLqcckT1h7PdNkKRURvJtaHbLkGaGHDJ1cgQ2KDlngWKN' +
      'Nf1gB7gKrTcotJeO3NFL/W9hxUV7WDA8IGbIamvKmC6a7y3hFtyYjtmQBFI75fLM' +
      'LQePoHzlN7yUY4UgTj4MYcUMK06Ryj9RvVJ+jjSHyPHfXu8AUgm8ZnrCpU6LSdQM' +
      'vJyUIg7a/bUEsxfwlkUnuPylmVz19uPPi0kv6qplMb66lZUsmcmfHm0vogRLIlmo' +
      'mITjEFX989NlioGyslvkgkOxnPSHkvGGd09LCcSFC3yKNgN2hAfMd67LJDeZCBtH' +
      'UT7WlQy9A96meOxs1zSFc895ETDBXkNc66H3uKYF4kmiUXQZTiDWhOeJbo12JGIc' +
      '2HgJwJB3VMk9yIElpadco0au+SzRJNp6Vbc+NYLNfw93hbgyJcLYjkTno1JLezWY' +
      'w2eIjb2WCtHRwwEdd588XpCIosV20Na5VBKEWjUOae+Of0M/NFw+FBB+uaRTYfrH' +
      'xo6m1NuJaiCQN6MpLzV3rxEeAn3RLzbuUmGGa56yxwOZp8SfB0zMqldnIJuyVB4H' +
      'bB75DRV3BvxTQwjtaJKNFI2eJupznHz6MIhYjsYb9QLg8xFEFwoSPwgDhbAHzlq8' +
      'SZEPq4JLJV2moK0SGrvpSZdqL0M0RZCInEeDXOaw'
    Host = 'api.sandbox.ebay.com'
    Left = 24
    Top = 24
  end
  object gtbyfcltm1: TGeteBayOfficialTime
    Connector = ebytrdngcnct1
    WarningLevel = WHigh
    OnEndRequest = gtbyfcltm1EndRequest
    Left = 24
    Top = 88
  end
  object upldsthstdpctrs1: TUploadSiteHostedPictures
    Connector = ebytrdngcnct1
    WarningLevel = WHigh
    OnEndRequest = upldsthstdpctrs1EndRequest
    PictureSet = Standard
    PictureWatermark = []
    ExtensionInDays = 0
    PictureSystemVersion = 0
    Left = 32
    Top = 152
  end
end
