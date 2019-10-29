unit TBGConnection.Model.Interfaces;

interface

uses
  {$ifndef FPC}
  System.Classes, Data.DB,
  {$else}
  Classes, DB,
  {$endif}
  TBGConnection.Model.DataSet.Interfaces;

type
  TChangeDataSet = procedure of Object;


  iConexaoParametros = interface;
  iConexao = interface;
  iQuery = interface;

  iTBGModelObject = interface
    ['{2275EA0D-C77A-40C5-8B7A-4469FD158BAF}']
    function ThisAs: TObject;
  end;

  iDriver = interface(iTBGModelObject)
    ['{F8F3E0E2-4333-40CD-8A4E-7B7790F2FA73}']
    function Conexao : iConexao;
    function Query : iQuery;
    function DataSet : iDataSet;
    function Cache : iDriverProxy;
    function LimitCacheRegister(Value : Integer) : iDriver;
  end;

  iConexao = interface(iTBGModelObject)
    ['{FF14FC96-C57C-4BD0-9AFB-5F7AAD5D5138}']
    function Conectar : iConexao;
    function &End: TComponent;
    function Connection : TComponent;
    function Commit : iConexao;
    function StartTransaction : iConexao;
    function RollbackTransaction : iConexao;
    //function Parametros: iConexaoParametros;
  end;

  iQuery = interface(iTBGModelObject)
    ['{BA7F4622-7AA4-413D-B9CD-CADAB16DF714}']
    function Open(aSQL: String): iQuery;
    function Close : iQuery;
    function SQL : TStrings;
    function Params : TParams;
    function ParamByName(Value : String) : TParam;
    function ExecSQL : iQuery; overload;
    function ExecSQL(aSQL : String) : iQuery; overload;
    function DataSet : TDataSet; overload;
    function DataSet(Value : TDataSet) : iQuery; overload;
    function DataSource(Value : TDataSource) : iQuery;
    function Fields : TFields;
    function &End: TComponent;
    function Tag(Value : Integer) : iQuery;
    function LocalSQL(Value : TComponent) : iQuery;
    function UpdateTableName(Tabela : String) : iQuery;
  end;


  iConexaoParametros = interface(iTBGModelObject)
    ['{26A78068-9C26-4381-BA90-B7313F9ACAB7}']
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

  iConexaoParametrosZeos = interface(iConexaoParametros)
    ['{583A441A-5798-4BB6-B29B-3D366FCF5E46}']
    function LibraryLocation(Value: String): iConexaoParametrosZeos;
    function Protocol(Value: String): iConexaoParametrosZeos;
    function GetProtocol: String;
    function GetLibraryLocation: String;
  end;

  iConexaoParametrosRestDW = interface(iConexaoParametros)
    ['{6D42EE32-D243-4B7A-B2F5-A6C80D2F2027}']
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
  end;

  iInstanciar = interface
    function Instanciar_Proxy(Value : String) : iDriverProxy;
  end;

implementation

end.



