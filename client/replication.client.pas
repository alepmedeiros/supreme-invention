unit replication.client;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.VCLUI.Wait,
  FireDAC.Comp.client,
  Data.DB,
  FireDAC.Phys.PG,
  FireDAC.Phys.PGDef,
  Vcl.ExtCtrls,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  FireDAC.Comp.DataSet,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Menus;

type
  TForm1 = class(TForm)
    FDConnection1: TFDConnection;
    FDEventAlerter1: TFDEventAlerter;
    TrayIcon1: TTrayIcon;
    FDQuery1: TFDQuery;
    PopupMenu1: TPopupMenu;
    Fechar1: TMenuItem;
    Abrir1: TMenuItem;
    Memo1: TMemo;
    FDQuery2: TFDQuery;
    FDPhysPgDriverLink1: TFDPhysPgDriverLink;
    procedure FormCreate(Sender: TObject);
    procedure FDEventAlerter1Alert(ASender: TFDCustomEventAlerter;
      const AEventName: string; const AArgument: Variant);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  RESTRequest4D,
  DataSet.Serialize,
  System.StrUtils;

{$R *.dfm}


procedure TForm1.FDEventAlerter1Alert(ASender: TFDCustomEventAlerter;
  const AEventName: string; const AArgument: Variant);
var
  i: Integer;
  sArgs: String;
begin
  Memo1.Clear;

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

  Memo1.Lines.Add('[' +AEventName+ '],[' +sArgs+ ']');

  var lId := SplitString(sArgs, ';');
  if CompareStr(AEventName,'transform_change_event') = 0 then
  begin
    FDQuery1.Close;
    FDQuery1.SQL.Clear;
    FDQuery1.Open('select * from transform_expression where id = ' + lId[1]);

    TDataSetSerializeConfig.GetInstance.CaseNameDefinition := TCaseNameDefinition.cndLower;

    var lResponse :=
    TRequest.New.BaseURL('http://localhost:9000/receber_dados')
      .Accept('application/json').AddBody(FDQuery1.ToJSONObject()).Post;

    Memo1.Lines.Add(lResponse.Content);
  end;

//  Memo1.Lines.Add('Event - [' + AEventName + '] - [' + sArgs + ']');
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FDPhysPgDriverLink1.VendorHome := EmptyStr;
  FDPhysPgDriverLink1.VendorLib := ExtractFilePath(Application.ExeName)+'libpq.dll';
  FDConnection1.Connected := true;
  FDEventAlerter1.Register;
end;


end.
