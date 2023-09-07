program server;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  Horse,
  Horse.Jhonson,
  System.JSON,
  System.SysUtils,
  replication.servidor.dados in 'replication.servidor.dados.pas' {dmDados: TDataModule},
  replication.servidor.serializable.transformexpression in 'replication.servidor.serializable.transformexpression.pas',
  replication.servidor.produto in 'replication.servidor.produto.pas',
  replication.servidor.utils in 'replication.servidor.utils.pas',
  replication.servidor.setor in 'replication.servidor.setor.pas',
  replication.servidor.process in 'replication.servidor.process.pas',
  replication.servidor.roteiroproducao in 'replication.servidor.roteiroproducao.pas',
  replication.servidor.roteiroproducaoitem in 'replication.servidor.roteiroproducaoitem.pas',
  replication.servidor.serviceorder in 'replication.servidor.serviceorder.pas';

procedure ReceberDados(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  JSONData: TJSONObject;
begin
  JSONData := Req.Body<TJSONObject>;

  var
  lDados := replication.servidor.dados.TdmDados.Create(nil);
  try
    var lTabelas: TTabelas;

    case lTabelas.ToEnum(JSONData.GetValue<String>('tabeladestino')) of
      Produto: TProduto.New(lDados, JSONData.ToString).Insert.Update.Delete;
      setor: TSetor.New(lDados, JSONData.ToString).Insert.Update.Delete;
      Process: TProcess.New(lDados, JSONData.ToString).Insert.Update.Delete;
      Roteiro_Producao: TRoteiro_Producao.New(lDados, JSONData.ToString).Insert.Update.Delete;
      Roteiro_producao_item: TRoteiro_producao_item.New(lDados, JSONData.ToString).Insert.Update.Delete;
      Service_Order: TServiceOrder.New(lDados,JSONData.ToString).Insert.Update.Delete;
      Service_Order_Process: ;
    end;


  finally
    lDados.Free;
  end;

  Res.Status(202);
end;

procedure Configuration(App: THorse);
begin
  App.Post('/receber_dados', ReceberDados);
end;

begin
  var
  lHorse := THorse.Create;
  lHorse.Use(Jhonson());

  Configuration(lHorse);

  lHorse.Listen(9000);
end.
