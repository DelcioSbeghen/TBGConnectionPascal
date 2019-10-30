unit TBGFiredacDriver.Model.Conexao;

interface

uses
  TBGConnection.Model.Interfaces, FireDAC.Comp.Client, System.Classes, Data.DB,
  TBGConnection.Model.DataSet.Interfaces;

Type
  TFiredacDriverModelConexao = class(TInterfacedObject, iConexao)
  private
    FConnection : TFDConnection;
  public
    constructor Create(Connection : TFDConnection; LimitCacheRegister : Integer);
    destructor Destroy; override;
    class function New(Connection : TFDConnection; LimitCacheRegister : Integer) : iConexao;
    function ThisAs: TObject;
    //iConexao
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

{ TFiredacDriverModelConexao }

function TFiredacDriverModelConexao.Commit: iConexao;
begin
  Result := Self;
  FConnection.Commit;
end;

function TFiredacDriverModelConexao.Conectar: iConexao;
begin
  Result := Self;
  FConnection.Connected := true;
end;

function TFiredacDriverModelConexao.&End: TComponent;
begin
  Result := FConnection;
end;

function TFiredacDriverModelConexao.Connection: TComponent;
begin
  Result := FConnection;
end;

constructor TFiredacDriverModelConexao.Create(Connection : TFDConnection; LimitCacheRegister : Integer);
begin
  FConnection := Connection;
end;

destructor TFiredacDriverModelConexao.Destroy;
begin

  inherited;
end;

class function TFiredacDriverModelConexao.New(Connection : TFDConnection; LimitCacheRegister : Integer) : iConexao;
begin
  Result := Self.Create(Connection, LimitCacheRegister);
end;

function TFiredacDriverModelConexao.RollbackTransaction: iConexao;
begin
  Result := Self;
  FConnection.Rollback;
end;

function TFiredacDriverModelConexao.StartTransaction: iConexao;
begin
  Result := Self;
  FConnection.StartTransaction;
end;

function TFiredacDriverModelConexao.ThisAs: TObject;
begin
  Result := Self;
end;

end.
