unit TBGFiredacDriver.Model.DataSet;

interface

uses
  TBGConnection.Model.DataSet.Interfaces, Data.DB, TBGConnection.Model.DataSet.Observer,
  FireDAC.Comp.Client;

Type
  TConnectionModelFiredacDataSet = class(TInterfacedObject, iDataSet, ICacheDataSetObserver)
  private
    FDataSet : TFDQuery;
    FObserver : ICacheDataSetSubject;
    FGUUID : String;
    FSQL : String;
  public
    constructor Create(Observer : ICacheDataSetSubject);
    destructor Destroy; override;
    class function New(Observer : ICacheDataSetSubject) : iDataSet;
    function DataSet : TDataSet; overload;
    function DataSet (Value : TDataSet) : iDataSet; overload;
    function GUUID : String;
    function SQL : String; overload;
    function SQL (Value : String) : iDataSet; overload;
    function Update(Value : String) : ICacheDataSetObserver;
  end;

implementation

uses
  System.SysUtils;

{ TConnectionModelFiredacDataSet }

constructor TConnectionModelFiredacDataSet.Create(Observer : ICacheDataSetSubject);
begin
  FDataSet := TFDQuery.Create(nil);
  FGUUID :=  TGUID.NewGuid.ToString;
  FObserver := Observer;
  FObserver.AddObserver(Self);
end;

function TConnectionModelFiredacDataSet.DataSet: TDataSet;
begin
  Result := FDataSet;
end;

function TConnectionModelFiredacDataSet.DataSet(Value: TDataSet): iDataSet;
begin
  Result := Self;
  if Assigned(FDataSet) then
    FreeAndNil(FDataSet);
  FDataSet := TFDQuery(Value);
end;

destructor TConnectionModelFiredacDataSet.Destroy;
begin
  FObserver.RemoveObserver(Self);
  FreeAndNil(FDataSet);
  inherited;
end;

function TConnectionModelFiredacDataSet.GUUID: String;
begin
  Result := FGUUID;
end;

class function TConnectionModelFiredacDataSet.New(Observer : ICacheDataSetSubject) : iDataSet;
begin
  Result := Self.Create(Observer);
end;

function TConnectionModelFiredacDataSet.SQL: String;
begin
  Result := FSQL;
end;

function TConnectionModelFiredacDataSet.SQL(Value: String): iDataSet;
begin
  Result := Self;
  FSQL := UpperCase(Trim(Value));
end;

function TConnectionModelFiredacDataSet.Update(Value: String): ICacheDataSetObserver;
begin
  Result := Self;
  if FGUUID <> Value then
    if FDataSet.State in [dsBrowse] then
      FDataSet.Refresh;
end;

end.
