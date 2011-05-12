unit googleTranslator;

interface

uses idHTTP,
  IdThread,
  IdComponent,
  IdSync,
  Controls,
  Classes,
  Forms,
  IniFiles,
  StdCtrls,
  dxStatusBar;

type

  Operations = (OpWriteLogMes,OpSaveLog,OpOnWork, opReturnRes);

  TTransSync = class(TidSync)
  public
    Operation : Operations;
    Value: String;
    iVal : Integer;
    WorkMode: TWorkMode;
    FThread : TidThread;
    procedure DoSynchronize; override;
    procedure WriteLog(Logmessage: string);
    procedure SaveLog;
    procedure OnHttpWork(AWorkMode: TWorkMode; const AWorkCount: Integer);
    procedure ReturnResult(tag : Integer; res_string : string);
  end;

  TTranslateThread =  class(TidThread)
  private
     // Private declarations
     FTextCTag      : Integer;
     FHttpStatusCode : Integer;
     FRxDelta       : Integer;
     FTxDelta       : Integer;
     FSource        : string;
     FresultString  : string;
     FLangpair      : string;
     FBasePath      : string;
     FLangIniFile   : string;
     FSyncObj       : TTransSync;
     FForm          : TForm;
     FStatusBarPanel : TdxStatusBarPanel;
     FLangIni       : TIniFile;
     FLanguages     : TStringList;
     Fhttp          : TidHttp;
     Furl           : String;
     Fstatus        : String;
  protected
     // Protected declarations
     function URLEncode(const S: RawByteString): RawByteString;
     function googleTranslate(source : string; langpair : string; var resultString : string) : string;
     procedure TranslateEndRequest(ASender: TObject; AWorkMode: TWorkMode);
     procedure TranslateStartRequest(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
     procedure HttpWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
  public
     // Public declarations
     property Source : string read FSource write FSource;
     property ResultString : string read FresultString;
     property LangPair : string read FLangpair write FLangpair;
     property ControlTag : integer read FTextCTag write FTextCTag;
     property Form : TForm read FForm;
     property StatusBarPanel : TdxStatusBarPanel read FStatusBarPanel write FStatusBarPanel;
     // methods
     constructor  Create(Form: TForm);
     destructor Destroy; override;
     procedure Run; override;
  end;

implementation

uses SysUtils, uMain, uLog, cxTextEdit, cxDBEdit, cxMemo, DB;

{ TTranslateThread }

function TTranslateThread.URLEncode(const S: RawByteString): RawByteString;
  const
    NoConversion = ['A'..'Z', 'a'..'z', '*', '@', '.', '_', '-', '/', ':', '=', '?'];
  var
    i, idx, len: Integer;

  function DigitToHex(Digit: Integer): AnsiChar;
  begin
    case Digit of
      0..9: Result := AnsiChar(Chr(Digit + Ord('0')));
      10..15: Result := AnsiChar(Chr(Digit - 10 + Ord('A')));
    else
      Result := '0';
    end;
  end; // DigitToHex

begin
  len := 0;
  for i := 1 to Length(S) do
    if S[i] in NoConversion then
      len := len + 1
    else
      len := len + 3;
  SetLength(Result, len);
  idx := 1;
  for i := 1 to Length(S) do
    if S[i] in NoConversion then
    begin
      Result[idx] := S[i];
      idx := idx + 1;
    end
    else
    begin
      Result[idx] := '%';
      Result[idx + 1] := DigitToHex(Ord(S[i]) div 16);
      Result[idx + 2] := DigitToHex(Ord(S[i]) mod 16);
      idx := idx + 3;
    end;
end; // URLEncode

// source - the string to be translated
// langpair - the string that defines the source and target language in special format,
//     i.e. “en|ru”. The list of available languages and their abbreviations
//     you may find in Translation API description
// resultString - the translation
// result - the error message if any. Empty result means that
//     the function has been executed successfully
function TTranslateThread.googleTranslate(source : string; langpair : string; var resultString : string) : string;
var
  s : String;
  utfs : UTF8String;

begin
  result := '';

  Fhttp := TidHttp.Create;
  Fhttp.OnWork := HttpWork;
  Fhttp.OnWorkBegin := TranslateStartRequest;
  Fhttp.OnWorkEnd := TranslateEndRequest;

  try
    utfs := UTF8String(source);
    utfs := URLEncode(utfs);
    Furl := 'http://ajax.googleapis.com/ajax/services/language/translate?v=1.0&q=' + String(utfs) + '&langpair=' + langpair;

    Fhttp.Request.Referer := 'http://oursite.com';
    Fhttp.Request.UserAgent := 'Our Application';
    FSyncObj.WriteLog(Format('ThreadID %d - Start text %s',[Self.ThreadID,utfs]));
    s := Fhttp.Get(Furl);
    FSyncObj.WriteLog(Format('ThreadID %d - Result text %s',[Self.ThreadID,s]));
    FSyncObj.WriteLog(Format('ThreadID %d - GoogleTranslate Status %s',[Self.ThreadID,Fstatus]));
    Fstatus := Copy(s, pos('"responseStatus":', s)+18, length(s));
    Fstatus := Copy(Fstatus, 0, pos('}', Fstatus)-1);

    FSyncObj.WriteLog(Format('ThreadID %d - GoogleTranslate Status %s',[Self.ThreadID,Fstatus]));

    if (Fstatus = '200') then begin //status is OK
      s := Copy(s, pos('"translatedText":', s)+18, length(s));
      resultString := Copy(s, 0, pos('"}, "responseDetails"', s)-1);
    end
    else begin //an error occured
      s := Copy(s, pos('"responseDetails":', s)+20, length(s));
      resultString := '';
      result := Copy(s, 0, pos('", "responseStatus"', s)-1);
      FSyncObj.WriteLog(Format('ThreadID %d - Error GoogleTranslate - Result %s',[Self.ThreadID,result]));
    end;

  finally
    Fhttp.Free;
  end;
end;

constructor TTranslateThread.Create(Form: TForm);
var inireaderrormsg : string;
begin
  inherited Create(true);
  FForm := Form;
  FSyncObj := TTransSync.Create;
  FSyncObj.FThread := Self;
  FBasePath := ExtractFileDir(Paramstr(0));
  FLangIniFile := FBasePath+'Settings/languages.ini';
  FLanguages := TStringList.Create;
  try
    try
      FLangIni := TIniFile.Create(FLangIniFile);
      FLangIni.ReadSection('languages',FLanguages);
    finally
      if Assigned(FLangIni) then FreeAndNil(FLangIni);
    end;
  except
    inireaderrormsg := 'Error whel reading language ini file';
    FSyncObj.WriteLog(inireaderrormsg);
    Exception.Create(inireaderrormsg);
  end;
  FreeOnTerminate := True;
end;

destructor TTranslateThread.Destroy;
begin
  if Assigned(FLanguages) then FreeAndNil(FLanguages);
  inherited;
end;

procedure TTranslateThread.HttpWork(ASender: TObject;
  AWorkMode: TWorkMode; AWorkCount: Int64);
begin

end;

procedure TTranslateThread.TranslateEndRequest(ASender: TObject; AWorkMode: TWorkMode);
begin
  FSyncObj.WriteLog(Format('ThreadID %d - GoogleTranslate HTTP Result %d',[Self.ThreadID,(ASender as TidHttp).ResponseCode]));
end;

procedure TTranslateThread.TranslateStartRequest(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
begin
  FSyncObj.WriteLog(Format('ThreadID %d - GoogleTranslate Start HTTP request',[Self.ThreadID]));
end;

procedure TTranslateThread.Run;
var res: string;
begin
  inherited;
  if Length(FSource)>0 then
  if Length(FLangpair)>0 then res := googleTranslate(FSource,FLangpair,FresultString);
  if res = '' then  begin
    if FTextCTag > 0 then FSyncObj.ReturnResult(FTextCTag,FresultString);
  end
  else begin
    FSyncObj.WriteLog(Format('ThreadID %d - GoogleTranslate error %s',[Self.ThreadID,res]));
    FSyncObj.ReturnResult(FTextCTag,res);
  end;
end;

{ TTransSync }

procedure TTransSync.DoSynchronize;
var i: Integer;
    tmpfield :TField;
    tmpfiledname : string;
    tmpdataset : TDataSet;
begin
  inherited;
  case Operation of
    OpWriteLogMes : begin
      fmMain.WriteLog(Value);
    end;
    OpSaveLog : fmLog.AdvLogMemo.Lines.SaveToFile(fmMain.BasePath+'\log\exception.log');
    OpOnWork : begin
      case WorkMode of
        wmRead : begin
          fmMain.RxCounter := fmMain.RxCounter + iVal;
          fmMain.RxCounterDelta := fmMain.RxCounterDelta + iVal;
        end;
        wmWrite : begin
          fmMain.TxCounter := fmMain.TxCounter + iVal;
          fmMain.TxCounterDelta := fmMain.TxCounterDelta + iVal;
        end
      end;
    end;
    opReturnRes : with FThread as TTranslateThread do begin
      for i:=0 to Form.ComponentCount -1 do if Form.Components[i].Tag = iVal then begin
        tmpfiledname := Form.Components[i].ClassName;
        if Form.Components[i].ClassName = 'TcxTextEdit' then (Form.Components[i] as TcxTextEdit).Text := Value;
        if Form.Components[i].ClassName = 'TcxDBTextEdit' then begin
          tmpfiledname := (Form.Components[i] as TcxDbTextEdit).DataBinding.DataField;
          tmpdataset := (Form.Components[i] as TcxDbTextEdit).DataBinding.DataSource.DataSet;
          tmpfield := tmpdataset.FieldByName(tmpfiledname);
          if not (tmpdataset.State in [dsEdit]) then tmpdataset.Edit;
          //(Form.Components[i] as TcxDbTextEdit).Text := Value;
          tmpfield.Value := Value;
          (Form.Components[i] as TcxDbTextEdit).Refresh;

        end;
        if Form.Components[i].ClassName = 'TcxMemo' then (Form.Components[i] as TcxMemo).Text := Value;
        if Form.Components[i].ClassName = 'TcxDBMemo' then begin
          tmpfiledname := (Form.Components[i] as TcxDbMemo).DataBinding.DataField;
          tmpdataset := (Form.Components[i] as TcxDbMemo).DataBinding.DataSource.DataSet;
          tmpfield := tmpdataset.FieldByName(tmpfiledname);
          if not (tmpdataset.State in [dsEdit]) then tmpdataset.Edit;
          //(Form.Components[i] as TcxDbMemo).Text := Value;
          tmpfield.Value := Value;
          (Form.Components[i] as TcxDbMemo).Refresh;
        end;
        fmMain.WriteLog(Value);
        StatusBarPanel.Text := 'Idle';
        Break;
      end;
    end;
  end;
end;

procedure TTransSync.OnHttpWork(AWorkMode: TWorkMode; const AWorkCount: Integer);
begin
  WorkMode := AWorkMode;
  iVal := AWorkCount;
  Operation := OpOnWork;
  Synchronize;
end;

procedure TTransSync.ReturnResult(tag: Integer; res_string: string);
begin
  Value := res_string;
  iVal := tag;
  Operation := opReturnRes;
  Synchronize;
end;

procedure TTransSync.SaveLog;
begin
  Operation := OpSaveLog;
  Synchronize;
end;

procedure TTransSync.WriteLog(Logmessage: string);
begin
  Value := Logmessage;
  Operation := OpWriteLogMes ;
  Synchronize;
end;

end.
