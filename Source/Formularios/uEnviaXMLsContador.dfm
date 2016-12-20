inherited frmEnviaXMLsContador: TfrmEnviaXMLsContador
  Caption = 'Envio de XMLs'
  ClientHeight = 241
  ClientWidth = 747
  OnShow = FormShow
  ExplicitWidth = 763
  ExplicitHeight = 279
  PixelsPerInch = 96
  TextHeight = 17
  object GroupBox1: TGroupBox
    Left = 16
    Top = 8
    Width = 138
    Height = 73
    Caption = ' Ano '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    object cmbAno: TComboBox
      Left = 20
      Top = 31
      Width = 99
      Height = 25
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ItemIndex = 0
      ParentFont = False
      TabOrder = 0
      Text = '2016'
      OnClick = cmbAnoClick
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
    Left = 17
    Top = 94
    Width = 137
    Height = 73
    Caption = ' M'#234's '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    object cmbMes: TComboBox
      Left = 19
      Top = 31
      Width = 99
      Height = 25
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ItemIndex = 10
      ParentFont = False
      TabOrder = 0
      Text = 'NOVEMBRO'
      OnClick = cmbAnoClick
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
  object pnlBotoes: TPanel
    Left = 0
    Top = 190
    Width = 747
    Height = 51
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      747
      51)
    object btnEnviar: TBitBtn
      Left = 573
      Top = 8
      Width = 155
      Height = 30
      Anchors = [akTop, akRight]
      Caption = ' [CTRL+E] Enviar'
      Glyph.Data = {
        36080000424D3608000000000000360000002800000020000000100000000100
        2000000000000008000000000000000000000000000000000000FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0550000C0550000FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
        9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B005C0000005C0000009B9B
        9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00BF540000D47A0B00C055
        0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
        9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B005B000000701600005C00
        00009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00BE510000F4BA2300D577
        0800C9681A00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
        9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B005A000000905600007113
        0000650400009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00BE510000E6910100F0AD
        1500D4760800C9681900FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
        9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B005A000000822D00008C49
        000070120000650400009B9B9B009B9B9B009B9B9B009B9B9B00CA671300C45E
        0600C45E0700C55F0800C5600900C5600A00C5610B00CA670900E9930000E18B
        0000F0A90E00D0730A00C9681800FFFFFF00FFFFFF00FFFFFF00660300006000
        0000600000006100000061000000610000006100000066030000852F00007D27
        00008C4500006C0F0000650400009B9B9B009B9B9B009B9B9B00DC8C2500FFE7
        6700FFD55500FDCD4700FCC63E00F8BC3300F5B42700F3AB1C00ED9F1200E995
        0500E48C0000ED9E0200CE720C00C9681700FFFFFF00FFFFFF00782800009B83
        03009B710000996900009862000094580000915000008F470000893B00008531
        000080280000893A00006A0E0000650400009B9B9B009B9B9B00DE912800FFE6
        7600FAD06300F8CD5600F7CA4D00F6C44300F4BD3900F2B32F00EFA82400EEA4
        1A00EC9C0E00E68F0200EF9B0000D27C1600C7631200FFFFFF007A2D00009B82
        1200966C0000946900009366000092600000905900008E4F00008B4400008A40
        000088380000822B00008B3700006E180000630000009B9B9B00E3982E00FFEB
        8300FBDA6F00F9D36500F9CF5C00F7C95200F6C74900F5BF4000F3B63500F1B0
        2C00EFA92100EDA41800E68A0000F6BF2900EDBD6500C96511007F3400009B87
        1F0097760B00956F0100956B00009365000092630000915B00008F5200008D4C
        00008B4500008940000082260000925B00008959010065010000E9A23100FFF0
        8E00FDE17A00FCDC7200FBD76900F9D26000F8CB5500F7C84E00F5C54700F4BD
        3C00F3B53400EFA71B00F2B62B00F5D67500DD963B00C5600D00853E00009B8C
        2A00997D160098780E0097730500956E00009467000093640000916100009059
        00008F5100008B4300008E520000917211007932000061000000EDAC3800FFF4
        9D00FEE78900FEE38000FDE07A00FBDC7100FBD76900FAD26100F7CD5500F6C9
        5100F5BD3600F2BD3800FCDC6E00DE922C00C45D0B00FFFFFF00894800009B90
        39009A8325009A7F1C00997C160097780D0097730500966E0000936900009265
        0000915900008E59000098780A007A2E0000600000009B9B9B00F1BC5A00FFFF
        FA00FFFFE300FFFFE000FFFEDD00FFFCD800FFFDD900FFF7C700FBD46300F8C9
        4700F7D47400FEE68C00E3931F00C45D0D00FFFFFF00FFFFFF008D5800009B9B
        96009B9B7F009B9B7C009B9A79009B9874009B9975009B936300977000009465
        0000937010009A8228007F2F0000600000009B9B9B009B9B9B00EEA42A00EEB1
        4400EDAB3E00ECAA3D00EBA83C00EAA83D00E8A03700E7A33B00FDDE6700FDE9
        A200FFF3B100E59F2E00C2580900FFFFFF00FFFFFF00FFFFFF008A4000008A4D
        000089470000884600008744000086440000843C0000833F0000997A03009985
        3E009B8F4D00813B00005E0000009B9B9B009B9B9B009B9B9B00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00ECA01A00FFFBC800FFFC
        CC00E5A54000C1570700FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
        9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00883C00009B9764009B98
        6800814100005D0000009B9B9B009B9B9B009B9B9B009B9B9B00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F3B83B00FFFEC800E5A6
        3F00C1560500FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
        9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B008F5400009B9A64008142
        00005D0000009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F8BE3300E4A54100C155
        0500FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
        9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00945A0000804100005D00
        00009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00DA8A2600C1570800FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B009B9B
        9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00762600005D0000009B9B
        9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00}
      NumGlyphs = 2
      TabOrder = 0
      OnClick = btnEnviarClick
    end
    object btnVoltar: TBitBtn
      Left = 397
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
    end
  end
  object gpbContador: TGroupBox
    Left = 168
    Top = 8
    Width = 561
    Height = 159
    Caption = ' Contador '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    inline BuscaContador1: TBuscaContador
      Left = 19
      Top = 33
      Width = 541
      Height = 113
      TabOrder = 0
      ExplicitLeft = 19
      ExplicitTop = 33
      inherited StaticText2: TStaticText
        Width = 47
        Caption = 'Nome'
        ExplicitWidth = 47
      end
      inherited edtCodigo: TCurrencyEdit
        Visible = True
      end
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
end