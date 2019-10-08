unit TBGConnectionReg;

{$mode objfpc}{$H+}

interface

uses
 {$IFNDEF UNIX}Windows,
 {$ELSE}Lcl,{$ENDIF}LResources, Classes, TBGConnection.View.Principal;

Procedure Register;

implementation

Procedure Register;
Begin
 RegisterComponents('TBGAbstractConnection', [TTBGConnection]);
End;

initialization
{$I tbgconnection.lrs}

end.

