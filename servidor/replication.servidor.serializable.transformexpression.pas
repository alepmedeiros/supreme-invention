unit replication.servidor.serializable.transformexpression;

interface

uses
  GBJSON.Attributes;

type
  TTransformExpression = class
  private
    Fsetorproducaoid: Integer;
    Ftabeladestino: String;
    Fds_estrutura_op_item: String;
    Fnomecentrotrabalho: string;
    Froteiroproducaoid: Integer;
    Ftabelaorigem: String;
    Fdescsetorproducao: String;
    Fqt_op_item: Double;
    Fnome_produto: String;
    Fprodutoid: Integer;
    Fid: Integer;
    Freferencia_roteiro: String;
    Fnome_roteiro: String;
    Fstatus: String;
    Fordemproducaoitemid: Integer;
    Fobs_centro_trabalho: String;
    Fdt_cadastro: TDateTime;
    Fcentrotrabalhoid: Integer;
    Fdt_orprod: TDateTime;
    Froteiroproducaoitemid: Integer;
    Fobs_roteiro: String;
    Fdataop: TDateTime;
    Ftipoacao: String;
    Fordem: Integer;
    Fstatus_ordemproducao_item: String;
    Fdt_entga_ordprod: TDateTime;
  public
    property id: Integer read Fid write Fid;
    property tabelaorigem: String read Ftabelaorigem write Ftabelaorigem;
    property tabeladestino: String read Ftabeladestino write Ftabeladestino;
    property setorproducaoid: Integer read Fsetorproducaoid write Fsetorproducaoid;
    property descsetorproducao: String read Fdescsetorproducao write Fdescsetorproducao;
    property centrotrabalhoid: Integer read Fcentrotrabalhoid write Fcentrotrabalhoid;
    property nomecentrotrabalho: string read Fnomecentrotrabalho write Fnomecentrotrabalho;
    property obs_centro_trabalho: String read Fobs_centro_trabalho write Fobs_centro_trabalho;
    property status: String read Fstatus write Fstatus;
    property roteiroproducaoid: Integer read Froteiroproducaoid write Froteiroproducaoid;
    property nome_roteiro: String read Fnome_roteiro write Fnome_roteiro;
    property referencia_roteiro: String read Freferencia_roteiro write Freferencia_roteiro;
    property obs_roteiro: String read Fobs_roteiro write Fobs_roteiro;
    property roteiroproducaoitemid: Integer read Froteiroproducaoitemid write Froteiroproducaoitemid;
    property ordem: Integer read Fordem write Fordem;
    property dt_cadastro: TDateTime read Fdt_cadastro write Fdt_cadastro;
    property produtoid: Integer read Fprodutoid write Fprodutoid;
    property nome_produto: String read Fnome_produto write Fnome_produto;
    property ordemproducaoitemid: Integer read Fordemproducaoitemid write Fordemproducaoitemid;
    property qt_op_item: Double read Fqt_op_item write Fqt_op_item;
    property dt_orprod: TDateTime read Fdt_orprod write Fdt_orprod;
    property dt_entga_ordprod: TDateTime read Fdt_entga_ordprod write Fdt_entga_ordprod;
    property ds_estrutura_op_item: String read Fds_estrutura_op_item write Fds_estrutura_op_item;
    property status_ordemproducao_item: String read Fstatus_ordemproducao_item write Fstatus_ordemproducao_item;
    property tipoacao: String read Ftipoacao write Ftipoacao;
    property dataop: TDateTime read Fdataop write Fdataop;

    class function New: TTransformExpression;
  end;

implementation

{ TTransformExpression }

class function TTransformExpression.New: TTransformExpression;
begin
  Result := Self.Create;
end;

end.
