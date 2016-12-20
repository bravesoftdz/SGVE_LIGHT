inherited frmCadastroCFOP: TfrmCadastroCFOP
  Caption = 'Cadastro de CFOP'
  ClientHeight = 392
  ExplicitHeight = 430
  PixelsPerInch = 96
  TextHeight = 17
  inherited pnlBotoes: TPanel
    Top = 340
    ExplicitTop = 340
  end
  inherited pgGeral: TPageControl
    Height = 340
    ExplicitHeight = 340
    inherited tsConsulta: TTabSheet
      ExplicitHeight = 304
      inherited gridConsulta: TDBGridCBN
        Height = 279
        ConfCores.Normal.Tipo.Height = -13
        ConfCores.Normal.Tipo.Name = 'Segoe UI'
        ConfCores.Zebrada.Tipo.Height = -13
        ConfCores.Zebrada.Tipo.Name = 'Segoe UI'
        ConfCores.Selecao.Tipo.Height = -13
        ConfCores.Selecao.Tipo.Name = 'Segoe UI Light'
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
            FieldName = 'CFOP'
            Width = 62
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DESCRICAO'
            Width = 576
            Visible = True
          end>
      end
      inherited lblAjudaSelecionar: TStaticText
        Top = 279
        ExplicitTop = 279
        ExplicitWidth = 696
      end
    end
    inherited tsDados: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 32
      ExplicitWidth = 696
      ExplicitHeight = 304
      inherited pnlDados: TPanel
        Height = 304
        ExplicitHeight = 304
        object Label1: TLabel
          Left = 195
          Top = 72
          Width = 67
          Height = 21
          Caption = 'Descri'#231#227'o'
        end
        object Label2: TLabel
          Left = 43
          Top = 72
          Width = 39
          Height = 21
          Caption = 'CFOP'
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
        object edtDescricao: TEdit
          Left = 196
          Top = 95
          Width = 458
          Height = 29
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 12418084
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object edtCFOP: TEdit
          Left = 44
          Top = 95
          Width = 122
          Height = 29
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 12418084
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
      end
    end
  end
  inherited cds: TClientDataSet
    Left = 23
    Top = 208
    object cdsCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Visible = False
    end
    object cdsCFOP: TStringField
      FieldName = 'CFOP'
      Size = 4
    end
    object cdsDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 70
    end
  end
  inherited ds: TDataSource
    Left = 23
  end
end
