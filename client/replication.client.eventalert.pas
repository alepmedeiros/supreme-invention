unit replication.client.eventalert;

interface

uses
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
  replication.client.interfaces,
  System.Classes,
  System.Generics.Collections;

type
  TEventAlert = class(TInterfacedObject, iEventAlert)
  private
    FConn: TFDConnection;
    FEventAlerter: TFDEventAlerter;
    FConf: iConfiguracao;
    FNames: TStrings;
    FRetorno: TList<String>;

    procedure EventAlerter(ASender: TFDCustomEventAlerter;
      const AEventName: string; const AArgument: Variant);

    constructor Create(Conn: TCustomConnection);
    destructor Destroy; override;
  public
    class function New(Conn: TCustomConnection): iEventAlert;
    function Names(Value: TStrings): iEventAlert;
    function Alert: TList<String>;
  end;

implementation

uses
  System.Variants,
  System.StrUtils;

function TEventAlert.Alert: TList<String>;
begin
  FEventAlerter.OnAlert := EventAlerter;
  Result := FRetorno;
end;

constructor TEventAlert.Create(Conn: TCustomConnection);
begin
  FConn := TFDConnection(Conn);
  FEventAlerter:= TFDEventAlerter.Create(FConn);
end;

destructor TEventAlert.Destroy;
begin
  FConn.Free;
  inherited;
end;

procedure TEventAlert.EventAlerter(ASender: TFDCustomEventAlerter;
  const AEventName: string; const AArgument: Variant);
var
  i: Integer;
  sArgs: String;
begin
  FRetorno.Create;

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
  FRetorno.Add(lId[0]);
  FRetorno.Add(lId[1]);
end;

function TEventAlert.Names(Value: TStrings): iEventAlert;
begin
  Result := Self;
  FNames := Value;
end;

class function TEventAlert.New(Conn: TCustomConnection): iEventAlert;
begin
  Result := Self.Create(Conn);
end;

end.
