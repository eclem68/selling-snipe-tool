program EbayTool;

uses
  Forms,
  HotLog,
  uMain in 'uMain.pas' {fmMain},
  uUserSettings in 'uUserSettings.pas' {fmUserSettings},
  uIniSettings in 'uIniSettings.pas',
  uLog in 'uLog.pas' {fmLog},
  uGetDetails in 'uGetDetails.pas',
  uTypes in 'uTypes.pas',
  uGetCategories in 'uGetCategories.pas',
  uEbayProfile in 'uEbayProfile.pas' {fmEbayProfiles},
  uItemEditor in 'uItemEditor.pas' {fmItemEditor},
  uGetSuggestedCategories in 'uGetSuggestedCategories.pas',
  uSiteSelector in 'uSiteSelector.pas' {fmSiteSelector};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Ebay selling & snipping tool';
  Application.CreateForm(TfmMain, fmMain);
  Application.CreateForm(TfmUserSettings, fmUserSettings);
  Application.CreateForm(TfmLog, fmLog);
  Application.CreateForm(TfmEbayProfiles, fmEbayProfiles);
  Application.CreateForm(TfmItemEditor, fmItemEditor);
  Application.CreateForm(TfmSiteSelector, fmSiteSelector);
  Application.Run;
end.
