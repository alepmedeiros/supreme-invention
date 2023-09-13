unit replication.client.setorproducao;

interface

uses
  System.JSON,
  GBJSON.Interfaces;

type
  TSetorProducao = class
  private
    Fsetorproducaoid: Integer;
    Fdesc_setorproducao: String;
  public
    property setorproducaoid: Integer read Fsetorproducaoid write Fsetorproducaoid;
    property desc_setorproducao: String read Fdesc_setorproducao write Fdesc_setorproducao;

    class function New: TSetorProducao;
  end;

  TSetorProducaoHelper = class helper for TSetorProducao
    function ToJSON: TJSONObject;
    function JsonToObject(Value: String): TSetorProducao;
  end;

implementation

{ TSetorProducao }

class function TSetorProducao.New: TSetorProducao;
begin
  Result := Self.Create;
end;

{ TSetorProducaoHelper }

function TSetorProducaoHelper.JsonToObject(Value: String): TSetorProducao;
begin
  Result := TGBJSONDefault.Serializer<TSetorProducao>.JsonStringToObject(Value);
end;

function TSetorProducaoHelper.ToJSON: TJSONObject;
begin
  Result := TGBJSONDefault.Deserializer<TSetorProducao>.ObjectToJsonObject(Self);
end;

end.
