object frmScript: TfrmScript
  Left = 285
  Top = 246
  Caption = 'frmScript'
  ClientHeight = 251
  ClientWidth = 479
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Versao1: TMemo
    Left = 6
    Top = 6
    Width = 31
    Height = 23
    Ctl3D = False
    Lines.Strings = (
      'insert into parametros values(1,1)'
      '^')
    ParentCtl3D = False
    TabOrder = 0
    WordWrap = False
  end
  object versao2: TMemo
    Left = 46
    Top = 6
    Width = 31
    Height = 23
    Ctl3D = False
    Lines.Strings = (
      
        'INSERT INTO PESSOAS (CODIGO, RAZAO, TIPO) VALUES (0, '#39'CONSUMIDOR' +
        #39', '#39'C'#39')'
      '^')
    ParentCtl3D = False
    TabOrder = 1
    WordWrap = False
  end
  object versao3: TMemo
    Left = 86
    Top = 6
    Width = 31
    Height = 23
    Ctl3D = False
    Lines.Strings = (
      'CREATE GENERATOR GEN_NFCES_INUTILIZADAS_ID'
      '^'
      'CREATE TABLE NFCES_INUTILIZADAS ('
      '    CODIGO         INTEGER NOT NULL,'
      '    MODELO         CHAR(3),'
      '    SERIE          CHAR(3),'
      '    INICIO         INTEGER,'
      '    FIM            INTEGER,'
      '    JUSTIFICATIVA  VARCHAR(150)'
      ')'
      '^'
      
        'ALTER TABLE NFCES_INUTILIZADAS ADD CONSTRAINT PK_NFCES_INUTILIZA' +
        'DAS PRIMARY KEY (CODIGO)'
      '^'
      'CREATE TRIGGER NFCES_INUTILIZADAS_BI FOR NFCES_INUTILIZADAS'
      'ACTIVE BEFORE INSERT POSITION 0'
      'AS'
      'BEGIN'
      '  IF ((NEW.CODIGO IS NULL)or(NEW.CODIGO = 0)) THEN'
      '    NEW.CODIGO = GEN_ID(GEN_NFCES_INUTILIZADAS_ID,1);'
      'END'
      '^')
    ParentCtl3D = False
    TabOrder = 2
    WordWrap = False
  end
  object versao4: TMemo
    Left = 126
    Top = 6
    Width = 31
    Height = 23
    Ctl3D = False
    Lines.Strings = (
      'CREATE TABLE CONTADOR ('
      '    CODIGO_PESSOA INTEGER NOT NULL,'
      '    CNPJ VARCHAR(14),'
      '    CRC VARCHAR(10))'
      '^'
      'alter table CONTADOR'
      'add constraint PK_CONTADOR'
      'primary key (CODIGO_PESSOA)'
      '^'
      'alter table CONTADOR'
      'add constraint FK_CONTADOR_1'
      'foreign key (CODIGO_PESSOA)'
      'references PESSOAS(CODIGO)'
      '^')
    ParentCtl3D = False
    TabOrder = 3
    WordWrap = False
  end
  object versao5: TMemo
    Left = 166
    Top = 6
    Width = 31
    Height = 23
    Ctl3D = False
    Lines.Strings = (
      'ALTER TABLE IBPT'
      'ADD CODIGO_CFOP_FORA INTEGER'
      '^')
    ParentCtl3D = False
    TabOrder = 4
    WordWrap = False
  end
  object versao6: TMemo
    Left = 206
    Top = 6
    Width = 31
    Height = 23
    Ctl3D = False
    Lines.Strings = (
      'ALTER TABLE PARAMETROS'
      'ADD STATUS_USO SMALLINT'
      '^'
      'ALTER TABLE PARAMETROS'
      'ADD DATA_FINAL DATE'
      '^'
      'ALTER TABLE PARAMETROS'
      'ADD MENSAGEM VARCHAR(200)'
      '^'
      'ALTER TABLE PRODUTOS'
      'ADD INF_ADICIONAIS VARCHAR(500)'
      '^'
      'ALTER TABLE PARAMETROS'
      'ADD ULTIMA_CONEXAO DATE'
      '^'
      'ALTER TABLE PARAMETROS'
      'ADD DATA_SENHA VARCHAR(50)'
      '^')
    ParentCtl3D = False
    TabOrder = 5
    WordWrap = False
  end
  object versao7: TMemo
    Left = 246
    Top = 6
    Width = 31
    Height = 23
    Ctl3D = False
    Lines.Strings = (
      'UPDATE PARAMETROS SET STATUS_USO = 1'
      '^')
    ParentCtl3D = False
    TabOrder = 6
    WordWrap = False
  end
  object versao8: TMemo
    Left = 286
    Top = 6
    Width = 31
    Height = 23
    Ctl3D = False
    Lines.Strings = (
      'CREATE TABLE FORMAS_PAGAMENTO ('
      '    CODIGO INTEGER NOT NULL,'
      '    DESCRICAO VARCHAR(100))'
      '^'
      'alter table FORMAS_PAGAMENTO'
      'add constraint PK_FORMAS_PAGAMENTO'
      'primary key (CODIGO)'
      '^'
      'CREATE GENERATOR GEN_FORMAS_PAGAMENTO_ID'
      '^'
      'CREATE TRIGGER FORMAS_PAGAMENTO_BI FOR FORMAS_PAGAMENTO'
      'ACTIVE BEFORE INSERT POSITION 0'
      'AS'
      'BEGIN'
      '  IF ((NEW.CODIGO IS NULL)or(NEW.CODIGO = 0)) THEN'
      '    NEW.CODIGO = GEN_ID(GEN_FORMAS_PAGAMENTO_ID,1);'
      'END'
      '^')
    ParentCtl3D = False
    TabOrder = 7
    WordWrap = False
  end
  object versao9: TMemo
    Left = 326
    Top = 6
    Width = 31
    Height = 23
    Ctl3D = False
    Lines.Strings = (
      'ALTER TABLE NATUREZA_OPERACAO'
      'ADD SUSPENSAO_ICMS CHAR(1)'
      '^')
    ParentCtl3D = False
    TabOrder = 8
    WordWrap = False
  end
  object versao10: TMemo
    Left = 366
    Top = 6
    Width = 31
    Height = 23
    Ctl3D = False
    Lines.Strings = (
      'CREATE GENERATOR GEN_ICMS_ESTADO_ID'
      '^'
      'CREATE GENERATOR GEN_ITENS_NOTAS_FISCAIS_ID'
      '^'
      'CREATE GENERATOR GEN_LOTES_NFE_ID'
      '^'
      'CREATE GENERATOR GEN_NOTAS_FISCAIS_ID'
      '^'
      'CREATE TABLE ICMS_ESTADO ('
      '    CODIGO           INTEGER NOT NULL,'
      '    CODIGO_ESTADO    INTEGER,'
      '    PERC_REDUCAO_BC  NUMERIC(15,2)'
      ')'
      '^'
      'CREATE TABLE ITENS_NF_COFINS_ALIQ ('
      '    CODIGO_ITEM  INTEGER NOT NULL,'
      '    ALIQUOTA     NUMERIC(15,2) NOT NULL'
      ')'
      '^'
      'CREATE TABLE ITENS_NF_COFINS_NT ('
      '    CODIGO_ITEM  INTEGER NOT NULL'
      ')'
      '^'
      'CREATE TABLE ITENS_NF_ICMS_00 ('
      '    CODIGO_ITEM      INTEGER NOT NULL,'
      '    ORIGEM           INTEGER NOT NULL,'
      '    ALIQUOTA         NUMERIC(15,2) NOT NULL,'
      '    PERC_REDUCAO_BC  NUMERIC(15,2)'
      ')'
      '^'
      'CREATE TABLE ITENS_NF_ICMS_SN_101 ('
      '    CODIGO_ITEM          INTEGER NOT NULL,'
      '    ORIGEM               INTEGER NOT NULL,'
      '    ALIQUOTA_CREDITO_SN  NUMERIC(15,2) NOT NULL'
      ')'
      '^'
      'CREATE TABLE ITENS_NF_IPI_NT ('
      '    CODIGO_ITEM  INTEGER NOT NULL'
      ')'
      '^'
      'CREATE TABLE ITENS_NF_IPI_TRIB ('
      '    CODIGO_ITEM  INTEGER NOT NULL,'
      '    ALIQUOTA     NUMERIC(15,2) NOT NULL'
      ')'
      '^'
      'CREATE TABLE ITENS_NF_PIS_ALIQ ('
      '    CODIGO_ITEM  INTEGER NOT NULL,'
      '    ALIQUOTA     NUMERIC(15,2) NOT NULL'
      ')'
      '^'
      'CREATE TABLE ITENS_NF_PIS_NT ('
      '    CODIGO_ITEM  INTEGER NOT NULL'
      ')'
      '^'
      'CREATE TABLE ITENS_NOTAS_FISCAIS ('
      '    CODIGO              INTEGER NOT NULL,'
      '    CODIGO_NOTA_FISCAL  INTEGER,'
      '    CODIGO_PRODUTO      INTEGER,'
      '    CODIGO_NATUREZA     INTEGER,'
      '    QUANTIDADE          NUMERIC(15,4) NOT NULL,'
      '    VALOR_UNITARIO      NUMERIC(15,4) NOT NULL'
      ')'
      '^'
      'CREATE TABLE LOCAIS_ENTREGA_NOTAS_FISCAIS ('
      '    CODIGO_NOTA_FISCAL  INTEGER NOT NULL,'
      '    CNPJ_CPF            VARCHAR(14) NOT NULL,'
      '    LOGRADOURO          VARCHAR(80) NOT NULL,'
      '    NUMERO              VARCHAR(10) NOT NULL,'
      '    BAIRRO              VARCHAR(50),'
      '    COMPLEMENTO         VARCHAR(100) NOT NULL,'
      '    COD_MUN             INTEGER NOT NULL,'
      '    NOME_MUN            VARCHAR(80) NOT NULL,'
      '    UF                  VARCHAR(2) NOT NULL,'
      '    CEP                 VARCHAR(10) NOT NULL'
      ')'
      '^'
      'CREATE TABLE LOTES_NFE ('
      '    CODIGO              INTEGER NOT NULL,'
      '    CODIGO_NOTA_FISCAL  INTEGER,'
      '    DATA                TIMESTAMP NOT NULL'
      ')'
      '^'
      'CREATE TABLE LOTES_NFE_RETORNO ('
      '    CODIGO_LOTE  INTEGER NOT NULL,'
      '    STATUS       VARCHAR(3) NOT NULL,'
      '    MOTIVO       VARCHAR(50),'
      '    RECIBO       VARCHAR(15) NOT NULL'
      ')'
      '^'
      'CREATE TABLE NOTAS_FISCAIS ('
      '    CODIGO                 INTEGER NOT NULL,'
      '    NUMERO_NOTA_FISCAL     INTEGER NOT NULL,'
      '    CODIGO_NATUREZA        INTEGER,'
      '    SERIE                  VARCHAR(3) NOT NULL,'
      '    CODIGO_EMITENTE        INTEGER, '
      '    CODIGO_DESTINATARIO    INTEGER, '
      '    CODIGO_FPAGTO          INTEGER, '
      '    DATA_EMISSAO           TIMESTAMP NOT NULL,'
      '    DATA_SAIDA             TIMESTAMP NOT NULL,'
      '    CODIGO_TRANSPORTADORA  INTEGER, '
      '    TIPO_FRETE             INTEGER NOT NULL,'
      '    ENTRADA_SAIDA          CHAR(1),'
      '    FINALIDADE             CHAR(1),'
      '    NFE_REFERENCIADA       VARCHAR(44)'
      ')'
      '^'
      'CREATE TABLE NOTAS_FISCAIS_NFE ('
      '    CODIGO_NOTA_FISCAL  INTEGER NOT NULL,'
      '    CHAVE_ACESSO        VARCHAR(44) NOT NULL,'
      '    XML                 BLOB SUB_TYPE 1 SEGMENT SIZE 80 NOT NULL'
      ')'
      '^'
      'CREATE TABLE NOTAS_FISCAIS_NFE_RETORNO ('
      '    CODIGO_NOTA_FISCAL  INTEGER NOT NULL,'
      '    STATUS              VARCHAR(3) NOT NULL,'
      '    MOTIVO              VARCHAR(800)'
      ')'
      '^'
      'CREATE TABLE OBSERVACOES_NOTAS_FISCAIS ('
      '    CODIGO_NOTA_FISCAL    INTEGER NOT NULL,'
      '    OBSERVACOES           VARCHAR(800),'
      '    OBS_GER_PELO_SISTEMA  VARCHAR(800)'
      ')'
      '^'
      'CREATE TABLE TOTAIS_NOTAS_FISCAIS ('
      '    CODIGO_NOTA_FISCAL          INTEGER NOT NULL,'
      '    FRETE                       NUMERIC(15,2) NOT NULL,'
      '    SEGURO                      NUMERIC(15,2) NOT NULL,'
      '    DESCONTO                    NUMERIC(15,2) NOT NULL,'
      '    OUTRAS_DESPESAS             NUMERIC(15,2) NOT NULL,'
      '    PERCENTUAL_DESCONTO_FATURA  NUMERIC(15,2)'
      ')'
      '^'
      'CREATE TABLE VOLUMES_NOTAS_FISCAIS ('
      '    CODIGO_NOTA_FISCAL  INTEGER NOT NULL,'
      '    ESPECIE             VARCHAR(50),'
      '    QUANTIDADE_VOLUMES  NUMERIC(15,2) NOT NULL,'
      '    PESO_LIQUIDO        NUMERIC(15,2) NOT NULL,'
      '    PESO_BRUTO          NUMERIC(15,2) NOT NULL'
      ')'
      '^'
      
        'ALTER TABLE ICMS_ESTADO ADD CONSTRAINT PK_ICMS_ESTADO PRIMARY KE' +
        'Y (CODIGO)'
      '^'
      
        'ALTER TABLE ITENS_NF_COFINS_ALIQ ADD CONSTRAINT PK_ITENS_NF_COFI' +
        'NS_ALIQ PRIMARY KEY (CODIGO_ITEM)'
      '^'
      
        'ALTER TABLE ITENS_NF_COFINS_NT ADD CONSTRAINT PK_ITENS_NF_COFINS' +
        '_NT PRIMARY KEY (CODIGO_ITEM)'
      '^'
      
        'ALTER TABLE ITENS_NF_ICMS_00 ADD CONSTRAINT PK_ITENS_NF_ICMS_00 ' +
        'PRIMARY KEY (CODIGO_ITEM)'
      '^'
      
        'ALTER TABLE ITENS_NF_ICMS_SN_101 ADD CONSTRAINT PK_ITENS_NF_ICMS' +
        '_SN_101 PRIMARY KEY (CODIGO_ITEM)'
      '^'
      
        'ALTER TABLE ITENS_NF_IPI_NT ADD CONSTRAINT PK_ITENS_NF_IPI_NT PR' +
        'IMARY KEY (CODIGO_ITEM)'
      '^'
      
        'ALTER TABLE ITENS_NF_IPI_TRIB ADD CONSTRAINT PK_ITENS_NF_IPI_TRI' +
        'B PRIMARY KEY (CODIGO_ITEM)'
      '^'
      
        'ALTER TABLE ITENS_NF_PIS_ALIQ ADD CONSTRAINT PK_ITENS_NF_PIS_ALI' +
        'Q PRIMARY KEY (CODIGO_ITEM)'
      '^'
      
        'ALTER TABLE ITENS_NF_PIS_NT ADD CONSTRAINT PK_ITENS_NF_PIS_NT PR' +
        'IMARY KEY (CODIGO_ITEM)'
      '^'
      
        'ALTER TABLE ITENS_NOTAS_FISCAIS ADD CONSTRAINT PK_ITENS_NOTAS_FI' +
        'SCAIS PRIMARY KEY (CODIGO)'
      '^'
      
        'ALTER TABLE LOCAIS_ENTREGA_NOTAS_FISCAIS ADD CONSTRAINT PK_LOCAI' +
        'S_ENTREGA_NOTAS_FISCAIS PRIMARY KEY (CODIGO_NOTA_FISCAL)'
      '^'
      
        'ALTER TABLE LOTES_NFE ADD CONSTRAINT PK_LOTES_NFE PRIMARY KEY (C' +
        'ODIGO)'
      '^'
      
        'ALTER TABLE LOTES_NFE_RETORNO ADD CONSTRAINT PK_LOTES_NFE_RETORN' +
        'O PRIMARY KEY (CODIGO_LOTE)'
      '^'
      
        'ALTER TABLE NOTAS_FISCAIS ADD CONSTRAINT PK_NOTAS_FISCAIS PRIMAR' +
        'Y KEY (CODIGO)'
      '^'
      
        'ALTER TABLE NOTAS_FISCAIS_NFE ADD CONSTRAINT PK_NOTAS_FISCAIS_NF' +
        'E PRIMARY KEY (CODIGO_NOTA_FISCAL)'
      '^'
      
        'ALTER TABLE NOTAS_FISCAIS_NFE_RETORNO ADD CONSTRAINT PK_NOTAS_FI' +
        'SCAIS_NFE_RETORNO PRIMARY KEY (CODIGO_NOTA_FISCAL)'
      '^'
      
        'ALTER TABLE OBSERVACOES_NOTAS_FISCAIS ADD CONSTRAINT PK_OBSERVAC' +
        'OES_NOTAS_FISCAIS PRIMARY KEY (CODIGO_NOTA_FISCAL)'
      '^'
      
        'ALTER TABLE TOTAIS_NOTAS_FISCAIS ADD CONSTRAINT PK_TOTAIS_NOTAS_' +
        'FISCAIS PRIMARY KEY (CODIGO_NOTA_FISCAL)'
      '^'
      
        'ALTER TABLE VOLUMES_NOTAS_FISCAIS ADD CONSTRAINT PK_VOLUMES_NOTA' +
        'S_FISCAIS PRIMARY KEY (CODIGO_NOTA_FISCAL)'
      '^'
      
        'ALTER TABLE ICMS_ESTADO ADD CONSTRAINT FK_ICMS_ESTADO_1 FOREIGN ' +
        'KEY (CODIGO_ESTADO) REFERENCES ESTADOS (CODIGO)'
      '^'
      
        'ALTER TABLE ITENS_NF_COFINS_ALIQ ADD CONSTRAINT FK_ITENS_NF_COFI' +
        'NS_ALIQ_IT FOREIGN KEY (CODIGO_ITEM) REFERENCES ITENS_NOTAS_FISC' +
        'AIS (CODIGO) ON DELETE CASCADE'
      '^'
      
        'ALTER TABLE ITENS_NF_COFINS_NT ADD CONSTRAINT FK_ITENS_NF_COFINS' +
        '_NT_IT FOREIGN KEY (CODIGO_ITEM) REFERENCES ITENS_NOTAS_FISCAIS ' +
        '(CODIGO) ON DELETE CASCADE'
      '^'
      
        'ALTER TABLE ITENS_NF_ICMS_00 ADD CONSTRAINT FK_ITENS_NF_ICMS_00_' +
        'IT FOREIGN KEY (CODIGO_ITEM) REFERENCES ITENS_NOTAS_FISCAIS (COD' +
        'IGO) ON DELETE CASCADE'
      '^'
      
        'ALTER TABLE ITENS_NF_ICMS_SN_101 ADD CONSTRAINT FK_ITENS_NF_ICMS' +
        '_SN_101_IT FOREIGN KEY (CODIGO_ITEM) REFERENCES ITENS_NOTAS_FISC' +
        'AIS (CODIGO) ON DELETE CASCADE'
      '^'
      
        'ALTER TABLE ITENS_NF_IPI_NT ADD CONSTRAINT FK_ITENS_NF_IPI_NT_IT' +
        ' FOREIGN KEY (CODIGO_ITEM) REFERENCES ITENS_NOTAS_FISCAIS (CODIG' +
        'O) ON DELETE CASCADE'
      '^'
      
        'ALTER TABLE ITENS_NF_IPI_TRIB ADD CONSTRAINT FK_ITENS_NF_IPI_TRI' +
        'B_IT FOREIGN KEY (CODIGO_ITEM) REFERENCES ITENS_NOTAS_FISCAIS (C' +
        'ODIGO) ON DELETE CASCADE'
      '^'
      
        'ALTER TABLE ITENS_NF_PIS_ALIQ ADD CONSTRAINT FK_ITENS_NF_PIS_ALI' +
        'Q_IT FOREIGN KEY (CODIGO_ITEM) REFERENCES ITENS_NOTAS_FISCAIS (C' +
        'ODIGO) ON DELETE CASCADE'
      '^'
      
        'ALTER TABLE ITENS_NF_PIS_NT ADD CONSTRAINT FK_ITENS_NF_PIS_NT_IT' +
        ' FOREIGN KEY (CODIGO_ITEM) REFERENCES ITENS_NOTAS_FISCAIS (CODIG' +
        'O) ON DELETE CASCADE'
      '^'
      
        'ALTER TABLE ITENS_NOTAS_FISCAIS ADD CONSTRAINT FK_ITENS_NOTAS_FI' +
        'SCAIS_NAT FOREIGN KEY (CODIGO_NATUREZA) REFERENCES NATUREZA_OPER' +
        'ACAO (CODIGO) ON DELETE CASCADE'
      '^'
      
        'ALTER TABLE ITENS_NOTAS_FISCAIS ADD CONSTRAINT FK_ITENS_NOTAS_FI' +
        'SCAIS_NF FOREIGN KEY (CODIGO_NOTA_FISCAL) REFERENCES NOTAS_FISCA' +
        'IS (CODIGO) ON DELETE CASCADE'
      '^'
      
        'ALTER TABLE ITENS_NOTAS_FISCAIS ADD CONSTRAINT FK_ITENS_NOTAS_FI' +
        'SCAIS_PROD FOREIGN KEY (CODIGO_PRODUTO) REFERENCES PRODUTOS (COD' +
        'IGO) ON DELETE CASCADE'
      '^'
      
        'ALTER TABLE LOCAIS_ENTREGA_NOTAS_FISCAIS ADD CONSTRAINT FK_LOCAI' +
        'S_ENTREGA_NOTAS_FISCAIS FOREIGN KEY (CODIGO_NOTA_FISCAL) REFEREN' +
        'CES NOTAS_FISCAIS (CODIGO) ON DELETE CASCADE'
      '^'
      
        'ALTER TABLE LOTES_NFE ADD CONSTRAINT FK_LOTES_NFE_NOTA_FISCAL FO' +
        'REIGN KEY (CODIGO_NOTA_FISCAL) REFERENCES NOTAS_FISCAIS (CODIGO)' +
        ' ON DELETE CASCADE'
      '^'
      
        'ALTER TABLE LOTES_NFE_RETORNO ADD CONSTRAINT FK_LOTES_NFE_RETORN' +
        'O FOREIGN KEY (CODIGO_LOTE) REFERENCES LOTES_NFE (CODIGO) ON DEL' +
        'ETE CASCADE'
      '^'
      
        'ALTER TABLE NOTAS_FISCAIS ADD CONSTRAINT FK_NOTAS_FISCAIS_DEST F' +
        'OREIGN KEY (CODIGO_DESTINATARIO) REFERENCES PESSOAS (CODIGO)'
      '^'
      
        'ALTER TABLE NOTAS_FISCAIS ADD CONSTRAINT FK_NOTAS_FISCAIS_EMIT F' +
        'OREIGN KEY (CODIGO_EMITENTE) REFERENCES PESSOAS (CODIGO)'
      '^'
      
        'ALTER TABLE NOTAS_FISCAIS ADD CONSTRAINT FK_NOTAS_FISCAIS_FPAGTO' +
        ' FOREIGN KEY (CODIGO_FPAGTO) REFERENCES FORMAS_PAGAMENTO (CODIGO' +
        ')'
      '^'
      
        'ALTER TABLE NOTAS_FISCAIS ADD CONSTRAINT FK_NOTAS_FISCAIS_NAT FO' +
        'REIGN KEY (CODIGO_NATUREZA) REFERENCES NATUREZA_OPERACAO (CODIGO' +
        ')'
      '^'
      
        'ALTER TABLE NOTAS_FISCAIS ADD CONSTRAINT FK_NOTAS_FISCAIS_TRANSP' +
        ' FOREIGN KEY (CODIGO_TRANSPORTADORA) REFERENCES PESSOAS (CODIGO)'
      '^'
      
        'ALTER TABLE NOTAS_FISCAIS_NFE ADD CONSTRAINT FK_NOTAS_FISCAIS_NF' +
        'E FOREIGN KEY (CODIGO_NOTA_FISCAL) REFERENCES NOTAS_FISCAIS (COD' +
        'IGO) ON DELETE CASCADE'
      '^'
      
        'ALTER TABLE NOTAS_FISCAIS_NFE_RETORNO ADD CONSTRAINT FK_NOTAS_FI' +
        'SCAIS_NFE_RETORNO FOREIGN KEY (CODIGO_NOTA_FISCAL) REFERENCES NO' +
        'TAS_FISCAIS (CODIGO) ON DELETE CASCADE'
      '^'
      
        'ALTER TABLE OBSERVACOES_NOTAS_FISCAIS ADD CONSTRAINT FK_OBSERVAC' +
        'OES_NOTAS_FISCAIS FOREIGN KEY (CODIGO_NOTA_FISCAL) REFERENCES NO' +
        'TAS_FISCAIS (CODIGO) ON DELETE CASCADE'
      '^'
      
        'ALTER TABLE TOTAIS_NOTAS_FISCAIS ADD CONSTRAINT FK_TOTAIS_NOTAS_' +
        'FISCAIS FOREIGN KEY (CODIGO_NOTA_FISCAL) REFERENCES NOTAS_FISCAI' +
        'S (CODIGO) ON DELETE CASCADE'
      '^'
      
        'ALTER TABLE VOLUMES_NOTAS_FISCAIS ADD CONSTRAINT FK_VOLUMES_NOTA' +
        'S_FISCAIS FOREIGN KEY (CODIGO_NOTA_FISCAL) REFERENCES NOTAS_FISC' +
        'AIS (CODIGO) ON DELETE CASCADE'
      '^'
      'CREATE TRIGGER ICMS_ESTADO_BI FOR ICMS_ESTADO'
      'ACTIVE BEFORE INSERT POSITION 0'
      
        'AS BEGIN   IF ((NEW.CODIGO IS NULL)or(NEW.CODIGO = 0)) THEN     ' +
        'NEW.CODIGO = GEN_ID(GEN_ICMS_ESTADO_ID,1); END'
      '^'
      'CREATE TRIGGER ITENS_NOTAS_FISCAIS_BI FOR ITENS_NOTAS_FISCAIS'
      'ACTIVE BEFORE INSERT POSITION 0'
      
        'as begin   if ((new.codigo is null) or (new.codigo = 0))  then  ' +
        '   new.codigo = gen_id(gen_itens_notas_fiscais_id,1); end'
      '^'
      'CREATE TRIGGER LOTES_NFE_BI FOR LOTES_NFE'
      'ACTIVE BEFORE INSERT POSITION 0'
      
        'as begin   if ((new.codigo is null) or (new.codigo = 0)) then   ' +
        '  new.codigo = gen_id(gen_lotes_nfe_id,1); end'
      '^'
      'CREATE TRIGGER NOTAS_FISCAIS_BI FOR NOTAS_FISCAIS'
      'ACTIVE BEFORE INSERT POSITION 0'
      
        'as begin   if ((new.codigo is null) or (new.codigo = 0))  then  ' +
        '   new.codigo = gen_id(gen_notas_fiscais_id,1); end'
      '^')
    ParentCtl3D = False
    TabOrder = 9
    WordWrap = False
  end
  object versao11: TMemo
    Left = 405
    Top = 6
    Width = 31
    Height = 23
    Ctl3D = False
    Lines.Strings = (
      'CREATE GENERATOR GEN_ITENS_AVULSOS_ID'
      '^'
      'CREATE TABLE ITENS_AVULSOS ('
      '    CODIGO               INTEGER NOT NULL,'
      '    CODIGO_NOTA_FISCAL   INTEGER,'
      '    CODIGO_PRODUTO       INTEGER,'
      '    PRECO                NUMERIC(15,2) NOT NULL,'
      '    QUANTIDADE           NUMERIC(15,2) NOT NULL,'
      '    PERCENTUAL_DESCONTO  NUMERIC(15,2) NOT NULL'
      ')'
      '^'
      
        'ALTER TABLE ITENS_AVULSOS ADD CONSTRAINT PK_ITENS_AVULSOS PRIMAR' +
        'Y KEY (CODIGO);'
      '^'
      
        'ALTER TABLE ITENS_AVULSOS ADD CONSTRAINT FK_ITENS_AVULSOS_NF FOR' +
        'EIGN KEY (CODIGO_NOTA_FISCAL) REFERENCES NOTAS_FISCAIS (CODIGO) ' +
        'ON DELETE CASCADE'
      '^'
      
        'ALTER TABLE ITENS_AVULSOS ADD CONSTRAINT FK_ITENS_AVULSOS_PRODUT' +
        'O FOREIGN KEY (CODIGO_PRODUTO) REFERENCES PRODUTOS (CODIGO)'
      '^'
      'CREATE TRIGGER ITENS_AVULSOS_BI FOR ITENS_AVULSOS'
      'ACTIVE BEFORE INSERT POSITION 0'
      
        'as begin   if ((new.codigo is null) or (new.codigo = 0))  then  ' +
        '   new.codigo = gen_id(gen_itens_avulsos_id,1); end'
      '^')
    ParentCtl3D = False
    TabOrder = 10
    WordWrap = False
  end
  object versao12: TMemo
    Left = 445
    Top = 6
    Width = 31
    Height = 23
    Ctl3D = False
    Lines.Strings = (
      'ALTER TABLE CONFIGURACOES_NF'
      'ADD OBS_GERADA_SISTEMA VARCHAR(1500)'
      '^')
    ParentCtl3D = False
    TabOrder = 11
    WordWrap = False
  end
  object versao13: TMemo
    Left = 8
    Top = 38
    Width = 31
    Height = 23
    Ctl3D = False
    Lines.Strings = (
      'CREATE TABLE ALIQ_INTERNA_ICMS ('
      '    CODIGO         INTEGER NOT NULL,'
      '    CODIGO_ESTADO  INTEGER,'
      '    ALIQUOTA       NUMERIC(15,2)'
      ')'
      '^'
      'COMMIT WORK'
      '^')
    ParentCtl3D = False
    TabOrder = 12
    WordWrap = False
  end
  object versao14: TMemo
    Left = 46
    Top = 38
    Width = 31
    Height = 23
    Ctl3D = False
    Lines.Strings = (
      
        'INSERT INTO ALIQ_INTERNA_ICMS (CODIGO, CODIGO_ESTADO, ALIQUOTA) ' +
        'VALUES (1, 1, 17)^'
      
        'INSERT INTO ALIQ_INTERNA_ICMS (CODIGO, CODIGO_ESTADO, ALIQUOTA) ' +
        'VALUES (2, 2, 17)^'
      
        'INSERT INTO ALIQ_INTERNA_ICMS (CODIGO, CODIGO_ESTADO, ALIQUOTA) ' +
        'VALUES (3, 3, 17)^'
      
        'INSERT INTO ALIQ_INTERNA_ICMS (CODIGO, CODIGO_ESTADO, ALIQUOTA) ' +
        'VALUES (4, 4, 17)^'
      
        'INSERT INTO ALIQ_INTERNA_ICMS (CODIGO, CODIGO_ESTADO, ALIQUOTA) ' +
        'VALUES (5, 5, 17)^'
      
        'INSERT INTO ALIQ_INTERNA_ICMS (CODIGO, CODIGO_ESTADO, ALIQUOTA) ' +
        'VALUES (6, 6, 17)^'
      
        'INSERT INTO ALIQ_INTERNA_ICMS (CODIGO, CODIGO_ESTADO, ALIQUOTA) ' +
        'VALUES (7, 7, 17)^'
      
        'INSERT INTO ALIQ_INTERNA_ICMS (CODIGO, CODIGO_ESTADO, ALIQUOTA) ' +
        'VALUES (8, 8, 17)^'
      
        'INSERT INTO ALIQ_INTERNA_ICMS (CODIGO, CODIGO_ESTADO, ALIQUOTA) ' +
        'VALUES (9, 9, 17)^'
      
        'INSERT INTO ALIQ_INTERNA_ICMS (CODIGO, CODIGO_ESTADO, ALIQUOTA) ' +
        'VALUES (10, 10, 17)^'
      
        'INSERT INTO ALIQ_INTERNA_ICMS (CODIGO, CODIGO_ESTADO, ALIQUOTA) ' +
        'VALUES (11, 11, 17)^'
      
        'INSERT INTO ALIQ_INTERNA_ICMS (CODIGO, CODIGO_ESTADO, ALIQUOTA) ' +
        'VALUES (12, 12, 17)^'
      
        'INSERT INTO ALIQ_INTERNA_ICMS (CODIGO, CODIGO_ESTADO, ALIQUOTA) ' +
        'VALUES (13, 13, 17)^'
      
        'INSERT INTO ALIQ_INTERNA_ICMS (CODIGO, CODIGO_ESTADO, ALIQUOTA) ' +
        'VALUES (14, 14, 18)^'
      
        'INSERT INTO ALIQ_INTERNA_ICMS (CODIGO, CODIGO_ESTADO, ALIQUOTA) ' +
        'VALUES (15, 15, 17)^'
      
        'INSERT INTO ALIQ_INTERNA_ICMS (CODIGO, CODIGO_ESTADO, ALIQUOTA) ' +
        'VALUES (16, 16, 17)^'
      
        'INSERT INTO ALIQ_INTERNA_ICMS (CODIGO, CODIGO_ESTADO, ALIQUOTA) ' +
        'VALUES (17, 17, 12)^'
      
        'INSERT INTO ALIQ_INTERNA_ICMS (CODIGO, CODIGO_ESTADO, ALIQUOTA) ' +
        'VALUES (18, 18, 17)^'
      
        'INSERT INTO ALIQ_INTERNA_ICMS (CODIGO, CODIGO_ESTADO, ALIQUOTA) ' +
        'VALUES (19, 19, 17)^'
      
        'INSERT INTO ALIQ_INTERNA_ICMS (CODIGO, CODIGO_ESTADO, ALIQUOTA) ' +
        'VALUES (20, 20, 18)^'
      
        'INSERT INTO ALIQ_INTERNA_ICMS (CODIGO, CODIGO_ESTADO, ALIQUOTA) ' +
        'VALUES (21, 21, 17)^'
      
        'INSERT INTO ALIQ_INTERNA_ICMS (CODIGO, CODIGO_ESTADO, ALIQUOTA) ' +
        'VALUES (22, 22, 17)^'
      
        'INSERT INTO ALIQ_INTERNA_ICMS (CODIGO, CODIGO_ESTADO, ALIQUOTA) ' +
        'VALUES (23, 23, 17)^'
      
        'INSERT INTO ALIQ_INTERNA_ICMS (CODIGO, CODIGO_ESTADO, ALIQUOTA) ' +
        'VALUES (24, 24, 17)^'
      
        'INSERT INTO ALIQ_INTERNA_ICMS (CODIGO, CODIGO_ESTADO, ALIQUOTA) ' +
        'VALUES (25, 25, 17)^'
      
        'INSERT INTO ALIQ_INTERNA_ICMS (CODIGO, CODIGO_ESTADO, ALIQUOTA) ' +
        'VALUES (26, 26, 18)^'
      
        'INSERT INTO ALIQ_INTERNA_ICMS (CODIGO, CODIGO_ESTADO, ALIQUOTA) ' +
        'VALUES (27, 27, 17)^')
    ParentCtl3D = False
    TabOrder = 13
    WordWrap = False
  end
  object versao15: TMemo
    Left = 86
    Top = 38
    Width = 31
    Height = 23
    Ctl3D = False
    Lines.Strings = (
      'ALTER TABLE PARAMETROS_NFCE'
      'ADD LEIAUTE_IMPRESSAO SMALLINT'
      '^'
      'ALTER TABLE PARAMETROS_NFCE'
      'ADD IMP_COMP_PEDIDO CHAR(1)'
      '^')
    ParentCtl3D = False
    TabOrder = 14
    WordWrap = False
  end
  object versao16: TMemo
    Left = 126
    Top = 38
    Width = 31
    Height = 23
    Ctl3D = False
    Lines.Strings = (
      'DROP TABLE NFCES_INUTILIZADAS'
      '^'
      'DROP GENERATOR GEN_NFCES_INUTILIZADAS_ID'
      '^'
      'CREATE GENERATOR GEN_NOTAS_INUTILIZADAS_ID'
      '^'
      'CREATE TABLE NOTAS_INUTILIZADAS ('
      '    CODIGO         INTEGER NOT NULL,'
      '    MODELO         CHAR(3),'
      '    SERIE          CHAR(3),'
      '    INICIO         INTEGER,'
      '    FIM            INTEGER,'
      '    JUSTIFICATIVA  VARCHAR(150)'
      ')'
      '^'
      
        'ALTER TABLE NOTAS_INUTILIZADAS ADD CONSTRAINT PK_NOTAS_INUTILIZA' +
        'DAS PRIMARY KEY (CODIGO)'
      '^'
      'CREATE TRIGGER NOTAS_INUTILIZADAS_BI FOR NOTAS_INUTILIZADAS'
      'ACTIVE BEFORE INSERT POSITION 0'
      
        'AS BEGIN   IF ((NEW.CODIGO IS NULL)or(NEW.CODIGO = 0)) THEN     ' +
        'NEW.CODIGO = GEN_ID(GEN_NOTAS_INUTILIZADAS_ID,1); END'
      '^')
    ParentCtl3D = False
    TabOrder = 15
    WordWrap = False
  end
  object versao17: TMemo
    Left = 166
    Top = 38
    Width = 31
    Height = 23
    Ctl3D = False
    Lines.Strings = (
      'ALTER TABLE TOTAIS_NOTAS_FISCAIS'
      'ADD TOTAL NUMERIC(15,2)'
      '^'
      'ALTER TABLE TOTAIS_NOTAS_FISCAIS'
      'ADD PRODUTOS NUMERIC(15,2)'
      '^')
    ParentCtl3D = False
    TabOrder = 16
    WordWrap = False
  end
  object versao18: TMemo
    Left = 206
    Top = 38
    Width = 31
    Height = 23
    Ctl3D = False
    Lines.Strings = (
      'ALTER TABLE PARAMETROS'
      'ADD VERSAO_EXECUTAVEL SMALLINT'
      '^')
    ParentCtl3D = False
    TabOrder = 17
    WordWrap = False
  end
  object versao19: TMemo
    Left = 246
    Top = 38
    Width = 31
    Height = 23
    Ctl3D = False
    Lines.Strings = (
      'ALTER TABLE ICMS_ESTADO'
      'ADD ALIQUOTA_ICMS NUMERIC(15,2)'
      '^'
      'commit'
      '^')
    ParentCtl3D = False
    TabOrder = 18
    WordWrap = False
  end
  object versao20: TMemo
    Left = 286
    Top = 38
    Width = 31
    Height = 23
    Ctl3D = False
    Lines.Strings = (
      'INSERT INTO ICMS_ESTADO values(0,1,0,0)'
      '^'
      'INSERT INTO ICMS_ESTADO values(0,2,0,0)'
      '^'
      'INSERT INTO ICMS_ESTADO values(0,3,0,0)'
      '^'
      'INSERT INTO ICMS_ESTADO values(0,4,0,0)'
      '^'
      'INSERT INTO ICMS_ESTADO values(0,5,0,0)'
      '^'
      'INSERT INTO ICMS_ESTADO values(0,6,0,0)'
      '^'
      'INSERT INTO ICMS_ESTADO values(0,7,0,0)'
      '^'
      'INSERT INTO ICMS_ESTADO values(0,8,0,0)'
      '^'
      'INSERT INTO ICMS_ESTADO values(0,9,0,0)'
      '^'
      'INSERT INTO ICMS_ESTADO values(0,10,0,0)'
      '^'
      'INSERT INTO ICMS_ESTADO values(0,11,0,0)'
      '^'
      'INSERT INTO ICMS_ESTADO values(0,12,0,0)'
      '^'
      'INSERT INTO ICMS_ESTADO values(0,13,0,0)'
      '^'
      'INSERT INTO ICMS_ESTADO values(0,14,0,0)'
      '^'
      'INSERT INTO ICMS_ESTADO values(0,15,0,0)'
      '^'
      'INSERT INTO ICMS_ESTADO values(0,16,0,0)'
      '^'
      'INSERT INTO ICMS_ESTADO values(0,17,0,0)'
      '^'
      'INSERT INTO ICMS_ESTADO values(0,18,0,0)'
      '^'
      'INSERT INTO ICMS_ESTADO values(0,19,0,0)'
      '^'
      'INSERT INTO ICMS_ESTADO values(0,20,0,0)'
      '^'
      'INSERT INTO ICMS_ESTADO values(0,21,0,0)'
      '^'
      'INSERT INTO ICMS_ESTADO values(0,22,0,0)'
      '^'
      'INSERT INTO ICMS_ESTADO values(0,23,0,0)'
      '^'
      'INSERT INTO ICMS_ESTADO values(0,24,0,0)'
      '^'
      'INSERT INTO ICMS_ESTADO values(0,25,0,0)'
      '^'
      'INSERT INTO ICMS_ESTADO values(0,26,0,0)'
      '^'
      'INSERT INTO ICMS_ESTADO values(0,27,0,0)'
      '^')
    ParentCtl3D = False
    TabOrder = 19
    WordWrap = False
  end
end
