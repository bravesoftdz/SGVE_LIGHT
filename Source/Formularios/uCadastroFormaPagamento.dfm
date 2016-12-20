inherited frmCadastroFormaPagamento: TfrmCadastroFormaPagamento
  Caption = 'Cadastro de Formas de Pagamento'
  ClientHeight = 417
  ExplicitWidth = 320
  ExplicitHeight = 455
  PixelsPerInch = 96
  TextHeight = 17
  inherited pnlBotoes: TPanel
    Top = 365
    ExplicitTop = 365
  end
  inherited pgGeral: TPageControl
    Height = 365
    ExplicitHeight = 365
    inherited tsConsulta: TTabSheet
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      inherited gridConsulta: TDBGridCBN
        Height = 296
      end
      inherited lblAjudaSelecionar: TStaticText
        Top = 304
        Width = 301
        ExplicitTop = 304
      end
    end
    inherited tsDados: TTabSheet
      inherited pnlDados: TPanel
        Height = 329
        ExplicitHeight = 329
        object Label1: TLabel
          Left = 131
          Top = 72
          Width = 67
          Height = 21
          Caption = 'Descri'#231#227'o'
        end
        object Label2: TLabel
          Left = 39
          Top = 72
          Width = 50
          Height = 21
          Caption = 'C'#243'digo'
        end
        object edtCodigo: TCurrencyEdit
          Left = 39
          Top = 95
          Width = 64
          Height = 29
          DisplayFormat = '0'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          Visible = False
        end
        object edtDescricao: TEdit
          Left = 132
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
      end
    end
  end
  inherited cds: TClientDataSet
    object cdsCODIGO: TIntegerField
      FieldName = 'CODIGO'
    end
    object cdsDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 100
    end
  end
end
