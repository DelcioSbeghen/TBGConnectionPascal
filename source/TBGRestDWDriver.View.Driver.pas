unit TBGRestDWDriver.View.Driver;

interface

{$ifdef FPC}
  {Necessário para uso do package rtl-generics:->  Generics.Collections}
  {$MODE DELPHI}{$H+}
{$endif}

uses
  {$ifndef FPC}
  System.Classes,
  System.SysUtils,
  System.Generics.Collections,
  {$else}
  Classes,
  SysUtils,
  Generics.Collections,
  {$endif}
  uRESTDWPoolerDB,
  TBGConnection.Model.Interfaces,
  TBGConnection.Model.Conexao.Parametros,
  TBGConnection.Model.DataSet.Interfaces;

const
  c_DefaultLimitCache = 10;

Type

  { TBGRestDWDriverConexao }

  TBGRestDWDriverConexao = class(TComponent, iDriver)
  private
    FFConnection: TRestDWDataBase;
    FiConexao : iConexao;
    FiQuery : TList<iQuery>;
    FLimitCacheRegister : Integer;
    FProxy : iDriverProxy;
    procedure SetFConnection(const Value: TRestDWDataBase);
    function GetLimitCache: Integer;
    procedure SetLimitCache(const Value: Integer);
  protected
    FParametros : iConexaoParametros;
    function Conexao : iConexao;
    function Query : iQuery;
    function LimitCacheRegister(Value : Integer) : iDriver;
    function Cache : iDriverProxy;
    function DataSet : iDataSet;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
    class function New : iDriver;
    function ThisAs: TObject;
    function Conectar : iConexao;
    function Parametros: iConexaoParametros;
  published
    property FConnection : TRestDWDataBase read FFConnection write SetFConnection;
    property LimitCache : Integer read GetLimitCache write SetLimitCache stored True default c_DefaultLimitCache;
  end;

{$ifndef FPC}
procedure Register;
{$endif}

implementation


uses
  TBGRestDWDriver.Model.Conexao, TBGRestDWDriver.Model.Query,
  TBGConnection.Model.DataSet.Proxy, TBGRestDWDriver.Model.DataSet;

{ TBGRestDWDriverConexao }

function TBGRestDWDriverConexao.Cache: iDriverProxy;
begin
  if not Assigned(FProxy) then
    FProxy := TTBGConnectionModelProxy.New(FLimitCacheRegister, Self);

  Result := FProxy;
end;

function TBGRestDWDriverConexao.Conectar: iConexao;
begin

end;

function TBGRestDWDriverConexao.GetLimitCache: Integer;
begin
  Result := FLimitCacheRegister;
end;

function TBGRestDWDriverConexao.LimitCacheRegister(Value: Integer): iDriver;
begin
  Result := Self;
  FLimitCacheRegister := Value;
end;

function TBGRestDWDriverConexao.Conexao: iConexao;
begin
  if not Assigned(FiConexao) then
    FiConexao := TRestDWDriverModelConexao.New(FFConnection, FLimitCacheRegister);

  Result := FiConexao;
end;

constructor TBGRestDWDriverConexao.Create;
begin
  inherited Create(nil);
  FiQuery := TList<iQuery>.Create;
  LimitCache := c_DefaultLimitCache;
end;

function TBGRestDWDriverConexao.DataSet: iDataSet;
begin
  if not Assigned(FProxy) then
    FProxy := TTBGConnectionModelProxy.New(FLimitCacheRegister, Self);

  Result := TConnectionModelRestDWDataSet.New(FProxy.ObserverList);
end;

destructor TBGRestDWDriverConexao.Destroy;
begin
  FreeAndNil(FiQuery);
  inherited;
end;

class function TBGRestDWDriverConexao.New: iDriver;
begin
  Result := Self.Create;
end;

function TBGRestDWDriverConexao.ThisAs: TObject;
begin
  Result := Self;
end;

function TBGRestDWDriverConexao.Parametros: iConexaoParametros;
begin
  Result := FParametros;
end;


function TBGRestDWDriverConexao.Query: iQuery;
begin
  if Not Assigned(FiQuery) then
    FiQuery := TList<iQuery>.Create;

  if Not Assigned(FiConexao) then
    FiConexao := TRestDWDriverModelConexao.New(FFConnection, FLimitCacheRegister);

  FiQuery.Add(TRestDWModelQuery.New(FFConnection, Self));
  Result := FiQuery[FiQuery.Count-1];
end;

procedure TBGRestDWDriverConexao.SetFConnection(const Value: TRestDWDataBase);
begin
  FFConnection := Value;
end;

procedure TBGRestDWDriverConexao.SetLimitCache(const Value: Integer);
begin
  FLimitCacheRegister := Value;
end;

{$ifndef FPC}
procedure Register;
begin
  RegisterComponents('TBGAbstractConnection', [TBGRestDWDriverConexao]);
end;
{$endif}


end.
