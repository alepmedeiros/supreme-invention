unit replication.servidor.produto;

interface

uses
  replication.servidor.dados,
  replication.servidor.serializable.transformexpression,
  GBJSON.Interfaces;

type
  TProduto = class
  private
    FDados: TdmDados;
    FJSON: String;
    FTransf: TTransformexpression;

    constructor Create(aDado: TDMDados; JSON: string);
  public
    class function New(aDado: TDMDados; JSON: String): TProduto;
    function Insert: TProduto;
    function Update: TProduto;
    function Delete: TProduto;
  end;

implementation

uses
  System.SysUtils;

constructor TProduto.Create(aDado: TDMDados; JSON: string);
begin
  FDados := aDado;
  FTransf := TGBJSONDefault.Serializer<TTransformExpression>.JsonStringToObject(JSON) ;
end;

function TProduto.Delete: TProduto;
begin
  Result := Self;
  try
    if not FTransf.tipoacao.Equals('D') then
      Exit;

    FDados.FDQuery2.Close;
    FDados.FDQuery2.SQL.Clear;
    FDados.FDQuery2.SQL.Add('delete from airammes.produto where idProduto_Integracao = :idProduto_Integracao');
    FDados.FDQuery2.ParamByName('idProduto_Integracao').AsInteger := FTransf.produtoid;
    FDados.FDQuery2.ExecSQL;
  except
    raise Exception.Create('Erro ao tentar excluir o registro');
  end;
end;

function TProduto.Insert: TProduto;
begin
  Result := Self;
  try
    if not FTransf.tipoacao.Equals('I') then
      Exit;

    FDados.FDQuery2.Close;
    FDados.FDQuery2.SQL.Clear;
    FDados.FDQuery2.SQL.Add('INSERT INTO airammes.PRODUTO (idProduto_Integracao, NomeProduto, idRoteiro_Producao) VALUES (:idProduto_Integracao, :NomeProduto, :idRoteiro_Producao)');
    FDados.FDQuery2.ParamByName('idProduto_Integracao').AsInteger := FTransf.produtoid;
    FDados.FDQuery2.ParamByName('NomeProduto').AsString := FTransf.nome_produto;
    FDados.FDQuery2.ParamByName('idRoteiro_Producao').AsInteger := FTransf.roteiroproducaoid;
    FDados.FDQuery2.ExecSQL;
  except
    raise Exception.Create('Erro ao tentar inserir os dados');
  end;
end;

class function TProduto.New(aDado: TDMDados; JSON: String): TProduto;
begin
  Result := Self.Create(aDado, JSON);
end;

function TProduto.Update: TProduto;
begin
  Result := self;
  try
    if not FTransf.tipoacao.Equals('U') then
      Exit;

    FDados.FDQuery1.Close;
    FDados.FDQuery1.SQL.Clear;
    FDados.FDQuery1.Open('select * from airammes.produto where idProduto_Integracao = ' + FTransf.produtoid.ToString);

    if FDados.FDQuery1.IsEmpty then
    begin
      FTransf.tipoacao := 'I';
      Self.Insert;
      exit;
    end;

    FDados.FDQuery2.Close;
    FDados.FDQuery2.SQL.Clear;
    FDados.FDQuery2.SQL.Add('UPDATE airammes.produto SET NomeProduto = :NomeProduto, idRoteiro_Producao = :idRoteiro_Producao where idProduto_Integracao = :idProduto_Integracao');
    FDados.FDQuery2.ParamByName('NomeProduto').AsString := FTransf.nome_produto;
    FDados.FDQuery2.ParamByName('idRoteiro_Producao').AsInteger := FTransf.roteiroproducaoid;
    FDados.FDQuery2.ParamByName('idProduto_Integracao').AsInteger :=  FTransf.produtoid;
    FDados.FDQuery2.ExecSQL;
  except
    raise Exception.Create('Erro ao tentar atualizar os dados');
  end;
end;

end.
