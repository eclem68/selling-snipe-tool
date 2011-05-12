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
    LogMemo: TMemo;
    SaveDialog1: TSaveDialog;
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmLog: TfmLog;

implementation

uses uMain, hotlog;

{$R *.dfm}

procedure TfmLog.Button1Click(Sender: TObject);
begin
  if SaveDialog1.Execute then LogMemo.Lines.SaveToFile(SaveDialog1.FileName);
end;

procedure TfmLog.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TfmLog.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if hLog.StopVisualFeedBack then Action:=caFree else Action := caHide;
end;

procedure TfmLog.FormCreate(Sender: TObject);
begin
  hLog.DisplayFeedBackInto(LogMemo);
  SaveDialog1.InitialDir := hLog.hlWriter.hlFileDef.path;
end;

procedure TfmLog.FormDestroy(Sender: TObject);
begin
  hLog.StopVisualFeedBack;
end;

end.
