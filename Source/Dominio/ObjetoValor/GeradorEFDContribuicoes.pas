unit GeradorEFDContribuicoes;

interface

uses ACBrSpedPisCofins,
     ACBrEPCBloco_0_Class,
     ACBrEPCBloco_0,                                                      
     ACBrEPCBloco_C,                                                      
     ACBrEPCBloco_D,
     EFDPisCofinsFuncoes,
    { Empresa,} Contador, NotaFiscal, ItemNotaFiscal,
     contnrs, DBClient, DB;
   //  EFDPisCofinsTipos;

type TGeradorEFDContribuicoes = class
  private
    registro0000 :TRegistro0000;
    registro0001 :TRegistro0001;
    registro0140 :TRegistro0140;

    { Atributos relacionados a geração dos blocos }
    GerarBloco0        :Boolean;
    GerarBlocoA        :Boolean;
    GerarBlocoC        :Boolean;
    GerarBlocoD        :Boolean;
    GerarBlocoF        :Boolean;
    GerarBlocoM        :Boolean;
    GerarBloco1        :Boolean;

    { Outros atributos }
    SpedPISCOFINS     : TACBrSPEDPisCofins;
    FisConcomitante   : Boolean;
    DataInicial       : TDateTime;
    DataFinal         : TDateTime;
    FRegime           : String;
  //  FEmpresa          : TEmpresa;
    FContador         : TContador;
    FCDSParticipantes : TClientDataSet;
    FCDSProdutos      : TClientDataSet;
    FCDSNaturezasOperacao :TClientDataSet;
    FCfops            :TClientDataSet;
    FConsidera_desconsidera   :Boolean;

  private

    function  addParticipante(codigo_participante :integer): Boolean;
    function  addProduto(codigo_produto :integer): Boolean;
    function  addNaturezaOperacao(codigo_Natureza :integer): Boolean;

   { Métodos geradores de cada bloco }
    procedure GeraBloco0;
    procedure GeraBlocoA;
    procedure GeraBlocoC;
    procedure GeraBlocoD;
    procedure GeraBlocoF;
    procedure GeraBlocoM;
    procedure GeraBloco1;

    { Métodos para adicionar dados nos registros do ACBr }
    { Bloco 0 }
    procedure addReg0000{(registro0000 :TRegistro0000)}; { Dados da Empresa }
    procedure addReg0001{(registro0001 :TRegistro0001)}; { Abertura do bloco 0 }
      procedure addReg0100(registro0100 :TRegistro0100); { Dados do contabilista }
      procedure addReg0110(registro0110 :TRegistro0110); { Regime de Apuração }
      procedure addReg0140; { Cadastro de Estabelecimento }
        procedure addReg0150(registro0140 :TRegistro0140; codigo_participante :integer); { Cadastro de Participante }
        procedure addReg0190(registro0140 :TRegistro0140); { Cadastro de medidas }
        procedure addReg0200(registro0140 :TRegistro0140; codigo_produto :integer); { Cadastro de itens/produtos }
        procedure addReg0400(registro0140 :TRegistro0140; codigo_natureza :integer); { Cadastro de natureza de operação/prestação }

    { Bloco C }
    procedure addRegC001(registroC001 :TRegistroC001); { Abertura do bloco C }
      procedure addRegC010(registroC001 :TRegistroC001); { Identificação do estabelecimento }
        procedure addRegC100(registroC100 :TRegistroC100; Nota_Fiscal :TNotaFiscal); { Documento de nota fiscal }
          procedure addRegC120(registroC100 :TRegistroC100; nCodNota :Real); { Complemento do Documento - Dados de Importação}
          procedure addRegC170(registroC100 :TRegistroC100; ItensNota :TObjectList); { Complemento do Documento - Itens }
        procedure addRegC500; { nota discal /contade energia eletrica  /agua /gas}

    { Bloco D }
    procedure addRegD001(registroD001 :TRegistroD001); { Abertura do bloco D }
      procedure addRegD010(registroD001 :TRegistroD001); { Indentificação do estabelecimento }
        procedure addRegD100(registroD100 :TRegistroD100); { Aquisição de serviços de transporte }
          procedure addRegD101(registroD100 :TRegistroD100; nCodNota :Real); { Complemento do Documento de Transporte - PIS/PASEP }
          procedure addRegD105(registroD100 :TRegistroD100; nCodNota :Real); { Complemento do Documento de Transoirte - COFINS }

    function  getNomeArquivo        : String;
  public

    procedure Gera_EFD_Contribuicoes;

    constructor Create(dDataInicial, dDataFinal :TDateTime;
                       lGeraBloco0              :Boolean;
                       lGeraBlocoA              :Boolean;
                       lGeraBlocoC              :Boolean;
                       lGeraBlocoD              :Boolean;
                       lGeraBlocoF              :Boolean;
                       lGeraBlocoM              :Boolean;
                       lGeraBloco1              :Boolean;
                       cCaminhoArquivo, regime  :String;
            //           Empresa                  :TEmpresa;
                       Contador                 :TContador;
                       cfops                    :TClientDataSet;
                       considera_desconsidera   :Boolean);

    constructor Destroy;                   

  private

end;

implementation

uses ACBrEPCBlocos, forms, SysUtils, Variants, Math, StrUtils, Repositorio, FabricaRepositorio,
     Especificacao, EspecificacaoNotaFiscalPorPeriodoEStatus, TipoStatusNotaFiscal, TipoFrete, StringUtilitario,
  {TotaisNotaFiscal,} Produto, {Pessoa,} NaturezaOperacao,
  ACBrEPCBloco_D_Class, ACBrEPCBloco_F_Class, ACBrEPCBloco_M_Class, TipoRegimeTributario;

const Buffer = 1000;

{ TGeradorEFDContribuicoes }

function TGeradorEFDContribuicoes.addParticipante( codigo_participante: integer ) :Boolean;
begin
   result := False;

   if FCDSParticipantes.Locate('CODIGO', codigo_participante, []) then exit;

   FCDSParticipantes.Append;
   FCDSParticipantes.FieldByName('CODIGO').AsInteger := codigo_participante;
   FCDSParticipantes.Post;

   result := true;
end;

function TGeradorEFDContribuicoes.addProduto(codigo_produto: integer) :Boolean;
begin
  result := false;

  if FCDSProdutos.Locate('CODIGO', codigo_produto, []) then exit;

   FCDSProdutos.Append;
   FCDSProdutos.FieldByName('CODIGO').AsInteger := codigo_produto;
   FCDSProdutos.Post;

  result := true;
end;

function TGeradorEFDContribuicoes.addNaturezaOperacao(codigo_Natureza: integer) :Boolean;
begin
  result := false;

  if FCDSNaturezasOperacao.Locate('CODIGO', codigo_Natureza, []) then exit;

   FCDSNaturezasOperacao.Append;
   FCDSNaturezasOperacao.FieldByName('CODIGO').AsInteger := codigo_Natureza;
   FCDSNaturezasOperacao.Post;

  result := true;
end;

procedure TGeradorEFDContribuicoes.addReg0000;
begin

   registro0000 := self.SpedPISCOFINS.Bloco_0.Registro0000New;

   if not Assigned(registro0000) then exit;

   registro0000.COD_VER          := vlVersao201;
   registro0000.TIPO_ESCRIT      := tpEscrOriginal;
   registro0000.IND_SIT_ESP      := indSitAbertura;
   registro0000.NUM_REC_ANTERIOR := '';
{   registro0000.NOME             := trim(self.FEmpresa.Razao);
   registro0000.CNPJ             := trim(self.FEmpresa.CPF_CNPJ);
   registro0000.UF               := trim(self.FEmpresa.Endereco.Cidade.estado.sigla);
   registro0000.COD_MUN          := self.FEmpresa.Endereco.Cidade.codibge; }
   registro0000.SUFRAMA          := '';
   registro0000.IND_NAT_PJ       := indNatPJSocEmpresariaGeral;
   registro0000.IND_ATIV         := indAtivIndustrial;
end;

procedure TGeradorEFDContribuicoes.addReg0001;
begin

  registro0001 := self.SpedPISCOFINS.Bloco_0.Registro0001New;

   if not Assigned(registro0001) then exit;

   registro0001.IND_MOV := imComDados;

   registro0140 := registro0001.Registro0140.New(registro0001);

   self.addReg0100(registro0001.Registro0100.New(registro0001));
   self.addReg0110(registro0001.Registro0110);
   self.addReg0140;
end;

procedure TGeradorEFDContribuicoes.addReg0100(registro0100: TRegistro0100);
begin
   if not Assigned(registro0100) then exit;

   if not assigned(self.FContador) then exit;

   registro0100.NOME       := trim(self.FContador.nome);
   registro0100.CPF        := trim(self.FContador.cpf);
   registro0100.CRC        := trim(self.FContador.crc);
   registro0100.CNPJ       := trim(self.FContador.cnpj);
   registro0100.CEP        := trim(self.FContador.cep);
   registro0100.ENDERECO   := trim(self.FContador.rua);
   registro0100.NUM        := trim(self.FContador.numero);
   registro0100.COMPL      := '';
   registro0100.BAIRRO     := trim(self.FContador.bairro);
   registro0100.FONE       := trim(self.FContador.fone);
   registro0100.FAX        := '';
   registro0100.EMAIL      := trim(self.FContador.email);
   registro0100.COD_MUN    := self.FContador.codigo_cidade;
end;

procedure TGeradorEFDContribuicoes.addReg0110(registro0110: TRegistro0110);
begin
   if not Assigned(registro0110) then exit;

   if FRegime = 'LR' then begin //lucro real
      registro0110.COD_INC_TRIB   := codEscrOpIncNaoCumulativo;
      registro0110.IND_APRO_CRED  := indMetodoApropriacaoDireta;
    end
   else if FRegime = 'LP' then begin //lucro presumido
      registro0110.COD_INC_TRIB   := codEscrOpIncCumulativo;
      registro0110.IND_REG_CUM    := codRegimeCompetEscritDetalhada;
    end;

   registro0110.COD_TIPO_CONT  := codIndTipoConExclAliqBasica;
end;

procedure TGeradorEFDContribuicoes.addReg0140;
begin
   if not Assigned(registro0140) then exit;

   registro0140.COD_EST := '1';
  { registro0140.NOME    := Trim(self.FEmpresa.Razao);
   registro0140.CNPJ    := Trim(self.FEmpresa.CPF_CNPJ);
   registro0140.UF      := Trim(self.FEmpresa.Endereco.Cidade.estado.sigla);
   registro0140.IE      := Trim(self.FEmpresa.RG_IE);
   registro0140.COD_MUN := self.FEmpresa.Endereco.Cidade.codibge;    }

   { Adicionando registros filhos }
//   self.addReg0150(registro0001);
   self.addReg0190(registro0140);
//   self.addReg0200(registro0140);
//   self.addReg0400(registro0140);
end;

procedure TGeradorEFDContribuicoes.addReg0150(registro0140: TRegistro0140; codigo_participante :integer);
var //participante :TPessoa;
    repositorio  :TRepositorio;
begin

   if NOT self.addParticipante( codigo_participante ) then  exit;

  {   try

       participante := nil;
       repositorio  := nil;
       repositorio  := TFabricaRepositorio.GetRepositorio(TPessoa.ClassName);
       participante := TPessoa( repositorio.Get( codigo_participante ) );

       if not Assigned(registro0140) then exit;

           with registro0140.Registro0150.New(registro0140) do
            begin
               COD_PART := IntToStr( participante.Codigo );
               NOME     := Trim( participante.Razao );
               COD_PAIS := '1058';
               CNPJ     := trim( IfThen( length(participante.CPF_CNPJ) > 11, participante.CPF_CNPJ, '') );
               CPF      := trim( IfThen( length(participante.CPF_CNPJ) > 11, '', participante.CPF_CNPJ) );
               IE       := trim( participante.RG_IE );
               COD_MUN  := participante.Endereco.Cidade.codibge;
               SUFRAMA  := ''; //no momento nenhum cliente ou fornecedor referente a zona franca de manaus
               ENDERECO := participante.Endereco.Logradouro;
               NUM      := participante.Endereco.Numero;
               COMPL    := participante.Endereco.Complemento;
               BAIRRO   := participante.Endereco.Bairro;
            end; { Fim do with }

    { finally
        FreeAndNil( participante );
        FreeAndNil( repositorio );
     end;   }

end;

procedure TGeradorEFDContribuicoes.addReg0190(registro0140: TRegistro0140);
begin
   if not Assigned(registro0140) then exit;

   with registro0140.Registro0190.New(registro0140) do
   begin
      UNID  := 'UN';
      DESCR := 'Unidade';
   end;
end;

procedure TGeradorEFDContribuicoes.addReg0200(registro0140: TRegistro0140; codigo_produto :integer);
var produto :TProduto;
    repositorio  :TRepositorio;
begin

   if NOT self.addProduto( codigo_produto )    then  exit;

     try
       produto      := nil;
       repositorio  := nil;
       repositorio  := TFabricaRepositorio.GetRepositorio(TProduto.ClassName);
       produto      := TProduto( repositorio.Get( codigo_produto ) );

       if not Assigned(registro0140) then exit;

          with registro0140.Registro0200.New(registro0140) do
           begin
              COD_ITEM     := IntToStr(produto.Codigo);
              DESCR_ITEM   := TRIM(produto.Descricao);
              COD_BARRA    := '';
              COD_ANT_ITEM := '';
              UNID_INV     := 'UN';
              TIPO_ITEM    := tiMercadoriaRevenda; // 00 - mercadoria para revenda
              COD_NCM      := IntToStr(produto.Cod_Ncm);
              EX_IPI       := '';
              COD_GEN      := '';
              COD_LST      := '';
              ALIQ_ICMS    := 0;
           end;

     finally
        FreeAndNil( produto );
        FreeAndNil( repositorio );
     end;

end;

procedure TGeradorEFDContribuicoes.addReg0400(registro0140: TRegistro0140; codigo_natureza :integer);
var natureza     :TNaturezaOperacao;
    repositorio  :TRepositorio;
begin

   if NOT self.addNaturezaOperacao( codigo_natureza ) then  exit;

     try
        natureza     := nil;
        repositorio  := nil;
        repositorio  := TFabricaRepositorio.GetRepositorio(TNaturezaOperacao.ClassName);
        natureza     := TNaturezaOperacao( repositorio.Get( codigo_natureza ) );

        if not Assigned(registro0140) then exit;

             with registro0140.Registro0400.New(registro0140) do
             begin
                COD_NAT   := IntToStr(natureza.Codigo);
                DESCR_NAT := natureza.Descricao;
             end;

     finally
        FreeAndNil( natureza );
        FreeAndNil( repositorio );
     end;

end;

procedure TGeradorEFDContribuicoes.addRegC001(registroC001: TRegistroC001);
begin
   if not Assigned(registroC001) then exit;

   with registroC001 do
   begin
      IND_MOV := imComDados;

      self.addRegC010(registroC001);
   end;
end;

procedure TGeradorEFDContribuicoes.addRegC010(registroC001: TRegistroC001);
var ListaNotas :TObjectList;
    repositorio :TRepositorio;
    especificacao :TEspecificacaoNotaFiscalPorPeriodoEStatus;
    i :integer;
    c_d :Boolean;
begin
   try
      if not Assigned(registroC001) then exit;

      c_d           := true;
      ListaNotas    := nil;
      repositorio   := TFabricaRepositorio.GetRepositorio(TNotaFiscal.ClassName);
     { especificacao := TEspecificacaoNotaFiscalPorPeriodoEStatus.Create(self.DataInicial,
                                                                        self.DataFinal,
                                                                        false,
                                                                        true,
                                                                        false,
                                                                        true,
                                                                        //self.FEmpresa.CPF_CNPJ,
                                                                        IfThen(self.FEmpresa.RegimeTributario= trtLucroPresumido, 'S', 'A'));}
      ListaNotas    := repositorio.GetListaPorEspecificacao( especificacao );

      with registroC001.RegistroC010.New do
       begin
         // CNPJ      := self.FEmpresa.CPF_CNPJ;
          IND_ESCRI := IndEscriIndividualizado;

          for i := 0 to ListaNotas.Count - 1 do
           begin
              Application.ProcessMessages;

              if (self.FCfops.Active) and not(self.FCfops.IsEmpty) then begin
            //    c_d :=  self.FCfops.Locate('cfop',(ListaNotas[i] as TNotaFiscal).Natureza.CFOP,[]) ;

                if not self.FConsidera_desconsidera then
                  c_d := (c_d = self.FConsidera_desconsidera);
              end;

              if c_d then  
                self.addRegC100(RegistroC100.New, (ListaNotas[i] as TNotaFiscal) );
           end;

       end;
       
   finally
      FreeAndNil( ListaNotas );
   end;
end;

procedure TGeradorEFDContribuicoes.addRegC100(registroC100: TRegistroC100; Nota_Fiscal :TNotaFiscal);
begin
   if not Assigned(registroC100) then exit;

   with registroC100 do
   begin
      Application.ProcessMessages;

      { Dados de identificação da NF }
 {     if Nota_Fiscal.Entrada_saida = 'E' then begin

        IND_OPER  := tpEntradaAquisicao;

        if self.FEmpresa.CPF_CNPJ = Nota_Fiscal.Emitente.CPF_CNPJ then  IND_EMIT  := edEmissaoPropria
                                                                  else  IND_EMIT  := edTerceiros;
        COD_PART  := intToStr(Nota_Fiscal.Emitente.Codigo);

      end
      else begin
        IND_OPER  := tpSaidaPrestacao;
        IND_EMIT  := edEmissaoPropria;
        COD_PART  := intToStr(Nota_Fiscal.Destinatario.Codigo);
      end;

      COD_MOD         := '55';

           if Nota_Fiscal.Status = snfCancelada  then   COD_SIT := sdfCancelado
      else if Nota_Fiscal.Status = snfAutorizada then   COD_SIT := sdfRegular;

      SER             := '001';

      NUM_DOC         := IntToStr(Nota_Fiscal.NumeroNotaFiscal);
      CHV_NFE         := Nota_Fiscal.ChaveAcesso;
      DT_DOC          := Nota_Fiscal.DataEmissao;
      DT_E_S          := Nota_Fiscal.DataSaida;
      IND_PGTO        := tpVista;

      { Valores da NF }
    {  VL_DOC          := Nota_Fiscal.Totais.TotalNF;
      VL_DESC         := Nota_Fiscal.Totais.Descontos;
      VL_ABAT_NT      := 0;
      VL_MERC         := Nota_Fiscal.Totais.TotalProdutos;
      VL_SEG          := Nota_Fiscal.Totais.Seguro;
      VL_OUT_DA       := Nota_Fiscal.Totais.OutrasDespesas;     }

      { Frete }
   {   if Nota_Fiscal.TipoFrete = tfCIF then   IND_FRT := tfPorContaEmitente
                                       else   IND_FRT := tfPorContaDestinatario;

      VL_FRT          := Nota_Fiscal.Totais.Frete;

      { Impostos }
      { ICMS }
  {    VL_BC_ICMS      := Nota_Fiscal.Totais.BaseCalculoICMS;
      VL_ICMS         := Nota_Fiscal.Totais.ICMS;

      { ICMS de ST }
  {    VL_BC_ICMS_ST   := Nota_Fiscal.Totais.BaseCalculoST;
      VL_ICMS_ST      := Nota_Fiscal.Totais.ICMSST;

      { IPI }
  {    VL_IPI          := Nota_Fiscal.Totais.IPI;

      { PIS/COFINS }
  {    VL_PIS          := Nota_Fiscal.Totais.PIS;
      VL_COFINS       := Nota_Fiscal.Totais.COFINS;

      { PIS/COFINS de ST }
 {     VL_PIS_ST       := 0;
      VL_COFINS_ST    := 0;

      //adiciona participante se ja nao estiver adicionado
      self.addReg0150( self.registro0140, strToInt(COD_PART));
      self.addReg0400( self.registro0140, Nota_Fiscal.Natureza.Codigo);

      //self.addRegC120(registroC100, self.CDSC100.FieldByName(TRegistrosC100.COD_NOTA).AsFloat);
      if Nota_Fiscal.Status = snfAutorizada then
         self.addRegC170(registroC100, Nota_Fiscal.Itens );    }

   end;
end;

procedure TGeradorEFDContribuicoes.addRegC120(registroC100: TRegistroC100;
  nCodNota: Real);
begin
  //registro de declaração de importação
end;

procedure TGeradorEFDContribuicoes.addRegC170(registroC100: TRegistroC100;
  ItensNota :TObjectList);
var i :integer;
    ItemFiscal : TItemNotaFiscal;
begin

  if not Assigned(registroC100) then exit;

   ItemFiscal := nil;

   for i := 0 to ItensNota.Count - 1 do
   begin
      Application.ProcessMessages;

      ItemFiscal := (ItensNota[i] as TItemNotaFiscal );

      with registroC100.RegistroC170.New do
      begin
         { Dados de identificação do item }
         NUM_ITEM           := intToStr(i + 1);
         COD_ITEM           := IntToStr(ItemFiscal.Produto.Codigo);
         DESCR_COMPL        := '';
         IND_MOV            := TRegistroC170.GetIndMov('0');
         CFOP               := ItemFiscal.NaturezaOperacao.CFOP;
         COD_NAT            := intToStr(ItemFiscal.NaturezaOperacao.Codigo);
         COD_CTA            := '';

         { Valores do item }
         QTD                := ItemFiscal.Quantidade;
         UNID               := ItemFiscal.Unidade;
         VL_ITEM            := ItemFiscal.ValorUnitario * ItemFiscal.Quantidade;
         VL_DESC            := ItemFiscal.ValorDesconto;

         { Dados de impostos }
         { ICMS }
     {    CST_ICMS           := TRegistroC170.GetCSTIcms( TStringUtilitario.CaracterAEsquerda('0', ItemFiscal.Icms00.CST, 3) );
         VL_BC_ICMS         := ItemFiscal.Icms00.BaseCalculo;
         ALIQ_ICMS          := ItemFiscal.Icms00.Aliquota;    }
         VL_BC_ICMS_ST      := 0;
         ALIQ_ST            := 0;
         VL_ICMS_ST         := 0;

         { IPI }
         IND_APUR           := TRegistroC170.GetIndApur('0'); //0 - mensal    1 - decendial
      {   CST_IPI            := TRegistroC170.GetCSTIpi( ItemFiscal.IpiTrib.CST );
         COD_ENQ            := '';
         VL_BC_IPI          := ItemFiscal.IpiTrib.BaseCalculo;
         ALIQ_IPI           := ItemFiscal.IpiTrib.Aliquota;
         VL_IPI             := ItemFiscal.IpiTrib.Valor;}

         { PIS }
       //  CST_PIS            := TRegistroC170.GetCSTPis( IfThen(ItemFiscal.NaturezaOperacao.suspensao_icms = 'S', '09', ItemFiscal.PisAliq.CST) );
       {  VL_BC_PIS          := ItemFiscal.PisAliq.BaseCalculo;
         ALIQ_PIS_PERC      := ItemFiscal.PisAliq.Aliquota;
//         QUANT_BC_PIS       := 0;
//         ALIQ_PIS_R         := 0;
         VL_PIS             := ItemFiscal.PisAliq.Valor;

         { COFINS }
    //     CST_COFINS         := TRegistroC170.GetCSTCofins( IfThen(ItemFiscal.NaturezaOperacao.suspensao_icms = 'S', '09', ItemFiscal.CofinsAliq.CST) );
       {  VL_BC_COFINS       := ItemFiscal.CofinsAliq.BaseCalculo;
         ALIQ_COFINS_PERC   := ItemFiscal.CofinsAliq.Aliquota;
//          QUANT_BC_COFINS    := 0;
//          ALIQ_COFINS_R      := 0;
         VL_COFINS          := ItemFiscal.CofinsAliq.Valor;

         { ADICIONA PRODUTO AO REGISTRO 200, SE JA NAO ESTIVER }
         self.addReg0200( self.registro0140, ItemFiscal.Produto.Codigo );
      end;

   end;
end;

procedure TGeradorEFDContribuicoes.addRegC500;
var
  registroC500 : TRegistroC500;
begin

  {
  REGISTRO C500: NOTA FISCAL/CONTA DE ENERGIA ELÉTRICA (CÓDIGO 06), NOTA
  FISCAL/CONTA DE FORNECIMENTO D'ÁGUA CANALIZADA (CÓDIGO 29) E NOTA FISCAL
  CONSUMO FORNECIMENTO DE GÁS (CÓDIGO 28) – DOCUMENTOS DE
  ENTRADA/AQUISIÇÃO COM CRÉDITO
  }

   registroC500 :=  TRegistroC500.Create;

 {  with RegistroC500 do
      begin
         COD_PART           := '';
         COD_MOD            := qry.fieldbyname('cod_mod').AsString;;
         COD_SIT            :=  sdRegular;
         SER                := qry.fieldbyname('serie').AsString;
         SUB                := qry.fieldbyname('subserie').AsInteger;
         NUM_DOC            := qry.fieldbyname('nrdoc').AsInteger;
         DT_DOC             := qry.fieldbyname('dtlancto').AsDateTime;
         DT_ENT             := qry.fieldbyname('dtvencto').AsDateTime;;
         VL_DOC             := qry.fieldbyname('vlrtot').AsFloat;;
         VL_ICMS            := qry.fieldbyname('vl_icms').AsFloat;;
         COD_INF            := '';
         VL_PIS             := qry.fieldbyname('vl_pis').AsFloat;
         VL_COFINS          := qry.fieldbyname('vl_cofins').AsFloat;;
      end;       }

  FreeAndNil( registroC500 );
end;

constructor TGeradorEFDContribuicoes.Create(dDataInicial,
  dDataFinal: TDateTime; lGeraBloco0, lGeraBlocoA, lGeraBlocoC,
  lGeraBlocoD, lGeraBlocoF, lGeraBlocoM, lGeraBloco1: Boolean; cCaminhoArquivo, regime: String;
  {Empresa :TEmpresa;} Contador :TContador; cfops :TClientDataSet; considera_desconsidera :Boolean);
begin
  inherited Create;

  self.FRegime   := regime;
//  self.FEmpresa  := Empresa;
  self.FContador := Contador;
  self.FCfops    := cfops;
  self.FConsidera_desconsidera := considera_desconsidera;

  { Atributos de período }
  self.DataInicial                  := dDataInicial;
  self.DataFinal                    := dDataFinal;

  { Atributos booleanos para verificação se vai gerar cada bloco }
  self.GerarBloco0                  := lGeraBloco0;
  self.GerarBlocoA                  := lGeraBlocoA;
  self.GerarBlocoC                  := lGeraBlocoC;
  self.GerarBlocoD                  := lGeraBlocoD;
  self.GerarBlocoF                  := lGeraBlocoF;
  self.GerarBlocoM                  := lGeraBlocoM;
  self.GerarBloco1                  := lGeraBloco1;

  Self.FisConcomitante               := false;

  { Propriedades do ACBr }
  Self.SpedPISCOFINS                := TACBrSPEDPisCofins.Create(nil);
  self.SpedPISCOFINS.Path           := cCaminhoArquivo;
  self.SpedPISCOFINS.Arquivo        := self.getNomeArquivo;
  self.SpedPISCOFINS.Delimitador    := '|';
  self.SpedPISCOFINS.TrimString     := True;
  self.SpedPISCOFINS.CurMascara     := '#0.00';
  self.SpedPISCOFINS.DT_INI         := self.DataInicial;
  self.SpedPISCOFINS.DT_FIN         := self.DataFinal;
  self.SpedPISCOFINS.LinhasBuffer   := Buffer;

  //inicializa cds de participantes para posterior comparação de repetidos
  FCDSParticipantes := TClientDataSet.Create(nil);
  FCDSParticipantes.Close;
  FCDSParticipantes.FieldDefs.Clear;
  FCDSParticipantes.FieldDefs.add('CODIGO',ftInteger);
  FCDSParticipantes.CreateDataSet;

  //inicializa cds de produtos para posterior comparação de repetidos
  FCDSProdutos := TClientDataSet.Create(nil);
  FCDSProdutos.Close;
  FCDSProdutos.FieldDefs.Clear;
  FCDSProdutos.FieldDefs.add('CODIGO',ftInteger);
  FCDSProdutos.CreateDataSet;

  //inicializa cds de produtos para posterior comparação de repetidos
  FCDSNaturezasOperacao := TClientDataSet.Create(nil);
  FCDSNaturezasOperacao .Close;
  FCDSNaturezasOperacao .FieldDefs.Clear;
  FCDSNaturezasOperacao .FieldDefs.add('CODIGO',ftInteger);
  FCDSNaturezasOperacao .CreateDataSet;
end;

procedure TGeradorEFDContribuicoes.GeraBloco0;
begin
  { Chamo as funções que escrevem os dados nas listas do ACBr }
   with Self.SpedPISCOFINS.Bloco_0 do
   begin
      self.addReg0000;
      self.addReg0001;
   end;

   if FisConcomitante then
   begin
      Self.SpedPISCOFINS.WriteBloco_0;
   end;
end;

procedure TGeradorEFDContribuicoes.GeraBloco1;
begin
   { Bloco não implementado }
   self.SpedPISCOFINS.Bloco_1.Registro1001.IND_MOV := imSemDados;
   if FisConcomitante then Self.SpedPISCOFINS.WriteBloco_1;
end;

procedure TGeradorEFDContribuicoes.GeraBlocoA;
begin
   { Bloco não implementado }
   self.SpedPISCOFINS.Bloco_A.RegistroA001.IND_MOV := imSemDados;

   if FisConcomitante then self.SpedPISCOFINS.WriteBloco_A(true);
end;

procedure TGeradorEFDContribuicoes.GeraBlocoC;
begin
   with Self.SpedPISCOFINS.Bloco_C do
   begin
      self.addRegC001(registroC001New);
   end;

   if FisConcomitante then
      Self.SpedPISCOFINS.WriteBloco_C(True);
end;

procedure TGeradorEFDContribuicoes.GeraBlocoD;
begin
   with self.SpedPISCOFINS.Bloco_D do begin
      with RegistroD001New do
        IND_MOV := imSemDados;
   end;

   {if FisConcomitante then} Self.SpedPISCOFINS.WriteBloco_D;
end;

procedure TGeradorEFDContribuicoes.GeraBlocoF;
begin
   with self.SpedPISCOFINS.Bloco_F do begin
      with RegistroF001New do
        IND_MOV := imSemDados;
   end;

  { if FisConcomitante then }Self.SpedPISCOFINS.WriteBloco_F;
end;

procedure TGeradorEFDContribuicoes.GeraBlocoM;
begin
   with self.SpedPISCOFINS.Bloco_M do begin
      with RegistroM001New do
        IND_MOV := imSemDados;
   end;

   {if FisConcomitante then} Self.SpedPISCOFINS.WriteBloco_M;
end;

procedure TGeradorEFDContribuicoes.Gera_EFD_Contribuicoes;
begin
  try
  Self.SpedPISCOFINS.IniciaGeracao;

  if self.GerarBloco0 then  self.GeraBloco0;
  if self.GerarBlocoA then  self.GeraBlocoA;
  if self.GerarBlocoC then  self.GeraBlocoC;
  if self.GerarBlocoD then  self.GeraBlocoD;
  if self.GerarBlocoF then  self.GeraBlocoF;
  if self.GerarBlocoM then  self.GeraBlocoM;
  if self.GerarBloco1 then  self.GeraBloco1;

  { Gravando arquivo no disco rígido }
  self.SpedPISCOFINS.SaveFileTXT;

  finally
   // registro0000.Destroy;
   // registro0001.Destroy;
  end;
end;

function TGeradorEFDContribuicoes.getNomeArquivo: String;
begin
  result := 'efd_PIS_COFINS'+ FormatDateTime('mm', self.DataInicial) + FormatDateTime('yyyy', self.DataInicial) + '.txt';
end;

procedure TGeradorEFDContribuicoes.addRegD001(registroD001: TRegistroD001);
begin
   if not Assigned(registroD001) then exit;

   with registroD001 do
   begin
   //   IND_MOV := imComDados;
      IND_MOV := imSemDados;

      self.addRegD010(registroD001);
   end;
end;

procedure TGeradorEFDContribuicoes.addRegD010(registroD001: TRegistroD001);
begin
   try
      if not Assigned(registroD001) then exit;

      with registroD001.RegistroD010.New do
       begin
     //     CNPJ      := trim( self.FEmpresa.CPF_CNPJ );

     {     while not self.CDSD100.Eof do
           begin
              Application.ProcessMessages;

              Inc(count);

              self.addRegD100(RegistroD100.New);
              self.CDSD100.Next;
           end;
                      }
       end;

   finally

   end;
end;

procedure TGeradorEFDContribuicoes.addRegD100(registroD100: TRegistroD100);
begin

end;

procedure TGeradorEFDContribuicoes.addRegD101(registroD100: TRegistroD100;
  nCodNota: Real);
begin

end;

procedure TGeradorEFDContribuicoes.addRegD105(registroD100: TRegistroD100;
  nCodNota: Real);
begin

end;

constructor TGeradorEFDContribuicoes.Destroy;
begin
 // FreeAndNil( FEmpresa );
  FreeAndNil( FContador );
  Self.SpedPISCOFINS.Free;
  Self.SpedPISCOFINS := nil;
end;

end.
