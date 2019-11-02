unit TBGQuery.View.Principal;

interface

uses
  {$ifndef FPC}
  System.Classes, System.SysUtils, Data.DB,
  {$else}
  Classes, SysUtils, DB,
  {$endif}
  TBGConnection.Model.Interfaces, TBGConnection.View.Interfaces;

Type

  { TTBGQuery }

  TTBGQuery = class(TComponent, iQuery)
  private
    FQuery : iQuery;
    FConnection: iTBGConnection;
    FDataSource: TDataSource;
    procedure SetConnection(const Value: iTBGConnection);
    function GetQuery: iQuery;
    procedure SetDataSource(const Value: TDataSource);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class function New: iQuery;
    function ThisAs: TObject;
    property Query: iQuery read GetQuery implements iQuery;
  published
    property Connection: iTBGConnection read FConnection write SetConnection;
    property DataSource: TDataSource read FDataSource write SetDataSource;
  end;

{$ifndef FPC}
procedure Register;
{$endif}

implementation

{ TTBGQuery }

constructor TTBGQuery.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TTBGQuery.Destroy;
begin

  inherited Destroy;
end;

function TTBGQuery.GetQuery: iQuery;
var
  LDriver: iDriver;
begin
  if not Assigned(FConnection) then
    raise Exception.Create('TBGConnection component not assigned to Query.');

  LDriver := FConnection.GetDriver;

  if not Assigned(LDriver) then
    raise Exception.Create('Driver not assigned to TBGConnection.');

  if not Assigned(FQuery) then
    FQuery := LDriver.Query;

  FQuery.DataSource(FDataSource);
  Result := FQuery;
end;

class function TTBGQuery.New: iQuery;
begin
  Result := Self.Create(nil);
end;

function TTBGQuery.ThisAs: TObject;
begin
  Result := Self;
end;

procedure TTBGQuery.SetConnection(const Value: iTBGConnection);
begin
  FConnection := Value;
end;

procedure TTBGQuery.SetDataSource(const Value: TDataSource);
begin
  FDataSource := Value;
end;

{$ifndef FPC}
procedure Register;
begin
  RegisterComponents('TBGAbstractConnection', [TTBGQuery]);
end;
{$endif}

end.
