{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit TBGQuery;

{$warn 5023 off : no warning about unused units}
interface

uses
  TBGQuery.View.Principal, TBGQueyReg, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('TBGQueyReg', @TBGQueyReg.Register);
end;

initialization
  RegisterPackage('TBGQuery', @Register);
end.
