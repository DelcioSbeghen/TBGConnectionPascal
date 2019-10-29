unit TBGConnection.View.Principal;

interface

uses
  {$ifndef FPC}
  System.Classes,
  System.SysUtils,
  {$else}
  Classes,
  SysUtils,
  {$endif}
  TBGConnection.View.Interfaces, TBGConnection.Model.Interfaces,
  TBGConnection.Model.DataSet.Interfaces,
  TBGConnection.Model.DataSet.Observer;

Type
  TTBGConnection = class(TComponent, iTBGConnection)
  private
    FDriver: iDriver;
    procedure SetDriver(const Value: iDriver);
    function GetDriver: iDriver;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
    class function New : iTBGConnection;
  published
    property Driver : iDriver read GetDriver write SetDriver;
  end;

{$ifndef FPC}
procedure Register;
{$endif}

implementation

uses
  TBGConnection.Model.DataSet.Proxy;

{$ifndef FPC}
{$R Icones.dcr}
{$endif}

{ TTBGConnection }

constructor TTBGConnection.Create;
begin
  inherited Create(nil);
end;

destructor TTBGConnection.Destroy;
begin

  inherited Destroy;
end;


function TTBGConnection.GetDriver: iDriver;
begin
  Result := FDriver;
end;

class function TTBGConnection.New: iTBGConnection;
begin
  Result := Self.Create;
end;


procedure TTBGConnection.SetDriver(const Value: iDriver);
begin
  FDriver := Value;
end;

{$ifndef FPC}
procedure Register;
begin
  RegisterComponents('TBGAbstractConnection', [TTBGConnection]);
end;
{$endif}

//initialization
//  TTBGConnection.Create;

end.
