unit TBGInterbaseExpressDriver.Model.Conexao;

interface
uses
  System.Classes,
  Data.DB, IBX.IBDatabase,
  TBGConnection.Model.Interfaces,
  TBGConnection.Model.DataSet.Interfaces;

Type
  TInterbaseExpressDriverModelConexao = class(TInterfacedObject, iConexao)
  private
    FConnection : TIBDatabase;
    FTrans: TIBTransaction;
  public
    constructor Create(Connection : TIBDatabase; LimitCacheRegister : Integer);
    destructor Destroy; override;
    class function New(Connection : TIBDatabase; LimitCacheRegister : Integer) : iConexao;
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
  System.SysUtils, TBGConnection.Model.DataSet.Proxy;

{ TInterbaseExpressDriverModelConexao }

function TInterbaseExpressDriverModelConexao.Commit: iConexao;
begin
  Result := Self;
  FConnection.Transactions[FConnection.FindTransaction(FTrans)].CommitRetaining;
end;

function TInterbaseExpressDriverModelConexao.Conectar: iConexao;
begin
  Result := Self;
  FConnection.Connected := True;

end;

function TInterbaseExpressDriverModelConexao.Connection: TComponent;
begin
  Result := FConnection;
end;

constructor TInterbaseExpressDriverModelConexao.Create(Connection : TIBDatabase; LimitCacheRegister : Integer);
begin
  FConnection := Connection;
end;

destructor TInterbaseExpressDriverModelConexao.Destroy;
begin

  inherited;
end;

function TInterbaseExpressDriverModelConexao.&End: TComponent;
begin
  Result := FConnection;
end;

class function TInterbaseExpressDriverModelConexao.New(Connection : TIBDatabase; LimitCacheRegister : Integer) : iConexao;
begin
  Result := Self.Create(Connection, LimitCacheRegister);
end;

function TInterbaseExpressDriverModelConexao.RollbackTransaction: iConexao;
begin
  Result := Self;
  FConnection.Transactions[FConnection.FindTransaction(FTrans)].RollbackRetaining;
end;

function TInterbaseExpressDriverModelConexao.StartTransaction: iConexao;
begin
  Result := Self;
  FConnection.Transactions[FConnection.FindTransaction(FTrans)].StartTransaction;
end;

function TInterbaseExpressDriverModelConexao.ThisAs: TObject;
begin
  Result := Self;
end;

end.
