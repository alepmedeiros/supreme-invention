unit replication.client.roteiroproducao;

interface

uses
  System.JSON,
  GBJSON.Interfaces;

type
  TRoteiroProducao = class
  private
    FroteiroName: String;
    Fidroteiroproducaointegracao: Integer;
    Fobs: string;
  public
    property roteiroName: String read FroteiroName write FroteiroName;
    property idroteiroproducaointegracao: Integer read Fidroteiroproducaointegracao write Fidroteiroproducaointegracao;
    property obs: string read Fobs write Fobs;

    class function New: TRoteiroProducao;
  end;

  TRoteiroProducaoHelper = class helper for TRoteiroProducao
    function ToJSON: TJSONObject;
    function JsonToObject(Value: String): TRoteiroProducao;
  end;

implementation

{ TRoteiroProducao }

class function TRoteiroProducao.New: TRoteiroProducao;
begin
  Result := Self.Create;
end;

{ TRoteiroProducaoHelper }

function TRoteiroProducaoHelper.JsonToObject(Value: String): TRoteiroProducao;
begin
  Result := TGBJSONDefault.Serializer<TRoteiroProducao>.JsonStringToObject(Value);
end;

function TRoteiroProducaoHelper.ToJSON: TJSONObject;
begin
  Result := TGBJSONDefault.Deserializer<TRoteiroProducao>.ObjectToJsonObject(Self);
end;

end.
