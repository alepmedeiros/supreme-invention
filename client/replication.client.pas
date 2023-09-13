unit replication.client;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.VCLUI.Wait,
  FireDAC.Comp.client,
  Data.DB,
  FireDAC.Phys.PG,
  FireDAC.Phys.PGDef,
  Vcl.ExtCtrls,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  FireDAC.Comp.DataSet,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.StdCtrls,
  Vcl.Menus,
  Vcl.Mask,
  Vcl.Buttons;

type
  TForm1 = class(TForm)
    TrayIcon1: TTrayIcon;
    PopupMenu1: TPopupMenu;
    Fechar1: TMenuItem;
    Abrir1: TMenuItem;
    Panel1: TPanel;
    Panel2: TPanel;
    Button1: TButton;
    MemoEventos: TMemo;
    Panel3: TPanel;
    Label1: TLabel;
    edtEventos: TEdit;
    edtDriverId: TLabeledEdit;
    edtUserName: TLabeledEdit;
    edtPassword: TLabeledEdit;
    edtDataBase: TLabeledEdit;
    edtServidor: TLabeledEdit;
    edtPorta: TLabeledEdit;
    edtLibrary: TLabeledEdit;
    OpenDialog1: TOpenDialog;
    edtServidorReplicacao: TLabeledEdit;
    Button2: TButton;
    procedure Fechar1Click(Sender: TObject);
    procedure Abrir1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure edtEventosKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private

  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  System.StrUtils,
  System.IniFiles;

{$R *.dfm}

procedure TForm1.Abrir1Click(Sender: TObject);
begin
  self.Show;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  self.Hide;
end;

procedure TForm1.edtEventosKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    MemoEventos.Lines.Add(edtEventos.Text);
    edtEventos.Clear;
  end;
end;

procedure TForm1.Fechar1Click(Sender: TObject);
begin
  self.Close;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  var larquivo := TInifile.Create(ExtractFilePath(Application.ExeName)+'CONFIGURACAO.INI');
  try
    edtDriverId.Text := larquivo.ReadString('CONFIGURACAO','DRIVERID', '');
    edtUserName.Text := larquivo.ReadString('CONFIGURACAO','USERNAME', '');
    edtPassword.Text := larquivo.ReadString('CONFIGURACAO','PASSWORD', '');
    edtDataBase.Text := larquivo.ReadString('CONFIGURACAO','DATABASE', '');
    edtServidor.Text := larquivo.ReadString('CONFIGURACAO','SERVER', '');
    edtPorta.Text := larquivo.ReadString('CONFIGURACAO','PORT', '');
    edtServidorReplicacao.Text := larquivo.ReadString('REPLICATION','SERVIDOR', '');
  finally
    larquivo.Free;
  end;
end;

end.
