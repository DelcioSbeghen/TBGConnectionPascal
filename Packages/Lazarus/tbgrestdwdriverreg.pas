unit TBGRestDWDriverReg;

{$mode objfpc}{$H+}

interface

uses
 {$IFNDEF UNIX}Windows,
 {$ELSE}Lcl,{$ENDIF}LResources, Classes, TBGRestDWDriver.View.Driver;

Procedure Register;

implementation

Procedure Register;
Begin
 RegisterComponents('TBGAbstractConnection', [TBGRestDWDriverConexao]);
End;

initialization
{$I tbgrestdwdriver.lrs}

end.

