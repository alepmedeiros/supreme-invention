program client;

uses
  Vcl.Forms,
  replication.client in 'replication.client.pas' {Form1},
  replication.client.resources.interfaces in 'src\resources\replication.client.resources.interfaces.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
