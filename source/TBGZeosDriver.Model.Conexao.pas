unit TBGZeosDriver.Model.Conexao;

interface

uses
  {$ifndef FPC}
  System.Classes, Data.DB, System.SysUtils,
  {$else}
  Classes, DB, SysUtils,
  {$endif}
  ZConnection,
  TBGConnection.Model.Interfaces,
  TBGConnection.Model.DataSet.Interfaces;

Type

  { TZeosDriverModelConexao }

  TZeosDriverModelConexao = class(TInterfacedObject, iConexao)
  private
    FConnection : TZConnection;
    FDriver : iDriver;
  public
    constructor Create(Connection : TZConnection; LimitCacheRegister : Integer; Driver : iDriver);
    destructor Destroy; override;
    class function New(Connection : TZConnection; LimitCacheRegister : Integer; Driver : iDriver) : iConexao;
    function ThisAs: TObject;
    function Conectar : iConexao;
    function &End: TComponent;
    function Connection : TComponent;
    function StartTransaction : iConexao;
    function RollbackTransaction : iConexao;
    function Commit : iConexao;
  end;

implementation

uses
  TBGConnection.Model.DataSet.Proxy;

{ TZeosDriverModelConexao }

function TZeosDriverModelConexao.Commit: iConexao;
begin
  Result := Self;
  FConnection.Commit;
end;

function TZeosDriverModelConexao.Conectar: iConexao;
begin
  Result := Self;
  FConnection.Connected := true;
end;

function TZeosDriverModelConexao.&End: TComponent;
begin
  Result := FConnection;
end;

function TZeosDriverModelConexao.Connection: TComponent;
begin
  Result := FConnection;
end;

constructor TZeosDriverModelConexao.Create(Connection : TZConnection; LimitCacheRegister : Integer; Driver : iDriver);
begin
  FDriver := Driver;
  FConnection := Connection;
end;

destructor TZeosDriverModelConexao.Destroy;
begin

  inherited;
end;

class function TZeosDriverModelConexao.New(Connection : TZConnection; LimitCacheRegister : Integer; Driver : iDriver) : iConexao;
begin
  Result := Self.Create(Connection, LimitCacheRegister, Driver);
end;

function TZeosDriverModelConexao.ThisAs: TObject;
begin
  Result := Self;
end;

function TZeosDriverModelConexao.RollbackTransaction: iConexao;
begin
  Result := Self;
  FConnection.Rollback;
end;

function TZeosDriverModelConexao.StartTransaction: iConexao;
begin
  Result := Self;
  FConnection.StartTransaction;
end;

end.

