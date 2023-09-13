unit replication.client.roteiroproducaoitempg;

interface

uses
  System.JSON,
  GBJSON.Interfaces;

type
  TRoteiroProducaoItemPG = class
  private
    Froteiroproducaoitemid: Integer;
    Fordem: Integer;
    Fdt_cadastro: TDateTime;
    Froteiroproducaoid: integer;
    Fcentrotrabalhoid: Integer;
  public
    property roteiroproducaoitemid: Integer read Froteiroproducaoitemid write Froteiroproducaoitemid;
    property ordem: Integer read Fordem write Fordem;
    property dt_cadastro: TDateTime read Fdt_cadastro write Fdt_cadastro;
    property roteiroproducaoid: integer read Froteiroproducaoid write Froteiroproducaoid;
    property centrotrabalhoid: Integer read Fcentrotrabalhoid write Fcentrotrabalhoid;

    class function New: TRoteiroProducaoItemPG;
  end;

  TRoteiroProducaoItemPGHelper = class helper for TRoteiroProducaoItemPG
    function ToJSON: TJSONObject;
    function JsonToObject(Value: String): TRoteiroProducaoItemPG;
  end;

implementation

{ TRoteiroProducaoItemPG }

class function TRoteiroProducaoItemPG.New: TRoteiroProducaoItemPG;
begin
  Result := Self.Create;
end;

{ TRoteiroProducaoItemPGHelper }

function TRoteiroProducaoItemPGHelper.JsonToObject(
  Value: String): TRoteiroProducaoItemPG;
begin
  Result := TGBJSONDefault.Serializer<TRoteiroProducaoItemPG>.JsonStringToObject(Value);
end;

function TRoteiroProducaoItemPGHelper.ToJSON: TJSONObject;
begin
  Result := TGBJSONDefault.Deserializer<TRoteiroProducaoItemPG>.ObjectToJsonObject(Self);
end;

end.
