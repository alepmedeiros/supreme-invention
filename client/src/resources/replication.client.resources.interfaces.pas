unit replication.client.resources.interfaces;

interface

uses
  Data.DB;

type
  iConnection = interface
    function Connection: TCustomConnection;
  end;

  iAlert = interface

  end;

implementation

end.
