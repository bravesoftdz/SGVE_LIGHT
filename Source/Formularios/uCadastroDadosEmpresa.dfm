inherited frmCadastroDadosEmpresa: TfrmCadastroDadosEmpresa
  Caption = 'Cadastro de dados da empresa'
  ClientHeight = 664
  ClientWidth = 1177
  ExplicitWidth = 1193
  ExplicitHeight = 702
  PixelsPerInch = 96
  TextHeight = 17
  inherited pnlBotoes: TPanel
    Top = 621
    Width = 1177
    Height = 43
    ExplicitTop = 621
    ExplicitWidth = 1177
    ExplicitHeight = 43
    inherited btnSalvar: TBitBtn
      Left = 390
      ExplicitLeft = 390
    end
  end
  inherited pgGeral: TPageControl
    Width = 1177
    Height = 621
    ActivePage = tsDados
    ExplicitWidth = 1177
    ExplicitHeight = 621
    inherited tsConsulta: TTabSheet
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 1169
      ExplicitHeight = 585
      inherited gridConsulta: TDBGridCBN
        Width = 1145
        Height = 552
        TitleFont.Height = -15
        TitleFont.Name = 'Segoe UI'
        ConfCores.Normal.Tipo.Height = -15
        ConfCores.Normal.Tipo.Name = 'Segoe UI'
        ConfCores.Zebrada.Tipo.Height = -15
        ConfCores.Zebrada.Tipo.Name = 'Segoe UI'
        ConfCores.Selecao.Tipo.Height = -15
        ConfCores.Selecao.Tipo.Name = 'Segoe UI'
        ConfCores.Destacado.Tipo.Height = -15
        ConfCores.Destacado.Tipo.Name = 'Segoe UI'
        ConfCores.Titulo.Tipo.Height = -15
        ConfCores.Titulo.Tipo.Name = 'Segoe UI'
        Columns = <
          item
            Expanded = False
            FieldName = 'CODIGO'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'RAZAO'
            Width = 492
            Visible = True
          end>
      end
      inherited lblAjudaSelecionar: TStaticText
        Top = 560
        Width = 301
        ExplicitTop = 560
      end
    end
    inherited tsDados: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 32
      ExplicitWidth = 1169
      ExplicitHeight = 585
      inherited pnlDados: TPanel
        Width = 1169
        Height = 585
        ExplicitWidth = 1169
        ExplicitHeight = 585
        inherited lblCamposObrigatorios: TLabel
          Top = 555
          ExplicitTop = 555
        end
        inherited lblAsterisco: TLabel
          Top = 551
          ExplicitTop = 551
        end
        object edtCodigo: TCurrencyEdit
          Left = 1
          Top = -8
          Width = 64
          Height = 26
          AutoSize = False
          DisplayFormat = '0'
          TabOrder = 0
          Visible = False
        end
        object GroupBox1: TGroupBox
          Left = 15
          Top = 5
          Width = 546
          Height = 191
          TabOrder = 1
          object Label1: TLabel
            Left = 17
            Top = 8
            Width = 85
            Height = 21
            Caption = 'Raz'#227'o social'
          end
          object Label2: TLabel
            Left = 17
            Top = 64
            Width = 101
            Height = 21
            Caption = 'Nome fantasia'
          end
          object Label3: TLabel
            Left = 213
            Top = 122
            Width = 12
            Height = 21
            Caption = 'IE'
          end
          object Label33: TLabel
            Left = 404
            Top = 122
            Width = 95
            Height = 21
            Caption = 'Data cadastro'
          end
          object edtRazao: TEdit
            Left = 18
            Top = 31
            Width = 507
            Height = 29
            CharCase = ecUpperCase
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 12418084
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            MaxLength = 60
            ParentFont = False
            TabOrder = 0
          end
          object edtFantasia: TEdit
            Left = 18
            Top = 87
            Width = 507
            Height = 29
            CharCase = ecUpperCase
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 12418084
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            MaxLength = 60
            ParentFont = False
            TabOrder = 1
          end
          inline CpfCnpj: TMaskCpfCnpj
            Left = 5
            Top = 120
            Width = 182
            Height = 58
            TabOrder = 2
            ExplicitLeft = 5
            ExplicitTop = 120
            ExplicitWidth = 182
            inherited Label19: TLabel
              Left = -1
              ExplicitLeft = -1
            end
            inherited stxTitulo: TStaticText [1]
            end
            inherited StaticText1: TStaticText [2]
              Left = -70
              ExplicitLeft = -70
            end
            inherited comPessoa: TComboBox [3]
              Left = -75
              Height = 29
              Visible = False
              ExplicitLeft = -75
              ExplicitHeight = 29
            end
            inherited edtCpf: TMaskEdit [4]
              Left = 13
              Width = 156
              Height = 29
              Font.Color = 12418084
              Font.Height = -16
              Font.Name = 'Segoe UI'
              Font.Style = [fsBold]
              ParentFont = False
              ExplicitLeft = 13
              ExplicitWidth = 156
              ExplicitHeight = 29
            end
          end
          object edtDataCadastro: TEdit
            Left = 404
            Top = 145
            Width = 121
            Height = 29
            CharCase = ecUpperCase
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 12418084
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            MaxLength = 8
            ParentFont = False
            TabOrder = 3
          end
          object edtIe: TEdit
            Left = 212
            Top = 145
            Width = 155
            Height = 29
            CharCase = ecUpperCase
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 12418084
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            MaxLength = 14
            ParentFont = False
            TabOrder = 4
            OnKeyPress = edtIeKeyPress
          end
        end
        object GroupBox2: TGroupBox
          Left = 15
          Top = 295
          Width = 546
          Height = 257
          Caption = ' Endere'#231'o '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 5855577
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 3
          object Label4: TLabel
            Left = 17
            Top = 24
            Width = 109
            Height = 20
            Caption = 'Rua/Logradouro'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -15
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object Label5: TLabel
            Left = 20
            Top = 82
            Width = 17
            Height = 20
            Caption = 'N'#186
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -15
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object Label6: TLabel
            Left = 103
            Top = 82
            Width = 40
            Height = 20
            Caption = 'Bairro'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -15
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object Label7: TLabel
            Left = 18
            Top = 192
            Width = 95
            Height = 20
            Caption = 'Complemento'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -15
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object Label12: TLabel
            Left = 430
            Top = 83
            Width = 27
            Height = 21
            Caption = 'CEP'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 3355443
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object edtLogradouro: TEdit
            Left = 18
            Top = 47
            Width = 507
            Height = 29
            CharCase = ecUpperCase
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 12418084
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            MaxLength = 80
            ParentFont = False
            TabOrder = 0
          end
          object edtNumero: TEdit
            Left = 19
            Top = 105
            Width = 70
            Height = 29
            CharCase = ecUpperCase
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 12418084
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            MaxLength = 10
            ParentFont = False
            TabOrder = 1
          end
          object edtBairro: TEdit
            Left = 103
            Top = 105
            Width = 315
            Height = 29
            CharCase = ecUpperCase
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 12418084
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            MaxLength = 50
            ParentFont = False
            TabOrder = 2
          end
          inline BuscaCidade1: TBuscaCidade
            Left = 20
            Top = 136
            Width = 523
            Height = 60
            TabOrder = 4
            ExplicitLeft = 20
            ExplicitTop = 136
            ExplicitWidth = 523
            inherited StaticText3: TStaticText
              Left = 474
              Top = 1
              Width = 23
              Height = 25
              Font.Name = 'Segoe UI'
              ExplicitLeft = 474
              ExplicitTop = 1
              ExplicitWidth = 23
              ExplicitHeight = 25
            end
            inherited StaticText2: TStaticText
              Left = 115
              Top = 1
              Width = 52
              Height = 25
              Font.Name = 'Segoe UI'
              ExplicitLeft = 115
              ExplicitTop = 1
              ExplicitWidth = 52
              ExplicitHeight = 25
            end
            inherited StaticText1: TStaticText
              Top = 1
              Height = 25
              Font.Name = 'Segoe UI'
              ExplicitTop = 1
              ExplicitHeight = 25
            end
            inherited edtCidade: TEdit
              Left = 116
              Width = 343
              Height = 28
              Font.Color = 12418084
              Font.Height = -15
              Font.Name = 'Segoe UI'
              Font.Style = [fsBold]
              ExplicitLeft = 116
              ExplicitWidth = 343
              ExplicitHeight = 28
            end
            inherited btnBusca: TBitBtn
              Left = 83
              Top = 23
              ExplicitLeft = 83
              ExplicitTop = 23
            end
            inherited edtUF: TEdit
              Left = 473
              Width = 32
              Height = 28
              Font.Color = 12418084
              Font.Height = -15
              Font.Name = 'Segoe UI'
              Font.Style = [fsBold]
              ExplicitLeft = 473
              ExplicitWidth = 32
              ExplicitHeight = 28
            end
            inherited edtCodCid: TCurrencyEdit
              Top = 25
              Width = 79
              Height = 28
              Font.Color = 12418084
              Font.Height = -15
              Font.Name = 'Segoe UI'
              Font.Style = [fsBold]
              ExplicitTop = 25
              ExplicitWidth = 79
              ExplicitHeight = 28
            end
          end
          object edtComplento: TEdit
            Left = 19
            Top = 215
            Width = 507
            Height = 29
            CharCase = ecUpperCase
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 12418084
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            MaxLength = 200
            ParentFont = False
            TabOrder = 5
          end
          object edtCEP: TMaskEdit
            Left = 431
            Top = 105
            Width = 92
            Height = 29
            EditMask = '00000\-000;0; '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 12418084
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            MaxLength = 9
            ParentFont = False
            TabOrder = 3
            Text = ''
          end
          object edtCodigoEndereco: TCurrencyEdit
            Left = 155
            Top = 16
            Width = 64
            Height = 26
            AutoSize = False
            DisplayFormat = '0'
            TabOrder = 6
            Visible = False
          end
        end
        object GroupBox3: TGroupBox
          Left = 15
          Top = 201
          Width = 546
          Height = 87
          Caption = ' Contato '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 5197647
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          object Label8: TLabel
            Left = 282
            Top = 20
            Width = 43
            Height = 20
            Caption = 'E-mail'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -15
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          inline Fone1: TFone
            Left = 16
            Top = 24
            Width = 127
            Height = 47
            TabOrder = 0
            ExplicitLeft = 16
            ExplicitTop = 24
            ExplicitWidth = 127
            inherited Label12: TLabel
              Top = -3
              Width = 34
              Height = 21
              Font.Color = clBlack
              Font.Height = -16
              Font.Style = []
              ExplicitTop = -3
              ExplicitWidth = 34
              ExplicitHeight = 21
            end
            inherited edtFone: TMaskEdit
              Width = 114
              Height = 28
              Font.Color = 12418084
              Font.Height = -15
              Font.Name = 'Segoe UI'
              Font.Style = [fsBold]
              ParentFont = False
              ExplicitWidth = 114
              ExplicitHeight = 28
            end
          end
          object edtEmail: TEdit
            Left = 284
            Top = 43
            Width = 250
            Height = 29
            CharCase = ecUpperCase
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 12418084
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            MaxLength = 30
            ParentFont = False
            TabOrder = 1
          end
          inline Fone2: TFone
            Left = 148
            Top = 24
            Width = 127
            Height = 47
            TabOrder = 2
            ExplicitLeft = 148
            ExplicitTop = 24
            ExplicitWidth = 127
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
              Width = 114
              Height = 28
              Font.Color = 12418084
              Font.Height = -15
              Font.Name = 'Segoe UI'
              Font.Style = [fsBold]
              ParentFont = False
              ExplicitWidth = 114
              ExplicitHeight = 28
            end
          end
        end
        object PageControl1: TPageControl
          Left = 584
          Top = 5
          Width = 577
          Height = 565
          ActivePage = TabSheet1
          TabOrder = 4
          OnChange = PageControl1Change
          object TabSheet1: TTabSheet
            Caption = 'Dados fiscais'
            object Label9: TLabel
              Left = 17
              Top = 0
              Width = 75
              Height = 21
              Caption = 'Certificado'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Segoe UI'
              Font.Style = []
              ParentFont = False
            end
            object Label10: TLabel
              Left = 17
              Top = 59
              Width = 141
              Height = 21
              Caption = 'Senha do certificado'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Segoe UI'
              Font.Style = []
              ParentFont = False
            end
            object btnCertificadoNFe: TSpeedButton
              Left = 425
              Top = 22
              Width = 124
              Height = 31
              Caption = ' Selecionar'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -15
              Font.Name = 'Segoe UI'
              Font.Style = []
              Glyph.Data = {
                36080000424D3608000000000000360000002800000020000000100000000100
                2000000000000008000000000000000000000000000000000000FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF004D74AB0023417900C5ABA7009B9B9B009B9B
                9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B
                9B009B9B9B009B9B9B009B9B9B00001047000000150061474300FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF004173AF00008EEC00009AF4001F4B80009B9B9B009B9B
                9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B
                9B009B9B9B009B9B9B00000F4B00002A88000036900000001C00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FEFFFF002F6EB2002BA7F50016C0FF0000A0F300568BC3009B9B9B009B9B
                9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B
                9B009A9B9B00000A4E0000439100005C9B00003C8F0000275F00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFF
                FF002974BB0068C4F8006BD4FF00279CE6006696C800FFFFFF009B9B9B009B9B
                9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009A9B
                9B00001057000460940007709B0000388200023264009B9B9B00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF003D8F
                D500A4E3FE00B5EEFF004CAAE700669DD200FFFFFF00FFFFFF009B9B9B009B9B
                9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00002B
                7100407F9A00518A9B000046830002396E009B9B9B009B9B9B00FFFFFF00FFFF
                FF00FEFEFE00A18889008A6A6A0093736E0086656700B0959500BAA8B100359E
                E800BDF5FF0077C4EF0063A1DA00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
                9B009A9A9A003D242500260606002F0F0A00220103004C31310056444D00003A
                840059919B0013608B00003D76009B9B9B009B9B9B009B9B9B00FFFFFF00D7CD
                CD007E585700DFD3CB00FFFFF700FFFFE700FFFEDB00D6BB9E0090584D00817B
                8E001794E4006BB5E900FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B007369
                69001A0000007B6F67009B9B93009B9B83009B9A770072573A002C0000001D17
                2A0000308000075185009B9B9B009B9B9B009B9B9B009B9B9B00EDE9E9008865
                6500FFFFFF00FFFFFF00FDF8E800FAF2DC00F8EDCF00FFF1CF00F6DEBA009F59
                4500C0C7D500FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00898585002401
                01009B9B9B009B9B9B0099948400968E780094896B009B8D6B00927A56003B00
                00005C6371009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00A3888900F6EF
                EA00FFFFFF00FEFBF500FBF7E800F9F4DA00F5EBCC00E6CEAC00F3DAB800E2BD
                9900AB8B8E00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF003F242500928B
                86009B9B9B009A979100979384009590760091876800826A48008F7654007E59
                350047272A009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B0093767400FFFF
                FF00FDFBF100FCF8EE00FAF3E100FCF5E300F7F0D700F0DFC100E7C9A900F0D1
                AB00A87E7500F8F6F600FFFFFF00FFFFFF00FFFFFF00FFFFFF002F1210009B9B
                9B0099978D0098948A00968F7D0098917F00938C73008C7B5D00836545008C6D
                4700441A1100949292009B9B9B009B9B9B009B9B9B009B9B9B00997D7A00FFFF
                FC00F9F2E100FAF3DE00FAF7E500FAF1DC00F1DFC000EDD9BA00ECD8B900EDCA
                A500AF867900EDE8E900FFFFFF00FFFFFF00FFFFFF00FFFFFF00351916009B9B
                9800958E7D00968F7A0096938100968D78008D7B5C0089755600887455008966
                41004B221500898485009B9B9B009B9B9B009B9B9B009B9B9B009C807B00FFFF
                EB00F9EED500FAF1D700F9F2DA00F2E3C600FEFBF900FFFFF000EFDFC000E9C6
                9E00B0857B00F5F2F300FFFFFF00FFFFFF00FFFFFF00FFFFFF00381C17009B9B
                8700958A7100968D7300958E76008E7F62009A9795009B9B8C008B7B5C008562
                3A004C211700918E8F009B9B9B009B9B9B009B9B9B009B9B9B00AF959600F7EA
                C800F9EBCC00EFDCBE00F4E4C700F0E1C500FDFCEC00FAF5DD00EFDCBC00DFB0
                8700B59A9A00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF004B3132009386
                6400958768008B785A00908063008C7D610099988800969179008B7858007B4C
                2300513636009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00DED4D700BA99
                8C00FDECC400EDD4B000E5CAA800EFDBBF00F2E3C400F2DEBC00EABF9300BB8E
                7D00E7DFE200FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007A7073005635
                28009988600089704C00816644008B775B008E7F60008E7A5800865B2F00572A
                1900837B7E009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00FFFFFF00CEBF
                C500BE9A8D00E6C7A500EFCBA300ECC8A200E8BE9400DCAA8600BE958500DFD6
                D700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B006A5B
                61005A362900826341008B673F0088643E00845A3000784622005A3121007B72
                73009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00FFFFFF00FFFF
                FF00E9E4E600C9B3B400B99C9300C3A09700BF9F9600CCB9B700F1EEEF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
                9B0085808200654F500055382F005F3C33005B3B3200685553008D8A8B009B9B
                9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00}
              NumGlyphs = 2
              ParentFont = False
              OnClick = btnCertificadoNFeClick
            end
            object Label30: TLabel
              Left = 426
              Top = 59
              Width = 67
              Height = 21
              Caption = 'Ambiente'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Segoe UI'
              Font.Style = []
              ParentFont = False
            end
            object PageControl2: TPageControl
              Left = 0
              Top = 128
              Width = 569
              Height = 401
              ActivePage = TabSheet5
              Align = alBottom
              TabOrder = 0
              object TabSheet3: TTabSheet
                Caption = 'NF-e'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -16
                Font.Name = 'Vani'
                Font.Style = []
                ParentFont = False
                ExplicitLeft = 0
                ExplicitTop = 0
                ExplicitWidth = 0
                ExplicitHeight = 0
                object Label13: TLabel
                  Left = 21
                  Top = 203
                  Width = 112
                  Height = 21
                  Caption = 'Tipo de emiss'#227'o'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -16
                  Font.Name = 'Segoe UI'
                  Font.Style = []
                  ParentFont = False
                end
                object cmbTipoEmissao: TComboBox
                  Left = 149
                  Top = 199
                  Width = 132
                  Height = 28
                  Style = csDropDownList
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -15
                  Font.Name = 'Segoe UI'
                  Font.Style = []
                  ItemIndex = 0
                  ParentFont = False
                  TabOrder = 1
                  Text = '1-NORMAL'
                  Items.Strings = (
                    '1-NORMAL'
                    '7-SVCRS')
                end
                object gpbAliquotas: TGroupBox
                  Left = 17
                  Top = 87
                  Width = 533
                  Height = 106
                  Caption = ' Al'#237'quotas '
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -16
                  Font.Name = 'Segoe UI'
                  Font.Style = []
                  ParentFont = False
                  TabOrder = 2
                  object Label14: TLabel
                    Left = 29
                    Top = 30
                    Width = 82
                    Height = 21
                    Caption = 'Cr'#233'dito S.N.'
                  end
                  object Label15: TLabel
                    Left = 149
                    Top = 30
                    Width = 37
                    Height = 21
                    Caption = 'ICMS'
                  end
                  object Label16: TLabel
                    Left = 269
                    Top = 30
                    Width = 22
                    Height = 21
                    Caption = 'PIS'
                  end
                  object Label17: TLabel
                    Left = 389
                    Top = 30
                    Width = 55
                    Height = 21
                    Caption = 'COFINS'
                  end
                  object edtCreditoSN: TDBCurrencyEdit
                    Left = 29
                    Top = 54
                    Width = 97
                    Height = 29
                    DisplayFormat = ' ,0.00;- ,0.00'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = 12418084
                    Font.Height = -16
                    Font.Name = 'Segoe UI'
                    Font.Style = [fsBold]
                    ParentFont = False
                    TabOrder = 0
                    OnChange = edtCreditoSNChange
                  end
                  object edtIcms: TDBCurrencyEdit
                    Left = 149
                    Top = 54
                    Width = 97
                    Height = 29
                    DisplayFormat = ' ,0.00;- ,0.00'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = 12418084
                    Font.Height = -16
                    Font.Name = 'Segoe UI'
                    Font.Style = [fsBold]
                    ParentFont = False
                    TabOrder = 1
                  end
                  object edtCofins: TDBCurrencyEdit
                    Left = 389
                    Top = 54
                    Width = 97
                    Height = 29
                    DisplayFormat = ' ,0.00;- ,0.00'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = 12418084
                    Font.Height = -16
                    Font.Name = 'Segoe UI'
                    Font.Style = [fsBold]
                    ParentFont = False
                    TabOrder = 3
                  end
                  object edtPis: TDBCurrencyEdit
                    Left = 269
                    Top = 54
                    Width = 97
                    Height = 29
                    DisplayFormat = ' ,0.00;- ,0.00'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = 12418084
                    Font.Height = -16
                    Font.Name = 'Segoe UI'
                    Font.Style = [fsBold]
                    ParentFont = False
                    TabOrder = 2
                  end
                end
                object rgpRegime: TRadioGroup
                  Left = 17
                  Top = 7
                  Width = 533
                  Height = 76
                  Caption = ' Regime tribut'#225'rio '
                  Columns = 3
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -16
                  Font.Name = 'Segoe UI'
                  Font.Style = []
                  Items.Strings = (
                    'Simples nacional'
                    'Lucro presumido'
                    'Lucro real')
                  ParentFont = False
                  TabOrder = 0
                end
                object memoObsGeradaSistema: TMemo
                  Left = 23
                  Top = 246
                  Width = 524
                  Height = 100
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -13
                  Font.Name = 'Segoe UI'
                  Font.Style = []
                  ParentFont = False
                  TabOrder = 3
                end
                object BitBtn1: TBitBtn
                  Left = 416
                  Top = 208
                  Width = 131
                  Height = 32
                  Caption = ' Limpar observa'#231#227'o'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -13
                  Font.Name = 'Segoe UI'
                  Font.Style = []
                  ParentFont = False
                  TabOrder = 4
                  OnClick = BitBtn1Click
                end
                object edtSequenciaNF: TEdit
                  Left = 307
                  Top = 199
                  Width = 70
                  Height = 29
                  CharCase = ecUpperCase
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = 12418084
                  Font.Height = -16
                  Font.Name = 'Segoe UI'
                  Font.Style = [fsBold]
                  MaxLength = 10
                  ParentFont = False
                  TabOrder = 5
                  Visible = False
                end
              end
              object TabSheet4: TTabSheet
                Caption = 'NFC-e'
                ImageIndex = 1
                ExplicitLeft = 0
                ExplicitTop = 0
                ExplicitWidth = 0
                ExplicitHeight = 0
                object Label26: TLabel
                  Left = 18
                  Top = 5
                  Width = 93
                  Height = 21
                  Caption = 'C'#243'digo token'
                end
                object Label27: TLabel
                  Left = 129
                  Top = 5
                  Width = 42
                  Height = 21
                  Caption = 'Token'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -16
                  Font.Name = 'Segoe UI'
                  Font.Style = []
                  ParentFont = False
                end
                object Label28: TLabel
                  Left = 18
                  Top = 64
                  Width = 127
                  Height = 21
                  Caption = 'Forma de emiss'#227'o'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -16
                  Font.Name = 'Segoe UI'
                  Font.Style = []
                  ParentFont = False
                end
                object Label29: TLabel
                  Left = 218
                  Top = 64
                  Width = 71
                  Height = 21
                  Caption = 'Vers'#227'o DF'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -16
                  Font.Name = 'Segoe UI'
                  Font.Style = []
                  ParentFont = False
                end
                object Label31: TLabel
                  Left = 18
                  Top = 126
                  Width = 172
                  Height = 21
                  Caption = 'Intervalo entre tentativas'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -16
                  Font.Name = 'Segoe UI'
                  Font.Style = []
                  ParentFont = False
                end
                object Label32: TLabel
                  Left = 218
                  Top = 126
                  Width = 150
                  Height = 21
                  Caption = 'N'#250'mero de tentativas'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -16
                  Font.Name = 'Segoe UI'
                  Font.Style = []
                  ParentFont = False
                end
                object Label11: TLabel
                  Left = 418
                  Top = 64
                  Width = 129
                  Height = 21
                  Caption = 'Modelo Impress'#227'o'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -16
                  Font.Name = 'Segoe UI'
                  Font.Style = []
                  ParentFont = False
                end
                object edtCodigoToken: TCurrencyEdit
                  Left = 17
                  Top = 28
                  Width = 96
                  Height = 29
                  AutoSize = False
                  DisplayFormat = '0'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = 12418084
                  Font.Height = -16
                  Font.Name = 'Segoe UI'
                  Font.Style = [fsBold]
                  ParentFont = False
                  TabOrder = 0
                end
                object edtToken: TEdit
                  Left = 130
                  Top = 28
                  Width = 407
                  Height = 29
                  AutoSize = False
                  CharCase = ecUpperCase
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = 12418084
                  Font.Height = -13
                  Font.Name = 'Segoe UI'
                  Font.Style = [fsBold]
                  MaxLength = 80
                  ParentFont = False
                  TabOrder = 1
                end
                object cmbFormaEmissao: TComboBox
                  Left = 18
                  Top = 87
                  Width = 183
                  Height = 25
                  Style = csDropDownList
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -13
                  Font.Name = 'Segoe UI'
                  Font.Style = []
                  ItemIndex = 0
                  ParentFont = False
                  TabOrder = 2
                  Text = '1-NORMAL'
                  Items.Strings = (
                    '1-NORMAL'
                    '9-CONTING'#202'NCIA OFFLINE')
                end
                object cmbVersaoDF: TComboBox
                  Left = 218
                  Top = 87
                  Width = 183
                  Height = 25
                  Style = csDropDownList
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -13
                  Font.Name = 'Segoe UI'
                  Font.Style = []
                  ItemIndex = 2
                  ParentFont = False
                  TabOrder = 3
                  Text = 've310'
                  Items.Strings = (
                    've200'
                    've300'
                    've310')
                end
                object spnIntervaloTentativas: TSpinEdit
                  Left = 17
                  Top = 150
                  Width = 184
                  Height = 31
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = 12418084
                  Font.Height = -16
                  Font.Name = 'Segoe UI'
                  Font.Style = [fsBold]
                  MaxValue = 0
                  MinValue = 0
                  ParentFont = False
                  TabOrder = 4
                  Value = 1000
                end
                object spnNumTentativas: TSpinEdit
                  Left = 217
                  Top = 150
                  Width = 184
                  Height = 31
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = 12418084
                  Font.Height = -16
                  Font.Name = 'Segoe UI'
                  Font.Style = [fsBold]
                  MaxValue = 0
                  MinValue = 0
                  ParentFont = False
                  TabOrder = 5
                  Value = 4
                end
                object rgpVisualizaImpressao: TRadioGroup
                  Left = 17
                  Top = 193
                  Width = 250
                  Height = 51
                  Caption = ' Visualiza impress'#227'o '
                  Columns = 2
                  Items.Strings = (
                    'Sim'
                    'N'#227'o')
                  TabOrder = 6
                end
                object rgpViaConsumidor: TRadioGroup
                  Left = 289
                  Top = 193
                  Width = 250
                  Height = 51
                  Caption = ' Via consumidor '
                  Columns = 2
                  Items.Strings = (
                    'Sim'
                    'N'#227'o')
                  TabOrder = 7
                end
                object rgpImprimeItens: TRadioGroup
                  Left = 17
                  Top = 259
                  Width = 250
                  Height = 51
                  Caption = ' Imprime itens '
                  Columns = 2
                  Items.Strings = (
                    'Sim'
                    'N'#227'o')
                  TabOrder = 8
                end
                object cmbModeloImpressao: TComboBox
                  Left = 418
                  Top = 87
                  Width = 119
                  Height = 25
                  Style = csDropDownList
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -13
                  Font.Name = 'Segoe UI'
                  Font.Style = []
                  ItemIndex = 0
                  ParentFont = False
                  TabOrder = 9
                  Text = 'Padr'#227'o'
                  Items.Strings = (
                    'Padr'#227'o'
                    'A4')
                end
                object rgpImpComprovante: TRadioGroup
                  Left = 289
                  Top = 259
                  Width = 250
                  Height = 51
                  Caption = ' Imprime Comprovante Pedido'
                  Columns = 2
                  ItemIndex = 1
                  Items.Strings = (
                    'Sim'
                    'N'#227'o')
                  TabOrder = 10
                end
              end
              object TabSheet5: TTabSheet
                Caption = 'SAT'
                ImageIndex = 2
                object Label24: TLabel
                  Left = 17
                  Top = 5
                  Width = 132
                  Height = 21
                  Caption = 'C'#243'digo de ativa'#231#227'o'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -16
                  Font.Name = 'Segoe UI'
                  Font.Style = []
                  ParentFont = False
                end
                object Label25: TLabel
                  Left = 226
                  Top = 6
                  Width = 105
                  Height = 21
                  Caption = 'Ind. Rat. ISSQN'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -16
                  Font.Name = 'Segoe UI'
                  Font.Style = []
                  ParentFont = False
                end
                object Label34: TLabel
                  Left = 18
                  Top = 70
                  Width = 175
                  Height = 21
                  Caption = 'Regime Tribut'#225'rio ISSQN'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -16
                  Font.Name = 'Segoe UI'
                  Font.Style = []
                  ParentFont = False
                end
                object Label37: TLabel
                  Left = 226
                  Top = 70
                  Width = 53
                  Height = 21
                  Caption = 'Modelo'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -16
                  Font.Name = 'Segoe UI'
                  Font.Style = []
                  ParentFont = False
                end
                object Label38: TLabel
                  Left = 18
                  Top = 127
                  Width = 94
                  Height = 21
                  Caption = 'Caminho DLL'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -16
                  Font.Name = 'Segoe UI'
                  Font.Style = []
                  ParentFont = False
                end
                object Label39: TLabel
                  Left = 416
                  Top = 70
                  Width = 72
                  Height = 21
                  Caption = 'Impress'#227'o'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -16
                  Font.Name = 'Segoe UI'
                  Font.Style = []
                  ParentFont = False
                end
                object cbxIndRatISSQN: TComboBox
                  Left = 226
                  Top = 29
                  Width = 160
                  Height = 25
                  Style = csDropDownList
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -13
                  Font.Name = 'Segoe UI'
                  Font.Style = []
                  ItemIndex = 1
                  ParentFont = False
                  TabOrder = 0
                  Text = 'N'#227'o'
                  Items.Strings = (
                    'Sim'#11
                    'N'#227'o')
                end
                object cbxRegTribISSQN: TComboBox
                  Left = 18
                  Top = 93
                  Width = 176
                  Height = 25
                  Style = csDropDownList
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -13
                  Font.Name = 'Segoe UI'
                  Font.Style = []
                  ItemIndex = 6
                  ParentFont = False
                  TabOrder = 1
                  Text = 'RTISSNenhum'
                  Items.Strings = (
                    'RTISSMicroempresaMunicipal'
                    'RTISSEstimativa'
                    'RTISSSociedadeProfissionais'
                    'RTISSCooperativa'
                    'RTISSMEI'
                    'RTISSMEEPP'
                    'RTISSNenhum')
                end
                object gpbDadosSH: TGroupBox
                  Left = 3
                  Top = 216
                  Width = 551
                  Height = 144
                  Caption = ' Dados Software House '
                  TabOrder = 2
                  object Label35: TLabel
                    Left = 17
                    Top = 24
                    Width = 37
                    Height = 21
                    Caption = 'CNPJ'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -16
                    Font.Name = 'Segoe UI'
                    Font.Style = []
                    ParentFont = False
                  end
                  object Label36: TLabel
                    Left = 18
                    Top = 79
                    Width = 73
                    Height = 21
                    Caption = 'Assinatura'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -16
                    Font.Name = 'Segoe UI'
                    Font.Style = []
                    ParentFont = False
                  end
                  object edtCNPJSH: TEdit
                    Left = 18
                    Top = 48
                    Width = 135
                    Height = 29
                    AutoSize = False
                    CharCase = ecUpperCase
                    Enabled = False
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = 12418084
                    Font.Height = -13
                    Font.Name = 'Segoe UI'
                    Font.Style = [fsBold]
                    MaxLength = 80
                    ParentFont = False
                    TabOrder = 0
                    Text = '01934032000127'
                  end
                  object edtAssinaturaSH: TEdit
                    Left = 18
                    Top = 103
                    Width = 511
                    Height = 29
                    AutoSize = False
                    CharCase = ecUpperCase
                    Enabled = False
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = 12418084
                    Font.Height = -13
                    Font.Name = 'Segoe UI'
                    Font.Style = [fsBold]
                    MaxLength = 80
                    ParentFont = False
                    TabOrder = 1
                    Text = 
                      '9D4C4EEF8C515E2C1269C2E4FFF0719D526C5096422BF1DEFA20DF50BA06469A' +
                      '28ADB25BA0447BEFBCED7C0F805A5CC58496B7B23497AF9A04F69C77F17C0CE6' +
                      '8161F8E4CA7E3A94C827B6C563CA6F47AEA05FA90A8CE3E4327853BB2D664BA2' +
                      '26728FFF1E2C6275ECC9B20129E1C1D2671A837AA1D265B36809501B519DBC08' +
                      '129E1C1D2671A837AA1D265B36809501B519DBC08129E1C1D2671A837AA1D265' +
                      'B36809501B519DBC08129E1C'
                  end
                end
                object edtCodigoAtivacao: TCurrencyEdit
                  Left = 16
                  Top = 29
                  Width = 176
                  Height = 29
                  DisplayFormat = '0'
                  TabOrder = 3
                end
                object cbxModelo: TComboBox
                  Left = 226
                  Top = 93
                  Width = 160
                  Height = 25
                  Style = csDropDownList
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -13
                  Font.Name = 'Segoe UI'
                  Font.Style = []
                  ParentFont = False
                  TabOrder = 4
                  Items.Strings = (
                    'satNenhum'
                    'satDinamico_cdecl'
                    'satDinamico_stdcall'
                    'mfe_Integrador_XML')
                end
                object edtDLL: TEdit
                  Left = 18
                  Top = 151
                  Width = 495
                  Height = 29
                  AutoSize = False
                  CharCase = ecUpperCase
                  Enabled = False
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = 12418084
                  Font.Height = -13
                  Font.Name = 'Segoe UI'
                  Font.Style = [fsBold]
                  MaxLength = 80
                  ParentFont = False
                  ReadOnly = True
                  TabOrder = 5
                end
                object btnBuscarDLL: TBitBtn
                  Left = 516
                  Top = 150
                  Width = 38
                  Height = 30
                  Glyph.Data = {
                    36080000424D3608000000000000360000002800000020000000100000000100
                    2000000000000008000000000000000000000000000000000000FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
                    9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B
                    9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00667BB7003370
                    C200206DC9001E69C6001B67C6001A65C6001864C6001663C6001460C400125E
                    C600105CC400105BC400105BC400105EC8001059C1005E77B60002175300000C
                    5E00000965000005620000036200000162000000620000006200000060000000
                    62000000600000006000000060000000640000005D0000135200284AA10080DF
                    FF0041BCFF0043B8FF003FB4FF003BB1FF0036AEFF0032A9FF002EA6FF0029A1
                    FF00259EFF00219AFF002097FF00209AFF00229FFF00063AA00000003D001C7B
                    9B0000589B0000549B0000509B00004D9B00004A9B0000459B0000429B00003D
                    9B00003A9B0000369B0000339B0000369B00003B9B0000003C002447A30079D3
                    FF0040B1FE0041AEFC003FABFC0039A7FA0037A3F90033A0F9002F9CF9002C99
                    F9002896F8002393F8001E8EF8001D8DF9001F92FF00053CA20000003F00156F
                    9B00004D9A00004A98000047980000439600003F9500003C9500003895000035
                    950000329400002F9400002A940000299500002E9B0000003E00254CA8007ED7
                    FF0045B7FE0048B3FC0044B0FC0040ACFC003CA9FB0039A6FA0035A2FA00319F
                    FA002D9BFA002998F9002594F9002292FB002095FF00063FA600000044001A73
                    9B0000539A00004F9800004C9800004898000045970000429600003E9600003B
                    9600003796000034950000309500002E970000319B0000004200254CA80084DB
                    FF004CBBFE004DB8FD004AB5FD0045B1FC0041AEFC003EAAFC003AA7FA0036A4
                    FA0032A0FA002D9DFA002B99FA002998FA002499FF000642AC00000044002077
                    9B0000579A000054990000519900004D9800004A980000469800004396000040
                    9600003C960000399600003596000034960000359B00000048002554B30080DD
                    FF004EBFFE0050BDFD004FBAFD004CB6FC0046B3FC0043AFFC003FABFC003DA7
                    FB0037A4FA0033A1FA002D9CFA002396FB00259BFF000642AC0000004F001C79
                    9B00005B9A00005999000056990000529800004F9800004B9800004798000043
                    970000409600003D9600003896000032970000379B00000048002554B300AAEC
                    FF0061C9FE0053C2FD004EBDFD004AB9FD0046B5FD0042B1FC003EAEFC003AAA
                    FC0036A6FB0031A3FA0036A2FB004DADFD006FC0FF001450B70000004F004688
                    9B0000659A00005E9900005999000055990000519900004D9800004A98000046
                    980000429700003F9600003E9700004999000B5C9B0000005300295ABC00BEF4
                    FF0095DEFF0093D9FE0082D3FE0071C9FD0069C6FD0067C4FD0062C0FD005FBC
                    FD006ABFFD0072C2FD007EC6FD007CC5FE0080CBFF001452BB00000058005A90
                    9B00317A9B002F759A001E6F9A000D6599000562990003609900005C99000058
                    9900065B99000E5E99001A62990018619A001C679B0000005700285DC200BDF5
                    FF0093DFFF0094DCFE0093DAFE0091DAFE0090D8FF008DD6FF008BD4FF0087D1
                    FF0083CDFF007EC8FF0076C5FF0076C4FF007BCBFF001456C20000005E005991
                    9B002F7B9B0030789A002F769A002D769A002C749B0029729B0027709B00236D
                    9B001F699B001A649B0012619B0012609B0017679B0000005E00285DC200C0F8
                    FF0097E1FF0095DFFE0093DFFF00B4EFFF00B2EDFF00B0EBFF00AFE9FF00ACE6
                    FF00A9E4FF00A7E2FF00A5E0FF00A7E1FF00A9E5FF001B5FCA0000005E005C94
                    9B00337D9B00317B9A002F7B9B00508B9B004E899B004C879B004B859B004882
                    9B0045809B00437E9B00417C9B00437D9B0045819B0000006600285DC200BFFB
                    FF0099E5FF0098E2FF009DE9FF004881D9002B60CD002D6CD2002D6BD1002D6B
                    D1002C6AD1002B6AD0002D6BD0002D6CD1002E6DD30085A9E20000005E005B97
                    9B0035819B00347E9B0039859B00001D75000000690000086E0000076D000007
                    6D0000066D0000066C0000076C0000086D0000096F0021457E002E6ED500D4FF
                    FF00A8F1FF00A6EFFF00B1F9FF001462D200FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000A7100709B
                    9B00448D9B00428B9B004D959B0000006E009B9B9B009B9B9B009B9B9B009B9B
                    9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B001866D800B6E5
                    FA00B3E8FB00B2E5FC00A8DEF8001667D900FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000274005281
                    96004F8497004E819800447A9400000375009B9B9B009B9B9B009B9B9B009B9B
                    9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00ACC8F2001F6C
                    DE002B72DE002B70DE00206CDE00A2C1F000FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0048648E000008
                    7A00000E7A00000C7A0000087A003E5D8C009B9B9B009B9B9B009B9B9B009B9B
                    9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
                    9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B
                    9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00}
                  NumGlyphs = 2
                  TabOrder = 6
                  OnClick = btnBuscarDLLClick
                end
                object cbxImpressao: TComboBox
                  Left = 416
                  Top = 93
                  Width = 129
                  Height = 25
                  Style = csDropDownList
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -13
                  Font.Name = 'Segoe UI'
                  Font.Style = []
                  ItemIndex = 0
                  ParentFont = False
                  TabOrder = 7
                  Text = 'Normal'
                  Items.Strings = (
                    'Normal'
                    'Resumida')
                end
              end
            end
            object edtCertificado: TEdit
              Left = 18
              Top = 23
              Width = 391
              Height = 29
              CharCase = ecUpperCase
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 12418084
              Font.Height = -16
              Font.Name = 'Segoe UI'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 1
            end
            object edtSenhaNFe: TEdit
              Left = 18
              Top = 82
              Width = 391
              Height = 29
              CharCase = ecUpperCase
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 12418084
              Font.Height = -16
              Font.Name = 'Segoe UI'
              Font.Style = [fsBold]
              MaxLength = 15
              ParentFont = False
              PasswordChar = '*'
              TabOrder = 2
            end
            object cmbAmbiente: TComboBox
              Left = 426
              Top = 83
              Width = 123
              Height = 25
              Style = csDropDownList
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'Segoe UI'
              Font.Style = []
              ItemIndex = 1
              ParentFont = False
              TabOrder = 3
              Text = 'HOMOLOGA'#199#195'O'
              Items.Strings = (
                'PRODU'#199#195'O'
                'HOMOLOGA'#199#195'O')
            end
          end
          object TabSheet2: TTabSheet
            Caption = 'Informa'#231#245'es de e-mail'
            ImageIndex = 1
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object Label18: TLabel
              Left = 49
              Top = 16
              Width = 76
              Height = 21
              Caption = 'SMTP Host'
            end
            object Label19: TLabel
              Left = 354
              Top = 14
              Width = 73
              Height = 21
              Caption = 'SMTP Port'
            end
            object Label20: TLabel
              Left = 49
              Top = 78
              Width = 76
              Height = 21
              Caption = 'SMTP User'
            end
            object Label21: TLabel
              Left = 353
              Top = 78
              Width = 111
              Height = 21
              Caption = 'SMTP Password'
            end
            object Label22: TLabel
              Left = 49
              Top = 139
              Width = 56
              Height = 21
              Caption = 'Assunto'
            end
            object Label23: TLabel
              Left = 49
              Top = 198
              Width = 77
              Height = 21
              Caption = 'Mensagem'
            end
            object edtHost: TEdit
              Left = 50
              Top = 39
              Width = 275
              Height = 29
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 12418084
              Font.Height = -16
              Font.Name = 'Segoe UI'
              Font.Style = []
              MaxLength = 50
              ParentFont = False
              TabOrder = 0
            end
            object edtPort: TCurrencyEdit
              Left = 353
              Top = 39
              Width = 136
              Height = 29
              AutoSize = False
              DisplayFormat = '0'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 12418084
              Font.Height = -16
              Font.Name = 'Segoe UI'
              Font.Style = []
              ParentFont = False
              TabOrder = 1
            end
            object edtUser: TEdit
              Left = 50
              Top = 101
              Width = 275
              Height = 29
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 12418084
              Font.Height = -16
              Font.Name = 'Segoe UI'
              Font.Style = []
              MaxLength = 50
              ParentFont = False
              TabOrder = 2
            end
            object edtPassword: TEdit
              Left = 353
              Top = 101
              Width = 136
              Height = 29
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 12418084
              Font.Height = -16
              Font.Name = 'Segoe UI'
              Font.Style = []
              MaxLength = 50
              ParentFont = False
              PasswordChar = '*'
              TabOrder = 3
            end
            object edtAssunto: TEdit
              Left = 50
              Top = 162
              Width = 439
              Height = 29
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 12418084
              Font.Height = -16
              Font.Name = 'Segoe UI'
              Font.Style = []
              MaxLength = 50
              ParentFont = False
              TabOrder = 4
            end
            object memoMensagem: TMemo
              Left = 50
              Top = 223
              Width = 439
              Height = 270
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 12418084
              Font.Height = -16
              Font.Name = 'Segoe UI'
              Font.Style = []
              MaxLength = 2000
              ParentFont = False
              TabOrder = 5
            end
          end
        end
      end
    end
  end
  inherited cds: TClientDataSet
    Left = 175
    Top = 48
    object cdsCODIGO: TIntegerField
      FieldName = 'CODIGO'
    end
    object cdsRAZAO: TStringField
      FieldName = 'RAZAO'
      Size = 60
    end
    object cdsFANTASIA: TStringField
      FieldName = 'FANTASIA'
      Size = 60
    end
    object cdsCPF_CNPJ: TStringField
      FieldName = 'CPF_CNPJ'
    end
    object cdsENDERECO: TStringField
      FieldName = 'ENDERECO'
      Size = 60
    end
    object cdsCIDADE: TStringField
      FieldName = 'CIDADE'
      Size = 60
    end
    object cdsFONE: TStringField
      FieldName = 'FONE'
      Size = 15
    end
    object cdsCELULAR: TStringField
      FieldName = 'CELULAR'
      Size = 15
    end
  end
  inherited ds: TDataSource
    Left = 218
    Top = 48
  end
end
