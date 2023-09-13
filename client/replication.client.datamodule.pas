unit replication.client.datamodule;

interface

uses
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
  FireDAC.Phys.PG,
  FireDAC.Phys.PGDef,
  FireDAC.VCLUI.Wait,
  FireDAC.Comp.client,
  Data.DB,
  System.IniFiles;

type
  TDataModule1 = class(TDataModule)
    FDConnection1: TFDConnection;
    FDPhysPgDriverLink1: TFDPhysPgDriverLink;
    FDEventAlerter1: TFDEventAlerter;
    procedure DataModuleCreate(Sender: TObject);
    procedure FDEventAlerter1Alert(ASender: TFDCustomEventAlerter;
      const AEventName: string; const AArgument: Variant);
  private
    FPath: String;
    FArquivo: TIniFile;

    procedure GerarLog(Value: String);
  public
    { Public declarations }
  end;

var
  DataModule1: TDataModule1;

CONST
    ARQUIVOINI = 'CONFIGURACAO.INI';
    SECAOCONF = 'CONFIGURACAO';
    SERVER = 'REPLICATION';

implementation

uses
  RESTRequest4D,
  System.SysUtils,
  System.StrUtils,
  System.Variants,
  Vcl.Forms,
  Vcl.Dialogs,
  system.JSON,
  GBJSON.Interfaces,
  replication.client.produtoPG,
  replication.client.setorproducao,
  replication.client.setor,
  replication.client.produto,
  replication.client.centrotrabalho,
  replication.client.process,
  replication.client.roteiroproducaopg,
  replication.client.roteiroproducao,
  replication.client.roteiroproducaoitempg,
  replication.client.roteiroproducaoitem,
  replication.client.ordemproducaoitem,
  replication.client.serviceorder;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

procedure TDataModule1.DataModuleCreate(Sender: TObject);
begin
  FArquivo := TIniFile.Create(ExtractFilePath(Application.ExeName)+ARQUIVOINI);

  FDPhysPgDriverLink1.VendorHome := EmptyStr;
  FDPhysPgDriverLink1.VendorLib := ExtractFilePath(Application.ExeName)+'libpq.dll';

  FDConnection1.Params.Clear;
  FDConnection1.Params.DriverID := FArquivo.ReadString(SECAOCONF,'DRIVERID', '');
  FDConnection1.Params.Database := FArquivo.ReadString(SECAOCONF,'DATABASE', '');
  FDConnection1.Params.UserName := FArquivo.ReadString(SECAOCONF,'USERNAME', '');
  FDConnection1.Params.Password := FArquivo.ReadString(SECAOCONF,'PASSWORD', '');
  FDConnection1.Params.Add('SERVER='+FArquivo.ReadString(SECAOCONF,'SERVER', ''));
  FDConnection1.Params.Add('PORT'+FArquivo.ReadString(SECAOCONF,'PORT', ''));
  FDConnection1.Connected := true;
  FDEventAlerter1.Register;
end;

procedure TDataModule1.FDEventAlerter1Alert(ASender: TFDCustomEventAlerter;
  const AEventName: string; const AArgument: Variant);
var
  i: Integer;
  sArgs: String;
begin
  if VarIsArray(AArgument) then begin
    sArgs := '';
    for i := VarArrayLowBound(AArgument, 1) to VarArrayHighBound(AArgument, 1) do begin
      if sArgs <> '' then
        sArgs := sArgs + '; ';
      sArgs := sArgs + VarToStr(AArgument[i]);
    end;
  end
  else if VarIsNull(AArgument) then
    sArgs := '<NULL>'
  else if VarIsEmpty(AArgument) then
    sArgs := '<UNASSIGNED>'
  else
    sArgs := VarToStr(AArgument);

  var lId := SplitString(sArgs, ';');

  var lResp: IResponse;

  var jsonObject := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(lid[1]), 0) as TJSONObject;
  var lOperacao := jsonObject.GetValue<String>('operacao');
  jsonObject.RemovePair('operacao');

  if CompareStr(AEventName,'produto_change_event') = 0 then
  begin
    var lProdutoPG := TProdutoPG.New.JsonToObject(jsonObject.ToJSON);
    var lProduto := TProduto.New;
    lProduto.idprodutointegracao := lProdutoPG.produtoid;
    lProduto.nomeproduto := lProdutoPG.nome_produto;
    lProduto.idroteiroproducao := lProdutoPG.roteiroproducaoid;

    if lOperacao.Equals('UPDATE') then
    begin
      try
        lResp := TRequest.New.BaseURL(FArquivo.ReadString(SERVER,'SERVIDOR', '')+'/server-app/produto')
        .AddBody(lProduto.ToJSON.ToJSON).Put;
        GerarLog('Replicado com sucesso: '+ lResp.StatusCode.ToString);
      except on e: Exception do
        GerarLog('Erro no evento: '+ AEventName + ', JSON: '+jsonObject.ToJSON+', mensagem excepton: ' + e.Message);
      end;
    end
    else if lOperacao.Equals('INSERT') then
    begin
      try
        lResp := TRequest.New.BaseURL(FArquivo.ReadString(SERVER,'SERVIDOR', '')+'/server-app/produto')
          .AddBody(lProduto.ToJSON.ToJSON).Post;
        GerarLog('Replicado com sucesso: '+ lResp.StatusCode.ToString);
      except on e: Exception do
        GerarLog('Erro no evento: '+ AEventName + ', JSON: '+jsonObject.ToJSON+', mensagem excepton: ' + e.Message);
      end;
    end;
  end
  else
  if CompareStr(AEventName,'setorproducao_change_event') = 0 then
  begin
    var lSetorProducao := TSetorProducao.New.JsonToObject(jsonObject.ToJSON);
    var lSetor := TSetor.NEw;
    lSetor.nomesetor := lSetorProducao.desc_setorproducao;
    lSetor.idsetorintegracao := lSetorProducao.setorproducaoid;

    if lOperacao.Equals('UPDATE') then
    begin
      try
        lResp := TRequest.New.BaseURL(FArquivo.ReadString(SERVER,'SERVIDOR', '')+'/server-app/setor')
        .AddBody(lSetor.ToJSON.ToJSON).Put;
        GerarLog('Replicado com sucesso: '+ lResp.StatusCode.ToString);
      except on e: Exception do
        GerarLog('Erro no evento: '+ AEventName + ', JSON: '+jsonObject.ToJSON+', mensagem excepton: ' + e.Message);
      end;
    end
    else if lOperacao.Equals('INSERT') then
    begin
      try
        lResp := TRequest.New.BaseURL(FArquivo.ReadString(SERVER,'SERVIDOR', '')+'/server-app/setor')
          .AddBody(lSetor.ToJSON.ToJSON).Post;
        GerarLog('Replicado com sucesso: '+ lResp.StatusCode.ToString);
      except on e: exception do
        GerarLog('Erro no evento: '+ AEventName + ', JSON: '+jsonObject.ToJSON+', mensagem excepton: ' + e.Message);
      end;
    end;
  end
  else
  if CompareStr(AEventName,'centro_trabalho_change_event') = 0 then
  begin
    var lCentroTrabalho := TCentroTrabalho.New.JsonToObject(jsonObject.ToJSON);
    var lProcess := TProcess.New;
    lProcess.idprocessintegracao := lCentroTrabalho.centrotrabalhoid;
    lProcess.nameprocess := lCentroTrabalho.nome_centro_trabalho;
    lProcess.obs := lCentroTrabalho.obs_centro_trabalho;
    lProcess.idsetor := lCentroTrabalho.setorproducaoid;
    lProcess.status := lCentroTrabalho.status;

    if lOperacao.Equals('UPDATE') then
    begin
      try
        lResp := TRequest.New.BaseURL(FArquivo.ReadString(SERVER,'SERVIDOR', '')+'/server-app/process')
          .AddBody(lProcess.ToJSON.ToJSON).Put;
        GerarLog('Replicado com sucesso: '+ lResp.StatusCode.ToString);
      except on e: exception do
        GerarLog('Erro no evento: '+ AEventName + ', JSON: '+jsonObject.ToJSON+', mensagem excepton: ' + e.Message);
      end;
    end
    else if lOperacao.Equals('INSERT') then
    begin
      try
        lResp := TRequest.New.BaseURL(FArquivo.ReadString(SERVER,'SERVIDOR', '')+'/server-app/process')
          .AddBody(lProcess.ToJSON.ToJSON).Post;
        GerarLog('Replicado com sucesso: '+ lResp.StatusCode.ToString);
      except on e: exception do
        GerarLog('Erro no evento: '+ AEventName + ', JSON: '+jsonObject.ToJSON+', mensagem excepton: ' + e.Message);
      end;
    end;
  end
  else
  if CompareStr(AEventName,'roteiro_producao_change_event') = 0 then
  begin
    var lRoteiroProducaoPG := TRoteiroProducaoPG.New.JsonToObject(jsonObject.ToJSON);
    var lRoteiroProducao := TRoteiroProducao.New;
    lRoteiroProducao.roteiroName := lRoteiroProducaoPG.nome_roteiro;
    lRoteiroProducao.idroteiroproducaointegracao := lRoteiroProducaoPG.roteiroproducaoid;
    lRoteiroProducao.obs := lRoteiroProducaoPG.obs_roteiro;

    if lOperacao.Equals('UPDATE') then
    begin
      try
        lResp := TRequest.New.BaseURL(FArquivo.ReadString(SERVER,'SERVIDOR', '')+'/server-app/roteiro-producao')
          .AddBody(lRoteiroProducao.ToJSON.ToJSON).Put;
        GerarLog('Replicado com sucesso: '+ lResp.StatusCode.ToString);
      except on e: exception do
        GerarLog('Erro no evento: '+ AEventName + ', JSON: '+jsonObject.ToJSON+', mensagem excepton: ' + e.Message);
      end;
    end
    else if lOperacao.Equals('INSERT') then
    begin
      try
        lResp := TRequest.New.BaseURL(FArquivo.ReadString(SERVER,'SERVIDOR', '')+'/server-app/roteiro-producao')
          .AddBody(lRoteiroProducao.ToJSON.ToJSON).Post;
        GerarLog('Replicado com sucesso: '+ lResp.StatusCode.ToString);
      except on e: exception do
        GerarLog('Erro no evento: '+ AEventName + ', JSON: '+jsonObject.ToJSON+', mensagem excepton: ' + e.Message);
      end;
    end;
  end
  else
  if CompareStr(AEventName,'roteiro_producao_item_change_event') = 0 then
  begin
    var lRoteiroProducaoItemPG := TRoteiroProducaoItemPG.New.JsonToObject(jsonObject.ToJSON);
    var lRoteiroProducaoItem := TRoteiroProducaoItem.New;
    lRoteiroProducaoItem.idroteiroproducaoitemintegracao := lRoteiroProducaoItemPG.roteiroproducaoitemid;
    lRoteiroProducaoItem.sequencingorder := lRoteiroProducaoItemPG.ordem;
    lRoteiroProducaoItem.idroteiroproducao := lRoteiroProducaoItemPG.roteiroproducaoid;
    lRoteiroProducaoItem.idprocess := lRoteiroProducaoItemPG.centrotrabalhoid;

    if lOperacao.Equals('UPDATE') then
    begin
      try
        lResp := TRequest.New.BaseURL(FArquivo.ReadString(SERVER,'SERVIDOR', '')+'/server-app/roteiro-producao')
          .AddBody(lRoteiroProducaoItem.ToJSON.ToJSON).Put;
        GerarLog('Replicado com sucesso: '+ lResp.StatusCode.ToString);
      except on e: exception do
        GerarLog('Erro no evento: '+ AEventName + ', JSON: '+jsonObject.ToJSON+', mensagem excepton: ' + e.Message);
      end;
    end
    else if lOperacao.Equals('INSERT') then
    begin
      try
        lResp := TRequest.New.BaseURL(FArquivo.ReadString(SERVER,'SERVIDOR', '')+'/server-app/roteiro-producao')
        .AddBody(lRoteiroProducaoItem.ToJSON.ToJSON).Post;
        GerarLog('Replicado com sucesso: '+ lResp.StatusCode.ToString);
      except on e: exception do
        GerarLog('Erro no evento: '+ AEventName + ', JSON: '+jsonObject.ToJSON+', mensagem excepton: ' + e.Message);
      end;
    end;
  end
  else
  if CompareStr(AEventName,'ordemproducaoitem_change_event') = 0 then
  begin
    var lOrdemProducaoItem := TOrdemProducaoItem.New.JsonToObject(jsonObject.ToJSON);
    var lServiceOrder := TServiceOrder.New;
    lServiceOrder.datacriacao := lOrdemProducaoItem.dt_orprod;
    lServiceOrder.numero := lOrdemProducaoItem.ordemproducaoitemid.ToString;
    lServiceOrder.status := lOrdemProducaoItem.status_ordemproducao_item;
    lServiceOrder.quantidade := lOrdemProducaoItem.qt_op_item;
    lServiceOrder.dataentrega := lOrdemProducaoItem.dt_entga_ordprod;
    lServiceOrder.sequencingorder := lOrdemProducaoItem.ordem;
    lServiceOrder.description := lOrdemProducaoItem.ds_estrutura_op_item;
    lServiceOrder.idserviceorderintegracao := lOrdemProducaoItem.ordemproducaoitemid;
    lServiceOrder.idproduto := lOrdemProducaoItem.produtoid;

    if lOperacao.Equals('UPDATE') then
    begin
      try
        lresp := TRequest.New.BaseURL(FArquivo.ReadString(SERVER,'SERVIDOR', '')+'/server-app/service-order')
        .AddBody(lServiceOrder.ToJSON.ToJSON).Put;
        GerarLog('Replicado com sucesso: '+ lResp.StatusCode.ToString);
      except on e: exception do
        GerarLog('Erro no evento: '+ AEventName + ', JSON: '+jsonObject.ToJSON+', mensagem excepton: ' + e.Message);
      end;
    end
    else if lOperacao.Equals('INSERT') then
    begin
      try
        lResp := TRequest.New.BaseURL(FArquivo.ReadString(SERVER,'SERVIDOR', '')+'/server-app/service-order')
        .AddBody(lServiceOrder.ToJSON.ToJSON).Post;
        GerarLog('Replicado com sucesso: '+ lResp.StatusCode.ToString);
      except on e: exception do
        GerarLog('Erro no evento: '+ AEventName + ', JSON: '+jsonObject.ToJSON+', mensagem excepton: ' + e.Message);
      end;
    end;
  end;
end;

procedure TDataModule1.GerarLog(Value: String);
var
  lArq: TextFile;
begin
  var lCaminho := ExtractFilePath(Application.ExeName)+'log.txt';
  AssignFile(lArq, lCaminho);
  if not FileExists(lCaminho) then
    Rewrite(lArq,lCaminho);
  Append(larq);
  Writeln(lArq, Value);
  Writeln(lArq, '');
  CloseFile(lArq);
end;

end.
