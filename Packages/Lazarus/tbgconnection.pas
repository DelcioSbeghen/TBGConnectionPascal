{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit TBGConnection;

{$warn 5023 off : no warning about unused units}
interface

uses
  TBGConnection.Model.Interfaces, TBGConnection.View.Interfaces, 
  TBGConnection.View.Principal, TBGConnection.Model.Conexao.Parametros, 
  TBGConnection.Model.Conexao.Parametros.RestDW, 
  TBGConnection.Model.DataSet.Proxy, TBGConnection.Model.DataSet.Observer, 
  TBGConnection.Model.DataSet.Factory, TBGConnection.Model.DataSet.Interfaces, 
  TBGConnection.Model.Helper, TBGConnectionReg, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('TBGConnectionReg', @TBGConnectionReg.Register);
end;

initialization
  RegisterPackage('TBGConnection', @Register);
end.
