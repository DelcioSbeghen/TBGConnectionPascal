unit TBGDBExpressDriver.View.Driver;

interface

uses
  TBGConnection.Model.Interfaces, System.Classes, TBGConnection.Model.Conexao.Parametros,
  System.Generics.Collections, Data.SQLExpr,
  TBGConnection.Model.DataSet.Interfaces;

const
  c_DefaultLimitCache = 10;

Type
  TBGDBExpressDriverConexao = class(TComponent, iDriver)
  private
    FFConnection: TSQLConnection;
    FiConexao : iConexao;
    FiQuery : TList<iQuery>;
    FLimitCacheRegister : Integer;
    FProxy : iDriverProxy;
    procedure SetFConnection(const Value: TSQLConnection);
    function GetLimitCache: Integer;
    procedure SetLimitCache(const Value: Integer);
  protected
    function Conexao : iConexao;
    function Query : iQuery;
    function Cache : iDriverProxy;
    function DataSet : iDataSet;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
    class function New : iDriver;
    function ThisAs: TObject;
    function Conectar : iConexao;
    function LimitCacheRegister(Value : Integer) : iDriver;
  published
    property FConnection : TSQLConnection read FFConnection write SetFConnection;
    property LimitCache : Integer read GetLimitCache write SetLimitCache;
  end;

procedure Register;

implementation

uses
  System.SysUtils, TBGDBExpressDriver.Model.Query,
  TBGDBExpressDriver.Model.Conexao, TBGConnection.Model.DataSet.Proxy,
  TBGDBExpressDriver.Model.DataSet;

{ TBGDBExpressDriverConexao }

function TBGDBExpressDriverConexao.Cache: iDriverProxy;
begin
   if not Assigned(FProxy) then
    FProxy := TTBGConnectionModelProxy.New(FLimitCacheRegister, Self);

  Result := FProxy;
end;

function TBGDBExpressDriverConexao.Conectar: iConexao;
begin

end;

function TBGDBExpressDriverConexao.GetLimitCache: Integer;
begin
  Result := FLimitCacheRegister;
end;

function TBGDBExpressDriverConexao.LimitCacheRegister(Value: Integer): iDriver;
begin
  Result := Self;
  FLimitCacheRegister := Value;
end;

function TBGDBExpressDriverConexao.Conexao: iConexao;
begin
  if not Assigned(FiConexao) then
    FiConexao := TDBExpressDriverModelConexao.New(FFConnection, FLimitCacheRegister);

  Result := FiConexao;
end;

constructor TBGDBExpressDriverConexao.Create;
begin
  inherited Create(nil);
  FiQuery := TList<iQuery>.Create;
  FLimitCacheRegister := c_DefaultLimitCache;
end;

function TBGDBExpressDriverConexao.DataSet: iDataSet;
begin
  if not Assigned(FProxy) then
    FProxy := TTBGConnectionModelProxy.New(FLimitCacheRegister, Self);

  Result := TConnectionModelDBExpressDataSet.New(FProxy.ObserverList);
end;

destructor TBGDBExpressDriverConexao.Destroy;
begin
  FreeAndNil(FiQuery);
  inherited;
end;

class function TBGDBExpressDriverConexao.New: iDriver;
begin
  Result := Self.Create;
end;

function TBGDBExpressDriverConexao.Query: iQuery;
begin
  if Not Assigned(FiQuery) then
    FiQuery := TList<iQuery>.Create;

  if Not Assigned(FiConexao) then
    FiConexao := TDBExpressDriverModelConexao.New(FFConnection, FLimitCacheRegister);

  FiQuery.Add(TDBExpressModelQuery.New(FFConnection, Self));
  Result := FiQuery[FiQuery.Count-1];
end;

procedure TBGDBExpressDriverConexao.SetFConnection(const Value: TSQLConnection);
begin
  FFConnection := Value;
end;

procedure TBGDBExpressDriverConexao.SetLimitCache(const Value: Integer);
begin
  FLimitCacheRegister := Value;
end;

function TBGDBExpressDriverConexao.ThisAs: TObject;
begin
  Result := Self;
end;

procedure Register;
begin
  RegisterComponents('TBGAbstractConnection', [TBGDBExpressDriverConexao]);
end;


end.
