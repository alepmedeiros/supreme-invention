unit replication.servidor.process;

interface

uses
  replication.servidor.dados,
  replication.servidor.serializable.transformexpression,
  GBJSON.Interfaces;

type
  TProcess = class
  private
    FDados: TdmDados;
    FJSON: String;
    FTransf: TTransformexpression;

    constructor Create(aDado: TDMDados; JSON: string);
  public
    class function New(aDado: TDMDados; JSON: String): TProcess;
    function Insert: TProcess;
    function Update: TProcess;
    function Delete: TProcess;
  end;

implementation

uses
  System.SysUtils;

constructor TProcess.Create(aDado: TDMDados; JSON: string);
begin
  FDados := aDado;
  FTransf := TGBJSONDefault.Serializer<TTransformExpression>.JsonStringToObject(JSON) ;
end;

function TProcess.Delete: TProcess;
begin
  Result := Self;
  try
    if not FTransf.tipoacao.Equals('D') then
      Exit;

    FDados.FDQuery2.Close;
    FDados.FDQuery2.SQL.Clear;
    FDados.FDQuery2.SQL.Add('delete from airammes.process where idProcess_Integracao = :idProcess_Integracao');
    FDados.FDQuery2.ParamByName('idProcess_Integracao').AsInteger := FTransf.centrotrabalhoid;
    FDados.FDQuery2.ExecSQL;
  except
    raise Exception.Create('Erro ao tentar excluir o registro');
  end;
end;

function TProcess.Insert: TProcess;
begin
  Result := Self;
  try
    if not FTransf.tipoacao.Equals('I') then
      Exit;

    FDados.FDQuery2.Close;
    FDados.FDQuery2.SQL.Clear;
    FDados.FDQuery2.SQL.Add('INSERT INTO airammes.process (idProcess_Integracao, NameProcess, Obs, idSetor, Status) VALUES (:idProcess_Integracao, :NameProcess, :Obs, :idSetor, :Status)');
    FDados.FDQuery2.ParamByName('idProcess_Integracao').AsInteger := FTransf.centrotrabalhoid;
    FDados.FDQuery2.ParamByName('NameProcess').AsString := FTransf.nomecentrotrabalho;
    FDados.FDQuery2.ParamByName('Obs').AsString := FTransf.obs_centro_trabalho;
    FDados.FDQuery2.ParamByName('idSetor').AsInteger := FTransf.setorproducaoid;
    FDados.FDQuery2.ParamByName('Status').AsString := FTransf.status;
    FDados.FDQuery2.ExecSQL;
  except
    raise Exception.Create('Erro ao tentar inserir os dados');
  end;
end;

class function TProcess.New(aDado: TDMDados; JSON: String): TProcess;
begin
  Result := Self.Create(aDado, JSON);
end;

function TProcess.Update: TProcess;
begin
  Result := self;
  try
    if not FTransf.tipoacao.Equals('U') then
      Exit;

    FDados.FDQuery1.Close;
    FDados.FDQuery1.SQL.Clear;
    FDados.FDQuery1.Open('select * from airammes.process where idProcess_Integracao = ' + FTransf.centrotrabalhoid.ToString);

    if FDados.FDQuery1.IsEmpty then
    begin
      FTransf.tipoacao := 'I';
      Self.Insert;
      exit;
    end;

    FDados.FDQuery2.Close;
    FDados.FDQuery2.SQL.Clear;
    FDados.FDQuery2.SQL.Add('UPDATE airammes.process SET NameProcess = :NameProcess, Obs = :Obs, idSetor = :idSetor, Status = :Status where idProcess_Integracao = :idProcess_Integracao');
    FDados.FDQuery2.ParamByName('NameProcess').AsString := FTransf.nomecentrotrabalho;
    FDados.FDQuery2.ParamByName('Obs').AsString := FTransf.obs_centro_trabalho;
    FDados.FDQuery2.ParamByName('idSetor').AsInteger := FTransf.setorproducaoid;
    FDados.FDQuery2.ParamByName('Status').AsString := FTransf.status;
    FDados.FDQuery2.ParamByName('idProcess_Integracao').AsInteger := FTransf.centrotrabalhoid;
    FDados.FDQuery2.ExecSQL;
  except
    raise Exception.Create('Erro ao tentar atualizar os dados');
  end;
end;

end.
