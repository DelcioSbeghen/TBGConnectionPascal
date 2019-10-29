unit TBGConnection.Model.Conexao.Parametros;

{$ifdef FPC}
{$mode objfpc}{$H+}
{$endif}

interface

uses
  TBGConnection.Model.Interfaces;

Type

  { TModelConexaoParametros }

  TModelConexaoParametros = class(TInterfacedObject, iConexaoParametros)
  private
    FConexao: iConexao;
    FDatabase : String;
    FUserName : String;
    FPassword : String;
    FDriverID : String;
    FServer : String;
    FPorta : Integer;
  public
    constructor Create(Conexao: iConexao);
    destructor Destroy; override;
    class function New(Conexao: iConexao): iConexaoParametros;
    function ThisAs: TObject;
    function Database(Value: String): iConexaoParametros;
    function UserName(Value: String): iConexaoParametros;
    function Password(Value: String): iConexaoParametros;
    function DriverID(Value: String): iConexaoParametros;
    function Server(Value: String): iConexaoParametros;
    function Porta(Value: Integer): iConexaoParametros;
    function GetDatabase: String;
    function GetUserName: String;
    function GetPassword: String;
    function GetDriverID: String;
    function GetServer: String;
    function GetPorta: Integer;
    function &End: iConexao;
  end;

  { TModelConexaoParametrosZeos }

  TModelConexaoParametrosZeos = class(TModelConexaoParametros, iConexaoParametrosZeos)
  strict private
    FProtocol: String;
    FLibLocation: String;
  public
    function LibraryLocation(Value: String): iConexaoParametrosZeos;
    function Protocol(Value: String): iConexaoParametrosZeos;
    function GetLibraryLocation: String;
    function GetProtocol: String;
  end;

implementation

{ TModelConexaoParametrosZeos }

function TModelConexaoParametrosZeos.LibraryLocation(Value: String
  ): iConexaoParametrosZeos;
begin
  Result := Self;
  FLibLocation := Value;
end;

function TModelConexaoParametrosZeos.Protocol(Value: String
  ): iConexaoParametrosZeos;
begin
  Result := Self;
  FProtocol := Value;
end;

function TModelConexaoParametrosZeos.GetLibraryLocation: String;
begin
  Result := FLibLocation;
end;

function TModelConexaoParametrosZeos.GetProtocol: String;
begin
  Result := FProtocol;
end;

{ TModelConexaoParametros }

function TModelConexaoParametros.&End: iConexao;
begin
  Result := FConexao;
end;

constructor TModelConexaoParametros.Create(Conexao: iConexao);
begin
  FConexao := Conexao;
end;

function TModelConexaoParametros.Database(Value: String): iConexaoParametros;
begin
  Result := Self;
  FDatabase := Value;
end;

destructor TModelConexaoParametros.Destroy;
begin

  inherited;
end;

function TModelConexaoParametros.DriverID(Value: String): iConexaoParametros;
begin
  Result := Self;
  FDriverID := Value;
end;

function TModelConexaoParametros.GetDatabase: String;
begin
  Result := FDatabase;
end;

function TModelConexaoParametros.GetDriverID: String;
begin
  Result := FDriverID;
end;

function TModelConexaoParametros.GetPassword: String;
begin
  Result := FPassword;
end;

function TModelConexaoParametros.GetPorta: Integer;
begin
  Result := FPorta;
end;

function TModelConexaoParametros.GetServer: String;
begin
  Result := FServer;
end;

function TModelConexaoParametros.GetUserName: String;
begin
  Result := FUserName;
end;

class function TModelConexaoParametros.New(Conexao: iConexao)
  : iConexaoParametros;
begin
  Result := Self.Create(Conexao);
end;

function TModelConexaoParametros.ThisAs: TObject;
begin
  Result := Self;
end;

function TModelConexaoParametros.Password(Value: String): iConexaoParametros;
begin
  Result := Self;
  FPassword := Value;
end;

function TModelConexaoParametros.Porta(Value: Integer): iConexaoParametros;
begin
  Result := Self;
  FPorta := Value;
end;

function TModelConexaoParametros.Server(Value: String): iConexaoParametros;
begin
  Result := Self;
  FServer := Value;
end;

function TModelConexaoParametros.UserName(Value: String): iConexaoParametros;
begin
  Result := Self;
  FUserName := Value;
end;

end.
