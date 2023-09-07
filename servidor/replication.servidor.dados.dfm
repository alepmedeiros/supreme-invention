object dmDados: TdmDados
  OnCreate = DataModuleCreate
  Height = 161
  Width = 254
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=airammes'
      'User_Name=root'
      'Password=dev@admin#2020'
      'Server=localhost'
      'Port=3337'
      'DriverID=MySQL')
    LoginPrompt = False
    Left = 144
    Top = 24
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    Left = 48
    Top = 16
  end
  object FDQuery2: TFDQuery
    Connection = FDConnection1
    Left = 40
    Top = 80
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    Left = 136
    Top = 88
  end
end
