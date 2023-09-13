unit replication.client.produto;

interface

uses
  System.JSON,
  GBJSON.Interfaces;

type
  TProduto = class
  private
    Fnomeproduto: String;
    Fstatus: String;
    Fidroteiroproducao: Integer;
    Fidprodutointegracao: Integer;
  public
    property nomeproduto: String read Fnomeproduto write Fnomeproduto;
    property status: String read Fstatus write Fstatus;
    property idroteiroproducao: Integer read Fidroteiroproducao write Fidroteiroproducao;
    property idprodutointegracao: Integer read Fidprodutointegracao write Fidprodutointegracao;

    class function New: TProduto;
  end;

  TProdutoHelper = class helper for TProduto
    function ToJSON: TJSONObject;
    function JsonToObject(Value: String): TProduto;
  end;

implementation

{ TProduto }

class function TProduto.New: TProduto;
begin
  result := self.Create;
end;

{ TProdutoHelper }

function TProdutoHelper.JsonToObject(Value: String): TProduto;
begin
  Result := TGBJSONDefault.Serializer<TProduto>.JsonStringToObject(Value);
end;

function TProdutoHelper.ToJSON: TJSONObject;
begin
  Result := TGBJSONDefault.Deserializer<TProduto>.ObjectToJsonObject(Self);
end;

end.
