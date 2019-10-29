unit TBGConnection.Model.Conexao.Parametros.RestDW;

{$ifdef FPC}
{$mode objfpc}{$H+}
{$endif}

interface

uses
  Classes, SysUtils,
  TBGConnection.Model.Interfaces,
  TBGConnection.Model.Conexao.Parametros;

type

  { TModelConexaoParametrosRestDW }

  TModelConexaoParametrosRestDW = class(TModelConexaoParametros, iConexaoParametrosRestDW)
  private
    FConexao: iConexao;
    FAccessTag: string;
    FLogin: String;
    FPoolerService: string;
    FPoolerURL: String;
    FPoolerPort: Integer;
    FPoolerName: String;
    FClientConnectionDefs: TObject;
  public
    constructor Create(Conexao: iConexao);
    destructor Destroy; override;
    class function New(Conexao: iConexao): iConexaoParametrosRestDW;
    function ThisAs: TObject;

    function AccessTag(const Value: String): iConexaoParametrosRestDW; overload;
    function Login(const Value: String): iConexaoParametrosRestDW; overload;
    function PoolerService(const Value: String): iConexaoParametrosRestDW; overload;
    function PoolerURL(const Value: String): iConexaoParametrosRestDW; overload;
    function PoolerPort(const Value: Integer): iConexaoParametrosRestDW; overload;
    function PoolerName(const Value: String): iConexaoParametrosRestDW; overload;
    function ClientConnectionDefs(const Value: TObject): iConexaoParametrosRestDW; overload;
    function AccessTag: string; overload;
    function Login: String; overload;
    function PoolerService: string; overload;
    function PoolerURL: String; overload;
    function PoolerPort: Integer; overload;
    function PoolerName: String; overload;
    function ClientConnectionDefs: TObject; overload;
    function &End: iConexao;
  end;


implementation

{ TModelConexaoParametrosRestDW }

constructor TModelConexaoParametrosRestDW.Create(Conexao: iConexao);
begin
  FConexao := Conexao;
end;

destructor TModelConexaoParametrosRestDW.Destroy;
begin
  inherited Destroy;
end;

class function TModelConexaoParametrosRestDW.New(Conexao: iConexao): iConexaoParametrosRestDW;
begin
  Result := Self.Create(Conexao);
end;

function TModelConexaoParametrosRestDW.ThisAs: TObject;
begin
  Result := Self;
end;

function TModelConexaoParametrosRestDW.AccessTag(const Value: String
  ): iConexaoParametrosRestDW;
begin
  Result := Self;
  FAccessTag:=Value;
end;

function TModelConexaoParametrosRestDW.PoolerService(const Value: String
  ): iConexaoParametrosRestDW;
begin
  Result := Self;
  FPoolerService:=Value;
end;

function TModelConexaoParametrosRestDW.PoolerURL(const Value: String
  ): iConexaoParametrosRestDW;
begin
  Result := Self;
  FPoolerURL:=Value;
end;

function TModelConexaoParametrosRestDW.PoolerPort(const Value: Integer
  ): iConexaoParametrosRestDW;
begin
  Result := Self;
  FPoolerPort:=Value;
end;

function TModelConexaoParametrosRestDW.PoolerName(const Value: String
  ): iConexaoParametrosRestDW;
begin
  Result := Self;
  FPoolerName:=Value;
end;

function TModelConexaoParametrosRestDW.ClientConnectionDefs(const Value: TObject
  ): iConexaoParametrosRestDW;
begin
  Result := Self;
  FClientConnectionDefs:=Value;
end;

function TModelConexaoParametrosRestDW.AccessTag: string;
begin
  Result := FAccessTag;;
end;

function TModelConexaoParametrosRestDW.Login: String;
begin
  Result := FLogin;
end;

function TModelConexaoParametrosRestDW.PoolerService: string;
begin
  Result := FPoolerService;
end;

function TModelConexaoParametrosRestDW.PoolerURL: String;
begin
  Result := FPoolerURL;
end;

function TModelConexaoParametrosRestDW.PoolerPort: Integer;
begin
  Result := FPoolerPort;
end;

function TModelConexaoParametrosRestDW.PoolerName: String;
begin
  Result := FPoolerName;
end;

function TModelConexaoParametrosRestDW.ClientConnectionDefs: TObject;
begin
  Result := FClientConnectionDefs;
end;

function TModelConexaoParametrosRestDW.&End: iConexao;
begin
  Result := FConexao;
end;

function TModelConexaoParametrosRestDW.Login(
  const Value: String): iConexaoParametrosRestDW;
begin
  Result := Self;
  FLogin := Value;
end;

end.

