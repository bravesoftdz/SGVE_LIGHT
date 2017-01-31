inherited frmCadastroAliqPercReducPorEstado: TfrmCadastroAliqPercReducPorEstado
  Caption = 'Cadastro de Aliquota e % Redu'#231#227'o por estado'
  ClientHeight = 386
  ClientWidth = 524
  ExplicitWidth = 540
  ExplicitHeight = 424
  PixelsPerInch = 96
  TextHeight = 17
  inherited pnlBotoes: TPanel
    Top = 334
    Width = 524
    ExplicitTop = 334
    ExplicitWidth = 524
  end
  inherited pgGeral: TPageControl
    Width = 524
    Height = 334
    ExplicitWidth = 524
    ExplicitHeight = 334
    inherited tsConsulta: TTabSheet
      ExplicitWidth = 516
      ExplicitHeight = 298
      inherited gridConsulta: TDBGridCBN
        Width = 498
        Height = 265
        Columns = <
          item
            Expanded = False
            FieldName = 'CODIDO_ESTADO'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'UF'
            Width = 47
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ALIQUOTA'
            Width = 93
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PERC_REDUCAO'
            Width = 107
            Visible = True
          end>
      end
      inherited lblAjudaSelecionar: TStaticText
        Top = 273
        Width = 516
        ExplicitTop = 273
        ExplicitWidth = 516
      end
    end
    inherited tsDados: TTabSheet
      ExplicitWidth = 516
      ExplicitHeight = 298
      inherited pnlDados: TPanel
        Width = 516
        Height = 298
        ExplicitWidth = 516
        ExplicitHeight = 298
        object Label2: TLabel
          Left = 152
          Top = 89
          Width = 95
          Height = 20
          Caption = 'Al'#237'quota ICMS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object Label1: TLabel
          Left = 336
          Top = 89
          Width = 96
          Height = 20
          Caption = '% Redu'#231#227'o BC'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object Label3: TLabel
          Left = 43
          Top = 88
          Width = 19
          Height = 21
          Caption = 'UF'
        end
        object edtAliquota: TCurrencyEdit
          Left = 152
          Top = 111
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
          TabOrder = 0
        end
        object edtPercReducao: TCurrencyEdit
          Left = 336
          Top = 111
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
        object edtCodigo: TCurrencyEdit
          Left = 39
          Top = 12
          Width = 64
          Height = 26
          AutoSize = False
          DisplayFormat = '0'
          TabOrder = 2
          Visible = False
        end
        object edtCodigoUf: TCurrencyEdit
          Left = 127
          Top = 12
          Width = 64
          Height = 26
          AutoSize = False
          DisplayFormat = '0'
          TabOrder = 3
          Visible = False
        end
        object edtUF: TEdit
          Left = 44
          Top = 111
          Width = 59
          Height = 27
          CharCase = ecUpperCase
          Ctl3D = False
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 12418084
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 4
        end
      end
    end
  end
  inherited cds: TClientDataSet
    object cdsCODIDO_ESTADO: TIntegerField
      FieldName = 'CODIDO_ESTADO'
    end
    object cdsUF: TStringField
      FieldName = 'UF'
      Size = 2
    end
    object cdsALIQUOTA: TFloatField
      FieldName = 'ALIQUOTA'
    end
    object cdsPERC_REDUCAO: TFloatField
      FieldName = 'PERC_REDUCAO'
    end
    object cdsCODIGO: TIntegerField
      FieldName = 'CODIGO'
    end
  end
end
