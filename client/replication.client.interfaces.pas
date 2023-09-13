unit replication.client.interfaces;

interface

uses
  Data.DB,
  System.Classes,
  system.Generics.Collections;

type
  iFactory = interface;

  iConfiguracao = interface
    function SetDatabase(Value: String): iConfiguracao;
    function GetDatabase: String;
    function SetUserName(Value: String): iConfiguracao;
    function GetUserName: String;
    function SetPassword(Value: String): iConfiguracao;
    function GetPassowrd: String;
    function SetDriverId(Value: String): iConfiguracao;
    function GetDriverId: String;
    function SetServidor(Value: String): iConfiguracao;
    function GetServidor: String;
    function SetPorta(Value: String): iConfiguracao;
    function GetPorta: String;
    function SetReplicacao(Value: String): iConfiguracao;
    function GetReplicacao: String;
    function SetLibrary(Value: String): iConfiguracao;
    function GetLibrary: String;
    function Gravar: iConfiguracao;
  end;

  iLog = interface
    function Descricao(Value: String): iLog;
  end;

  iConexao = interface
    function Conn: TCustomConnection;
  end;

  iEventAlert = interface
    function Names(Value: TStrings): iEventAlert;
    function Alert: TList<String>;
  end;

  iPersistence = interface
    function Post(Value: String): iPersistence;
    function Put(Value: String): iPersistence;
    function Status: Integer;
    function Content: String;
  end;

  iFactory = interface
    function Configuracao: iConfiguracao;
    function Conectar: iConexao;
    function Alerta: iEventAlert;
  end;

implementation

end.
