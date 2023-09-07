unit replication.servidor.setor;

interface

uses
  replication.servidor.dados,
  replication.servidor.serializable.transformexpression,
  GBJSON.Interfaces;

type
  TSetor = class
  private
    FDados: TdmDados;
    FJSON: String;
    FTransf: TTransformexpression;

    constructor Create(aDado: TDMDados; JSON: string);
  public
    class function New(aDado: TDMDados; JSON: String): TSetor;
    function Insert: TSetor;
    function Update: TSetor;
    function Delete: TSetor;
  end;

implementation

uses
  System.SysUtils;

constructor TSetor.Create(aDado: TDMDados; JSON: string);
begin
  FDados := aDado;
  FTransf := TGBJSONDefault.Serializer<TTransformExpression>.JsonStringToObject(JSON) ;
end;

function TSetor.Delete: TSetor;
begin
  Result := Self;
  try
    if not FTransf.tipoacao.Equals('D') then
      Exit;

    FDados.FDQuery2.Close;
    FDados.FDQuery2.SQL.Clear;
    FDados.FDQuery2.SQL.Add('delete from airammes.setor where idSetor_Integracao = :idSetor_Integracao');
    FDados.FDQuery2.ParamByName('idSetor_Integracao').AsInteger := FTransf.setorproducaoid;
    FDados.FDQuery2.ExecSQL;
  except
    raise Exception.Create('Erro ao tentar excluir o registro');
  end;
end;

function TSetor.Insert: TSetor;
begin
  Result := Self;
  try
    if not FTransf.tipoacao.Equals('I') then
      Exit;

    FDados.FDQuery2.Close;
    FDados.FDQuery2.SQL.Clear;
    FDados.FDQuery2.SQL.Add('INSERT INTO airammes.setor (NomeSetor, idSetor_Integracao) VALUES (:NomeSetor, :idSetor_Integracao)');
    FDados.FDQuery2.ParamByName('NomeSetor').AsString := FTransf.descsetorproducao;
    FDados.FDQuery2.ParamByName('idSetor_Integracao').AsInteger := FTransf.setorproducaoid;
    FDados.FDQuery2.ExecSQL;
  except
    raise Exception.Create('Erro ao tentar inserir os dados');
  end;
end;

class function TSetor.New(aDado: TDMDados; JSON: String): TSetor;
begin
  Result := Self.Create(aDado, JSON);
end;

function TSetor.Update: TSetor;
begin
  Result := self;
  try
    if not FTransf.tipoacao.Equals('U') then
      Exit;

    FDados.FDQuery1.Close;
    FDados.FDQuery1.SQL.Clear;
    FDados.FDQuery1.Open('select * from airammes.setor where idSetor_Integracao = ' + FTransf.setorproducaoid.ToString);

    if FDados.FDQuery1.IsEmpty then
    begin
      FTransf.tipoacao := 'I';
      Self.Insert;
      exit;
    end;

    FDados.FDQuery2.Close;
    FDados.FDQuery2.SQL.Clear;
    FDados.FDQuery2.SQL.Add('UPDATE airammes.setor SET NomeSetor = :NomeSetor where idSetor_Integracao = :idSetor_Integracao');
    FDados.FDQuery2.ParamByName('NomeSetor').AsString := FTransf.descsetorproducao;
    FDados.FDQuery2.ParamByName('idSetor_Integracao').AsInteger := FTransf.setorproducaoid;
    FDados.FDQuery2.ExecSQL;
  except
    raise Exception.Create('Erro ao tentar atualizar os dados');
  end;
end;

end.
