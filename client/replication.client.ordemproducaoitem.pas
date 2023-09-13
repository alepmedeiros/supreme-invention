unit replication.client.ordemproducaoitem;

interface

uses
  System.JSON,
  GBJSON.Interfaces;

type
  TOrdemProducaoItem = class
  private
    Fordemproducaoitemid: Integer;
    Fqt_op_item: Integer;
    Fdt_orprod: TDateTime;
    Fdt_entga_ordprod: TDateTime;
    Fds_estrutura_op_item: String;
    Fprodutoid: Integer;
    Fordem: Integer;
    Fstatus_ordemproducao_item: String;
  public
    property ordemproducaoitemid: Integer read Fordemproducaoitemid write Fordemproducaoitemid;
    property qt_op_item: Integer read Fqt_op_item write Fqt_op_item;
    property dt_orprod: TDateTime read Fdt_orprod write Fdt_orprod;
    property dt_entga_ordprod: TDateTime read Fdt_entga_ordprod write Fdt_entga_ordprod;
    property ds_estrutura_op_item: String read Fds_estrutura_op_item write Fds_estrutura_op_item;
    property produtoid: Integer read Fprodutoid write Fprodutoid;
    property ordem: Integer read Fordem write Fordem;
    property status_ordemproducao_item: String read Fstatus_ordemproducao_item write Fstatus_ordemproducao_item;

    class function New: TOrdemProducaoItem;
  end;

  TOrdemProducaoItemHelper = class helper for TOrdemProducaoItem
    function ToJSON: TJSONObject;
    function JsonToObject(Value: String): TOrdemProducaoItem;
  end;

implementation

{ TOrdemProducaoItem }

class function TOrdemProducaoItem.New: TOrdemProducaoItem;
begin
  Result := Self.Create;
end;

{ TOrdemProducaoItemHelper }

function TOrdemProducaoItemHelper.JsonToObject(
  Value: String): TOrdemProducaoItem;
begin
  Result := TGBJSONDefault.Serializer<TOrdemProducaoItem>.JsonStringToObject(Value);
end;

function TOrdemProducaoItemHelper.ToJSON: TJSONObject;
begin
  Result := TGBJSONDefault.Deserializer<TOrdemProducaoItem>.ObjectToJsonObject(Self);
end;

end.
