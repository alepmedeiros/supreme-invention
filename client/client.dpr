program client;

{$R *.dres}

uses
  Vcl.Forms,
  replication.client in 'replication.client.pas' {Form1},
  replication.client.resources.interfaces in 'src\resources\replication.client.resources.interfaces.pas',
  replication.client.interfaces in 'replication.client.interfaces.pas',
  replication.client.configuracao in 'replication.client.configuracao.pas',
  replication.client.log in 'replication.client.log.pas',
  replication.client.conexao in 'replication.client.conexao.pas',
  replication.client.eventalert in 'replication.client.eventalert.pas',
  replication.client.persistences in 'replication.client.persistences.pas',
  replication.client.resources in 'replication.client.resources.pas',
  replication.client.factory in 'replication.client.factory.pas',
  replication.client.setor in 'replication.client.setor.pas',
  replication.client.produto in 'replication.client.produto.pas',
  replication.client.serviceorder in 'replication.client.serviceorder.pas',
  replication.client.roteiroproducao in 'replication.client.roteiroproducao.pas',
  replication.client.roteiroproducaoitem in 'replication.client.roteiroproducaoitem.pas',
  replication.client.process in 'replication.client.process.pas',
  replication.client.setorproducao in 'replication.client.setorproducao.pas',
  replication.client.centrotrabalho in 'replication.client.centrotrabalho.pas',
  replication.client.roteiroproducaopg in 'replication.client.roteiroproducaopg.pas',
  replication.client.roteiroproducaoitempg in 'replication.client.roteiroproducaoitempg.pas',
  replication.client.produtoPG in 'replication.client.produtoPG.pas',
  replication.client.ordemproducaoitem in 'replication.client.ordemproducaoitem.pas',
  replication.client.datamodule in 'replication.client.datamodule.pas' {DataModule1: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.Run;
end.
