unit uEbaySearchThread;

interface
{$DEFINE INDY10}
{$DEFINE DEMO}
uses
  Classes,
  SysUtils,
  TypInfo,
  Variants,
  uTypes,
  DB, ADODB,
  ActiveX,
  FindingServiceXMLClasses,
  EbayConnect, IdThread, IdSync, uThreadSync, IdComponent,
  Forms;

type
  TAspectFilter = class(TPersistent)
  public
    name : string;
    values : array of string;
  end;

  TFindAdvThread =  class(TidThread)
  private
    // Private declarations
    FAborted     : Boolean; 
    FForm        : TForm;
    FKeyWords    : string;
    FDescriptionSearch : Boolean;
    FCategories  : TStringList;
    FCondition     : string;
    FPaymentMethod : string;
    FSellerBusinessType : string;
    FCurrency      : string;
    FFeedbackScoreMax : Integer;
    FFeedbackScoreMin  : Integer;
    FBidsMax       : Integer;
    FBidsMin       : Integer;
    FQuantityMax   : Integer;
    FQuantityMin   : Integer;
    FEndTimeFrom   : TDateTime;
    FEndTimeTo     : TDateTime;
    FMaxDistance   : Integer;
    FLocalSearchOnly : Boolean;
    FExcludeAutoPay : Boolean;

    FSortOrder     : string;
    FLocatedIn     : string;
    FAvailableto   : string;
    FListingTypes  : TStringList;
    FSeller        : TStringList;
    FExcludeSeller : TStringList;
    FPriceFrom     : Real;
    FPriceTo       : Real;
    FPriceCurrency : string;
    FHideDuplicates: Boolean;
    FFetchAllPages : Boolean;
    FOperationResult : AckCodeType;
    FAppID       : string;
    FGlobalID    : Global_ID;
    FSearchID    : Integer;
    FOutputSelector : OutputSelectorSetType;
    FBuyerPostalCode : string;
    FRxDelta       : Integer;
    FTxDelta       : Integer;
    Fdc            : Char;
    FNotOlder      : integer;
    FListTime      : TDateTime;
    FStartTime     : TDateTime;
    FTimeShift     : TDateTime;
    FBasePath      : string;
    FImageFolder   : string;
    FXMLDebugOutPut: Boolean;

    FEbayFindingConnect  : TEbayFindingConnect;
    FFindItemsAdvanced   : TFindItemsAdvanced;
    FSyncObj : TFTSync;
    FConnection : TADOConnection;
    FQuery : TADOQuery;

    FCounter     : Integer;
    FCounterAll  : Integer;
    FPageNum     : Integer;
    FItemsPerPage: Integer;
    FTotalPages  : Integer;
    FTotalItems  : Integer;
    FTID         : Integer;
    FUpdateRec   : TSearchThreadStatus;

    Fcat_id      : Integer;
    FIgnoreCategories : Boolean;
    FSaveAspectValues : Boolean;

    FAspectFilters : array of TAspectFilter;

  protected
    // Protected declarations
    procedure SetCategories(Value : TStringList);
    procedure SetListingTypes(Value : TStringList);
    procedure SetSeller(Value : TStringList);
    procedure SetExcludeSeller(Value : TStringList);
    procedure FindItemsAdvancedAPIError(Sender: TObject; ErrorRecord: eBayFindingAPIError);
    procedure FindItemsAdvancedEndRequest(Sender: TObject);
    procedure FindItemsAdvancedStartRequest(Sender: TObject);
    procedure DecTCounter;
    procedure WriteEbayApiExceptionLog(E : Exception);
    procedure WriteExceptionLog(E: Exception);
    procedure SaveAspect;
    {$IFDEF INDY10}procedure EbayFindingConnectWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);{$ENDIF}
    {$IFDEF INDY9}procedure EbayFindingConnectWork(Sender: TObject; AWorkMode: TWorkMode; const AWorkCount: Integer);{$ENDIF}
    {$IFDEF DEMO}procedure ReportOperation;{$ENDIF}
  public
    // Objects visible outside threads
    property EbayFindingConnect  : TEbayFindingConnect read FEbayFindingConnect write FEbayFindingConnect;
    property FindItemsAdvanced   : TFindItemsAdvanced read FFindItemsAdvanced write FFindItemsAdvanced;
    property AppID      : string read FAppID write FAppID;
    property GlobalID   : Global_ID read FGlobalID write FGlobalID;
    property KeyWords   : string read FKeyWords write FKeyWords;
    property DescriptionSearch : Boolean read FDescriptionSearch write FDescriptionSearch;
    property Categories : TStringList read FCategories write SetCategories;
    property LocatedIn  : string read FLocatedIn write FLocatedIn;
    property Page : Integer read FPageNum write FPageNum;
    property ItemsPerPage: Integer read FItemsPerPage write FItemsPerPage;
    property TID  : Integer read FTID write FTID;
    property ItemsSaved : Integer read FCounter;
    property ItemsLoaded: Integer read FCounterAll;
    property TotalPages : Integer read FTotalPages;
    property TotalItems : Integer read FTotalItems;
    property FetchAllPages : Boolean read FFetchAllPages write FFetchAllPages;
    property SearchID   : Integer read FSearchID write FSearchID;
    property DecimalSeparator : Char read Fdc write Fdc;
    property Condition : string read FCondition write FCondition;
    property SortOrder : string read FSortOrder write FSortOrder;
    property FeedbackScoreMax : Integer read FFeedbackScoreMax write FFeedbackScoreMax;
    property FeedbackScoreMin  : Integer read FFeedbackScoreMin write FFeedbackScoreMin;
    property BidsMax : Integer read FBidsMax write FBidsMax;
    property BidsMin : Integer read FBidsMin write FBidsMin;
    property QuantityMax : Integer read FQuantityMax write FQuantityMax;
    property QuantityMin : Integer read FQuantityMin write FQuantityMin;
    property EndTimeFrom   : TDateTime read FEndTimeFrom write FEndTimeFrom;
    property EndTimeTo     : TDateTime read FEndTimeTo write FEndTimeTo;
    property BuyerPostalCode : string read FBuyerPostalCode write FBuyerPostalCode;
    property MaxDistance   : Integer read FMaxDistance write FMaxDistance;
    property LocalSearchOnly : Boolean read FLocalSearchOnly write FLocalSearchOnly;

    property Availableto   : string  read FAvailableto write FAvailableto;
    property ListingTypes  : TStringList  read FListingTypes write SetListingTypes;
    property Seller        : TStringList  read FSeller write SetSeller;
    property ExcludeSeller : TStringList  read FExcludeSeller write SetExcludeSeller;
    property PriceFrom     : Real  read FPriceFrom write FPriceFrom;
    property PriceTo       : Real  read FPriceTo write FPriceTo;
    property PriceCurrency : string read FPriceCurrency write FPriceCurrency;
    property PaymentMethod : string read FPaymentMethod write FPaymentMethod;
    property SellerBusinessType : string read FSellerBusinessType write FSellerBusinessType;
    property Currency      : string read FCurrency write FCurrency; 
    property OutputSelector : OutputSelectorSetType read FOutputSelector write FOutputSelector;
    property HideDuplicates: Boolean  read FHideDuplicates write FHideDuplicates;

    property NotOlder : integer read FNotOlder write FNotOlder;
    property PBasePath : string read FBasePath write FBasePath;
    property ImageFolder : string read FImageFolder write FImageFolder;
    property Cat_id : Integer read Fcat_id;
    property Aborted : Boolean read FAborted write FAborted;
    property XMLDebugOutput: Boolean read FXMLDebugOutPut write FXMLDebugOutPut;
    property IgnoreCategories : Boolean read FIgnoreCategories write FIgnoreCategories;
    property SaveAspectValues : Boolean read FSaveAspectValues write FSaveAspectValues;

    // methods
    constructor  Create(Form: TForm);
    destructor Destroy; override;
    procedure Run; override;
    procedure WriteToDB(FItemsCounter:integer);
    procedure AddAspectFilter(AspectFilter : TAspectFilter);
    procedure ClearAspectFilters;
  end;

implementation

uses functions, FindingServiceXML, IdHTTP, uMain, Math, Jpeg, IniFiles;
{ TFindAdvThread }

{$IFDEF DEMO}
const KeysURL = 'http://miroslav.if.ua/keys.php';

procedure TFindAdvThread.ReportOperation;
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
      Request.Add('Operation=FindItemAdvanced');
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
{$ENDIF}

constructor TFindAdvThread.Create(Form: TForm);
begin
  inherited Create(true);
  FAborted := False;
  Fcat_id := 0;
  FSyncObj := TFTSync.Create;
  DecTCounter;
  FForm := Form;
  FCategories  := TStringList.Create;
  FListingTypes  := TStringList.Create;
  FSeller        := TStringList.Create;
  FExcludeSeller := TStringList.Create;
  FEbayFindingConnect := TEbayFindingConnect.Create(nil);
  FEbayFindingConnect.OnWork := EbayFindingConnectWork;
  FItemsPerPage :=100;

  FConnection := TADOConnection.Create(nil);
  FConnection.ConnectionString := fmMain.con1.ConnectionString;
  FConnection.LoginPrompt := False;
  FQuery := TADOQuery.Create(nil);
  FQuery.Connection := FConnection;
  FQuery.SQL.Add('select count(*) as cnt from Items where ItemID = :ItemID');
  FQuery.Parameters[0].DataType := ftString;
  FQuery.Prepared := True;
  FreeOnTerminate := True;
  FFetchAllPages := True;
  FIgnoreCategories := False;
  Fdc := '.';
  FStartTime := now;
  FListTime := Now;
  FXMLDebugOutPut := False;
  FSaveAspectValues := False;
end;

destructor TFindAdvThread.Destroy;
begin
  FreeAndNil(FData);
  ClearAspectFilters;
  if FEbayFindingConnect <> nil then FreeAndNil(FEbayFindingConnect);
  if FCategories <> nil then FreeAndNil(FCategories);
  if FListingTypes <> nil then FreeAndNil(FListingTypes);
  if FSeller <> nil then FreeAndNil(FSeller);
  if FExcludeSeller <> nil then FreeAndNil(FExcludeSeller);
  if FQuery <> nil then FreeAndNil(FQuery);
  if FConnection <> nil then FreeAndNil(FConnection);
  inherited;
end;

procedure TFindAdvThread.Run;
var i: Integer;
    hr: HRESULT;
    xTime : TDateTime;
    LowTimeLimit : TDateTime;
begin
  inherited;
  xTime := FNotOlder/1440;
  // initialize
  try
    hr := CoInitializeEx(nil, COINIT_APARTMENTTHREADED);
    if hr <> S_OK then Exception.Create('Error occurs: ' + IntToHex(hr, 2));
    FConnection.Open;
    // initialize Ebay Components
    FEbayFindingConnect.AppID := FAppID;
    FEbayFindingConnect.GlobalID := FGlobalID;
    
    FFindItemsAdvanced := TFindItemsAdvanced.Create(nil);
    FFindItemsAdvanced.Connector := FEbayFindingConnect;
    FFindItemsAdvanced.OnAPIError := FindItemsAdvancedAPIError;
    FFindItemsAdvanced.OnEndRequest := FindItemsAdvancedEndRequest;
    FFindItemsAdvanced.OnStartRequest := FindItemsAdvancedStartRequest;

    if Terminated then Stop;
    FRxDelta := 0;
    FTxDelta := 0;
    // begin execution
    Fcat_id := 0;
    repeat
      // categories
      FSyncObj.WriteLog(Format('Start downloading for Category ID %s',[FCategories[Fcat_id]]));
      repeat
        // pages
        try
          FOperationResult := FFindItemsAdvanced.DoRequestEx;
          FCounter := 0;
          FCounterAll := 0;

          if (FOperationResult in [Success, Warning, PartialFailure]) then
          begin
            if not FConnection.Connected then FConnection.Connected := True;
            try
              FConnection.BeginTrans;
              for i:=0 to FFindItemsAdvanced.SearchResult.Count-1 do begin
                WriteToDB(i);
                Inc(FCounterAll);
              end;
              if FSaveAspectValues then SaveAspect;
              FConnection.CommitTrans;
              FTimeShift := Now - eBayTimeStrConvert(FFindItemsAdvanced.timeStamp);
              LowTimeLimit := FStartTime-FTimeShift-XTime;
              FTotalPages := FFindItemsAdvanced.paginationOutput.totalPages;
              FTotalItems := FFindItemsAdvanced.paginationOutput.TotalEntries;
            except
              on E : Exception do
              begin
                WriteExceptionLog(E);
                FConnection.RollbackTrans;
              end;
            end;
            // when page processing complete - write to log
            FSyncObj.WriteLog(Format('%s: ThreadID %d - ApiCall: FindItemsAdvanced. Page %d of %d Items added %d, ignored %d of %d',[DateTimeToStr(now),Self.ThreadID, FPageNum, FTotalPages,FCounter,FCounterAll-FCounter,FFindItemsAdvanced.SearchResult.Count]));
          end;
          if (FOperationResult in [Failure, Warning, PartialFailure]) then
            with FSyncObj do begin
              WriteLog(Format('%s: ThreadID %d Request failure',[DateTimeToStr(now),Self.ThreadID]));
              WriteAdvLog('Request XML');
              for i := 0 to FEbayFindingConnect.RequestXMLText.Count -1 do WriteAdvLog(FEbayFindingConnect.RequestXMLText.Strings[i]);
              WriteAdvLog('Response XML');
              for i := 0 to FEbayFindingConnect.ResponseXMLText.Count -1 do WriteAdvLog(FEbayFindingConnect.ResponseXMLText.Strings[i]);
              SaveAdvLog;
            end;
          if (FOperationResult in [Failure, PartialFailure]) then begin
            Exception.Create('Request Failure');
            Break;
          end;
          FUpdateRec.TotalPages := FTotalPages;
          FUpdateRec.LoadedPages := FPageNum;
          FUpdateRec.TotalItems := FTotalItems;
          FUpdateRec.LoadedItems := FCounterAll;
          FUpdateRec.SavedItems := FCounter;
          FUpdateRec.ThreadID := SearchID;//FTID;
          FUpdateRec.CurrentCategory := Fcat_id;
          FUpdateRec.TotalCategories := FCategories.Count;
          FSyncObj.UpdThreadStatus(FUpdateRec,SearchID);
        except
          on E : Exception do WriteEbayApiExceptionLog(E);
        end;
        Inc(FPageNum);
        //FFindItemsAdvanced.paginationInput.PageNumber := FPageNum;
        //FSyncObj.WriteLog(Format('ListTime - %s , LowTimeLimit - %s',[DateTimeToStr(FListTime),DateTimeToStr(LowTimeLimit)]));
      until (FFindItemsAdvanced.paginationInput.PageNumber > FFindItemsAdvanced.paginationOutput.TotalPages)
      or (FFindItemsAdvanced.paginationOutput.TotalPages = FFindItemsAdvanced.paginationOutput.PageNumber)
      or (FFindItemsAdvanced.paginationOutput.PageNumber = def_MaxPagesCount)
      or not FFetchAllPages
      or FAborted
      //or ((NotOlder>0) and (FListTime<=(LowTimeLimit)))
      or (FCounter = 0);
      FSyncObj.WriteLog(Format('Category ID %s completed',[FCategories[Fcat_id]]));
      inc(Fcat_id);
      FPageNum := 1;
    until (Fcat_id >= FCategories.Count) or FAborted or FIgnoreCategories;
  finally
    FConnection.Close;
    if FFindItemsAdvanced <> nil then FreeAndNil(FFindItemsAdvanced);
    CoUninitialize;
  end;
  Stop;
end;


procedure TFindAdvThread.SaveAspect;
var i,j: Integer;
    name : string;
    AspectArray : TAspectArray;
begin
  if FFindItemsAdvanced.AspectHistogramContainer <> nil then begin
    FSyncObj.ClearAspect(SearchID);
    for i:=0 to FFindItemsAdvanced.AspectHistogramContainer.Aspect.Count-1 do begin
      name := FFindItemsAdvanced.AspectHistogramContainer.Aspect.Items[i].Name;
      SetLength(AspectArray,FFindItemsAdvanced.AspectHistogramContainer.Aspect.Items[i].Count);
      for j:=0 to FFindItemsAdvanced.AspectHistogramContainer.Aspect.Items[i].Count-1 do begin
        AspectArray[j].AspectValName := FFindItemsAdvanced.AspectHistogramContainer.Aspect.Items[i].ValueHistogram[j].ValueName;
        AspectArray[j].Aspectcnt := FFindItemsAdvanced.AspectHistogramContainer.Aspect.Items[i].ValueHistogram[j].Count;
      end;
      FSyncObj.SaveAspect(SearchID,name,AspectArray);
    end;
  end;
end;

procedure TFindAdvThread.WriteToDB(FItemsCounter:integer);
var cnt ,i: Integer;
    ItemDetails : TItemDetails;
    jpg : TJpegImage;
begin
  try
    with FFindItemsAdvanced.SearchResult.Item[FItemsCounter], FData
    do
    begin
      FListTime := Min(eBayTimeStrConvert(ListingInfo.StartTime),FListTime);
      // check if ItemID already in table
      FQuery.Parameters.ParamByName('ItemId').Value := ItemId;
      FQuery.Open;
      cnt:=  FQuery.FieldValues['cnt'];
      FQuery.Close;
      // clear record
      {
      ItemID := '';
      ItemTitle := '';
      URL := '';
      Price := 0;
      PriceCurrency := '';
      BuyItNowPrice := 0;
      BuyItNowCurrency := '';
      SellerID := '';
      ItemLocation := '';
      ShippingCost := 0;
      ShippingCostCurrency := '';
      GalleryImageURL := '';
      StartTime := 0;
      EnadTime := 0;
      ListingType := '';
      SearchID := 0;
      Updated := Now;
      CategoryID := '';
      }
      if cnt = 0 then  begin
        // If not exists - then insert into table
        inc(FCounter);

        ItemDetails.ItemID := ItemId;    // ItemID
        ItemDetails.ItemTitle := Title;   // ItemTitle
        ItemDetails.URL := ViewItemURL;   // URL
        if Fdc = '.' then
          ItemDetails.Price := StrToFloat( SellingStatus.CurrentPrice.NodeValue) // Price
        else
          ItemDetails.Price := StrToFloat( StringReplace(SellingStatus.CurrentPrice.NodeValue,'.',Fdc,[]));    // Price
        ItemDetails.PriceCurrency := SellingStatus.CurrentPrice.CurrencyId;   // PriceCurrency
        if ListingInfo.BuyItNowAvailable then begin
          if Fdc = '.' then
            ItemDetails.BuyItNowPrice := StrToFloat( ListingInfo.BuyItNowPrice.NodeValue)    // BuyItNowPrice
          else
            ItemDetails.BuyItNowPrice := StrToFloat( StringReplace(ListingInfo.BuyItNowPrice.NodeValue,'.',Fdc,[]));   // BuyItNowPrice
          ItemDetails.BuyItNowCurrency := ListingInfo.BuyItNowPrice.CurrencyId;  // BuyItNowCurrency
        end;
        ItemDetails.SellerID := SellerInfo.SellerUserName;  // SellerID
        ItemDetails.ItemLocation := Location;   // ItemLocation
        if shippingInfo.shippingServiceCost.NodeValue <> null then begin
          if Fdc = '.' then
            ItemDetails.ShippingCost := StrToFloat( shippingInfo.shippingServiceCost.NodeValue)  // ShippingCost
          else
            ItemDetails.ShippingCost := StrToFloat( StringReplace(shippingInfo.shippingServiceCost.NodeValue,'.',Fdc,[]));   // ShippingCost
          ItemDetails.ShippingCostCurrency := shippingInfo.shippingServiceCost.CurrencyId; // ShippingCostCurrency
        end;
        ItemDetails.GalleryImageURL := GalleryURL; // GalleryImageURL
        ItemDetails.StartTime := eBayTimeStrConvert(ListingInfo.StartTime); // StartTime
        ItemDetails.EndTime := eBayTimeStrConvert(ListingInfo.EndTime); // EndTime
        ItemDetails.ListingType := listingInfo.ListingType; // ListingType
        ItemDetails.SearchID := FSearchID; // SearchID
        ItemDetails.Updated := eBayTimeStrConvert(FFindItemsAdvanced.Timestamp); // Updated
        ItemDetails.CategoryID := PrimaryCategory.CategoryId; // CategoryID
        FSyncObj.SaveItemDetails(ItemDetails);
      end;
    end;
  except
    on E : Exception do WriteExceptionLog(E);
  end;
end;

procedure TFindAdvThread.FindItemsAdvancedAPIError(Sender: TObject; ErrorRecord: eBayFindingAPIError);
var i : Integer;
begin
  with ErrorRecord , FSyncObj do begin
    WriteAdvLog(Format('%s: ThreadID %d - ApiCall: FindItemsAdvanced. API Error',[DateTimeToStr(now),Self.ThreadID]));
    WriteAdvLog(Format('ErrorId %d , Domain %s , Severity %s ,Category %s',[ErrorId, Domain, Severity, Category]));
    WriteAdvLog(Format('Message %s , Subdomain %s , ExceptionId %s',[Message,Subdomain,ExceptionId]));
  end;
  FSyncObj.WriteAdvLog('Request XML');
  for i := 0 to FEbayFindingConnect.RequestXMLText.Count -1 do FSyncObj.WriteAdvLog(FEbayFindingConnect.RequestXMLText.Strings[i]);
  FSyncObj.WriteAdvLog('Response XML');
  for i := 0 to FEbayFindingConnect.ResponseXMLText.Count -1 do FSyncObj.WriteAdvLog(FEbayFindingConnect.ResponseXMLText.Strings[i]);
  FSyncObj.SaveAdvLog;
end;

procedure TFindAdvThread.FindItemsAdvancedEndRequest(Sender: TObject);
begin
  FSyncObj.WriteLog(Format('%s: ThreadID %d - ApiCall: FindItemsAdvanced. Result %s',[DateTimeToStr(now),Self.ThreadID,GetEnumName(TypeInfo(AckCodeType),ord(FFindItemsAdvanced.Ack))]));
  with FFindItemsAdvanced.paginationOutput do begin
    FSyncObj.WriteAdvLog(Format('%s: ThreadID %d - ApiCall: FindItemsAdvanced. EndRequest Page %d of %d',[DateTimeToStr(now),Self.ThreadID, FPageNum, FTotalPages]));
  end;
  if FXMLDebugOutPut then FFindItemsAdvanced.ResponseXMLDoc.SaveToFile(Format('%s/log/FindResponse_%d.xml',[FBasePath,FPageNum]));
  FSyncObj.IncApiUsage;
  FSyncObj.UpdTimeShift(FFindItemsAdvanced.Timestamp);
end;

procedure TFindAdvThread.FindItemsAdvancedStartRequest(Sender: TObject);
var i , j: Integer;
    FS: TFormatSettings;
    AF: IXMLAspectFilter;
begin
  FSyncObj.WriteLog(Format('%s: ThreadID %d - ApiCall: FindItemsAdvanced. Starting',[DateTimeToStr(now),Self.ThreadID]));

  FS.DecimalSeparator := '.';
  FFindItemsAdvanced.paginationInput.PageNumber := FPageNum;
  FFindItemsAdvanced.paginationInput.EntriesPerPage :=FItemsPerPage;
  if FSortOrder <> 'BestMatch' then FFindItemsAdvanced.sortOrder := SortOrderType(GetEnumValue(TypeInfo(SortOrderType),FSortOrder));
  FFindItemsAdvanced.DescriptionSearch := FDescriptionSearch;

  // assign input Params
  if Length(FKeyWords)>0 then FFindItemsAdvanced.Keywords := FKeyWords;
  FFindItemsAdvanced.CategoryId.Clear;
  {
  if FCategories.Count >0 then for i:=0 to FCategories.Count-1 do begin
    FFindItemsAdvanced.CategoryId.Add(FCategories[i]);
    if i>=9 then Break;
  end;
  }
  FFindItemsAdvanced.CategoryId.Add(FCategories[Fcat_id]);
  FFindItemsAdvanced.OutputSelector := FOutputSelector;
  if Length(FBuyerPostalCode)>0 then FFindItemsAdvanced.buyerPostalCode := FBuyerPostalCode;
  // Item Filters
  FFindItemsAdvanced.ItemFilter.Clear;
  // Located in
  if Length(FLocatedIn) =2 then
  with FFindItemsAdvanced.ItemFilter.Add do begin
    Name := 'LocatedIn';
    Value.Add(FLocatedIn);
  end
  // Available to
  else if Length(FAvailableto) =2 then
  with FFindItemsAdvanced.ItemFilter.Add do begin
    Name := 'Availableto';
    Value.Add(FAvailableto);
  end;
  // Condition
  if Length(FCondition) > 0 then
  if FCondition <> 'Any' then
  with FFindItemsAdvanced.ItemFilter.Add do begin
    Name := 'Condition';
    Value.Add(FCondition);
  end;
  // PaymentMethod
  if Length(FPaymentMethod) > 0 then
  if FPaymentMethod <> 'Any' then
  with FFindItemsAdvanced.ItemFilter.Add do begin
    Name := 'PaymentMethod';
    Value.Add(FPaymentMethod);
  end;
  // SellerBusinessType
  if Length(FSellerBusinessType) > 0 then
  if FSellerBusinessType <> 'Any' then
  with FFindItemsAdvanced.ItemFilter.Add do begin
    Name := 'SellerBusinessType';
    Value.Add(FSellerBusinessType);
  end;
  // Currency
  if Length(FCurrency) > 0 then
  if FCurrency <> 'Any' then
  with FFindItemsAdvanced.ItemFilter.Add do begin
    Name := 'Currency';
    Value.Add(FCurrency);
  end;
  // Listing type
  if FListingTypes.Count>0 then
  with FFindItemsAdvanced.ItemFilter.Add do begin
    Name := 'ListingType';
    for i:=0 to FListingTypes.Count -1 do Value.Add(FListingTypes[i]);
  end;
  // Seller
  if FSeller.Count>0 then
  with FFindItemsAdvanced.ItemFilter.Add do begin
    Name := 'Seller';
    for i:=0 to FSeller.Count -1 do Value.Add(FSeller[i]);
  end
  // Exclude seller
  else if FExcludeSeller.Count>0 then
  with FFindItemsAdvanced.ItemFilter.Add do begin
    Name := 'ExcludeSeller';
    for i:=0 to FExcludeSeller.Count -1 do Value.Add(FExcludeSeller[i]);
  end;
  // Hide duplicates
  if FHideDuplicates then
  with FFindItemsAdvanced.ItemFilter.Add do begin
    Name := 'HideDuplicateItems';
    Value.Add('true');
  end;
  //  Price range
  if Length(FPriceCurrency) = 3 then begin
    if FPriceFrom > 0 then begin
      with FFindItemsAdvanced.ItemFilter.Add do begin
        Name := 'MinPrice';
        Value.Add(FloatToStr(FPriceFrom,FS));
        ParamName:='Currency';
        ParamValue:=FPriceCurrency;
      end;
    end;
    if FPriceTo > 0 then begin
      with FFindItemsAdvanced.ItemFilter.Add do begin
        Name := 'MaxPrice';
        Value.Add(FloatToStr(FPriceTo,FS));
        ParamName:='Currency';
        ParamValue:=FPriceCurrency;
      end;
    end;
  end;
  if FFeedbackScoreMax > 0 then
  with FFindItemsAdvanced.ItemFilter.Add do begin
    Name := 'FeedbackScoreMax';
    Value.Add(IntToStr(FFeedbackScoreMax));
  end;
  if FFeedbackScoreMin > 0 then
  with FFindItemsAdvanced.ItemFilter.Add do begin
    Name := 'FeedbackScoreMin';
    Value.Add(IntToStr(FFeedbackScoreMin));
  end;
  if FBidsMax > 0 then
  with FFindItemsAdvanced.ItemFilter.Add do begin
    Name := 'MaxBids';
    Value.Add(IntToStr(FBidsMax));
  end;
  if FBidsMin > 0 then
  with FFindItemsAdvanced.ItemFilter.Add do begin
    Name := 'MinBids';
    Value.Add(IntToStr(FBidsMin));
  end;
  if FQuantityMax > 0 then
  with FFindItemsAdvanced.ItemFilter.Add do begin
    Name := 'MaxQuantity';
    Value.Add(IntToStr(FQuantityMax));
  end;
  if FQuantityMin > 0 then
  with FFindItemsAdvanced.ItemFilter.Add do begin
    Name := 'MinQuantity';
    Value.Add(IntToStr(FQuantityMin));
  end;
  if FEndTimeFrom > 0 then
  with FFindItemsAdvanced.ItemFilter.Add do begin
    Name := 'EndTimeFrom';
    Value.Add(eBayStrTimeConvert(FEndTimeFrom));
  end;
  if FEndTimeTo > 0 then
  with FFindItemsAdvanced.ItemFilter.Add do begin
    Name := 'EndTimeTo';
    Value.Add(eBayStrTimeConvert(FEndTimeTo));
  end;
  if (FGlobalID = EBAY_MOTOR) and (Length(FBuyerPostalCode)>0) and FLocalSearchOnly and (FMaxDistance >0) then
  with FFindItemsAdvanced.ItemFilter.Add do begin
    Name := 'MaxDistance';
    Value.Add(IntToStr(FMaxDistance));
  end;
  if (FGlobalID = EBAY_MOTOR) and (Length(FBuyerPostalCode)>0) and FLocalSearchOnly and (FMaxDistance >0) then
  with FFindItemsAdvanced.ItemFilter.Add do begin
    Name := 'LocalSearchOnly';
    Value.Add('true');
  end;
  // Aspect Filters
  FFindItemsAdvanced.AspectFilter.Clear;
  if Length(FAspectFilters)>0 then
  for i:=0 to High(FAspectFilters) do begin
    AF := FFindItemsAdvanced.AspectFilter.Add;
    AF.AspectName := FAspectFilters[i].name;
    for j:=0 to High(FAspectFilters[i].values) do AF.AspectValueName.Add(FAspectFilters[i].values[j]);
  end;
  {$IFDEF DEMO}ReportOperation;{$ENDIF}
  if FXMLDebugOutPut then FFindItemsAdvanced.RequestXMLDoc.SaveToFile(Format('%s/log/FindRequest_%d.xml',[FBasePath,FPageNum]));
end;

procedure TFindAdvThread.WriteEbayApiExceptionLog(E : Exception);
var i : Integer;
begin
  with FSyncObj do begin
    WriteLog(Format('%s: ThreadID %d Exception',[DateTimeToStr(now),Self.ThreadID]));
    WriteLog(Format('Exception class name: %s',[E.ClassName]));
    WriteLog(Format('Exception message: %s',[E.Message]));
    WriteAdvLog('Request XML');
    for i := 0 to FEbayFindingConnect.RequestXMLText.Count -1 do WriteAdvLog(FEbayFindingConnect.RequestXMLText.Strings[i]);
    WriteAdvLog('Response XML');
    for i := 0 to FEbayFindingConnect.ResponseXMLText.Count -1 do WriteAdvLog(FEbayFindingConnect.ResponseXMLText.Strings[i]);
    SaveAdvLog;
  end;
end;

procedure TFindAdvThread.WriteExceptionLog(E: Exception);
begin
  with FSyncObj do begin
    WriteLog(Format('%s: ThreadID %d Exception',[DateTimeToStr(now),Self.ThreadID]));
    WriteLog(Format('Exception class name: %s',[E.ClassName]));
    WriteLog(Format('Exception message: %s',[E.Message]));
    SaveAdvLog;
  end;
end;

procedure TFindAdvThread.DecTCounter;
begin
  FSyncObj.Operation := OpDecCounter;
  FSyncObj.Synchronize;
end;

procedure TFindAdvThread.SetCategories(Value : TStringList);
begin
  FCategories.Assign(Value);
end;

procedure TFindAdvThread.SetListingTypes(Value : TStringList);
begin
  FListingTypes.Assign(Value);
end;

procedure TFindAdvThread.SetSeller(Value : TStringList);
begin
  FSeller.Assign(Value);
end;

procedure TFindAdvThread.SetExcludeSeller(Value : TStringList);
begin
  FExcludeSeller.Assign(Value);
end;

{$IFDEF INDY9}
procedure TFindAdvThread.EbayFindingConnectWork(Sender: TObject; AWorkMode: TWorkMode; const AWorkCount: Integer);
{$ENDIF}
{$IFDEF INDY10}
procedure TFindAdvThread.EbayFindingConnectWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
{$ENDIF}
begin
  case AWorkMode of
  wmRead  : begin
    FSyncObj.OnHttpWork(AWorkMode,AWorkCount-FRxDelta);
    FRxDelta := AWorkCount;
  end;
  wmWrite : begin
    FSyncObj.OnHttpWork(AWorkMode,AWorkCount-FTxDelta);
    FTxDelta := AWorkCount;
  end;
  end;
end;

procedure TFindAdvThread.AddAspectFilter(AspectFilter : TAspectFilter);
var AF : TAspectFilter;
    i : Integer;
begin
  AF := TAspectFilter.Create;
  AF.name := AspectFilter.name;
  SetLength(AF.values,Length(AspectFilter.values));
  for i:=0 to High(AF.values) do AF.values[i]:=AspectFilter.values[i];
  SetLength(FAspectFilters,High(FAspectFilters)+2);
  FAspectFilters[High(FAspectFilters)] := AF;
end;

procedure TFindAdvThread.ClearAspectFilters;
var i: Integer;
begin
  for i:=0 to High(FAspectFilters) do FreeAndNil(FAspectFilters[i]);
  SetLength(FAspectFilters,0);
end;

initialization
  Randomize;
end.

