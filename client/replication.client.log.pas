unit replication.client.log;

interface

uses
  replication.client.interfaces;

type
  TLog = class(TInterfacedObject, iLog)
  private
    FArquivo: TextFile;

    constructor Create;
    destructor Destroy; override;
  public
    class function New: iLog;
    function Descricao(Value: String): iLog;
  end;

implementation

uses
  System.SysUtils;

constructor TLog.Create;
begin
  AssignFile(FArquivo, ExtractFilePath(ParamStr(0))+'.log');
  {$I-}
  Reset(FArquivo);
  {$I+}
  if not IOResult = 0 then
  begin
    Rewrite(FArquivo);
    Exit;
  end;

  CloseFile(FArquivo);
  Append(FArquivo);
end;

function TLog.Descricao(Value: String): iLog;
begin
  Result := Self;
  Writeln(FArquivo, '['+FormatDateTime('dd/mm/yyyy hh:mm:ss', Now)+'] - ' + Value);
end;

destructor TLog.Destroy;
begin
  CloseFile(FArquivo);
  inherited;
end;

class function TLog.New: iLog;
begin
  Result := Self.Create;
end;

end.

