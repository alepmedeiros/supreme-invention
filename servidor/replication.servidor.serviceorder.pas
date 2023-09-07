unit replication.servidor.serviceorder;

interface

uses
  replication.servidor.dados,
  replication.servidor.serializable.transformexpression,
  GBJSON.Interfaces;

type
  TServiceOrder = class
  private
    FDados: TdmDados;
    FJSON: String;
    FTransf: TTransformexpression;

    constructor Create(aDado: TDMDados; JSON: string);
  public
    class function New(aDado: TDMDados; JSON: String): TServiceOrder;
    function Insert: TServiceOrder;
    function Update: TServiceOrder;
    function Delete: TServiceOrder;
  end;

implementation

uses
  System.SysUtils;

constructor TServiceOrder.Create(aDado: TDMDados; JSON: string);
begin
  FDados := aDado;
  FTransf := TGBJSONDefault.Serializer<TTransformExpression>.JsonStringToObject(JSON) ;
end;

function TServiceOrder.Delete: TServiceOrder;
begin
  Result := Self;
  try
    if not FTransf.tipoacao.Equals('D') then
      Exit;

    FDados.FDQuery2.Close;
    FDados.FDQuery2.SQL.Clear;
    FDados.FDQuery2.SQL.Add('delete from airammes.Service_Order where idService_Order_Integracao = :idService_Order_Integracao');
    FDados.FDQuery2.ParamByName('idService_Order_Integracao').AsInteger := FTransf.ordemproducaoitemid;
    FDados.FDQuery2.ExecSQL;
  except
    raise Exception.Create('Erro ao tentar excluir o registro');
  end;
end;

function TServiceOrder.Insert: TServiceOrder;
begin
  Result := Self;
  try
    if not FTransf.tipoacao.Equals('I') then
      Exit;

    FDados.FDQuery2.Close;
    FDados.FDQuery2.SQL.Clear;
    FDados.FDQuery2.SQL.Add('INSERT INTO airammes.Service_Order (Data_Criacao,Numero,Status,Quantidade,DataEntrega,sequencing_Order,Description,idService_Order_Integracao,idProduto) ');
    FDados.FDQuery2.SQL.Add('VALUES (:Data_Criacao,:Numero,:Status,:Quantidade,:DataEntrega,:sequencing_Order,:Description,:idService_Order_Integracao,:idProduto)');
    FDados.FDQuery2.ParamByName('Data_Criacao').AsDateTime := FTransf.dt_orprod;
    FDados.FDQuery2.ParamByName('Numero').AsString := FTransf.ordemproducaoitemid.ToString;
    FDados.FDQuery2.ParamByName('Status').AsString := FTransf.status;
    FDados.FDQuery2.ParamByName('Quantidade').AsInteger := StrToInt(FTransf.qt_op_item.ToString);
    FDados.FDQuery2.ParamByName('DataEntrega').AsDateTime := FTransf.dt_entga_ordprod;
    FDados.FDQuery2.ParamByName('sequencing_Order').AsInteger := FTransf.ordem;
    FDados.FDQuery2.ParamByName('Description').AsString := FTransf.ds_estrutura_op_item;
    FDados.FDQuery2.ParamByName('idService_Order_Integracao').AsInteger := FTransf.ordemproducaoitemid;
    FDados.FDQuery2.ParamByName('idProduto').AsInteger := FTransf.produtoid;
    FDados.FDQuery2.ExecSQL;
  except
    raise Exception.Create('Erro ao tentar inserir os dados');
  end;
end;

class function TServiceOrder.New(aDado: TDMDados; JSON: String): TServiceOrder;
begin
  Result := Self.Create(aDado, JSON);
end;

function TServiceOrder.Update: TServiceOrder;
begin
  Result := self;
  try
    if not FTransf.tipoacao.Equals('U') then
      Exit;

    FDados.FDQuery1.Close;
    FDados.FDQuery1.SQL.Clear;
    FDados.FDQuery1.Open('select * from airammes.Service_Order where idService_Order_Integracao = ' + FTransf.ordemproducaoitemid.ToString);

    if FDados.FDQuery1.IsEmpty then
    begin
      FTransf.tipoacao := 'I';
      Self.Insert;
      exit;
    end;

    FDados.FDQuery2.Close;
    FDados.FDQuery2.SQL.Clear;
    FDados.FDQuery2.SQL.Add('UPDATE airammes.Service_Order SET Data_Criacao = :Data_Criacao,Numero=:Numero,Status=:Status,');
    FDados.FDQuery2.SQL.Add('Quantidade=:Quantidade,DataEntrega=:DataEntrega,sequencing_Order=:sequencing_Order,Description=:Description,idProduto=:idProduto');
    FDados.FDQuery2.SQL.Add(' where idService_Order_Integracao = :idService_Order_Integracao');
    FDados.FDQuery2.ParamByName('Data_Criacao').AsDateTime := FTransf.dt_orprod;
    FDados.FDQuery2.ParamByName('Numero').AsString := FTransf.ordemproducaoitemid.ToString;
    FDados.FDQuery2.ParamByName('Status').AsString := FTransf.status;
    FDados.FDQuery2.ParamByName('Quantidade').AsInteger := StrToInt(FTransf.qt_op_item.ToString);
    FDados.FDQuery2.ParamByName('DataEntrega').AsDateTime := FTransf.dt_entga_ordprod;
    FDados.FDQuery2.ParamByName('sequencing_Order').AsInteger := FTransf.ordem;
    FDados.FDQuery2.ParamByName('Description').AsString := FTransf.ds_estrutura_op_item;
    FDados.FDQuery2.ParamByName('idService_Order_Integracao').AsInteger := FTransf.ordemproducaoitemid;
    FDados.FDQuery2.ParamByName('idProduto').AsInteger := FTransf.produtoid;
    FDados.FDQuery2.ExecSQL;
  except
    raise Exception.Create('Erro ao tentar atualizar os dados');
  end;
end;

end.
