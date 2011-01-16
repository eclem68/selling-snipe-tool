unit uIniSettings;

{$I definitions.inc}
interface

uses IniFiles;

type

  REbay = record
    AppID: string;
    DevID: string;
    CertID: string;
    Token: string;
  end;

  RSeparator = record
    DecimalSeparator: string[1];
    CSVSeparator: string[1];
  end;

  Tinisettings = class
  private
    FIniFile: TIniFile;
    FtmpString: string;
  protected
    function GetLocaleInformation(Flag: Integer): String;
  public
    ebay: REbay;
    separator: RSeparator;
    procedure Load(f: string);
    procedure Save(f: string);
{$IFDEF DEMO}
    procedure GetKeys;
    procedure ReportOperation(operation : string);
{$ENDIF}
  end;

implementation

{ Tinisettings }

uses SysUtils, Windows, Classes
{$IFDEF DEMO}
  , DCPcrypt2, DCPrijndael, DCPbase64, functions,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, Dialogs,
  Forms
{$ENDIF};
{$IFDEF DEMO}

const
  KeySize = 32; // 32 bytes = 256 bits
  BlockSize = 16; // 16 bytes = 128 bits
  IVText = 'abcdefghijklmnop';
  KeysURL = 'http://miroslav.if.ua/keys.php';

  // Pad a string with zeros so that it is a multiple of size
function PadWithZeros(const str: string; size: Integer): string;
var
  origsize, i: Integer;
begin
  Result := str;
  origsize := Length(Result);
  if ((origsize mod size) <> 0) or (origsize = 0) then
  begin
    SetLength(Result, ((origsize div size) + 1) * size);
    for i := origsize + 1 to Length(Result) do
      Result[i] := #0;
  end;
end;

procedure Tinisettings.ReportOperation(operation : string);
var Request : TStringList;
    Response : TMemoryStream;
    ResponseData : TStringList;
    IdHttp : TIdHTTP;
    IniFile : TIniFile;
    KeyText : string;
begin
  try
    ResponseData := TStringList.Create;
    IdHttp := TIdHTTP.Create(nil);
    IdHttp.HandleRedirects := True;
    IdHttp.ConnectTimeout:=5000; // 5 секунд
    IdHttp.ReadTimeout:=5000;
    try
      IniFile := TIniFile.Create(PBasePath+'/settings.ini');
      KeyText := IniFile.ReadString('demo','key','');
      Request := TStringList.Create;
      Response := TMemoryStream.Create;
      Request.Add(Format('Operation=%s',[operation]));
      Request.Add(Format('Key=%s',[KeyText]));
      try
        IdHttp.Post(KeysURL,Request,Response);
      except
        Exception.Create('Error while report operation');
      end;
      Response.Seek(0,soFromBeginning);
      ResponseData.LoadFromStream(Response);
    finally
      Request.Free;
      Response.Free;
    end;
  finally
    ResponseData.Free;
    IdHttp.Free;
  end;
end;

procedure Tinisettings.GetKeys;
var
  Request: TStringList;
  Response: TMemoryStream;
  ResponseData: TStringList;
  Cipher: TDCP_rijndael;
  Data, Key, IV: string;
  tmp: TArray;
  IdHTTP: TIdHTTP;
  KeyText: string;
  CurrentTime: Integer;
begin
  try
    ResponseData := TStringList.Create;
    IdHTTP := TIdHTTP.Create(nil);
    IdHTTP.HandleRedirects := True;
    IdHTTP.ConnectTimeout := 5000; // 5 секунд
    IdHTTP.ReadTimeout := 5000;
    try
      KeyText := FIniFile.ReadString('demo', 'key', '');
      Request := TStringList.Create;
      Response := TMemoryStream.Create;
      CurrentTime := Round((Now - int(Now)) * 864000);
      Request.Add(Format('Time=%d', [CurrentTime]));
      Request.Add(Format('Key=%s', [KeyText]));
      try
        IdHTTP.Post(KeysURL, Request, Response);
      except
        Exception.Create('Error while keys downloading');
      end;
      Response.Seek(0, soFromBeginning);
      ResponseData.LoadFromStream(Response);
    finally
      Request.Free;
      Response.Free;
    end;
    if Pos('Error', ResponseData.Text) = 0 then
    begin
      KeyText := Format('%s%d', [KeyText, CurrentTime]);
      // Pad Key and IV with zeros as appropriate
      Key := PadWithZeros(KeyText, KeySize);
      IV := PadWithZeros(IVText, BlockSize);
      // Decode the Base64 encoded string
      Data := Base64DecodeStr(ResponseData.Text);
      // Create the cipher and initialise according to the key length
      Cipher := TDCP_rijndael.Create(nil);
      if Length(KeyText) <= 16 then
        Cipher.Init(Key[1], 128, @IV[1])
      else if Length(KeyText) <= 24 then
        Cipher.Init(Key[1], 192, @IV[1])
      else
        Cipher.Init(Key[1], 256, @IV[1]);
      // Decrypt the data
      Cipher.DecryptCBC(Data[1], Data[1], Length(Data));
      // Free the cipher and clear sensitive information
      Cipher.Free;
      FillChar(Key[1], Length(Key), 0);
      // Display the result
      // Display the result
      tmp := explode(';', Data, 0);
      if High(tmp) = 3 then
      begin
        ebay.AppID := tmp[0];
        ebay.DevID := tmp[1];
        ebay.CertID := tmp[2];
        ebay.Token := tmp[3];
      end
      else
        Exception.Create('Invalid keys data');
    end
    else
    begin
      MessageDlg('Error during keys downloading. Program will be terminated',
        mtWarning, [mbOK], 0);
      Application.ProcessMessages;
      Application.Terminate;
    end;
  finally
    ResponseData.Free;
    IdHTTP.Free;
  end;
end;
{$ENDIF}

function Tinisettings.GetLocaleInformation(Flag: Integer): String;
var
  pcLCA: Array [0 .. 20] of Char;
begin
  if (GetLocaleInfo(LOCALE_SYSTEM_DEFAULT, Flag, pcLCA, 19) <= 0) then
    pcLCA[0] := #0;
  Result := pcLCA;
end;

procedure Tinisettings.Load(f: string);
begin
  if FileExists(f) then
    try
      FIniFile := TIniFile.Create(f);
{$IFDEF DEMO}
      GetKeys;
{$ELSE}
      ebay.AppID := FIniFile.ReadString('ebay', 'AppID', '');
      ebay.DevID := FIniFile.ReadString('ebay', 'DevID', '');
      ebay.CertID := FIniFile.ReadString('ebay', 'CertID', '');
      ebay.Token := FIniFile.ReadString('ebay', 'Token', '');
{$ENDIF}
      FtmpString := FIniFile.ReadString('separator', 'DecimalSeparator',
        GetLocaleInformation(LOCALE_SDECIMAL));
      separator.DecimalSeparator := FtmpString[1];
      FtmpString := FIniFile.ReadString('separator', 'CSVSeparator', ';');
      separator.CSVSeparator := FtmpString[1];
    finally
      FIniFile.Free;
    end
  else
    raise Exception.Create('File not found.');
end;

procedure Tinisettings.Save(f: string);
begin
  if FileExists(f) then
    try
      FIniFile := TIniFile.Create(f);
    finally
      FIniFile.Free;
    end
  else
    raise Exception.Create('File not found.');
end;

end.
