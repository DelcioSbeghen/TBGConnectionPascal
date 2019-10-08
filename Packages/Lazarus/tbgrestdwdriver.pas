{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit TBGRestDWDriver;

{$warn 5023 off : no warning about unused units}
interface

uses
  TBGRestDWDriver.Model.Conexao, TBGRestDWDriver.Model.Query, 
  TBGRestDWDriver.View.Driver, TBGRestDWDriver.Model.DataSet,TBGRestDWDriverReg, 
  LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('TBGRestDWDriverReg', @TBGRestDWDriverReg.Register);
end;

initialization
  RegisterPackage('TBGRestDWDriver', @Register);
end.
