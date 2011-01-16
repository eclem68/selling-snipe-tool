unit uTypes;

interface

type
  Tinisettings = record
    // database
    DataSource : string;
    // sheduling
    autorun : Boolean;
    checkregular : Boolean;
    Checkperiod : Integer;
    //autorunsearch : Boolean;
    runminimized : Boolean;
    // ebay
    AppID : string;
    DevID : string;
    CertID : string;
    Token : string;
    timeshiftebay : TDateTime;
    DecimalSeparator : Char;
    CSVSeparator : Char;
    ShowLatsResults : Integer;
    NotOlder : Integer;
    ClearData : Boolean;
    xmloutput : Boolean;
  end;

  TSearchThreadStatus = record
    TotalPages : Integer;
    LoadedPages : Integer;
    TotalItems : Integer;
    LoadedItems : Integer;
    SavedItems : Integer;
    CurrentCategory : Integer;
    TotalCategories : Integer;
    ThreadID : Integer;
  end;

  TDownloadImageThreadStatus = record
    TotalItems : Integer;
    SavedPhotos : Integer
  end;

  TItemDetails = record
    ItemID : string;
    ItemTitle : string;
    URL : string;
    Price : Real;
    PriceCurrency : string;
    BuyItNowPrice : Real;
    BuyItNowCurrency : string;
    SellerID : string;
    ItemLocation : string;
    ShippingCost : Real;
    ShippingCostCurrency : string;
    GalleryImageURL : string;
    StartTime : TDateTime;
    EndTime : TDateTime;
    ListingType : string;
    SearchID : Integer;
    Updated : TDateTime;
    CategoryID : string;
  end;

  TAspect = record
    AspectValName : string;
    Aspectcnt : Integer;
  end;

  TAspectArray = array of TAspect;

  ListingTypes =(AdFormat, Auction, AuctionWithBIN, Classified, FixedPrice, StoreInventory, All);

implementation

end.
