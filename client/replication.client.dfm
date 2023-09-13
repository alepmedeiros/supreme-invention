object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 472
  ClientWidth = 548
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnShow = FormShow
  TextHeight = 21
  object Panel1: TPanel
    Left = 0
    Top = 279
    Width = 548
    Height = 193
    Align = alClient
    BevelOuter = bvNone
    Padding.Left = 10
    Padding.Top = 10
    Padding.Right = 10
    Padding.Bottom = 10
    TabOrder = 0
    object MemoEventos: TMemo
      AlignWithMargins = True
      Left = 10
      Top = 60
      Width = 528
      Height = 123
      Margins.Left = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alClient
      BorderStyle = bsNone
      TabOrder = 0
    end
    object Panel3: TPanel
      Left = 10
      Top = 10
      Width = 528
      Height = 47
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object Label1: TLabel
        Left = 0
        Top = 0
        Width = 528
        Height = 21
        Align = alTop
        Caption = 'Events'
        ExplicitWidth = 45
      end
      object edtEventos: TEdit
        Left = 0
        Top = 21
        Width = 528
        Height = 26
        Align = alClient
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        TabOrder = 0
        OnKeyPress = edtEventosKeyPress
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 548
    Height = 279
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object Button1: TButton
      Left = 10
      Top = 8
      Width = 75
      Height = 29
      Caption = 'Start'
      TabOrder = 0
      OnClick = Button1Click
    end
    object edtDriverId: TLabeledEdit
      Left = 10
      Top = 67
      Width = 119
      Height = 29
      BorderStyle = bsNone
      EditLabel.Width = 58
      EditLabel.Height = 21
      EditLabel.Caption = 'DriverID'
      TabOrder = 1
      Text = ''
    end
    object edtUserName: TLabeledEdit
      Left = 248
      Top = 126
      Width = 138
      Height = 29
      BorderStyle = bsNone
      EditLabel.Width = 74
      EditLabel.Height = 21
      EditLabel.Caption = 'UserName'
      TabOrder = 2
      Text = ''
    end
    object edtPassword: TLabeledEdit
      Left = 392
      Top = 126
      Width = 146
      Height = 29
      BorderStyle = bsNone
      EditLabel.Width = 66
      EditLabel.Height = 21
      EditLabel.Caption = 'Password'
      TabOrder = 3
      Text = ''
    end
    object edtDataBase: TLabeledEdit
      Left = 10
      Top = 126
      Width = 232
      Height = 29
      BorderStyle = bsNone
      EditLabel.Width = 64
      EditLabel.Height = 21
      EditLabel.Caption = 'DataBase'
      TabOrder = 4
      Text = ''
    end
    object edtServidor: TLabeledEdit
      Left = 135
      Top = 67
      Width = 119
      Height = 29
      BorderStyle = bsNone
      EditLabel.Width = 59
      EditLabel.Height = 21
      EditLabel.Caption = 'Servidor'
      TabOrder = 5
      Text = ''
    end
    object edtPorta: TLabeledEdit
      Left = 260
      Top = 67
      Width = 85
      Height = 29
      BorderStyle = bsNone
      EditLabel.Width = 36
      EditLabel.Height = 21
      EditLabel.Caption = 'Porta'
      TabOrder = 6
      Text = ''
    end
    object edtLibrary: TLabeledEdit
      Left = 10
      Top = 182
      Width = 528
      Height = 29
      BorderStyle = bsNone
      EditLabel.Width = 49
      EditLabel.Height = 21
      EditLabel.Caption = 'Library'
      Enabled = False
      TabOrder = 7
      Text = ''
    end
    object edtServidorReplicacao: TLabeledEdit
      Left = 10
      Top = 244
      Width = 528
      Height = 29
      BorderStyle = bsNone
      EditLabel.Width = 137
      EditLabel.Height = 21
      EditLabel.Caption = 'Servidor Replica'#231#227'o'
      TabOrder = 8
      Text = ''
    end
    object Button2: TButton
      Left = 91
      Top = 8
      Width = 126
      Height = 29
      Caption = 'Save Config'
      TabOrder = 9
    end
  end
  object TrayIcon1: TTrayIcon
    Animate = True
    BalloonHint = 'Este '#233' um aplicativo de replica'#231#227'o de dados'
    BalloonTitle = 'Agente Executando'
    BalloonFlags = bfInfo
    PopupMenu = PopupMenu1
    Visible = True
    Left = 264
    Top = 264
  end
  object PopupMenu1: TPopupMenu
    Left = 344
    Top = 264
    object Fechar1: TMenuItem
      Caption = 'Fechar'
      OnClick = Fechar1Click
    end
    object Abrir1: TMenuItem
      Caption = 'Abrir'
      OnClick = Abrir1Click
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 416
    Top = 232
  end
end
