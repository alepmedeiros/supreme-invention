unit replication.client.process;

interface

uses
  System.JSON,
  GBJSON.Interfaces;

type
  TProcess = class
  private
    Fstatus: String;
    Fnameprocess: String;
    Fobs: String;
    Fidsetor: Integer;
    Fidprocessintegracao: Integer;
  public
    property status: String read Fstatus write Fstatus;
    property nameprocess: String read Fnameprocess write Fnameprocess;
    property obs: String read Fobs write Fobs;
    property idsetor: Integer read Fidsetor write Fidsetor;
    property idprocessintegracao: Integer read Fidprocessintegracao write Fidprocessintegracao;

    class function New: TProcess;
  end;

  TProcessHelper = class helper for TProcess
    function ToJSON: TJSONObject;
    function JsonToObject(Value: String): TProcess;
  end;

implementation

{ TProcess }

class function TProcess.New: TProcess;
begin
  Result := Self.Create;
end;

{ TProcessHelper }

function TProcessHelper.JsonToObject(Value: String): TProcess;
begin
  Result := TGBJSONDefault.Serializer<TProcess>.JsonStringToObject(Value);
end;

function TProcessHelper.ToJSON: TJSONObject;
begin
  Result := TGBJSONDefault.Deserializer<TProcess>.ObjectToJsonObject(Self);
end;

end.
