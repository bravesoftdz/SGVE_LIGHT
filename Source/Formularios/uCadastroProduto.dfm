inherited frmCadastroProduto: TfrmCadastroProduto
  Caption = 'Cadastro de produtos'
  ClientHeight = 490
  ClientWidth = 673
  ExplicitWidth = 689
  ExplicitHeight = 528
  PixelsPerInch = 96
  TextHeight = 17
  inherited pnlBotoes: TPanel
    Top = 438
    Width = 673
    ExplicitTop = 438
    ExplicitWidth = 673
    inherited btnIncluir: TSpeedButton
      Left = 10
      Width = 125
      ExplicitLeft = 10
      ExplicitWidth = 125
    end
    inherited btnAlterar: TSpeedButton
      Left = 141
      Width = 125
      ExplicitLeft = 141
      ExplicitWidth = 125
    end
    inherited btnCancelar: TBitBtn
      Left = 284
      Width = 125
      ExplicitLeft = 284
      ExplicitWidth = 125
    end
    inherited btnSalvar: TBitBtn
      Left = 420
      Width = 125
      ExplicitLeft = 420
      ExplicitWidth = 125
    end
  end
  inherited pgGeral: TPageControl
    Width = 673
    Height = 438
    ActivePage = tsDados
    ExplicitWidth = 673
    ExplicitHeight = 438
    inherited tsConsulta: TTabSheet
      ExplicitWidth = 665
      ExplicitHeight = 402
      inherited gridConsulta: TDBGridCBN
        Left = 9
        Top = 4
        Width = 647
        Height = 373
        OnDrawColumnCell = gridConsultaDrawColumnCell
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
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DESCRICAO'
            Width = 324
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'VALOR'
            Visible = True
          end>
      end
      inherited lblAjudaSelecionar: TStaticText
        Top = 377
        Width = 665
        ExplicitTop = 377
        ExplicitWidth = 665
      end
    end
    inherited tsDados: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 32
      ExplicitWidth = 665
      ExplicitHeight = 402
      inherited pnlDados: TPanel
        Width = 665
        Height = 402
        ExplicitWidth = 665
        ExplicitHeight = 402
        inherited lblCamposObrigatorios: TLabel
          Left = 26
          Top = 370
          Width = 259
          Height = 20
          Caption = 'Campos de preenchimento obrigat'#243'rio'
          Font.Height = -15
          ExplicitLeft = 26
          ExplicitTop = 370
          ExplicitWidth = 259
          ExplicitHeight = 20
        end
        inherited lblAsterisco: TLabel
          Top = 367
          ExplicitTop = 367
        end
        object Label1: TLabel
          Left = 72
          Top = 40
          Width = 145
          Height = 20
          Caption = 'Descri'#231#227'o do produto'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object Label2: TLabel
          Left = 72
          Top = 105
          Width = 35
          Height = 20
          Caption = 'Valor'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object Label3: TLabel
          Left = 375
          Top = 105
          Width = 115
          Height = 20
          Caption = 'C'#243'digo de barras'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object Label4: TLabel
          Left = 56
          Top = 35
          Width = 11
          Height = 32
          Caption = '*'
          Font.Charset = ANSI_CHARSET
          Font.Color = clMaroon
          Font.Height = -24
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label6: TLabel
          Left = 56
          Top = 171
          Width = 11
          Height = 32
          Caption = '*'
          Font.Charset = ANSI_CHARSET
          Font.Color = clMaroon
          Font.Height = -24
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label7: TLabel
          Left = 224
          Top = 105
          Width = 132
          Height = 20
          Caption = 'Unidade de medida'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object Label8: TLabel
          Left = 72
          Top = 240
          Width = 233
          Height = 20
          Caption = 'Informa'#231#245'es adicionais do produto'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object edtDescricao: TEdit
          Left = 73
          Top = 63
          Width = 520
          Height = 27
          CharCase = ecUpperCase
          Ctl3D = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 12418084
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 0
        end
        object edtValor: TCurrencyEdit
          Left = 72
          Top = 127
          Width = 129
          Height = 27
          AutoSize = False
          Ctl3D = False
          DisplayFormat = ',0.00;-,0.00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 12418084
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 1
        end
        inline BuscaNCM: TBuscaNCMIbpt
          Left = 73
          Top = 178
          Width = 536
          Height = 60
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          ExplicitLeft = 73
          ExplicitTop = 178
          ExplicitWidth = 536
          ExplicitHeight = 60
          inherited StaticText3: TStaticText [0]
            Left = 302
            Top = -3
            Width = 39
            Height = 24
            Font.Height = -15
            ExplicitLeft = 302
            ExplicitTop = -3
            ExplicitWidth = 39
            ExplicitHeight = 24
          end
          inherited StaticText4: TStaticText [1]
            Left = 438
            Top = -3
            Width = 29
            Height = 24
            Font.Height = -15
            ExplicitLeft = 438
            ExplicitTop = -3
            ExplicitWidth = 29
            ExplicitHeight = 24
          end
          inherited StaticText2: TStaticText [2]
            Left = 150
            Top = -3
            Width = 61
            Height = 24
            Font.Height = -15
            ExplicitLeft = 150
            ExplicitTop = -3
            ExplicitWidth = 61
            ExplicitHeight = 24
          end
          inherited StaticText1: TStaticText [3]
            Top = -3
            Width = 37
            Height = 24
            Font.Height = -15
            ExplicitTop = -3
            ExplicitWidth = 37
            ExplicitHeight = 24
          end
          inherited btnBusca: TBitBtn
            Left = 111
            Top = 19
            ExplicitLeft = 111
            ExplicitTop = 19
          end
          inherited edtNCM: TEdit
            Top = 20
            Width = 101
            Height = 27
            Ctl3D = False
            Font.Color = 12418084
            ParentCtl3D = False
            ExplicitTop = 20
            ExplicitWidth = 101
            ExplicitHeight = 27
          end
          inherited edtAliquota: TCurrencyEdit
            Left = 150
            Top = 20
            Width = 130
            Height = 28
            Ctl3D = False
            Font.Color = 12418084
            ParentCtl3D = False
            ExplicitLeft = 150
            ExplicitTop = 20
            ExplicitWidth = 130
            ExplicitHeight = 28
          end
          inherited edtCFOP: TEdit
            Left = 302
            Top = 20
            Height = 27
            Ctl3D = False
            Font.Color = 12418084
            ParentCtl3D = False
            ExplicitLeft = 302
            ExplicitTop = 20
            ExplicitHeight = 27
          end
          inherited edtCST: TEdit
            Left = 438
            Top = 20
            Height = 27
            Ctl3D = False
            Font.Color = 12418084
            ParentCtl3D = False
            ExplicitLeft = 438
            ExplicitTop = 20
            ExplicitHeight = 27
          end
          inherited BitBtn1: TBitBtn
            Left = 402
            Top = 19
            ExplicitLeft = 402
            ExplicitTop = 19
          end
        end
        object cmbUnidadeMedida: TComboBox
          Left = 224
          Top = 127
          Width = 129
          Height = 29
          Style = csDropDownList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 12418084
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          Items.Strings = (
            'UNID'
            'KG'
            'L'
            'M'
            'P'#199)
        end
        object edtCodigo: TCurrencyEdit
          Left = 39
          Top = 12
          Width = 64
          Height = 26
          AutoSize = False
          DisplayFormat = '0'
          TabOrder = 5
          Visible = False
        end
        object edtCodigoBarras: TEdit
          Left = 376
          Top = 127
          Width = 217
          Height = 27
          CharCase = ecUpperCase
          Ctl3D = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 12418084
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          MaxLength = 13
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 3
          OnKeyPress = edtCodigoBarrasKeyPress
        end
        object memoInfAdicionais: TMemo
          Left = 73
          Top = 263
          Width = 519
          Height = 89
          CharCase = ecUpperCase
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 6
        end
      end
    end
  end
  inherited cds: TClientDataSet
    Left = 15
    Top = 112
    object cdsCODIGO: TIntegerField
      FieldName = 'CODIGO'
    end
    object cdsDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 70
    end
    object cdsVALOR: TFloatField
      FieldName = 'VALOR'
      DisplayFormat = ',#.##; -,#.##;'
    end
    object cdsNCM: TStringField
      FieldName = 'NCM'
      Size = 12
    end
    object cdsCFOP: TStringField
      FieldName = 'CFOP'
      Size = 4
    end
  end
  inherited ds: TDataSource
    Left = 18
    Top = 56
  end
end
