unit uThreadSync;

interface

uses IdSync , IdComponent, uTypes;

type
  Operations = (OpWriteLogMes,
                OpWriteAdvLog,
                OpSaveLog,
                OpDecCounter,
                OpIncApiUsage,
                OpOnWork,
                OpOnSave,
                OpReturnResult,
                OpReturnDResult,
                OpUpdateDThreadParams,
                OpSaveItemDetails,
                OpUpdTimeShift,
                OpSaveAspect,
                OpClearAspect
                );

  TFTSync = class(TidSync)
  private
  public
    Value: String;
    iVal : Integer;
    iReal : Real;
    EbayTime : TDateTime;
    XRec : TSearchThreadStatus;
    DRec : TDownloadImageThreadStatus;
    FItemRec: TItemDetails;
    FAspectArray : TAspectArray;
    FAspectName : string;
    FSearchID : integer;
    WorkMode: TWorkMode;
    Operation : Operations;
    procedure DoSynchronize; override;
    procedure WriteAdvLog(Logmessage: string);
    procedure WriteLog(Logmessage: string);
    procedure IncApiUsage;
    procedure SaveAdvLog;
    procedure OnHttpWork(AWorkMode: TWorkMode; const AWorkCount: Integer);
    procedure OnSave(Saved,Total : Integer);
    procedure UpdThreadStatus(FRec : TSearchThreadStatus; SearchID : Integer);
    procedure UpdDThreadStatus(FRec : TDownloadImageThreadStatus);
    procedure SaveItemDetails(ItemRec : TItemDetails);
    procedure SaveAspect(SearchID: Integer; AspectName: String; AspectArray : TAspectArray);
    procedure ClearAspect(SearchID: Integer);
    procedure UpdTimeShift(tEbayTime : string);
    procedure UpdDThreadParams;
  end;

implementation

uses uLog, SysUtils, uEbaySearchThread, uMain, functions;

{ TFTSync }
procedure TFTSync.DoSynchronize;
var x : Integer;
    i : Integer;
begin
  inherited;
  case Operation of
    OpWriteLogMes : begin
      fmMain.WriteLog(Value);
    end;
    OpSaveLog : fmLog.AdvLogMemo.Lines.SaveToFile(fmMain.BasePath+'\log\exception.log');
    OpDecCounter : inc(fmMain.FTCount,-1);
    OpIncApiUsage : fmMain.IncApiUsage;
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
    OpOnSave : fmMain.sbrStatusBar.Panels[4].Text := Value;
    OpReturnResult : with fmMain do
      for i:=0 to High(SearchStatusArr) do
        if SearchStatusArr[i].ThreadID = iVal then begin
          SearchStatusArr[i].TotalPages := XRec.TotalPages;
          SearchStatusArr[i].LoadedPages := XRec.LoadedPages;
          SearchStatusArr[i].TotalItems := XRec.TotalItems;
          SearchStatusArr[i].LoadedItems := SearchStatusArr[i].LoadedItems + XRec.LoadedItems;
          SearchStatusArr[i].SavedItems := SearchStatusArr[i].SavedItems + XRec.SavedItems;
          SearchStatusArr[i].CurrentCategory := XRec.CurrentCategory;
          SearchStatusArr[i].TotalCategories := XRec.TotalCategories;
          SearchStatusArr[i].ThreadID := XRec.ThreadID;
          UpdateThreadStatus;
          Break;
        end;
    OpSaveItemDetails : with fmMain do begin
      SaveItemetails(FItemRec);
    end;
    OpUpdTimeShift : with fmMain do begin
      TimeShift := Now - EbayTime;
      TimeShiftSet := True;
      sbrStatusBar.Panels[3].Text := 'Time shift: '+TimeToStr(TimeShift);
      inisettings.timeshiftebay := TimeShift;
    end;
    OpSaveAspect : with fmMain do begin
      fmMain.SaveAspect(FSearchID,FAspectName,FAspectArray);
    end;
    OpClearAspect : with fmMain do begin
      fmMain.ClearAspect(FSearchID);
    end;
  end;
end;

procedure TFTSync.WriteAdvLog(Logmessage: string);
begin
  Value := Logmessage;
  Operation := OpWriteAdvLog;
  Synchronize;
end;

procedure TFTSync.WriteLog(Logmessage: string);
begin
  Value := Logmessage;
  Operation := OpWriteLogMes ;
  Synchronize;
  Operation := OpWriteAdvLog;
  Synchronize;
end;

procedure TFTSync.IncApiUsage;
begin
  Operation := OpIncApiUsage;
  Synchronize;
end;

procedure TFTSync.SaveAdvLog;
begin
  Operation := OpSaveLog;
  Synchronize;
end;

procedure TFTSync.OnHttpWork(AWorkMode: TWorkMode; const AWorkCount: Integer);
begin
  WorkMode := AWorkMode;
  iVal := AWorkCount;
  Operation := OpOnWork;
  Synchronize;
end;

procedure TFTSync.OnSave(Saved, Total: Integer);
begin
  Operation := OpOnSave;
  Value := Format('Saved %d of %d items',[Saved,Total]);
  Synchronize;
end;

procedure TFTSync.UpdThreadStatus(FRec : TSearchThreadStatus; SearchID : Integer);
begin
  iVal := SearchID;
  Operation := OpReturnResult ;
  XRec := FRec;
  Synchronize;
end;

procedure TFTSync.UpdDThreadStatus(FRec : TDownloadImageThreadStatus);
begin
  Operation := OpReturnDResult ;
  DRec := FRec;
  Synchronize;
end;

procedure TFTSync.UpdDThreadParams;
begin
  Operation := OpUpdateDThreadParams ;
  Synchronize;
end;

procedure TFTSync.SaveItemDetails(ItemRec: TItemDetails);
begin
  Operation := OpSaveItemDetails;
  FItemRec:= ItemRec;
  Synchronize;
end;

procedure TFTSync.SaveAspect(SearchID: Integer; AspectName: String; AspectArray : TAspectArray);
begin
  Operation := OpSaveAspect;
  FAspectName := AspectName;
  FSearchID := SearchID;
  FAspectArray:= AspectArray;
  Synchronize;
end;

procedure TFTSync.ClearAspect(SearchID: Integer);
begin
  Operation := OpClearAspect;
  FSearchID := SearchID;
  Synchronize;
end;

procedure TFTSync.UpdTimeShift(tEbayTime : string);

begin
  Operation := OpUpdTimeShift;
  EbayTime := eBayTimeStrConvert(tEbayTime);
  Synchronize;
end;

end.
