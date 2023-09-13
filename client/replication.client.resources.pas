unit replication.client.resources;

interface

type
  TNotifyEvent = (PRODUTO, SETOR, SERVICE_ORDER, ROTEIRO_PRODUCAO, ROTEIRO_PRODUCAO_ITEM,
                  PROCESS);

  TNotifyEventHelper = record helper for TNotifyEvent
    function ToString: string;
  end;

implementation

{ TNotifyEventHelper }

function TNotifyEventHelper.ToString: string;
begin
  case self of
    PRODUTO: Result := 'produto_change_event';
    SETOR: Result := 'setorproducao_change_event';
    SERVICE_ORDER: Result := 'ordemproducaoitem_change_event';
    ROTEIRO_PRODUCAO: Result := 'roteiro_producao_change_event';
    ROTEIRO_PRODUCAO_ITEM: Result := 'roteiro_producao_item_change_event';
    PROCESS: Result := 'centro_trabalho_change_event';
  end;
end;

end.
