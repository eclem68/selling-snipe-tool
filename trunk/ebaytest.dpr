program ebaytest;

uses
  Forms,
  uTst in 'uTst.pas' {fmTest};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfmTest, fmTest);
  Application.Run;
end.
