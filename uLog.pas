unit uLog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SynEdit, SynMemo, StdCtrls, ExtCtrls;

type
  TfmLog = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    AdvLogMemo: TSynMemo;
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmLog: TfmLog;

implementation

uses uMain;

{$R *.dfm}

procedure TfmLog.Button1Click(Sender: TObject);
begin
  AdvLogMemo.Lines.SaveToFile(fmMain.BasePath+'/log/programm.log');
end;

procedure TfmLog.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TfmLog.FormDestroy(Sender: TObject);
begin
  AdvLogMemo.Lines.SaveToFile(fmMain.BasePath+'/log/programm.log');
end;

end.
