unit replication.client.serviceorder;

interface

uses
  System.JSON,
  GBJSON.Interfaces;

type
  TServiceOrder = class
  private
    Fdatacriacao: TDateTime;
    Fdataentrega: TDateTime;
    Fnumero: String;
    Fquantidade: Integer;
    Forder: Integer;
    Fdescription: String;
    Fidproduto: Integer;
    Fidserviceorderintegracao: Integer;
    Fstatus: String;
    Fsequencingorder: Integer;
  public
    property datacriacao: TDateTime read Fdatacriacao write Fdatacriacao;
    property dataentrega: TDateTime read Fdataentrega write Fdataentrega;
    property numero: String read Fnumero write Fnumero;
    property quantidade: Integer read Fquantidade write Fquantidade;
    property order: Integer read Forder write Forder;
    property description: String read Fdescription write Fdescription;
    property idproduto: Integer read Fidproduto write Fidproduto;
    property idserviceorderintegracao: Integer read Fidserviceorderintegracao write Fidserviceorderintegracao;
    property status: String read Fstatus write Fstatus;
    property sequencingorder: Integer read Fsequencingorder write Fsequencingorder;

    class function New: TServiceOrder;
  end;

  TServiceOrderHelper = class helper for TServiceOrder
    function ToJSON: TJSONObject;
    function JsonToObject(Value: String): TServiceOrder;
  end;

implementation

{ TServiceOrder }

class function TServiceOrder.New: TServiceOrder;
begin
  Result := Self.Create;
end;

{ TServiceOrderHelper }

function TServiceOrderHelper.JsonToObject(Value: String): TServiceOrder;
begin
  Result := TGBJSONDefault.Serializer<TServiceOrder>.JsonStringToObject(Value);
end;

function TServiceOrderHelper.ToJSON: TJSONObject;
begin
  Result := TGBJSONDefault.Deserializer<TServiceOrder>.ObjectToJsonObject(Self);
end;

end.
