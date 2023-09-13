unit replication.client.roteiroproducaoitem;

interface

uses
  System.JSON,
  GBJSON.Interfaces;

type
  TRoteiroProducaoItem = class
  private
    Fsequencingorder: Integer;
    Ffinalizeprocess: String;
    Fidprocess: Integer;
    Fidroteiroproducao: Integer;
    Fidroteiroproducaoitemintegracao: Integer;
  public
    property sequencingorder: Integer read Fsequencingorder write Fsequencingorder;
    property finalizeprocess: String read Ffinalizeprocess write Ffinalizeprocess;
    property idprocess: Integer read Fidprocess write Fidprocess;
    property idroteiroproducao: Integer read Fidroteiroproducao write Fidroteiroproducao;
    property idroteiroproducaoitemintegracao: Integer read Fidroteiroproducaoitemintegracao write Fidroteiroproducaoitemintegracao;

    class function New: TRoteiroProducaoItem;
  end;

  TRoteiroProducaoItemHelper = class helper for TRoteiroProducaoItem
    function ToJSON: TJSONObject;
    function JsonToObject(Value: String): TRoteiroProducaoItem;
  end;

implementation

{ TRoteiroProducaoItem }

class function TRoteiroProducaoItem.New: TRoteiroProducaoItem;
begin
  Result := Self.Create;
end;

{ TRoteiroProducaoItemHelper }

function TRoteiroProducaoItemHelper.JsonToObject(
  Value: String): TRoteiroProducaoItem;
begin
  Result := TGBJSONDefault.Serializer<TRoteiroProducaoItem>.JsonStringToObject(Value);
end;

function TRoteiroProducaoItemHelper.ToJSON: TJSONObject;
begin
  Result := TGBJSONDefault.Deserializer<TRoteiroProducaoItem>.ObjectToJsonObject(Self);
end;

end.
