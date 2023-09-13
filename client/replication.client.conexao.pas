unit replication.client.conexao;

interface

uses
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.PG,
  FireDAC.Phys.PGDef,
  FireDAC.VCLUI.Wait,
  FireDAC.Comp.client,
  Data.DB,
  replication.client.interfaces;

type
  TConexao = class(TInterfacedObject, iConexao)
  private
    FConn: TFDConnection;
    FDriver: TFDPhysPgDriverLink;
    FConf: iConfiguracao;

    constructor Create(Conf: iConfiguracao);
    destructor Destroy; override;
  public
    class function New(Conf: iConfiguracao): iConexao;
    function Conn: TCustomConnection;
  end;

implementation

uses
  replication.client.configuracao,
  System.SysUtils;

function TConexao.Conn: TCustomConnection;
begin
  try
    FDriver.VendorLib := FConf.GetLibrary;

    FConn.Params.Clear;
    FConn.Params.DriverID := FConf.GetDriverId;
    FConn.Params.Database := FConf.GetDatabase;
    FConn.Params.UserName := FConf.GetUserName;
    FConn.Params.Password := FConf.GetPassowrd;
    FConn.Params.Add('SERVER='+FConf.GetServidor);
    FConn.Params.Add('PORT='+FConf.GetPorta);
    FConn.LoginPrompt := False;
    FConn.Connected := True;
  except
    raise Exception.Create('Erro ao tentar conectar a base de dads, favor rever as configurações');
  end;
  Result := FConn;
end;

constructor TConexao.Create(Conf: iConfiguracao);
begin
  FConn := TFDConnection.Create(nil);
  FDriver := TFDPhysPgDriverLink.Create(FConn);
  FConf := Conf;
end;

destructor TConexao.Destroy;
begin
  FConn.Free;
  inherited;
end;

class function TConexao.New(Conf: iConfiguracao): iConexao;
begin
  Result := Self.Create(Conf);
end;

end.
