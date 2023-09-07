unit replication.servidor.roteiroproducaoitem;

interface

uses
  replication.servidor.dados,
  replication.servidor.serializable.transformexpression,
  GBJSON.Interfaces;

type
  TRoteiro_producao_item = class
  private
    FDados: TdmDados;
    FJSON: String;
    FTransf: TTransformexpression;

    constructor Create(aDado: TDMDados; JSON: string);
  public
    class function New(aDado: TDMDados; JSON: String): TRoteiro_producao_item;
    function Insert: TRoteiro_producao_item;
    function Update: TRoteiro_producao_item;
    function Delete: TRoteiro_producao_item;
  end;

implementation

uses
  System.SysUtils;

constructor TRoteiro_producao_item.Create(aDado: TDMDados; JSON: string);
begin
  FDados := aDado;
  FTransf := TGBJSONDefault.Serializer<TTransformExpression>.JsonStringToObject(JSON) ;
end;

function TRoteiro_producao_item.Delete: TRoteiro_producao_item;
begin
  Result := Self;
  try
    if not FTransf.tipoacao.Equals('D') then
      Exit;

    FDados.FDQuery2.Close;
    FDados.FDQuery2.SQL.Clear;
    FDados.FDQuery2.SQL.Add('delete from airammes.Roteiro_producao_item where idRoteiro_Producao_Item_Integracao = :idRoteiro_Producao_Item_Integracao');
    FDados.FDQuery2.ParamByName('idRoteiro_Producao_Item_Integracao').AsInteger := FTransf.roteiroproducaoitemid;
    FDados.FDQuery2.ExecSQL;
  except
    raise Exception.Create('Erro ao tentar excluir o registro');
  end;
end;

function TRoteiro_producao_item.Insert: TRoteiro_producao_item;
begin
  Result := Self;
  try
    if not FTransf.tipoacao.Equals('I') then
      Exit;

    FDados.FDQuery2.Close;
    FDados.FDQuery2.SQL.Clear;
    FDados.FDQuery2.SQL.Add('INSERT INTO airammes.Roteiro_producao_item (idRoteiro_Producao_Item_Integracao, Sequencing_Order, idRoteiro_Producao, idProcess) VALUES (:idRoteiro_Producao_Item_Integracao, :Sequencing_Order, :idRoteiro_Producao, :idProcess)');
    FDados.FDQuery2.ParamByName('idRoteiro_Producao_Item_Integracao').AsInteger := FTransf.roteiroproducaoitemid;
    FDados.FDQuery2.ParamByName('Sequencing_Order').AsInteger := FTransf.ordem;
    FDados.FDQuery2.ParamByName('idRoteiro_Producao').AsInteger := FTransf.roteiroproducaoid;
    FDados.FDQuery2.ParamByName('idProcess').AsInteger := FTransf.centrotrabalhoid;
    FDados.FDQuery2.ExecSQL;
  except
    raise Exception.Create('Erro ao tentar inserir os dados');
  end;
end;

class function TRoteiro_producao_item.New(aDado: TDMDados; JSON: String): TRoteiro_producao_item;
begin
  Result := Self.Create(aDado, JSON);
end;

function TRoteiro_producao_item.Update: TRoteiro_producao_item;
begin
  Result := self;
  try
    if not FTransf.tipoacao.Equals('U') then
      Exit;

    FDados.FDQuery1.Close;
    FDados.FDQuery1.SQL.Clear;
    FDados.FDQuery1.Open('select * from airammes.Roteiro_producao_item where idRoteiro_Producao_Item_Integracao = ' + FTransf.roteiroproducaoitemid.ToString);

    if FDados.FDQuery1.IsEmpty then
    begin
      FTransf.tipoacao := 'I';
      Self.Insert;
      exit;
    end;

    FDados.FDQuery2.Close;
    FDados.FDQuery2.SQL.Clear;
    FDados.FDQuery2.SQL.Add('UPDATE airammes.Roteiro_Producao SET Sequencing_Order = :Sequencing_Order, idRoteiro_Producao = :idRoteiro_Producao, idProcess = :idProcess where idRoteiro_Producao_Item_Integracao = :idRoteiro_Producao_Item_Integracao');
    FDados.FDQuery2.ParamByName('Sequencing_Order').AsInteger := FTransf.ordem;
    FDados.FDQuery2.ParamByName('idRoteiro_Producao').AsInteger := FTransf.roteiroproducaoid;
    FDados.FDQuery2.ParamByName('idProcess').AsInteger := FTransf.centrotrabalhoid;
    FDados.FDQuery2.ParamByName('idRoteiro_Producao_Integracao').AsInteger := FTransf.roteiroproducaoitemid;
    FDados.FDQuery2.ExecSQL;
  except
    raise Exception.Create('Erro ao tentar atualizar os dados');
  end;
end;

end.
