unit replication.client.setor;

interface

uses
  System.JSON,
  GBJSON.Interfaces;

type
  TSetor = class
  private
    Fnomesetor: String;
    Fdescription: String;
    Fidsetorintegracao: Integer;
    Foperacao: String;
  public
    property nomesetor: String read Fnomesetor write Fnomesetor;
    property description: String read Fdescription write Fdescription;
    property idsetorintegracao: Integer read Fidsetorintegracao write Fidsetorintegracao;

    class function New: TSetor;
  end;

  TSetorHelper = class helper for TSetor
    function ToJSON: TJSONObject;
    function JsonToObject(Value: String): TSetor;
  end;

implementation

{ TSetor }

class function TSetor.New: TSetor;
begin
  Result := Self.Create;
end;

{ TSetorHelper }

function TSetorHelper.JsonToObject(Value: String): TSetor;
begin
  Result := TGBJSONDefault.Serializer<TSetor>.JsonStringToObject(Value);
end;

function TSetorHelper.ToJSON: TJSONObject;
begin
  Result := TGBJSONDefault.Deserializer<TSetor>.ObjectToJsonObject(Self);
end;

end.
