{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit TBGRemoteCache;

{$warn 5023 off : no warning about unused units}
interface

uses
  TBGRemoteCache.View.Principal, TBGRemoteCache.Model.Interfaces, 
  TBGRemoteCacheReg, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('TBGRemoteCacheReg', @TBGRemoteCacheReg.Register);
end;

initialization
  RegisterPackage('TBGRemoteCache', @Register);
end.
