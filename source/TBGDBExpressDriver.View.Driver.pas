unit TBGDBExpressDriver.View.Driver;

interface

uses
  TBGConnection.Model.Interfaces, System.Classes, TBGConnection.Model.Conexao.Parametros,
  System.Generics.Collections, Data.SQLExpr;

Type
  TBGDBExpressDriverConexao = class(TComponent, iDriver)
  private
    FFConnection: TSQLConnection;
    FFQuery: TSQLQuery;
    FiConexao : iConexao;
    FiQuery : TList<iQuery>;
    FLimitCacheRegister : Integer;
    procedure SetFConnection(const Value: TSQLConnection);
    procedure SetFQuery(const Value: TSQLQuery);
    function GetLimitCache: Integer;
    procedure SetLimitCache(const Value: Integer);
    protected
      FParametros : iConexaoParametros;
      function Conexao : iConexao;
      function Query : iQuery;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iDriver;
      function Conectar : iConexao;
      function &End: TComponent;
      function Parametros: iConexaoParametros;
      function LimitCacheRegister(Value : Integer) : iDriver;
    published
      property FConnection : TSQLConnection read FFConnection write SetFConnection;
      property LimitCache : Integer read GetLimitCache write SetLimitCache;
  end;

procedure Register;

implementation

uses
  System.SysUtils, TBGDBExpressDriver.Model.Query,
  TBGDBExpressDriver.Model.Conexao;

{ TBGDBExpressDriverConexao }

function TBGDBExpressDriverConexao.Conectar: iConexao;
begin

end;

function TBGDBExpressDriverConexao.&End: TComponent;
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
  FiQuery := TList<iQuery>.Create;
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

function TBGDBExpressDriverConexao.Parametros: iConexaoParametros;
begin
  Result := FParametros;
end;


function TBGDBExpressDriverConexao.Query: iQuery;
begin
  if Not Assigned(FiQuery) then
    FiQuery := TList<iQuery>.Create;

  if Not Assigned(FiConexao) then
    FiConexao := TDBExpressDriverModelConexao.New(FFConnection, FLimitCacheRegister);

  FiQuery.Add(TDBExpressModelQuery.New(FFConnection, FiConexao));
  Result := FiQuery[FiQuery.Count-1];
end;

procedure TBGDBExpressDriverConexao.SetFConnection(const Value: TSQLConnection);
begin
  FFConnection := Value;
end;

procedure TBGDBExpressDriverConexao.SetFQuery(const Value: TSQLQuery);
begin
  FFQuery := Value;
end;

procedure TBGDBExpressDriverConexao.SetLimitCache(const Value: Integer);
begin
  FLimitCacheRegister := Value;
end;

procedure Register;
begin
  RegisterComponents('TBGAbstractConnection', [TBGDBExpressDriverConexao]);
end;


end.
