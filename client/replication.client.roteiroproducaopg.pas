unit replication.client.roteiroproducaopg;

interface

uses
  System.JSON,
  GBJSON.Interfaces;

type
  TRoteiroProducaoPG = class
  private
    Froteiroproducaoid: Integer;
    Fnome_roteiro: String;
    Freferencia_roteiro: String;
    Fobs_roteiro: String;
  public
    property roteiroproducaoid: Integer read Froteiroproducaoid write Froteiroproducaoid;
    property nome_roteiro: String read Fnome_roteiro write Fnome_roteiro;
    property referencia_roteiro: String read Freferencia_roteiro write Freferencia_roteiro;
    property obs_roteiro: String read Fobs_roteiro write Fobs_roteiro;

    class function New: TRoteiroProducaoPG;
  end;

  TRoteiroProducaoPGHelper = class helper for TRoteiroProducaoPG
    function ToJSON: TJSONObject;
    function JsonToObject(Value: String): TRoteiroProducaoPG;
  end;

implementation

{ TRoteiroProducaoPG }

class function TRoteiroProducaoPG.New: TRoteiroProducaoPG;
begin
  Result := Self.Create;
end;

{ TRoteiroProducaoPGHelper }

function TRoteiroProducaoPGHelper.JsonToObject(
  Value: String): TRoteiroProducaoPG;
begin
  Result := TGBJSONDefault.Serializer<TRoteiroProducaoPG>.JsonStringToObject(Value);
end;

function TRoteiroProducaoPGHelper.ToJSON: TJSONObject;
begin
  Result := TGBJSONDefault.Deserializer<TRoteiroProducaoPG>.ObjectToJsonObject(Self);
end;

end.
