inherited frmCadastroNcmIBPT: TfrmCadastroNcmIBPT
  Caption = 'Cadastro de NCM (IBPT)'
  PixelsPerInch = 96
  TextHeight = 17
  inherited pgGeral: TPageControl
    inherited tsConsulta: TTabSheet
      inherited gridConsulta: TDBGridCBN
        ConfCores.Normal.Tipo.Height = -13
        ConfCores.Normal.Tipo.Name = 'Segoe UI'
        ConfCores.Zebrada.Tipo.Height = -13
        ConfCores.Zebrada.Tipo.Name = 'Segoe UI'
        ConfCores.Selecao.Tipo.Height = -13
        ConfCores.Selecao.Tipo.Name = 'Segoe UI'
        ConfCores.Destacado.Tipo.Height = -13
        ConfCores.Destacado.Tipo.Name = 'Segoe UI'
        ConfCores.Titulo.Tipo.Height = -13
        ConfCores.Titulo.Tipo.Name = 'Segoe UI'
        Columns = <
          item
            Expanded = False
            FieldName = 'CODIGO'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'NCM'
            Width = 103
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ALIQ_NACIONAL'
            Title.Caption = 'ALIQ. NACIONAL'
            Width = 111
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ALIQ_INTERNACIONAL'
            Title.Caption = 'ALIQ. INTERNACIONAL'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CST'
            Width = 66
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CFOP'
            Visible = False
          end>
      end
    end
    inherited tsDados: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 32
      ExplicitWidth = 696
      ExplicitHeight = 360
      inherited pnlDados: TPanel
        object Label1: TLabel
          Left = 72
          Top = 40
          Width = 36
          Height = 21
          Caption = 'NCM'
        end
        object Label2: TLabel
          Left = 72
          Top = 241
          Width = 95
          Height = 21
          Caption = 'Aliq. Nacional'
        end
        object Label3: TLabel
          Left = 339
          Top = 40
          Width = 27
          Height = 21
          Caption = 'CST'
        end
        object Label4: TLabel
          Left = 206
          Top = 241
          Width = 124
          Height = 21
          Caption = 'Aliq. Internacional'
        end
        object Label5: TLabel
          Left = 206
          Top = 40
          Width = 52
          Height = 21
          Caption = 'CSOSN'
        end
        object edtCodigo: TCurrencyEdit
          Left = 39
          Top = 12
          Width = 64
          Height = 26
          AutoSize = False
          DisplayFormat = '0'
          TabOrder = 0
          Visible = False
        end
        object edtNCM: TEdit
          Left = 73
          Top = 63
          Width = 94
          Height = 29
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 12418084
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          MaxLength = 8
          ParentFont = False
          TabOrder = 1
          Text = '11114444'
          OnKeyPress = edtNCMKeyPress
        end
        object edtAliqNacional: TCurrencyEdit
          Left = 72
          Top = 263
          Width = 94
          Height = 29
          AutoSize = False
          DisplayFormat = ',0.00;-,0.00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 12418084
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
        end
        object edtAliqInternacional: TCurrencyEdit
          Left = 206
          Top = 263
          Width = 94
          Height = 29
          AutoSize = False
          DisplayFormat = ',0.00;-,0.00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 12418084
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 7
        end
        inline BuscaCFOP1: TBuscaCFOP
          Left = 72
          Top = 112
          Width = 546
          Height = 58
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          ExplicitLeft = 72
          ExplicitTop = 112
          inherited StaticText2: TStaticText
            Visible = False
          end
          inherited StaticText1: TStaticText
            Width = 165
            Caption = 'CFOP dentro do estado'
            ExplicitWidth = 165
          end
          inherited edtCFOP: TEdit
            Font.Color = 12418084
          end
          inherited edtDescricao: TEdit
            Font.Color = 12418084
          end
        end
        object cmbCSOSN: TComboBox
          Left = 206
          Top = 63
          Width = 94
          Height = 29
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 2
          Text = '- -'
          Items.Strings = (
            '- -'
            '101'
            '102'
            '103'
            '201'
            '202'
            '203'
            '300'
            '400'
            '500'
            '900')
        end
        object cmbCST: TComboBox
          Left = 339
          Top = 63
          Width = 94
          Height = 29
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 3
          Text = '- -'
          Items.Strings = (
            '- -'
            '000'
            '020'
            '040'
            '041'
            '050'
            '051'
            '010'
            '030'
            '060'
            '070'
            '090')
        end
        inline BuscaCFOP2: TBuscaCFOP
          Left = 72
          Top = 176
          Width = 546
          Height = 58
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
          ExplicitLeft = 72
          ExplicitTop = 176
          inherited StaticText2: TStaticText
            Left = 136
            Top = 0
            Visible = False
            ExplicitLeft = 136
            ExplicitTop = 0
          end
          inherited StaticText1: TStaticText
            Width = 147
            Caption = 'CFOP fora do estado'
            ExplicitWidth = 147
          end
          inherited edtCFOP: TEdit
            Font.Color = 12418084
          end
          inherited edtDescricao: TEdit
            Font.Color = 12418084
          end
        end
      end
    end
  end
  inherited cds: TClientDataSet
    Left = 23
    Top = 104
    object cdsCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Visible = False
    end
    object cdsNCM: TStringField
      FieldName = 'NCM'
      Size = 8
    end
    object cdsALIQ_NACIONAL: TFloatField
      FieldName = 'ALIQ_NACIONAL'
    end
    object cdsALIQ_INTERNACIONAL: TFloatField
      FieldName = 'ALIQ_INTERNACIONAL'
    end
    object cdsCST: TStringField
      FieldName = 'CST'
      Size = 3
    end
  end
  inherited ds: TDataSource
    Left = 26
  end
end
