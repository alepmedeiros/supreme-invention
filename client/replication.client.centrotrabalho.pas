unit replication.client.centrotrabalho;

interface

uses
  System.JSON,
  GBJSON.Interfaces;

type
  TCentroTrabalho = class
  private
    Fcentrotrabalhoid: Integer;
    Fnome_centro_trabalho: String;
    Fobs_centro_trabalho: String;
    Fsetorproducaoid: Integer;
    Fstatus: String;
  public
    property centrotrabalhoid: Integer read Fcentrotrabalhoid write Fcentrotrabalhoid;
    property nome_centro_trabalho: String read Fnome_centro_trabalho write Fnome_centro_trabalho;
    property obs_centro_trabalho: String read Fobs_centro_trabalho write Fobs_centro_trabalho;
    property setorproducaoid: Integer read Fsetorproducaoid write Fsetorproducaoid;
    property status: String read Fstatus write Fstatus;

    class function New: TCentroTrabalho;
  end;

  TCentroTrabalhoHelper = class helper for TCentroTrabalho
    function ToJSON: TJSONObject;
    function JsonToObject(Value: String): TCentroTrabalho;
  end;

implementation

{ TCentroTrabalho }

class function TCentroTrabalho.New: TCentroTrabalho;
begin
  Result := Self.Create;
end;

{ TCentroTrabalhoHelper }

function TCentroTrabalhoHelper.JsonToObject(Value: String): TCentroTrabalho;
begin
  Result := TGBJSONDefault.Serializer<TCentroTrabalho>.JsonStringToObject(Value);
end;

function TCentroTrabalhoHelper.ToJSON: TJSONObject;
begin
  Result := TGBJSONDefault.Deserializer<TCentroTrabalho>.ObjectToJsonObject(Self);
end;

end.
