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
    ExplicitWidth = 1177
    ExplicitHeight = 35
    inherited tsConsulta: TTabSheet
      ExplicitWidth = 1169
      ExplicitHeight = 25
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
        Width = 1169
        ExplicitTop = 0
        ExplicitWidth = 1169
      end
    end
    inherited tsDados: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 32
      ExplicitWidth = 1169
      ExplicitHeight = 25
      inherited pnlDados: TPanel
        Width = 1169
        Height = 585
        ExplicitWidth = 1169
        ExplicitHeight = 25
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
              ActivePage = TabSheet3
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
