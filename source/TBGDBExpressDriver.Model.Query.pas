unit TBGDBExpressDriver.Model.Query;

interface

uses
  TBGConnection.Model.Interfaces, Data.DB, System.Classes,
  System.SysUtils, Data.SqlExpr, Datasnap.Provider, Datasnap.DBCLient,
  TBGConnection.Model.DataSet.Proxy, TBGConnection.Model.DataSet.Interfaces,
  TBGConnection.Model.DataSet.Observer, System.Generics.Collections;

Type
  TDBExpressModelQuery = class(TComponent, iQuery)
  private
    FConexao : TSQLConnection;
    FDriver : iDriver;
    FQuery : TList<TSQLQuery>;
    DataSetProvider1: TList<TDataSetProvider>;
    ClientDataSet1: TList<TClientDataSet>;
    FKey : Integer;
    FDataSource : TDataSource;
    FDataSet : TDictionary<integer, iDataSet>;
    FSQL : String;
    procedure InstanciaQuery;
    function GetDataSet : iDataSet;
    function GetCDS : TClientDataSet;
    function GetQuery : TSQLQuery;
  public
    constructor Create(Conexao : TSQLConnection; Driver : iDriver); reintroduce;
    destructor Destroy; override;
    class function New(Conexao : TSQLConnection; Driver : iDriver) : iQuery;
    function ThisAs: TObject;
    //iQuery
    function Open(aSQL: String): iQuery;
    function ExecSQL(aSQL : String) : iQuery; overload;
    function DataSet : TDataSet; overload;
    function DataSet(Value : TDataSet) : iQuery; overload;
    function DataSource(Value : TDataSource) : iQuery;
    function Fields : TFields;
    function &End: TComponent;
    procedure ApplyUpdates(DataSet : TDataSet);
    procedure RealoadCache(DataSet : TDataSet);
    function Tag(Value : Integer) : iQuery;
    function LocalSQL(Value : TComponent) : iQuery;
    function Close : iQuery;
    function SQL : TStrings;
    function Params : TParams;
    function ParamByName(Value : String) : TParam;
    function ExecSQL : iQuery; overload;
    function UpdateTableName(Tabela : String) : iQuery;
  end;

implementation

{ TDBExpressModelQuery }

function TDBExpressModelQuery.&End: TComponent;
begin
  Result := GetQuery;
end;

function TDBExpressModelQuery.ExecSQL: iQuery;
begin
  Result := Self;
  GetQuery.ExecSQL;
  RealoadCache(nil);
end;

function TDBExpressModelQuery.ExecSQL(aSQL: String): iQuery;
begin
  FSQL := aSQL;
  GetQuery.SQL.Text := FSQL;
  GetQuery.ExecSQL;
  RealoadCache(nil);
end;

function TDBExpressModelQuery.Fields: TFields;
begin
  Result := GetCDS.Fields;
end;

function TDBExpressModelQuery.GetDataSet: iDataSet;
begin
  Result := FDataSet.Items[FKey];
end;

function TDBExpressModelQuery.GetQuery: TSQLQuery;
begin
  if FQuery.Count = 0 then
    InstanciaQuery;

  Result := FQuery.Items[Pred(FQuery.Count)]
end;

function TDBExpressModelQuery.GetCDS: TClientDataSet;
begin
  Result := ClientDataSet1.Items[Pred(ClientDataSet1.Count)];
end;

procedure TDBExpressModelQuery.ApplyUpdates(DataSet: TDataSet);
begin
  GetCDS.ApplyUpdates(0);
  FDriver.Cache.ReloadCache('');
end;

procedure TDBExpressModelQuery.InstanciaQuery;
var
  Query : TSQLQuery;
  Provider : TDataSetProvider;
  ClientDataSet : TClientDataSet;
begin
  Query := TSQLQuery.Create(Self);
  Query.SQLConnection := FConexao;
  Provider := TDataSetProvider.Create(Self);
  ClientDataSet := TClientDataSet.Create(Self);
  Provider.DataSet := Query;
  Provider.Options := [poAllowCommandText];
  Provider.Name := 'Provider' + FormatDateTime('nnss', now);
  ClientDataSet.ProviderName := Provider.Name;
  ClientDataSet.FetchOnDemand := true;
  ClientDataSet.AfterPost := ApplyUpdates;
  ClientDataSet.AfterDelete := ApplyUpdates;
  DataSetProvider1.Add(Provider);
  ClientDataSet1.Add(ClientDataSet);
  FQuery.Add(Query);
end;

function TDBExpressModelQuery.LocalSQL(Value: TComponent): iQuery;
begin
  Result := Self;
  raise Exception.Create('Fun��o n�o suportada por este driver');
end;

function TDBExpressModelQuery.Close: iQuery;
begin
  Result := Self;
  GetQuery.Close;
end;

constructor TDBExpressModelQuery.Create(Conexao : TSQLConnection; Driver : iDriver);
begin
  inherited Create(nil);
  FDriver := Driver;
  FConexao := Conexao;
  FQuery := TList<TSQLQuery>.Create;
  FDataSet := TDictionary<integer, iDataSet>.Create;
  DataSetProvider1 := TList<TDataSetProvider>.Create;
  ClientDataSet1  := TList<TClientDataSet>.Create;
  //InstanciaQuery;
end;

function TDBExpressModelQuery.DataSet: TDataSet;
begin
  Result := TDataSet(GetCDS);
end;

function TDBExpressModelQuery.DataSet(Value: TDataSet): iQuery;
begin
  Result := Self;
  GetDataSet.DataSet(Value);
end;

function TDBExpressModelQuery.DataSource(Value : TDataSource) : iQuery;
begin
  Result := Self;
  FDataSource := Value;
end;

destructor TDBExpressModelQuery.Destroy;
var
  vProvider: TDataSetProvider;
  vClient: TClientDataSet;
  vQuery: TSQLQuery;
begin
  if Assigned(DataSetProvider1) then
  begin
    for vProvider in DataSetProvider1 do
    begin
      vProvider.Free;
    end;
  end;
  if Assigned(ClientDataSet1) then
  begin
    for vClient in ClientDataSet1 do
    begin
      vClient.Close;
      vClient.Free;
    end;
  end;
  if Assigned(FQuery) then
  begin
    for vQuery in FQuery do
    begin
      vQuery.Close;
      vQuery.Free;
    end;
  end;
  FreeAndNil(DataSetProvider1);
  FreeAndNil(ClientDataSet1);
  FreeAndNil(FQuery);
  FreeAndNil(FDataSet);
  FreeAndNil(DataSetProvider1);
  FreeAndNil(ClientDataSet1);
  inherited;
end;

class function TDBExpressModelQuery.New(Conexao : TSQLConnection; Driver : iDriver) : iQuery;
begin
  Result := Self.Create(Conexao, Driver);
end;

function TDBExpressModelQuery.Open(aSQL: String): iQuery;
var
  DataSet : iDataSet;
begin
  Result := Self;
  FSQL := aSQL;
  if not FDriver.Cache.CacheDataSet(FSQL, DataSet) then
  begin
    InstanciaQuery;
    DataSet.SQL(FSQL);
    DataSet.DataSet(GetCDS);
    GetCDS.Close;
    GetCDS.CommandText := FSQL;
    GetCDS.Open;
    FDriver.Cache.AddCacheDataSet(DataSet.GUUID, DataSet);
  end;
  FDataSource.DataSet := DataSet.DataSet;
  Inc(FKey);
  FDataSet.Add(FKey, DataSet);
end;

function TDBExpressModelQuery.ParamByName(Value: String): TParam;
begin
  Result := GetQuery.ParamByName(Value);
end;

function TDBExpressModelQuery.Params: TParams;
begin
  Result := GetQuery.Params;
end;

procedure TDBExpressModelQuery.RealoadCache(DataSet : TDataSet);
begin
   FDriver.Cache.ReloadCache('');
end;

function TDBExpressModelQuery.SQL: TStrings;
begin
  Result := GetQuery.SQL;
end;

function TDBExpressModelQuery.Tag(Value: Integer): iQuery;
begin
  Result := Self;
  GetQuery.Tag := Value;
end;

function TDBExpressModelQuery.ThisAs: TObject;
begin
  Result := Self;
end;

function TDBExpressModelQuery.UpdateTableName(Tabela: String): iQuery;
begin
  Result := Self;
end;

end.

