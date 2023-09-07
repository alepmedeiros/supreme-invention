unit replication.servidor.roteiroproducao;

interface

uses
  replication.servidor.dados,
  replication.servidor.serializable.transformexpression,
  GBJSON.Interfaces;

type
  TRoteiro_Producao = class
  private
    FDados: TdmDados;
    FJSON: String;
    FTransf: TTransformexpression;

    constructor Create(aDado: TDMDados; JSON: string);
  public
    class function New(aDado: TDMDados; JSON: String): TRoteiro_Producao;
    function Insert: TRoteiro_Producao;
    function Update: TRoteiro_Producao;
    function Delete: TRoteiro_Producao;
  end;

implementation

uses
  System.SysUtils;

constructor TRoteiro_Producao.Create(aDado: TDMDados; JSON: string);
begin
  FDados := aDado;
  FTransf := TGBJSONDefault.Serializer<TTransformExpression>.JsonStringToObject(JSON) ;
end;

function TRoteiro_Producao.Delete: TRoteiro_Producao;
begin
  Result := Self;
  try
    if not FTransf.tipoacao.Equals('D') then
      Exit;

    FDados.FDQuery2.Close;
    FDados.FDQuery2.SQL.Clear;
    FDados.FDQuery2.SQL.Add('delete from airammes.Roteiro_Producao where idRoteiro_Producao_Integracao = :idRoteiro_Producao_Integracao');
    FDados.FDQuery2.ParamByName('idRoteiro_Producao_Integracao').AsInteger := FTransf.roteiroproducaoid;
    FDados.FDQuery2.ExecSQL;
  except
    raise Exception.Create('Erro ao tentar excluir o registro');
  end;
end;

function TRoteiro_Producao.Insert: TRoteiro_Producao;
begin
  Result := Self;
  try
    if not FTransf.tipoacao.Equals('I') then
      Exit;

    FDados.FDQuery2.Close;
    FDados.FDQuery2.SQL.Clear;
    FDados.FDQuery2.SQL.Add('INSERT INTO airammes.Roteiro_Producao (idRoteiro_Producao_Integracao, Roteiro_Name, Obs) VALUES (:idRoteiro_Producao_Integracao, :Roteiro_Name, :Obs)');
    FDados.FDQuery2.ParamByName('idRoteiro_Producao_Integracao').AsInteger := FTransf.roteiroproducaoid;
    FDados.FDQuery2.ParamByName('Roteiro_Name').AsString := FTransf.nome_roteiro;
    FDados.FDQuery2.ParamByName('Obs').AsString := FTransf.obs_roteiro;
    FDados.FDQuery2.ExecSQL;
  except
    raise Exception.Create('Erro ao tentar inserir os dados');
  end;
end;

class function TRoteiro_Producao.New(aDado: TDMDados; JSON: String): TRoteiro_Producao;
begin
  Result := Self.Create(aDado, JSON);
end;

function TRoteiro_Producao.Update: TRoteiro_Producao;
begin
  Result := self;
  try
    if not FTransf.tipoacao.Equals('U') then
      Exit;

    FDados.FDQuery1.Close;
    FDados.FDQuery1.SQL.Clear;
    FDados.FDQuery1.Open('select * from airammes.Roteiro_Producao where idRoteiro_Producao_Integracao = ' + FTransf.roteiroproducaoid.ToString);

    if FDados.FDQuery1.IsEmpty then
    begin
      FTransf.tipoacao := 'I';
      Self.Insert;
      exit;
    end;

    FDados.FDQuery2.Close;
    FDados.FDQuery2.SQL.Clear;
    FDados.FDQuery2.SQL.Add('UPDATE airammes.Roteiro_Producao SET Roteiro_Name = :Roteiro_Name, Obs = :Obs where idRoteiro_Producao_Integracao = :idRoteiro_Producao_Integracao');
    FDados.FDQuery2.ParamByName('Roteiro_Name').AsString := FTransf.nome_roteiro;
    FDados.FDQuery2.ParamByName('Obs').AsString := FTransf.obs_roteiro;
    FDados.FDQuery2.ParamByName('idRoteiro_Producao_Integracao').AsInteger := FTransf.roteiroproducaoid;
    FDados.FDQuery2.ExecSQL;
  except
    raise Exception.Create('Erro ao tentar atualizar os dados');
  end;
end;

end.
