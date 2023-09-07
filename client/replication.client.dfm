object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 459
  ClientWidth = 587
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object Memo1: TMemo
    Left = 8
    Top = 144
    Width = 571
    Height = 307
    Lines.Strings = (
      'Memo1')
    TabOrder = 0
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=AWORKSDB'
      'User_Name=postgres'
      'Password=BURITISEVEN2023'
      'Server=192.168.0.10'
      'DriverID=PG')
    LoginPrompt = False
    Left = 48
    Top = 16
  end
  object FDEventAlerter1: TFDEventAlerter
    Connection = FDConnection1
    Names.Strings = (
      'transform_change_event')
    OnAlert = FDEventAlerter1Alert
    Left = 192
    Top = 16
  end
  object TrayIcon1: TTrayIcon
    Animate = True
    BalloonHint = 'Este '#233' um aplicativo de replica'#231#227'o de dados'
    BalloonTitle = 'Agente Executando'
    BalloonFlags = bfInfo
    PopupMenu = PopupMenu1
    Visible = True
    Left = 184
    Top = 72
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    Left = 264
    Top = 72
  end
  object PopupMenu1: TPopupMenu
    Left = 128
    Top = 16
    object Fechar1: TMenuItem
      Caption = 'Fechar'
    end
    object Abrir1: TMenuItem
      Caption = 'Abrir'
    end
  end
  object FDQuery2: TFDQuery
    Connection = FDConnection1
    Left = 376
    Top = 64
  end
  object FDPhysPgDriverLink1: TFDPhysPgDriverLink
    Left = 72
    Top = 80
  end
end
