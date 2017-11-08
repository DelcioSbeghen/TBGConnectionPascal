unit TBGUnidacDriver.View.Driver;

interface

uses
  TBGConnection.Model.Interfaces, System.Classes, TBGConnection.Model.Conexao.Parametros,
  System.Generics.Collections,  MemDS, DBAccess, Uni;

Type
  TBGUnidacDriverConexao = class(TComponent, iDriver)
  private
    FFConnection: TUniConnection;
    FFQuery: TUniQuery;
    FiConexao : iConexao;
    FiQuery : TList<iQuery>;
    FLimitCacheRegister : Integer;
    procedure SetFConnection(const Value: TUniConnection);
    procedure SetFQuery(const Value: TUniQuery);
    function GetLimitCache: Integer;
    procedure SetLimitCache(const Value: Integer);
    protected
      FParametros : iConexaoParametros;
      function Conexao : iConexao;
      function Query : iQuery;
      function LimitCacheRegister(Value : Integer) : iDriver;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iDriver;
      function Conectar : iConexao;
      function &End: TComponent;
      function Parametros: iConexaoParametros;
    published
      property FConnection : TUniConnection read FFConnection write SetFConnection;
      property LimitCache : Integer read GetLimitCache write SetLimitCache;
    end;

procedure Register;

implementation


uses
  System.SysUtils, TBGUnidacDriver.Model.Conexao, TBGUnidacDriver.Model.Query;

{ TBGUnidacDriverConexao }

function TBGUnidacDriverConexao.Conectar: iConexao;
begin

end;

function TBGUnidacDriverConexao.&End: TComponent;
begin

end;

function TBGUnidacDriverConexao.GetLimitCache: Integer;
begin
  Result := FLimitCacheRegister;
end;

function TBGUnidacDriverConexao.LimitCacheRegister(Value: Integer): iDriver;
begin
  Result := Self;
  FLimitCacheRegister := Value;
end;

function TBGUnidacDriverConexao.Conexao: iConexao;
begin
  if not Assigned(FiConexao) then
    FiConexao := TUnidacDriverModelConexao.New(FFConnection, FLimitCacheRegister);

  Result := FiConexao;
end;

constructor TBGUnidacDriverConexao.Create;
begin
  FiQuery := TList<iQuery>.Create;
end;

destructor TBGUnidacDriverConexao.Destroy;
begin
  FreeAndNil(FiQuery);
  inherited;
end;

class function TBGUnidacDriverConexao.New: iDriver;
begin
  Result := Self.Create;
end;

function TBGUnidacDriverConexao.Parametros: iConexaoParametros;
begin
  Result := FParametros;
end;


function TBGUnidacDriverConexao.Query: iQuery;
begin
  if Not Assigned(FiQuery) then
    FiQuery := TList<iQuery>.Create;

  if Not Assigned(FiConexao) then
    FiConexao := TUnidacDriverModelConexao.New(FFConnection, FLimitCacheRegister);

  FiQuery.Add(TUnidacModelQuery.New(FFConnection, FiConexao));
  Result := FiQuery[FiQuery.Count-1];
end;

procedure TBGUnidacDriverConexao.SetFConnection(const Value: TUniConnection);
begin
  FFConnection := Value;
end;

procedure TBGUnidacDriverConexao.SetFQuery(const Value: TUniQuery);
begin
  FFQuery := Value;
end;

procedure TBGUnidacDriverConexao.SetLimitCache(const Value: Integer);
begin
  FLimitCacheRegister := Value;
end;

procedure Register;
begin
  RegisterComponents('TBGAbstractConnection', [TBGUnidacDriverConexao]);
end;


end.
