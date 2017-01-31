inherited frmRelatorioNFEs: TfrmRelatorioNFEs
  Caption = 'Relat'#243'rio de NF-es'
  ClientHeight = 225
  ClientWidth = 543
  OnShow = FormShow
  ExplicitWidth = 559
  ExplicitHeight = 263
  PixelsPerInch = 96
  TextHeight = 17
  object RLReport1: TRLReport
    Left = 7
    Top = 132
    Width = 794
    Height = 1123
    Margins.LeftMargin = 5.000000000000000000
    Margins.RightMargin = 5.000000000000000000
    DataSource = dsNFe
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Calibri'
    Font.Style = []
    Visible = False
    BeforePrint = RLReport1BeforePrint
    object RLBand1: TRLBand
      Left = 19
      Top = 38
      Width = 756
      Height = 91
      BandType = btTitle
      Borders.Sides = sdCustom
      Borders.DrawLeft = True
      Borders.DrawTop = True
      Borders.DrawRight = True
      Borders.DrawBottom = True
      object RLLabel14: TRLLabel
        Left = 429
        Top = 73
        Width = 261
        Height = 15
        Caption = 'Enviadas            Canceladas           N'#227'o enviadas'
      end
      object RLLabel2: TRLLabel
        Left = -2
        Top = 58
        Width = 759
        Height = 15
        Caption = 
          '----------------------------------------------------------------' +
          '----------------------------------------------------------------' +
          '-------------------------------------------------------------'
      end
      object RLLabel1: TRLLabel
        Left = 236
        Top = 15
        Width = 177
        Height = 29
        Caption = 'Relat'#243'rio de NF-e'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -24
        Font.Name = 'Calibri'
        Font.Style = []
        ParentFont = False
      end
      object RLSystemInfo1: TRLSystemInfo
        Left = 673
        Top = 23
        Width = 36
        Height = 15
        Text = ''
      end
      object RLLabel3: TRLLabel
        Left = 641
        Top = 23
        Width = 25
        Height = 15
        Caption = 'Dia:'
      end
      object RLSystemInfo2: TRLSystemInfo
        Left = 681
        Top = 43
        Width = 38
        Height = 15
        Info = itHour
        Text = ''
      end
      object RLLabel4: TRLLabel
        Left = 641
        Top = 43
        Width = 33
        Height = 15
        Caption = 'Hora:'
      end
      object RLSystemInfo3: TRLSystemInfo
        Left = 620
        Top = 3
        Width = 80
        Height = 15
        Alignment = taRightJustify
        Info = itPageNumber
        Text = ''
      end
      object RLLabel5: TRLLabel
        Left = 698
        Top = 3
        Width = 8
        Height = 15
        Caption = '/'
      end
      object RLSystemInfo4: TRLSystemInfo
        Left = 706
        Top = 3
        Width = 102
        Height = 15
        Info = itLastPageNumber
        Text = ''
      end
      object rlbReferente: TRLLabel
        Left = 4
        Top = 69
        Width = 79
        Height = 18
        Caption = 'Referente '#224' '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Calibri'
        Font.Style = []
        ParentFont = False
      end
      object RLDraw1: TRLDraw
        Left = 405
        Top = 70
        Width = 20
        Height = 18
        Brush.Style = bsClear
        DrawKind = dkElipse
      end
      object RLDraw2: TRLDraw
        Left = 494
        Top = 70
        Width = 20
        Height = 18
        Brush.Style = bsClear
        DrawKind = dkElipse
      end
      object RLDraw3: TRLDraw
        Left = 590
        Top = 70
        Width = 20
        Height = 18
        Brush.Style = bsClear
        DrawKind = dkElipse
      end
      object RLLabel15: TRLLabel
        Left = 641
        Top = 3
        Width = 29
        Height = 15
        Caption = 'P'#225'g,:'
      end
      object lbEnviadas: TRLLabel
        Left = 410
        Top = 69
        Width = 10
        Height = 18
        Caption = 'x'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentFont = False
        Visible = False
      end
      object lbCanceladas: TRLLabel
        Left = 499
        Top = 69
        Width = 10
        Height = 18
        Caption = 'x'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentFont = False
        Visible = False
      end
      object lbNaoEnviadas: TRLLabel
        Left = 595
        Top = 69
        Width = 10
        Height = 18
        Caption = 'x'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentFont = False
        Visible = False
      end
    end
    object RLGroup1: TRLGroup
      Left = 19
      Top = 129
      Width = 756
      Height = 160
      DataFields = 'DATA'
      object RLBand3: TRLBand
        Left = 0
        Top = 0
        Width = 756
        Height = 53
        BandType = btColumnHeader
        Borders.Sides = sdCustom
        Borders.DrawLeft = False
        Borders.DrawTop = False
        Borders.DrawRight = False
        Borders.DrawBottom = False
        object RLDBText2: TRLDBText
          Left = 1
          Top = 11
          Width = 49
          Height = 23
          DataField = 'DATA'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Calibri'
          Font.Style = [fsBold]
          ParentFont = False
          Text = ''
        end
        object RLLabel7: TRLLabel
          Left = 7
          Top = 35
          Width = 48
          Height = 15
          Caption = 'N'#186' Nota'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Calibri'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLLabel8: TRLLabel
          Left = 65
          Top = 35
          Width = 36
          Height = 15
          Caption = 'Chave'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Calibri'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLLabel9: TRLLabel
          Left = 386
          Top = 35
          Width = 37
          Height = 15
          Caption = 'Status'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Calibri'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLLabel10: TRLLabel
          Left = 697
          Top = 35
          Width = 32
          Height = 15
          Caption = 'Valor'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Calibri'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
      object RLGroup2: TRLGroup
        Left = 0
        Top = 53
        Width = 756
        Height = 64
        DataFields = 'NUMERO_NOTA_FISCAL'
        object RLBand4: TRLBand
          Left = 0
          Top = 0
          Width = 756
          Height = 22
          BandType = btColumnHeader
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = True
          Borders.DrawRight = False
          Borders.DrawBottom = True
          object RLDBText4: TRLDBText
            Left = 9
            Top = 3
            Width = 129
            Height = 15
            DataField = 'NUMERO_NOTA_FISCAL'
            DataSource = dsNFe
            Text = ''
            BeforePrint = RLDBText4BeforePrint
          end
          object RLDBText5: TRLDBText
            Left = 65
            Top = 3
            Width = 82
            Height = 14
            DataField = 'CHAVE_ACESSO'
            DataSource = dsNFe
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = 'Calibri'
            Font.Style = []
            ParentFont = False
            Text = ''
          end
          object RLDBText6: TRLDBText
            Left = 387
            Top = 3
            Width = 42
            Height = 15
            DataField = 'STATUS'
            DataSource = dsNFe
            Text = ''
          end
          object RLLabel11: TRLLabel
            Left = 410
            Top = 3
            Width = 7
            Height = 15
            Caption = '-'
          end
          object RLDBText7: TRLDBText
            Left = 417
            Top = 3
            Width = 250
            Height = 15
            AutoSize = False
            DataField = 'MOTIVO'
            DataSource = dsNFe
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = 'Calibri'
            Font.Style = []
            ParentFont = False
            Text = ''
          end
          object RLDBText8: TRLDBText
            Left = 713
            Top = 3
            Width = 36
            Height = 15
            Alignment = taRightJustify
            DataField = 'TOTAL'
            DataSource = dsNFe
            Text = ''
            BeforePrint = RLDBText8BeforePrint
          end
        end
        object RLBand5: TRLBand
          Left = 0
          Top = 22
          Width = 756
          Height = 23
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = False
          Borders.DrawRight = False
          Borders.DrawBottom = False
          object RLDBText1: TRLDBText
            Left = 19
            Top = 4
            Width = 74
            Height = 15
            Alignment = taRightJustify
            DataField = 'QUANTIDADE'
            DataSource = dsNFe
            Text = ''
          end
          object RLDBText9: TRLDBText
            Left = 109
            Top = 5
            Width = 57
            Height = 15
            DataField = 'PRODUTO'
            DataSource = dsNFe
            Text = ''
          end
          object RLDBText10: TRLDBText
            Left = 523
            Top = 4
            Width = 59
            Height = 15
            DataField = 'NCM_IBPT'
            DataSource = dsNFe
            Text = ''
          end
          object lbQtde: TRLLabel
            Left = 19
            Top = 4
            Width = 35
            Height = 15
            Caption = 'Qtde:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Calibri'
            Font.Style = [fsBold]
            ParentFont = False
            AfterPrint = lbQtdeAfterPrint
          end
          object lbNCM: TRLLabel
            Left = 486
            Top = 4
            Width = 34
            Height = 15
            Caption = 'NCM:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Calibri'
            Font.Style = [fsBold]
            ParentFont = False
            AfterPrint = lbNCMAfterPrint
          end
        end
      end
      object RLBand6: TRLBand
        Left = 0
        Top = 117
        Width = 756
        Height = 28
        BandType = btSummary
        Borders.Sides = sdCustom
        Borders.DrawLeft = False
        Borders.DrawTop = True
        Borders.DrawRight = False
        Borders.DrawBottom = True
        object RLLabel16: TRLLabel
          Left = 534
          Top = 5
          Width = 98
          Height = 19
          Caption = 'Total do dia >'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Calibri'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lbTotalDia: TRLLabel
          Left = 717
          Top = 5
          Width = 32
          Height = 19
          Alignment = taRightJustify
          Caption = '0,00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Calibri'
          Font.Style = [fsBold]
          ParentFont = False
          BeforePrint = lbTotalDiaBeforePrint
        end
      end
    end
    object RLBand2: TRLBand
      Left = 19
      Top = 289
      Width = 756
      Height = 25
      AlignToBottom = True
      BandType = btSummary
      Borders.Sides = sdCustom
      Borders.DrawLeft = False
      Borders.DrawTop = True
      Borders.DrawRight = False
      Borders.DrawBottom = False
      object RLLabel13: TRLLabel
        Left = 528
        Top = 3
        Width = 104
        Height = 19
        Caption = 'Total do m'#234's >'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbTotalGeral: TRLLabel
        Left = 717
        Top = 3
        Width = 32
        Height = 19
        Alignment = taRightJustify
        Caption = '0,00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentFont = False
        BeforePrint = lbTotalGeralBeforePrint
      end
    end
  end
  object GroupBox1: TGroupBox
    Left = 16
    Top = 8
    Width = 129
    Height = 73
    Caption = ' Ano '
    TabOrder = 0
    object cmbAno: TComboBox
      Left = 20
      Top = 31
      Width = 88
      Height = 25
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 0
      Text = '2016'
      Items.Strings = (
        '2016'
        '2017'
        '2018'
        '2019'
        '2020'
        '2021'
        '2022'
        '2023'
        '2024'
        '2025'
        '2026'
        '2027'
        '2028'
        '2029'
        '2030')
    end
  end
  object GroupBox2: TGroupBox
    Left = 160
    Top = 8
    Width = 137
    Height = 73
    Caption = ' M'#234's '
    TabOrder = 1
    object cmbMes: TComboBox
      Left = 19
      Top = 31
      Width = 99
      Height = 25
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 0
      Text = 'JANEIRO'
      Items.Strings = (
        'JANEIRO'
        'FEVEREIRO'
        'MAR'#199'O'
        'ABRIL'
        'MAIO'
        'JUNHO'
        'JULHO'
        'AGOSTO'
        'SETEMBRO'
        'OUTUBRO'
        'NOVEMBRO'
        'DEZEMBRO')
    end
  end
  object GroupBox3: TGroupBox
    Left = 312
    Top = 8
    Width = 216
    Height = 73
    Caption = ' Status '
    TabOrder = 2
    object chkEnviadas: TCheckBox
      Left = 14
      Top = 23
      Width = 83
      Height = 17
      Caption = 'Enviadas'
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
    object chkCanceladas: TCheckBox
      Left = 14
      Top = 47
      Width = 83
      Height = 17
      Caption = 'Canceladas'
      TabOrder = 1
    end
    object chkNaoEnviadas: TCheckBox
      Left = 110
      Top = 23
      Width = 103
      Height = 17
      Caption = 'N'#227'o enviadas'
      TabOrder = 2
    end
  end
  object rgpLeiaute: TRadioGroup
    Left = 16
    Top = 88
    Width = 512
    Height = 52
    Caption = ' Leiaute '
    Columns = 2
    ItemIndex = 1
    Items.Strings = (
      'Anal'#237'tico'
      'Sint'#233'tico')
    TabOrder = 3
  end
  object pnlBotoes: TPanel
    Left = 0
    Top = 174
    Width = 543
    Height = 51
    Align = alBottom
    TabOrder = 4
    ExplicitTop = 176
    ExplicitWidth = 544
    DesignSize = (
      543
      51)
    object btnImprimir: TBitBtn
      Left = 369
      Top = 8
      Width = 155
      Height = 30
      Anchors = [akTop, akRight]
      Caption = ' [CTRL+P] Imprimir'
      Glyph.Data = {
        36080000424D3608000000000000360000002800000020000000100000000100
        2000000000000008000000000000000000000000000000000000FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00D7C39B00ECE3D600ECE3D600ECE3D600ECE3D600ECE3
        D600ECE3D600D7C39B00FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
        9B009B9B9B009B9B9B00735F3700887F7200887F7200887F7200887F7200887F
        7200887F7200735F37009B9B9B009B9B9B009B9B9B009B9B9B00B0ACAC00B1AC
        AC00A7A2A200726C7300C4AB7F00EDE1D500EDE1D500EDE1D500EDE1D500EDE1
        D500EDE1D500C4AB7F0076717700A49E9E00A9A4A400ABA5A5004C4848004D48
        4800433E3E000E080F0060471B00897D7100897D7100897D7100897D7100897D
        7100897D710060471B00120D1300403A3A004540400047414100958F8F00C3C0
        BF00C3C0BF00837D8400C6A87400E0CBAE00E0CBAE00E0CBAE00E0CBAE00E0CB
        AE00E0CBAE00C6A87400837D8400C3C0BF00C3C0BF0099929200312B2B005F5C
        5B005F5C5B001F192000624410007C674A007C674A007C674A007C674A007C67
        4A007C674A00624410001F1920005F5C5B005F5C5B00352E2E00A49FA100D1CF
        CE00D1CFCE00D3D2D100D2D2D300D0D0D200D0D0D200D0D0D200D0D0D200D0D0
        D200D0D0D200D2D2D300D3D2D100BACAD7006E9BE300A49FA100403B3D006D6B
        6A006D6B6A006F6E6D006E6E6F006C6C6E006C6C6E006C6C6E006C6C6E006C6C
        6E006C6C6E006E6E6F006F6E6D00566673000A377F00403B3D00AAA7A700D9D7
        D700D9D7D700D9D7D700D9D7D700D9D7D700D9D7D700D9D7D700D9D7D700D9D7
        D700D9D7D700D9D7D700D9D7D7008AC3E900004BFB00ABA8A800464343007573
        7300757373007573730075737300757373007573730075737300757373007573
        7300757373007573730075737300265F85000000970047444400B7B3B300E6E8
        E900D6C5AF00BC6B1000BB6A0F00BB6A0F00BB6A0F00BB6A0F00BB6A0F00BB6A
        0F00BB6A0F00BB6A0F00BC6B1000D6C5AF00E6E8E900B8B5B500534F4F008284
        850072614B005807000057060000570600005706000057060000570600005706
        000057060000570600005807000072614B008284850054515100BCB9BA00EEF2
        F500BA7B3E00E1A94200E1A84200E1A84200E1A84200E1A84200E1A84200E1A8
        4200E1A84200E1A84200E1A94200BA7B3E00EEF2F500BFBBBC00585556008A8E
        9100561700007D4500007D4400007D4400007D4400007D4400007D4400007D44
        00007D4400007D4400007D450000561700008A8E91005B575800CDC8C900F8FC
        FF00CD975300EEC67000EEC77100EEC77100EEC77100EEC77100EEC77100EEC7
        7100EEC77100EEC77100EEC67000CD975300F8FCFF00CECBCC00696465009498
        9B00693300008A620C008A630D008A630D008A630D008A630D008A630D008A63
        0D008A630D008A630D008A620C006933000094989B006A676800D2D0D000FCFF
        FF00D7A55C00EDC97700E9BF6800E9BF6800E9BF6800E9BF6800E9BF6800E9BF
        6800E9BF6800E9BF6800EDC97700D7A55C00FCFFFF00D4D1D0006E6C6C00989B
        9B007341000089651300855B0400855B0400855B0400855B0400855B0400855B
        0400855B0400855B04008965130073410000989B9B00706D6C00DEDCDB00FFFF
        FF00E8C07000E0AC5400B99D6B00D7BD9100D7BD9100D7BD9100D7BD9100D7BD
        9100D7BD9100B99D6B00E0AC5400E8C07000FFFFFF00E3DFDF007A7877009B9B
        9B00845C0C007C4800005539070073592D0073592D0073592D0073592D007359
        2D0073592D00553907007C480000845C0C009B9B9B007F7B7B00D1CBCD00BCBB
        C000DEB67300CF9E5F00C4AB7F00DFCAAD00DFCAAD00DFCAAD00DFCAAD00DFCA
        AD00DFCAAD00C4AB7F00CD995600DDB36E00BEBDC100D1CACC006D6769005857
        5C007A520F006B3A000060471B007B6649007B6649007B6649007B6649007B66
        49007B66490060471B0069350000794F0A005A595D006D666800FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00D0BD9800ECDFD100ECDFD100ECDFD100ECDFD100ECDF
        D100ECDFD100D0BD9800FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
        9B009B9B9B009B9B9B006C593400887B6D00887B6D00887B6D00887B6D00887B
        6D00887B6D006C5934009B9B9B009B9B9B009B9B9B009B9B9B00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00D5C4A400EFE4D800EFE4D800EFE4D800EFE4D800EFE4
        D800EFE4D800D5C4A400FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
        9B009B9B9B009B9B9B00716040008B8074008B8074008B8074008B8074008B80
        74008B807400716040009B9B9B009B9B9B009B9B9B009B9B9B00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00DED0B800F5EDE400F5EDE400F5EDE400F5EDE400F5ED
        E400F5EDE400DED0B800FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
        9B009B9B9B009B9B9B007A6C5400918980009189800091898000918980009189
        8000918980007A6C54009B9B9B009B9B9B009B9B9B009B9B9B00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00E2D6C100F8F3EA00F8F3EA00F8F3EA00F8F3EA00F8F3
        EA00F8F3EA00E2D6C100FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
        9B009B9B9B009B9B9B007E725D00948F8600948F8600948F8600948F8600948F
        8600948F86007E725D009B9B9B009B9B9B009B9B9B009B9B9B00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00E7DDCD00EFE8DB00EFE8DB00EFE8DB00EFE8DB00EFE8
        DB00EFE8DB00E8DFD000FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
        9B009B9B9B009B9B9B00837969008B8477008B8477008B8477008B8477008B84
        77008B847700847B6C009B9B9B009B9B9B009B9B9B009B9B9B00}
      NumGlyphs = 2
      TabOrder = 0
      OnClick = btnImprimirClick
      ExplicitLeft = 370
    end
    object btnVoltar: TBitBtn
      Left = 193
      Top = 8
      Width = 155
      Height = 30
      Anchors = [akTop, akRight]
      Caption = ' [ESC] Voltar'
      Glyph.Data = {
        36080000424D3608000000000000360000002800000020000000100000000100
        2000000000000008000000000000000000000000000000000000FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E5650800E46A0C00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
        9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B0081010000800600009B9B
        9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E6670A00E5801A00E5781600FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
        9B009B9B9B009B9B9B009B9B9B009B9B9B0082030000811C0000811400009B9B
        9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00E7690700ED9A2E00F0B03E00E26E1000FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
        9B009B9B9B009B9B9B009B9B9B0083050000893600008C4C00007E0A00009B9B
        9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00E96F0800EEA13900F8CB5D00E99B3600DC700E00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
        9B009B9B9B009B9B9B00850B00008A3D00009467000085370000780C00009B9B
        9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00FFFFFF00FFFF
        FF00FFFFFF00ED770900EFAE4A00F9D06F00F7C05400DF973700D7782100E082
        2500DC781F00DC781900DB721300DA6B0F00DA680A00D35008009B9B9B009B9B
        9B009B9B9B00891300008B4A0000956C0B00935C00007B330000731400007C1E
        00007814000078140000770E000076070000760400006F000000FFFFFF00FFFF
        FF00EE7F0A00F4BB5F00FAD88500F7C76500F6C05900EDAF4A00EAAA4100E7A5
        3500E89E2B00E7932100E4891900E2821100E37D0A00CB4B00009B9B9B009B9B
        9B008A1B0000905700009674210093630100925C0000894B0000864600008341
        0000843A0000832F0000802500007E1E00007F19000067000000FFFFFF00F188
        0C00F6C67100FCE19F00F9CE7A00F7CA6D00F6C36100F6C05500F6BA4A00F4B3
        3E00F3AA3300F1A32900F09A1F00EF921700EE8B0F00CE4E02009B9B9B008D24
        000092620D00987D3B00956A160093660900925F0000925C000092560000904F
        00008F4600008D3F00008C3600008B2E00008A2700006A000000F3971400F9DC
        9B00FEEFD000FAD78800F9D38300F8CF7700F7C86900F5C15B00F4BB5100F2B6
        4500F1AC3900F0A53000EE9D2600ED941C00EF911500D05406008F3300009578
        37009A8B6C0096732400956F1F00946B130093640500915D0000905700008E52
        00008D4800008C4100008A390000893000008B2D00006C000000F2950E00F8CF
        8700FFF9EC00FCE1AC00F9D58300F8D27F00F7CB7200F6C56300F4BD5400F3B5
        4400F2AF3B00F0A63200EF9F2600ED951D00F0971800D65908008E310000946B
        23009B958800987D480095711F00946E1B0093670E0092610000905900008F51
        00008E4B00008C4200008B3B0000893100008C33000072000000FFFFFF00F386
        0100F5C17000FFFAEC00FCE2AD00F9D17D00F8CF7A00F7C86800F6C56A00F4C2
        6100F3BB5300F2B44700F0AE3D00EFA53200F09F2000DA6009009B9B9B008F22
        0000915D0C009B968800987E4900956D1900946B16009364040092610600905E
        00008F5700008E5000008C4A00008B4100008C3B000076000000FFFFFF00FFFF
        FF00F17D0000F5BB6800FFFAEB00FBE1AD00F9CE7000F8CC7000FBE7B600FAEA
        BE00F9E2AB00F8DE9C00F6D88A00F6D47F00F6C34E00D96209009B9B9B009B9B
        9B008D190000915704009B968700977D4900956A0C0094680C00978352009686
        5A00957E4700947A38009274260092701B00925F000075000000FFFFFF00FFFF
        FF00FFFFFF00EF780000F2B35C00FEF8E400FCE7BF00F8D17C00F3A94300F1A1
        3700F0A03100EF9A2B00ED912500EC882100EC8A2100DF640F009B9B9B009B9B
        9B009B9B9B008B1400008E4F00009A94800098835B00946D18008F4500008D3D
        00008C3C00008B360000892D000088240000882600007B000000FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00EE700000F1AC5000FEFDF100F9D59300EA780300FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
        9B009B9B9B009B9B9B008A0C00008D4800009A998D0095712F00861400009B9B
        9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00ED6F0000F1AA5500FAE39F00ED8F1B00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
        9B009B9B9B009B9B9B009B9B9B00890B00008D460000967F3B00892B00009B9B
        9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00ED710400EEA03100ED952500FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
        9B009B9B9B009B9B9B009B9B9B009B9B9B00890D00008A3C0000893100009B9B
        9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00EF830700ED820B00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
        9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B008B1F0000891E00009B9B
        9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00}
      NumGlyphs = 2
      TabOrder = 1
      OnClick = btnVoltarClick
      ExplicitLeft = 194
    end
  end
  object dsNFe: TDataSource
    DataSet = qryNFe
    Left = 448
    Top = 112
  end
  object qryNFe: TFDQuery
    Connection = dm.FDConnection
    SQL.Strings = (
      
        'select NF.numero_nota_fiscal, NFER.status, NFER.motivo, NFE.chav' +
        'e_acesso, NFE.XML,'
      
        ' CAST(NF.data_saida as DATE) data, TNF.total, PRO.descricao prod' +
        'uto,               '
      
        ' ibpt.ncm_ibpt, INF.quantidade                           from NO' +
        'TAS_FISCAIS NF     '
      
        ' left join NOTAS_FISCAIS_NFE NFE on NFE.CODIGO_NOTA_FISCAL = NF.' +
        'CODIGO             '
      
        ' left join NOTAS_FISCAIS_NFE_RETORNO NFER ON NFER.CODIGO_NOTA_FI' +
        'SCAL = NF.CODIGO   '
      
        ' inner join ITENS_NOTAS_FISCAIS INF on INF.CODIGO_NOTA_FISCAL = ' +
        'NF.CODIGO          '
      
        ' inner join PRODUTOS PRO on PRO.CODIGO = INF.CODIGO_PRODUTO     ' +
        '                   '
      
        ' inner join TOTAIS_NOTAS_FISCAIS TNF on TNF.CODIGO_NOTA_FISCAL =' +
        ' NF.CODIGO         '
      
        ' inner join ibpt         on ibpt.codigo = pro.codigo_ibpt       ' +
        '                   '
      
        ' where (extract(year from NF.data_saida) = :ano and             ' +
        '                   '
      
        '        extract(month from NF.data_saida) = :mes)               ' +
        '                   '
      
        ' order by NF.data_saida, NF.codigo                              ' +
        '                   ')
    Left = 496
    Top = 112
    ParamData = <
      item
        Name = 'ANO'
        DataType = ftSmallint
        ParamType = ptInput
      end
      item
        Name = 'MES'
        DataType = ftSmallint
        ParamType = ptInput
      end>
    object qryNFeNUMERO_NOTA_FISCAL: TIntegerField
      FieldName = 'NUMERO_NOTA_FISCAL'
      Origin = 'NUMERO_NOTA_FISCAL'
      Required = True
    end
    object qryNFeSTATUS: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'STATUS'
      Origin = 'STATUS'
      ProviderFlags = []
      ReadOnly = True
      Size = 3
    end
    object qryNFeMOTIVO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'MOTIVO'
      Origin = 'MOTIVO'
      ProviderFlags = []
      ReadOnly = True
      Size = 800
    end
    object qryNFeCHAVE_ACESSO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'CHAVE_ACESSO'
      Origin = 'CHAVE_ACESSO'
      ProviderFlags = []
      ReadOnly = True
      Size = 44
    end
    object qryNFeXML: TMemoField
      AutoGenerateValue = arDefault
      FieldName = 'XML'
      Origin = 'XML'
      ProviderFlags = []
      ReadOnly = True
      BlobType = ftMemo
    end
    object qryNFeDATA: TDateField
      AutoGenerateValue = arDefault
      FieldName = 'DATA'
      Origin = '"DATA"'
      ProviderFlags = []
      ReadOnly = True
    end
    object qryNFeTOTAL: TBCDField
      AutoGenerateValue = arDefault
      FieldName = 'TOTAL'
      Origin = 'TOTAL'
      ProviderFlags = []
      ReadOnly = True
      DisplayFormat = ' ,0.00;- ,0.00'
      currency = True
      Precision = 18
      Size = 2
    end
    object qryNFePRODUTO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'PRODUTO'
      Origin = 'DESCRICAO'
      ProviderFlags = []
      ReadOnly = True
      Size = 70
    end
    object qryNFeNCM_IBPT: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'NCM_IBPT'
      Origin = 'NCM_IBPT'
      ProviderFlags = []
      ReadOnly = True
      Size = 10
    end
    object qryNFeQUANTIDADE: TBCDField
      AutoGenerateValue = arDefault
      FieldName = 'QUANTIDADE'
      Origin = 'QUANTIDADE'
      ProviderFlags = []
      ReadOnly = True
      Precision = 18
    end
  end
  object ACBrMail1: TACBrMail
    Host = '127.0.0.1'
    Port = '25'
    SetSSL = False
    SetTLS = False
    Attempts = 3
    DefaultCharset = UTF_8
    IDECharset = CP1252
    Left = 192
    Top = 112
  end
  object RLPDFFilter1: TRLPDFFilter
    DocumentInfo.Creator = 
      'FortesReport Community Edition v4.0 \251 Copyright '#169' 1999-2015 F' +
      'ortes Inform'#225'tica'
    DisplayName = 'Documento PDF'
    Left = 259
    Top = 264
  end
end
