unit TBGRemoteCache.View.Principal;

interface

uses
  {$ifndef FPC}
  System.Classes,
  {$else}
  Classes,
  {$endif}
  TBGRemoteCache.Model.Interfaces;

Type
  TTBGRemoteCache = class(TComponent, iRemoteCache)
    private
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iRemoteCache;
  end;

{$ifndef FPC}
procedure Register;
{$endif}

implementation

{ TTBGRemoteCache }

constructor TTBGRemoteCache.Create;
begin

end;

destructor TTBGRemoteCache.Destroy;
begin

  inherited;
end;

class function TTBGRemoteCache.New: iRemoteCache;
begin
  Result := Self.Create;
end;

{$ifndef FPC}
procedure Register;
begin
  RegisterComponents('TBGAbstractConnection', [TTBGRemoteCache]);
end;
{$endif}


end.
