{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit TBGZeosDriver;

{$warn 5023 off : no warning about unused units}
interface

uses
  TBGZeosDriver.Model.Conexao, TBGZeosDriver.Model.Query, 
  TBGZeosDriver.View.Driver, TBGZeosDriver.Model.DataSet, TBGZeosDriverReg, 
  LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('TBGZeosDriverReg', @TBGZeosDriverReg.Register);
end;

initialization
  RegisterPackage('TBGZeosDriver', @Register);
end.
