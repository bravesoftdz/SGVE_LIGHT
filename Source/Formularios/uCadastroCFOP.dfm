inherited frmCadastroCFOP: TfrmCadastroCFOP
  Caption = 'Cadastro de CFOP'
  ClientHeight = 421
  ExplicitHeight = 459
  PixelsPerInch = 96
  TextHeight = 17
  inherited pnlBotoes: TPanel
    Top = 369
    ExplicitTop = 369
  end
  inherited pgGeral: TPageControl
    Height = 369
    ExplicitHeight = 369
    inherited tsConsulta: TTabSheet
      ExplicitHeight = 333
      inherited gridConsulta: TDBGridCBN
        Height = 300
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
            FieldName = 'CFOP'
            Width = 56
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DESCRICAO'
            Width = 509
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CODIGO'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'SUSPENSAO'
            Title.Caption = 'SUSP. ICMS'
            Visible = True
          end>
      end
      inherited lblAjudaSelecionar: TStaticText
        Top = 308
        ExplicitTop = 308
      end
    end
    inherited tsDados: TTabSheet
      ExplicitHeight = 333
      inherited pnlDados: TPanel
        Height = 333
        ExplicitHeight = 333
        object Label1: TLabel
          Left = 75
          Top = 130
          Width = 67
          Height = 21
          Caption = 'Descri'#231#227'o'
        end
        object Label2: TLabel
          Left = 75
          Top = 64
          Width = 39
          Height = 21
          Caption = 'CFOP'
        end
        object Label3: TLabel
          Left = 344
          Top = 64
          Width = 137
          Height = 21
          Caption = 'Suspens'#227'o de ICMS'
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
          Left = 76
          Top = 153
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
          Left = 76
          Top = 87
          Width = 165
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
        object cmbSuspensao: TComboBox
          Left = 344
          Top = 87
          Width = 190
          Height = 29
          Style = csDropDownList
          TabOrder = 3
          Items.Strings = (
            'SIM'
            'N'#195'O')
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
    object cdsSUSPENSAO: TStringField
      FieldName = 'SUSPENSAO'
      Size = 3
    end
  end
  inherited ds: TDataSource
    Left = 23
  end
end
