object DataModule1: TDataModule1
  OnCreate = DataModuleCreate
  Height = 186
  Width = 330
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=AWORKSDB'
      'User_Name=postgres'
      'Password=BURITISEVEN2023'
      'Server=192.168.0.10'
      'DriverID=PG')
    LoginPrompt = False
    Left = 64
    Top = 24
  end
  object FDPhysPgDriverLink1: TFDPhysPgDriverLink
    Left = 64
    Top = 104
  end
  object FDEventAlerter1: TFDEventAlerter
    Connection = FDConnection1
    Names.Strings = (
      'produto_change_event'
      'setorproducao_change_event'
      'centro_trabalho_change_event'
      'roteiro_producao_change_event'
      'roteiro_producao_item_change_event'
      'ordemproducaoitem_change_event')
    OnAlert = FDEventAlerter1Alert
    Left = 200
    Top = 24
  end
end
