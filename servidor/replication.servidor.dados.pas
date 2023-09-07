unit replication.servidor.dados;

interface

uses
  System.SysUtils,
  System.Classes,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef,
  FireDAC.ConsoleUI.Wait,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  Data.DB,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  IniFiles;

type
  TdmDados = class(TDataModule)
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;
    FDQuery2: TFDQuery;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    procedure DataModuleCreate(Sender: TObject);
  const
    SECTION = 'CONFIG';
    CAMINHO = 'CAMINHO';
    PORTA = 'PORTA';
    servidor = 'SERVIDOR';
    USUARIO = 'USERNAME';
    SENHA = 'PASSWORD';
    DRIVERNAME = 'DRIVERNAME';
  private
    FArq: TIniFile;
  public
    { Public declarations }
  end;

var
  dmDados: TdmDados;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}
{$R *.dfm}

procedure TdmDados.DataModuleCreate(Sender: TObject);
begin
//  FArq:= TIniFile.Create(ExtractFilePath(ParamStr(0))+'conf.ini');
//  FDConnection1.Params.Clear;
//  FDConnection1.Params.DriverID := FArq.ReadString(SECTION, DRIVERNAME, '');
//  FDConnection1.Params.Database := FArq.ReadString(SECTION, CAMINHO, '');
//  FDConnection1.Params.UserName := FArq.ReadString(SECTION, USUARIO, '');
//  FDConnection1.Params.Password := FArq.ReadString(SECTION, SENHA, '');
//  FDConnection1.Params.Add('SERVER='+FArq.ReadString(SECTION, SERVIDOR, ''));
//  FDConnection1.Params.Add('PORT='+FArq.ReadString(SECTION, PORTA, ''));
  FDConnection1.Connected := True;
end;

end.
