object Periodo: TPeriodo
  Left = 0
  Top = 0
  Width = 360
  Height = 52
  TabOrder = 0
  object Shape2: TShape
    Left = 191
    Top = 8
    Width = 163
    Height = 30
    Brush.Color = 16316664
    Pen.Color = 13283462
  end
  object Shape1: TShape
    Left = 8
    Top = 8
    Width = 162
    Height = 30
    Brush.Color = 16316664
    Pen.Color = 13283462
  end
  object Label1: TLabel
    Left = 14
    Top = 13
    Width = 30
    Height = 17
    Caption = 'In'#237'cio'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 198
    Top = 13
    Width = 20
    Height = 17
    Caption = 'Fim'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object dtpInicio: TDateTimePicker
    Left = 48
    Top = 8
    Width = 121
    Height = 29
    Date = 42677.000000000000000000
    Time = 42677.000000000000000000
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnChange = dtpInicioChange
  end
  object dtpFim: TDateTimePicker
    Left = 232
    Top = 8
    Width = 121
    Height = 29
    Date = 42677.999988425920000000
    Time = 42677.999988425920000000
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnChange = dtpInicioChange
  end
end
