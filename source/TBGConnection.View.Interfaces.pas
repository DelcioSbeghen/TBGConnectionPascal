unit TBGConnection.View.Interfaces;

interface

{$ifdef FPC}
{$mode objfpc}{$H+}
{$endif}


uses
  TBGConnection.Model.Interfaces, TBGConnection.Model.DataSet.Interfaces;

type
  iTBGConnection = interface
  ['{C5D26971-AB66-4D1F-8ADD-55D0F7EB8020}']
    procedure SetDriver(const Value: iDriver);
    function GetDriver: iDriver;
  end;

implementation

end.
