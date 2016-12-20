object MaskCpfCnpj: TMaskCpfCnpj
  Left = 0
  Top = 0
  Width = 238
  Height = 58
  TabOrder = 0
  object Label19: TLabel
    Left = 100
    Top = -3
    Width = 11
    Height = 32
    Caption = '*'
    Font.Charset = ANSI_CHARSET
    Font.Color = 9010488
    Font.Height = -24
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object StaticText1: TStaticText
    Left = 10
    Top = 3
    Width = 52
    Height = 25
    Caption = 'Pessoa'
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentColor = False
    ParentFont = False
    TabOrder = 2
    Transparent = False
  end
  object stxTitulo: TStaticText
    Left = 113
    Top = 3
    Width = 41
    Height = 25
    Caption = 'CNPJ'
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentColor = False
    ParentFont = False
    TabOrder = 3
    Transparent = False
  end
  object edtCpf: TMaskEdit
    Left = 112
    Top = 25
    Width = 116
    Height = 21
    EditMask = '999\.999\.999\-99;0; '
    MaxLength = 14
    TabOrder = 1
    Text = ''
  end
  object comPessoa: TComboBox
    Left = 10
    Top = 25
    Width = 83
    Height = 21
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 0
    Text = 'F'#205'SICA'
    OnChange = comPessoaChange
    OnClick = comPessoaChange
    Items.Strings = (
      'F'#205'SICA'
      'JUR'#205'DICA')
  end
end
