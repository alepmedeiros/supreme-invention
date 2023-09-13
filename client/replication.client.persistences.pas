unit replication.client.persistences;

interface

uses
  replication.client.interfaces,
  Restrequest4d;

type
  TPersistences = class(TInterfacedObject, iPersistence)
  private
    FReq: iRequest;
    FResp: iResponse;

    constructor Create(Url: String);
    destructor Destroy; override;
  public
    class function New(Url: String): iPersistence;
    function Post(Value: String): iPersistence;
    function Put(Value: String): iPersistence;
    function Status: Integer;
    function Content: String;
  end;

implementation


function TPersistences.Content: String;
begin
  Result := FResp.Content;
end;

constructor TPersistences.Create(Url: String);
begin
   FReq := TRequest.New.BaseURL(Url);
end;

destructor TPersistences.Destroy;
begin

  inherited;
end;

class function TPersistences.New(Url: String): iPersistence;
begin
  Result := Self.Create(Url);
end;

function TPersistences.Post(Value: String): iPersistence;
begin
  Result := Self;
  FResp := FReq.AddBody(Value).Post;
end;

function TPersistences.Put(Value: String): iPersistence;
begin
  Result := Self;
  FResp := FReq.AddBody(Value).Put;
end;

function TPersistences.Status: Integer;
begin
  Result := FResp.StatusCode;
end;

end.
