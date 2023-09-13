unit replication.client.configuracao;

interface

uses
  replication.client.interfaces,
  System.IniFiles;

type
  TConfiguracao = class(TInterfacedObject, iConfiguracao)
  private
    FArquivo: TIniFile;

    constructor Create;
    destructor Destroy; override;

    const
      ARQUIVO = 'CONF.INI';
      SECAOCONF = 'CONFIGURACAO';
      SERVER = 'REPLICATION';
  public
    class function New: iConfiguracao;
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

implementation

uses
  System.SysUtils;

constructor TConfiguracao.Create;
begin
  FArquivo := TIniFile.Create(ExtractFilePath(ParamStr(0))+ARQUIVO);
end;

destructor TConfiguracao.Destroy;
begin
  FArquivo.Free;
  inherited;
end;

function TConfiguracao.GetDatabase: String;
begin
  Result := FArquivo.ReadString(SECAOCONF, 'DATABASE', '');
end;

function TConfiguracao.GetDriverId: String;
begin
  Result := FArquivo.ReadString(SECAOCONF, 'DRIVERID', '');
end;

function TConfiguracao.GetLibrary: String;
begin
  Result := FArquivo.ReadString(SECAOCONF, 'LIBRARY', '');
end;

function TConfiguracao.GetPassowrd: String;
begin
  Result := FArquivo.ReadString(SECAOCONF, 'PASSWORD', '');
end;

function TConfiguracao.GetPorta: String;
begin
  Result := FArquivo.ReadString(SECAOCONF, 'PORTA', '');
end;

function TConfiguracao.GetReplicacao: String;
begin
  Result := FArquivo.ReadString(SERVER, 'SERVER', '');
end;

function TConfiguracao.GetServidor: String;
begin
  Result := FArquivo.ReadString(SECAOCONF, 'SERVER', '');
end;

function TConfiguracao.GetUserName: String;
begin
  Result := FArquivo.ReadString(SECAOCONF, 'USERNAME', '');
end;

function TConfiguracao.Gravar: iConfiguracao;
begin
  Result := Self;
  FArquivo.Free;
end;

class function TConfiguracao.New: iConfiguracao;
begin
  Result := Self.Create;
end;

function TConfiguracao.SetDatabase(Value: String): iConfiguracao;
begin
  Result := self;
  FArquivo.WriteString(SECAOCONF, 'DATABASE', Value);
end;

function TConfiguracao.SetDriverId(Value: String): iConfiguracao;
begin
  Result := self;
  FArquivo.WriteString(SECAOCONF, 'DRIVERID', Value);
end;

function TConfiguracao.SetLibrary(Value: String): iConfiguracao;
begin
  Result := Self;
  FArquivo.WriteString(SECAOCONF, 'LIBRARY', Value);
end;

function TConfiguracao.SetPassword(Value: String): iConfiguracao;
begin
  Result := self;
  FArquivo.WriteString(SECAOCONF, 'PASSWORD', Value);
end;

function TConfiguracao.SetPorta(Value: String): iConfiguracao;
begin
  Result := self;
  FArquivo.WriteString(SECAOCONF, 'PORTA', Value);
end;

function TConfiguracao.SetReplicacao(Value: String): iConfiguracao;
begin
  Result := self;
  FArquivo.WriteString(SERVER, 'SERVER', Value);
end;

function TConfiguracao.SetServidor(Value: String): iConfiguracao;
begin
  Result := self;
  FArquivo.WriteString(SECAOCONF, 'SERVER', Value);
end;

function TConfiguracao.SetUserName(Value: String): iConfiguracao;
begin
 Result := self;
  FArquivo.WriteString(SECAOCONF, 'USERNAME', Value);
end;

end.
