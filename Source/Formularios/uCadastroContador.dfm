inherited frmCadastroContador: TfrmCadastroContador
  Left = 410
  Top = 173
  Caption = 'Cadastro de Contadores'
  ClientHeight = 642
  ClientWidth = 529
  ExplicitWidth = 545
  ExplicitHeight = 680
  PixelsPerInch = 96
  TextHeight = 17
  inherited pnlBotoes: TPanel
    Top = 590
    Width = 529
    ExplicitTop = 590
    ExplicitWidth = 529
  end
  inherited pgGeral: TPageControl
    Width = 529
    Height = 590
    ExplicitWidth = 529
    ExplicitHeight = 590
    inherited tsConsulta: TTabSheet
      ExplicitWidth = 521
      ExplicitHeight = 554
      inherited gridConsulta: TDBGridCBN
        Width = 503
        Height = 547
      end
      inherited lblAjudaSelecionar: TStaticText
        Top = 529
        Width = 521
        ExplicitTop = 529
        ExplicitWidth = 521
      end
    end
    inherited tsDados: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 32
      ExplicitWidth = 521
      ExplicitHeight = 554
      inherited pnlDados: TPanel
        Width = 521
        Height = 554
        ExplicitWidth = 521
        ExplicitHeight = 554
        inherited lblCamposObrigatorios: TLabel
          Top = 528
          ExplicitTop = 528
        end
        inherited lblAsterisco: TLabel
          Top = 524
          Font.Color = 5916707
          ExplicitTop = 524
        end
        object edtCodigo: TCurrencyEdit
          Left = 8
          Top = -5
          Width = 73
          Height = 21
          AutoSize = False
          DisplayFormat = '0'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          Visible = False
        end
        object gpbIdentificacao: TGroupBox
          Left = 12
          Top = 0
          Width = 493
          Height = 153
          Caption = ' Identifica'#231#227'o '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          object lblRazao: TLabel
            Left = 13
            Top = 22
            Width = 144
            Height = 21
            Caption = 'Nome / Raz'#227'o Social'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object lblCPF_CNPJ: TLabel
            Left = 13
            Top = 78
            Width = 27
            Height = 21
            Caption = 'CPF'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object lblRG_IE: TLabel
            Left = 345
            Top = 78
            Width = 30
            Height = 21
            Caption = 'CRC'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object Label1: TLabel
            Left = 165
            Top = 78
            Width = 37
            Height = 21
            Caption = 'CNPJ'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object Label8: TLabel
            Left = 1
            Top = 9
            Width = 11
            Height = 32
            Caption = '*'
            Font.Charset = ANSI_CHARSET
            Font.Color = 5916707
            Font.Height = -24
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object edtNome: TEdit
            Left = 13
            Top = 46
            Width = 456
            Height = 29
            CharCase = ecUpperCase
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 12418084
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
          end
          object edtCpf: TMaskEdit
            Left = 13
            Top = 102
            Width = 123
            Height = 29
            EditMask = '999\.999\.999\-99;0; '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 12418084
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            MaxLength = 14
            ParentFont = False
            TabOrder = 1
            Text = ''
          end
          object edtCRC: TMaskEdit
            Left = 345
            Top = 102
            Width = 124
            Height = 29
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 12418084
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            MaxLength = 10
            ParentFont = False
            TabOrder = 3
            Text = ''
          end
          object edtcnpj: TMaskEdit
            Left = 165
            Top = 102
            Width = 152
            Height = 29
            EditMask = '99\.999\.999/9999\-99;0; '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 12418084
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            MaxLength = 18
            ParentFont = False
            TabOrder = 2
            Text = ''
          end
        end
        object gpbEndereco: TGroupBox
          Left = 12
          Top = 160
          Width = 493
          Height = 200
          Caption = ' Endere'#231'o '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          object Label2: TLabel
            Left = 13
            Top = 20
            Width = 123
            Height = 21
            Caption = 'Rua / Logradouro'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object Label3: TLabel
            Left = 380
            Top = 20
            Width = 58
            Height = 21
            Caption = 'N'#250'mero'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object Label4: TLabel
            Left = 13
            Top = 75
            Width = 42
            Height = 21
            Caption = 'Bairro'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object Label5: TLabel
            Left = 379
            Top = 75
            Width = 27
            Height = 21
            Caption = 'CEP'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object edtCodigoEndereco: TCurrencyEdit
            Left = 61
            Top = -5
            Width = 64
            Height = 26
            AutoSize = False
            DisplayFormat = '0'
            TabOrder = 5
            Visible = False
          end
          object edtRua: TEdit
            Left = 13
            Top = 44
            Width = 352
            Height = 29
            CharCase = ecUpperCase
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 12418084
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
          end
          object edtNumero: TMaskEdit
            Left = 380
            Top = 44
            Width = 89
            Height = 29
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 12418084
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            MaxLength = 12
            ParentFont = False
            TabOrder = 1
            Text = ''
          end
          object edtBairro: TEdit
            Left = 13
            Top = 99
            Width = 352
            Height = 29
            CharCase = ecUpperCase
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 12418084
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 2
          end
          inline BuscaCidade1: TBuscaCidade
            Left = 14
            Top = 135
            Width = 467
            Height = 54
            TabOrder = 3
            ExplicitLeft = 14
            ExplicitTop = 135
            ExplicitWidth = 467
            ExplicitHeight = 54
            inherited StaticText3: TStaticText
              Left = 427
              Font.Color = clBlack
              ExplicitLeft = 427
            end
            inherited StaticText2: TStaticText
              Left = 116
              Font.Color = clBlack
              ExplicitLeft = 116
            end
            inherited StaticText1: TStaticText
              Font.Color = clBlack
            end
            inherited edtCidade: TEdit
              Left = 117
              Width = 300
              Height = 29
              Font.Color = 12418084
              Font.Name = 'Segoe UI'
              Font.Style = [fsBold]
              ExplicitLeft = 117
              ExplicitWidth = 300
              ExplicitHeight = 29
            end
            inherited btnBusca: TBitBtn
              Left = 83
              ExplicitLeft = 83
            end
            inherited edtUF: TEdit
              Left = 426
              Width = 29
              Height = 29
              Font.Color = 12418084
              Font.Name = 'Segoe UI'
              Font.Style = [fsBold]
              ExplicitLeft = 426
              ExplicitWidth = 29
              ExplicitHeight = 29
            end
            inherited edtCodCid: TCurrencyEdit
              Left = 1
              Width = 77
              Font.Color = 12418084
              Font.Name = 'Segoe UI'
              Font.Style = [fsBold]
              ExplicitLeft = 1
              ExplicitWidth = 77
            end
          end
          object edtCep: TMaskEdit
            Left = 380
            Top = 99
            Width = 89
            Height = 29
            EditMask = '99999\-999;0; '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 12418084
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            MaxLength = 9
            ParentFont = False
            TabOrder = 4
            Text = ''
          end
        end
        object gpbContato: TGroupBox
          Left = 12
          Top = 367
          Width = 493
          Height = 76
          Caption = ' Contato '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 3
          inline Fone1: TFone
            Left = 14
            Top = 21
            Width = 137
            Height = 47
            TabOrder = 0
            ExplicitLeft = 14
            ExplicitTop = 21
            ExplicitWidth = 137
            inherited Label12: TLabel
              Top = -3
              Width = 34
              Height = 21
              Font.Height = -16
              Font.Style = []
              ExplicitTop = -3
              ExplicitWidth = 34
              ExplicitHeight = 21
            end
            inherited edtFone: TMaskEdit
              Width = 122
              Height = 29
              Font.Color = 12418084
              Font.Height = -16
              Font.Name = 'Segoe UI'
              Font.Style = [fsBold]
              ParentFont = False
              ExplicitWidth = 122
              ExplicitHeight = 29
            end
          end
          inline Fone2: TFone
            Left = 165
            Top = 21
            Width = 145
            Height = 47
            TabOrder = 1
            ExplicitLeft = 165
            ExplicitTop = 21
            ExplicitWidth = 145
            inherited Label12: TLabel
              Top = -3
              Width = 49
              Height = 21
              Caption = 'Celular'
              Font.Color = clBlack
              Font.Height = -16
              Font.Style = []
              ExplicitTop = -3
              ExplicitWidth = 49
              ExplicitHeight = 21
            end
            inherited edtFone: TMaskEdit
              Width = 126
              Height = 28
              Font.Color = 12418084
              Font.Height = -15
              Font.Name = 'Segoe UI'
              Font.Style = [fsBold]
              ParentFont = False
              ExplicitWidth = 126
              ExplicitHeight = 28
            end
          end
        end
        object GroupBox1: TGroupBox
          Left = 12
          Top = 449
          Width = 493
          Height = 72
          Caption = ' E-mail '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 4
          object Label6: TLabel
            Left = 16
            Top = 18
            Width = 11
            Height = 32
            Caption = '*'
            Font.Charset = ANSI_CHARSET
            Font.Color = 5916707
            Font.Height = -24
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object edtEmail: TEdit
            Left = 33
            Top = 29
            Width = 416
            Height = 29
            CharCase = ecLowerCase
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 12418084
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
          end
        end
      end
    end
  end
  inherited cds: TClientDataSet
    Left = 119
    object cdsCODIGO: TIntegerField
      FieldName = 'CODIGO'
    end
    object cdsNOME: TStringField
      FieldName = 'NOME'
    end
  end
  inherited ds: TDataSource
    Left = 162
    Top = 168
  end
end
