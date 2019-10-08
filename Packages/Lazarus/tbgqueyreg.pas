unit TBGQueyReg;

{$mode objfpc}{$H+}

interface

uses
 {$IFNDEF UNIX}Windows,
 {$ELSE}Lcl,{$ENDIF}LResources, Classes, TBGQuery.View.Principal;

Procedure Register;

implementation

Procedure Register;
Begin
 RegisterComponents('TBGAbstractConnection', [TTBGQuery]);
End;

initialization
{$I tbgquery.lrs}

end.

