unit TBGZeosDriver.Model.Query;

interface

uses
  TBGConnection.Model.Interfaces, Data.DB, System.Classes,
  System.SysUtils, ZConnection, ZDataset,
  TBGConnection.Model.DataSet.Interfaces, TBGConnection.Model.DataSet.Proxy,
  TBGConnection.Model.DataSet.Observer, TBGConnection.Model.DataSet.Factory,
  System.Generics.Collections;

Type
  TZeosModelQuery = class(TInterfacedObject, iQuery)
    private
      FSQL : String;
      FKey : Integer;
      FConexao : TZConnection;
      FiConexao : iConexao;
      FQuery : TList<TZQuery>;
      FDataSource : TDataSource;
      FDataSet : TDictionary<integer, iDataSet>;
      FChangeDataSet : TChangeDataSet;
      FParams : TParams;
      procedure InstanciaQuery;
      function GetDataSet : iDataSet;
      function GetQuery : TZQuery;
    public
      constructor Create(Conexao : TZConnection; iConexao : iConexao);
      destructor Destroy; override;
      class function New(Conexao : TZConnection; iConexao : iConexao) : iQuery;
      //iObserver
      procedure ApplyUpdates(DataSet : TDataSet);
      //iQuery
      function Open(aSQL: String): iQuery;
      function ExecSQL(aSQL : String) : iQuery; overload;
      function DataSet : TDataSet; overload;
      function DataSet(Value : TDataSet) : iQuery; overload;
      function DataSource(Value : TDataSource) : iQuery;
      function Fields : TFields;
      function ChangeDataSet(Value : TChangeDataSet) : iQuery;
      function &End: TComponent;
      function Tag(Value : Integer) : iQuery;
      function LocalSQL(Value : TComponent) : iQuery;
      function Close : iQuery;
      function SQL : TStrings;
      function Params : TParams;
      function ParamByName(Value : String) : TParam;
      function ExecSQL : iQuery; overload;
  end;

implementation

{ TZeosModelQuery }

function TZeosModelQuery.&End: TComponent;
begin
  Result := GetQuery;
end;

function TZeosModelQuery.ExecSQL: iQuery;
begin
  Result := Self;
  GetQuery.ExecSQL;
  ApplyUpdates(nil);
end;

procedure TZeosModelQuery.InstanciaQuery;
var
  Query : TZQuery;
begin
  Query := TZQuery.Create(nil);
  Query.Connection := FConexao;
  Query.AfterPost := ApplyUpdates;
  Query.AfterDelete := ApplyUpdates;
  FQuery.Add(Query);
end;

function TZeosModelQuery.ExecSQL(aSQL: String): iQuery;
begin
  FSQL := aSQL;
  GetQuery.SQL.Clear;
  GetQuery.SQL.Add(FSQL);
  GetQuery.ExecSQL;
  ApplyUpdates(nil);
end;

function TZeosModelQuery.Fields: TFields;
begin
  Result := GetQuery.Fields;
end;

function TZeosModelQuery.GetDataSet: iDataSet;
begin
  Result := FDataSet.Items[FKey];
end;

function TZeosModelQuery.GetQuery: TZQuery;
begin
  REsult := FQuery.Items[Pred(FQuery.Count)];
end;

function TZeosModelQuery.LocalSQL(Value: TComponent): iQuery;
begin
  Result := Self;
  raise Exception.Create('Fun��o n�o suportada por este driver');
end;

procedure TZeosModelQuery.ApplyUpdates(DataSet: TDataSet);
begin
  FiConexao.Cache.ReloadCache('');
end;

function TZeosModelQuery.ChangeDataSet(Value: TChangeDataSet): iQuery;
begin
  Result := Self;
  FChangeDataSet := Value;
end;

function TZeosModelQuery.Close: iQuery;
begin
  Result := Self;
  GetQuery.Close;
end;

constructor TZeosModelQuery.Create(Conexao : TZConnection; iConexao : iConexao);
begin
  FiConexao := iConexao;
  FConexao := Conexao;
  FKey := 0;
  FQuery := TList<TZQuery>.Create;
  FDataSet := TDictionary<integer, iDataSet>.Create;
  InstanciaQuery;
end;

function TZeosModelQuery.DataSet: TDataSet;
begin
  Result := TDataSet(GetQuery);
end;

function TZeosModelQuery.DataSet(Value: TDataSet): iQuery;
begin
  Result := Self;
  GetDataSet.DataSet(Value);
end;

function TZeosModelQuery.DataSource(Value : TDataSource) : iQuery;
begin
  Result := Self;
  FDataSource := Value;
end;

destructor TZeosModelQuery.Destroy;
begin
  FreeAndNil(FQuery);
  FreeAndNil(FDataSet);
  inherited;
end;

class function TZeosModelQuery.New(Conexao : TZConnection; iConexao : iConexao) : iQuery;
begin
  Result := Self.Create(Conexao, iConexao);
end;

function TZeosModelQuery.Open(aSQL: String): iQuery;
var
  Query : TZQuery;
  DataSet : iDataSet;
begin
  Result := Self;
  FSQL := aSQL;
  if not FiConexao.Cache.CacheDataSet(FSQL, DataSet) then
  begin
    InstanciaQuery;
    DataSet.SQL(FSQL);
    DataSet.DataSet(GetQuery);
    GetQuery.Close;
    GetQuery.SQL.Text := FSQL;
    GetQuery.Open;
    FiConexao.Cache.AddCacheDataSet(DataSet.GUUID, DataSet);
  end;
  FDataSource.DataSet := DataSet.DataSet;
  Inc(FKey);
  FDataSet.Add(FKey, DataSet);
end;

function TZeosModelQuery.ParamByName(Value: String): TParam;
begin
  Result := GetQuery.ParamByName(Value);
end;

function TZeosModelQuery.Params: TParams;
begin
  Result := GetQuery.Params;
end;

function TZeosModelQuery.SQL: TStrings;
begin
 Result := GetQuery.SQL;
end;

function TZeosModelQuery.Tag(Value: Integer): iQuery;
begin
  Result := Self;
  GetQuery.Tag := Value;
end;

end.
