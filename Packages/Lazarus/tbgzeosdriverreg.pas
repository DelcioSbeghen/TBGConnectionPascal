unit TBGZeosDriverReg;

{$mode objfpc}{$H+}

interface

uses
 {$IFNDEF UNIX}Windows,
 {$ELSE}Lcl,{$ENDIF}LResources, Classes, TBGZeosDriver.View.Driver;

Procedure Register;

implementation

Procedure Register;
Begin
 RegisterComponents('TBGAbstractConnection', [TBGZeosDriverConexao]);
End;

initialization
{$I tbgzeosdriver.lrs}

end.

