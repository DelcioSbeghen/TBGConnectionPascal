unit TBGRemoteCacheReg;

{$mode objfpc}{$H+}

interface

uses
 {$IFNDEF UNIX}Windows,
 {$ELSE}Lcl,{$ENDIF}LResources, Classes, TBGRemoteCache.View.Principal;

Procedure Register;

implementation

Procedure Register;
Begin
 RegisterComponents('TBGAbstractConnection', [TTBGRemoteCache]);
End;



end.

