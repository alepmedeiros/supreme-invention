unit replication.servidor.utils;

interface

uses
  System.TypInfo;

type
  TTabelas = (Produto, setor, Process, Roteiro_Producao, Roteiro_producao_item,Service_Order, Service_Order_Process);

  TTabelasHelper = record helper for TTabelas
    function ToString: String;
    function ToEnum(Value: String): TTabelas;
  end;

implementation

uses
  System.SysUtils;

{ TTabelasHelper }

function TTabelasHelper.ToEnum(Value: String): TTabelas;
begin
  Result := TTabelas(GetEnumValue(TypeInfo(TTabelas), lowercase(Value)));
end;

function TTabelasHelper.ToString: String;
begin
  Result := GetEnumName(TypeInfo(TTabelas), Integer(self));
end;

end.
