unit replication.client.produtoPG;

interface

uses
  System.JSON,
  GBJSON.Interfaces;

type
  TProdutoPG = class
  private
    Fprodutoid: Integer;
    Fnome_produto: String;
    Froteiroproducaoid: Integer;
  public
    property produtoid: Integer read Fprodutoid write Fprodutoid;
    property nome_produto: String read Fnome_produto write Fnome_produto;
    property roteiroproducaoid: Integer read Froteiroproducaoid write Froteiroproducaoid;

    class function New: TProdutoPG;
  end;

  TProdutoPGHelper = class helper for TProdutoPG
    function ToJSON: TJSONObject;
    function JsonToObject(Value: String): TProdutoPG;
  end;

implementation

{ TProdutoPG }

class function TProdutoPG.New: TProdutoPG;
begin
  Result := Self.Create;
end;

{ TProdutoPGHelper }

function TProdutoPGHelper.JsonToObject(Value: String): TProdutoPG;
begin
  Result := TGBJSONDefault.Serializer<TProdutoPG>.JsonStringToObject(Value);
end;

function TProdutoPGHelper.ToJSON: TJSONObject;
begin
  Result := TGBJSONDefault.Deserializer<TProdutoPG>.ObjectToJsonObject(Self);
end;

end.
