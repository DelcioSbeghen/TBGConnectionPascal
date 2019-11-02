unit TBGZeosDriver.View.Driver;

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
  ZConnection, ZDataSet,
  TBGConnection.Model.Interfaces,
  TBGConnection.Model.DataSet.Interfaces;

const
  c_DefaultLimitCache = 10;

Type

  { TBGZeosDriverConexao }

  TBGZeosDriverConexao = class(TComponent, iDriver)
  private
    FFConnection: TZConnection;
    FiConexao : iConexao;
    FiQuery : TList<iQuery>;
    FLimitCacheRegister : Integer;
    FProxy : iDriverProxy;
    procedure SetFConnection(const Value: TZConnection);
    procedure SetLimitCache(const Value: Integer);
    function GetLimitCache: Integer;
  protected
    function Conexao : iConexao;
    function Query : iQuery;
    function DataSet : iDataSet;
    function Cache : iDriverProxy;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
    class function New : iDriver;
    function ThisAs: TObject;
    function Conectar : iConexao;
    function LimitCacheRegister(Value : Integer) : iDriver;
  published
    property FConnection : TZConnection read FFConnection write SetFConnection;
    property LimitCache : Integer read GetLimitCache write SetLimitCache;
  end;

{$ifndef FPC}
procedure Register;
{$endif}

implementation

uses
  TBGZeosDriver.Model.Conexao, TBGZeosDriver.Model.Query,
  TBGConnection.Model.DataSet.Proxy, TBGZeosDriver.Model.DataSet;

{ TBGZeosDriverConexao }

function TBGZeosDriverConexao.Cache: iDriverProxy;
begin
  if not Assigned(FProxy) then
    FProxy := TTBGConnectionModelProxy.New(FLimitCacheRegister, Self);

  Result := FProxy;
end;

function TBGZeosDriverConexao.Conectar: iConexao;
begin

end;

function TBGZeosDriverConexao.GetLimitCache: Integer;
begin
  Result := FLimitCacheRegister;
end;

function TBGZeosDriverConexao.LimitCacheRegister(Value: Integer): iDriver;
begin
  Result := Self;
  FLimitCacheRegister := Value;
end;

function TBGZeosDriverConexao.Conexao: iConexao;
begin
  if not Assigned(FiConexao) then
    FiConexao := TZeosDriverModelConexao.New(FFConnection);

  Result := FiConexao;
end;

constructor TBGZeosDriverConexao.Create;
begin
  inherited Create(nil);
  FiQuery := TList<iQuery>.Create;
  FLimitCacheRegister := c_DefaultLimitCache;
end;

function TBGZeosDriverConexao.DataSet: iDataSet;
begin
  if not Assigned(FProxy) then
    FProxy := TTBGConnectionModelProxy.New(FLimitCacheRegister, Self);

  Result := TConnectionModelZeosDataSet.New(FProxy.ObserverList);
end;

destructor TBGZeosDriverConexao.Destroy;
begin
  FreeAndNil(FiQuery);
  inherited;
end;

class function TBGZeosDriverConexao.New: iDriver;
begin
  Result := Self.Create;
end;

function TBGZeosDriverConexao.ThisAs: TObject;
begin
  Result := Self;
end;

function TBGZeosDriverConexao.Query: iQuery;
begin
  if Not Assigned(FiQuery) then
    FiQuery := TList<iQuery>.Create;

  if Not Assigned(FiConexao) then
    FiConexao := TZeosDriverModelConexao.New(FFConnection);

  FiQuery.Add(TZeosModelQuery.New(FFConnection, Self));
  Result := FiQuery[FiQuery.Count-1];
end;

procedure TBGZeosDriverConexao.SetFConnection(const Value: TZConnection);
begin
  FFConnection := Value;
end;

procedure TBGZeosDriverConexao.SetLimitCache(const Value: Integer);
begin
  FLimitCacheRegister := Value;
end;

{$ifndef FPC}
procedure Register;
begin
  RegisterComponents('TBGAbstractConnection', [TBGZeosDriverConexao]);
end;
{$endif}

end.
