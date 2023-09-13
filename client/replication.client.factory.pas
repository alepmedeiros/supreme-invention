unit replication.client.factory;

interface

uses
  replication.client.interfaces;

type
  TFactory = class(TInterfacedObject, iFactory)
  private
    FConfiguracao: iConfiguracao;
    FConectar: iConexao;
    FAlert: iEventAlert;

    constructor Create;
    destructor Destroy; override;
  public
    class function New: iFactory;
    function Configuracao: iConfiguracao;
    function Conectar: iConexao;
    function Alerta: iEventAlert;
  end;

implementation

uses
  replication.client.configuracao,
  replication.client.conexao,
  replication.client.eventalert;

function TFactory.Alerta: iEventAlert;
begin
  if not Assigned(FAlert) then
    FAlert := TEventAlert.New(FConectar.Conn);
  Result := FAlert;
end;

function TFactory.Conectar: iConexao;
begin
  if not Assigned(FConectar) then
    FConectar := TConexao.New(FConfiguracao);
  Result := FConectar;
end;

function TFactory.Configuracao: iConfiguracao;
begin
  if not Assigned(FConfiguracao) then
    FConfiguracao := TConfiguracao.New;
  Result := FConfiguracao;
end;

constructor TFactory.Create;
begin

end;

destructor TFactory.Destroy;
begin

  inherited;
end;

class function TFactory.New: iFactory;
begin
  Result := Self.Create;
end;

end.
