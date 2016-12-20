unit GeradorEFDFiscal;

interface

uses ACBrSpedFiscal, ACBrEFDBlocos, {Empresa, }Contador, NotaFiscal, ItemNotaFiscal, {Pessoa,}ContNrs, DBClient,
     ACBrEFDBloco_0, EFDPisCofinsFuncoes, Math, Forms, Variants, TipoStatusNotaFiscal, StringUtilitario,
     ACBrEFDBloco_C, Funcoes,
     ACBrEFDBloco_E,
     ACBrEFDBloco_D;

type TGeradorEFDFiscal = class

  private
    FRegistro0000 :TRegistro0000;
    FRegistro0001 :TRegistro0001;
    FRegistro0150 :TRegistro0150;

    { Outros atributos }
    SpedFiscal            :TACBrSPEDFiscal;
 //   FEmpresa              :TEmpresa;
    FContador             :TContador;
    FDataInicial          :TDateTime;
    FDataFinal            :TDateTime;
    FConcomitante         :Boolean;
    FTotal_Debitos        :Real;
    FTotal_Creditos       :Real;
    ListaNotas            :TObjectList;

    FCDSParticipantes     :TClientDataSet;
    FCDSProdutos          :TClientDataSet;
    FCDSNaturezasOperacao :TClientDataSet;
    FCDSItensC190         :TClientDataSet;
    FCDSUnidades          :TClientDataSet;

    { Atributos relacionados a geração dos blocos }
    GerarBloco0        :Boolean;
    GerarBlocoC        :Boolean;
    GerarBlocoD        :Boolean;
    GerarBlocoE        :Boolean;
    GerarBlocoH        :Boolean;
    GerarBloco1        :Boolean;
    GerarBloco9        :Boolean;

    function  getNomeArquivo        : String;

  private

    function  addParticipante(codigo_participante :integer): Boolean;
    function  addProduto(codigo_produto :String): Boolean;
    function  addNaturezaOperacao(codigo_Natureza :integer): Boolean;
    function  addUnidades(unidade :String):Boolean;
    procedure preenche_lista_nf;
    procedure gera_registros_temporarios;

   { Métodos geradores de cada bloco }
    procedure GeraBloco0;
    procedure GeraBlocoC;
    procedure GeraBlocoD;
    procedure GeraBlocoE;
    procedure GeraBlocoH;
    procedure GeraBloco1;
    procedure GeraBloco9;

    { Métodos para adicionar dados nos registros do ACBr }
    { Bloco 0 }
    procedure addReg0000{(registro0000 :TRegistro0000)}; { Dados da Empresa }
    procedure addReg0001{(registro0001 :TRegistro0001)}; { Abertura do bloco 0 }
      procedure addReg0005(registro0005 :TRegistro0005); { Complementos da empresa }
      procedure addReg0100(registro0100 :TRegistro0100); { Dados do contabilista }
        procedure addReg0150{( codigo_participante :integer)}; { Cadastro de Participante }
        procedure addReg0190{(registro0190 :TRegistro0190)}; { Cadastro de medidas }
        procedure addReg0200{(codigo_produto :integer)}; { Cadastro de itens/produtos }
        procedure addReg0400{(codigo_natureza :integer)}; { Cadastro de natureza de operação/prestação }

    { Bloco C }
    procedure addRegC001(registroC001: TRegistroC001);
       procedure addRegC100(registroC001: TRegistroC001); { Documento de nota fiscal }
          procedure addRegC190(registroC100 :TRegistroC100; Itensnota :TObjectList); { itens emissão própria }
          procedure addRegC170(registroC100 :TRegistroC100; ItensNota :TObjectList); { itens emissão terceiros }
          procedure addRegC170Materia(registroC100 :TRegistroC100; ItensNota :TObjectList); { itens emissão terceiros }

    { Bloco C }
    procedure addRegE001(registroE001: TRegistroE001);
       procedure addRegE100(registroE100: TRegistroE100);

  public
    constructor Create(dDataInicial, dDataFinal :TDateTime;
                       lGeraBloco0              :Boolean;
                       lGeraBlocoC              :Boolean;
                       lGeraBlocoD              :Boolean;
                       lGeraBlocoE              :Boolean;
                       lGeraBlocoH              :Boolean;
                       lGeraBloco1              :Boolean;
                       lGeraBloco9              :Boolean;
                       cCaminhoArquivo          :String;
                   //    Empresa                  :TEmpresa;
                       Contador                 :TContador);

    constructor Destroy;

    procedure Gera_EFD_Fiscal;

end;

implementation

uses TypInfo, SysUtils, ACBrEFDBloco_0_Class, repositorio, FabricaRepositorio, Especificacao,
  StrUtils, Produto, NaturezaOperacao, EspecificacaoNotaFiscalPorPeriodoEStatus, TipoFrete, DB,
 { Icms00, TributacaoItemNotaFiscal,} Classes;

const Buffer = 1000;

{ TGeradorEFDFiscal }

function TGeradorEFDFiscal.addNaturezaOperacao(
  codigo_Natureza: integer): Boolean;
begin
  result := false;

  if FCDSNaturezasOperacao.Locate('CODIGO', codigo_Natureza, []) then exit;

   FCDSNaturezasOperacao.Append;
   FCDSNaturezasOperacao.FieldByName('CODIGO').AsInteger := codigo_Natureza;
   FCDSNaturezasOperacao.Post;

  result := true;
end;

function TGeradorEFDFiscal.addParticipante(
  codigo_participante: integer): Boolean;
begin
   result := False;

   if FCDSParticipantes.Locate('CODIGO', codigo_participante, []) then exit;

   FCDSParticipantes.Append;
   FCDSParticipantes.FieldByName('CODIGO').AsInteger := codigo_participante;
   FCDSParticipantes.Post;

   result := true;
end;

function TGeradorEFDFiscal.addProduto(codigo_produto: String): Boolean;
begin
  result := false;

  if FCDSProdutos.Locate('CODIGO', codigo_produto, []) then exit;

   FCDSProdutos.Append;
   FCDSProdutos.FieldByName('CODIGO').AsString := codigo_produto;
   FCDSProdutos.Post;

  result := true;
end;

procedure TGeradorEFDFiscal.addReg0000;
begin
//   registro0000 := self.SpedFiscal.Bloco_0.Registro0000New;

  with self.SpedFiscal.Bloco_0 do begin

   with Registro0000New do begin

   if not Assigned(registro0000) then exit;

   registro0000.COD_VER     := vlVersao109;
   registro0000.COD_FIN     := raOriginal;
   registro0000.DT_INI      := self.FDataInicial;
   registro0000.DT_FIN      := self.FDataFinal;
   {registro0000.NOME        := trim(self.FEmpresa.Razao);
   registro0000.CNPJ        := TStringUtilitario.ApenasNumeros( trim(self.FEmpresa.CPF_CNPJ) );
//   registro0000.CPF         :=
   registro0000.UF          := trim(self.FEmpresa.Endereco.Cidade.estado.sigla);
   registro0000.IE          := TStringUtilitario.ApenasNumeros( trim(self.FEmpresa.RG_IE) );
   registro0000.COD_MUN     := self.FEmpresa.Endereco.Cidade.codibge;   }
   registro0000.IM          := '';
   registro0000.SUFRAMA     := '';
   registro0000.IND_PERFIL  := pfPerfilA;
   registro0000.IND_ATIV    := atOutros;

   end;
   end;
end;

procedure TGeradorEFDFiscal.addReg0001;
begin
  FRegistro0001 := self.SpedFiscal.Bloco_0.Registro0001New;

   if not Assigned(FRegistro0001) then exit;

     FRegistro0001.IND_MOV := imComDados;

     self.addReg0005( FRegistro0001.Registro0005 );

     self.addReg0100( FRegistro0001.Registro0100 );

     self.addReg0200;
     self.addReg0190{( FRegistro0001.Registro0190.New( FRegistro0001 ))};

     self.addReg0150;

     self.addReg0400;
end;

procedure TGeradorEFDFiscal.addReg0005(registro0005: TRegistro0005);
begin
   with registro0005 do begin
   {   FANTASIA   := self.FEmpresa.Razao;
      CEP        := self.FEmpresa.Endereco.CEP;
      ENDERECO   := trim(self.FEmpresa.Endereco.Logradouro);
      NUM        := self.FEmpresa.Endereco.Numero;
      COMPL      := trim(self.FEmpresa.Endereco.Complemento);
      BAIRRO     := trim(self.FEmpresa.Endereco.Bairro);
      FONE       := TStringUtilitario.ApenasNumeros( self.FEmpresa.Fone1 );
      FAX        := TStringUtilitario.ApenasNumeros( self.FEmpresa.Fax );
      EMAIL      := self.FEmpresa.Email;    }
   end;
end;

procedure TGeradorEFDFiscal.addReg0100(registro0100: TRegistro0100);
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
   registro0100.FONE       := TStringUtilitario.ApenasNumeros( trim(self.FContador.fone) );
   registro0100.FAX        := '';
   registro0100.EMAIL      := trim(self.FContador.email);
   registro0100.COD_MUN    := self.FContador.codigo_cidade;

end;

procedure TGeradorEFDFiscal.addReg0150{(codigo_participante :integer)};
var{ participante :TPessoa; }
    repositorio  :TRepositorio;
    i, codigo_participante :integer;
begin

  try

    for i := 0 to ListaNotas.Count - 1 do begin

  {   if not(TNotaFiscal( ListaNotas.Items[i] ).Status = snfAutorizada) then
        continue;

      if TNotaFiscal( ListaNotas.Items[i] ).Entrada_saida = 'E' then
        codigo_participante := TNotaFiscal( ListaNotas.Items[i] ).Emitente.Codigo
      else
        codigo_participante := TNotaFiscal( ListaNotas.Items[i] ).Destinatario.Codigo;

      if not FCDSParticipantes.Locate('CODIGO',codigo_participante,[]) then  CONTINUE;

      participante := nil;
      repositorio  := nil;
      repositorio  := TFabricaRepositorio.GetRepositorio(TPessoa.ClassName);
      participante := TPessoa( repositorio.Get( codigo_participante ) );

      if not assigned( self.FRegistro0001 ) then EXIT;

      with self.FRegistro0001.Registro0150.New(self.FRegistro0001) do begin


              COD_PART := IntToStr( participante.Codigo );
              NOME     := Trim( participante.Razao );
              COD_PAIS := '1058';
              CNPJ     := trim( IfThen( length(participante.CPF_CNPJ) > 11, participante.CPF_CNPJ, '') );
              CPF      := TStringUtilitario.ApenasNumeros( trim( IfThen( length(participante.CPF_CNPJ) > 11, '', participante.CPF_CNPJ) ));
              IE       := TStringUtilitario.ApenasNumeros( trim( participante.RG_IE ) );
              COD_MUN  := participante.Endereco.Cidade.codibge;
              SUFRAMA  := ''; //no momento nenhum cliente ou fornecedor referente a zona franca de manaus
              ENDERECO := participante.Endereco.Logradouro;
              NUM      := participante.Endereco.Numero;
              COMPL    := participante.Endereco.Complemento;
              BAIRRO   := participante.Endereco.Bairro;


      end;                                }

      FCDSParticipantes.Delete;

    end;//for

  finally
    // FreeAndNil( participante );
     FreeAndNil( repositorio );
  end;
end;

procedure TGeradorEFDFiscal.addReg0190{(registro0190 :TRegistro0190)};
begin
 //  if not assigned( registro0190 ) then EXIT;

   if self.FCDSUnidades.IsEmpty then Exit;

//   with self.FRegistro0001.Registro0400.New(self.FRegistro0001) do

   FCDSUnidades.first;
   while not FCDSUnidades.Eof do begin

     with self.FRegistro0001.registro0190.New(self.FRegistro0001) do begin
        UNID  := FCDSUnidades.fieldByName('UNIDADE').AsString;
        DESCR := Campo_por_campo('UNIDADES','DESCRICAO','UNIDADE_MEDIDA',FCDSUnidades.fieldByName('UNIDADE').AsString);
     end;

     FCDSUnidades.Next;
   end;
end;

procedure TGeradorEFDFiscal.addReg0200{(codigo_produto: integer)};
var produto        :TProduto;
    repositorio    :TRepositorio;
    i, x           :integer;
    NotaFiscal     :TNotaFiscal;
    ItemNotaFiscal :TItemNotaFiscal;
    codigo_produto :String;
begin
  NotaFiscal     := nil;
  ItemNotaFiscal := nil;

  for i := 0 to ListaNotas.Count - 1 do begin

 {   NotaFiscal := TNotaFiscal(ListaNotas.Items[i]);

    if not ((NotaFiscal.Entrada_saida = 'E') and (self.FEmpresa.CPF_CNPJ <> NotaFiscal.Emitente.CPF_CNPJ))
        or not(NotaFiscal.Status = snfAutorizada) then
           CONTINUE;

    for x := 0 to NotaFiscal.Itens.Count - 1 do begin

        if not NotaFiscal.NotaDeMaterias then begin

           ItemNotaFiscal := (NotaFiscal.Itens[x] as TItemNotaFiscal);
           codigo_produto := 'P'+IntToStr( ItemNotaFiscal.Produto.Codigo);

           if not FCDSProdutos.Locate('CODIGO', codigo_produto,[]) then CONTINUE;

           if not assigned( self.FRegistro0001 ) then EXIT;

               with self.FRegistro0001.Registro0200.New(self.FRegistro0001) do
                begin
                   COD_ITEM     := 'P'+IntToStr(ItemNotaFiscal.Produto.Codigo);
                   DESCR_ITEM   := TRIM(ItemNotaFiscal.Produto.Descricao);
                   COD_BARRA    := '';
                   COD_ANT_ITEM := '';
                   UNID_INV     := 'UN';
                   TIPO_ITEM    := tiMercadoriaRevenda; // 00 - mercadoria para revenda
                   COD_NCM      := IntToStr(ItemNotaFiscal.Produto.Cod_Ncm);
                   EX_IPI       := '';
                   COD_GEN      := '';
                   COD_LST      := '';
                   ALIQ_ICMS    := 0;
                end;
        end
        else begin

           ItemNFMateria := (NotaFiscal.Itens[x] as TItemNfMateria);
           codigo_produto := IfThen(NotaFiscal.NotaDeServico,'S','M')+IntToStr( ItemNFMateria.Materia.codigo );

           if not FCDSProdutos.Locate('CODIGO', codigo_produto,[]) then CONTINUE;

           if not assigned( self.FRegistro0001 ) then EXIT;

               with self.FRegistro0001.Registro0200.New(self.FRegistro0001) do
                begin
                   COD_ITEM     := IfThen(NotaFiscal.NotaDeServico,'S','M')+IntToStr(ItemNFMateria.Materia.codigo);
                   DESCR_ITEM   := TRIM(ItemNFMateria.Materia.descricao);
                   COD_BARRA    := '';
                   COD_ANT_ITEM := '';
                   UNID_INV     := IfThen(NotaFiscal.NotaDeServico,'UN',ItemNFMateria.unidade);

                   if NotaFiscal.NotaDeServico then
                     TIPO_ITEM    := tiServicos //09: Serviços
                   else
                     TIPO_ITEM    := tiMateriaPrima; //01: Matéria-Prima;

                   COD_NCM      := IfThen(pos('99999',ItemNFMateria.Materia.cod_ncm)>0, '', ItemNFMateria.Materia.cod_ncm);
                   EX_IPI       := '';
                   COD_GEN      := '';
                   COD_LST      := '';
                   ALIQ_ICMS    := 0;
                end;
        end;

        FCDSProdutos.Delete;

    end;                      }

  end;
end;

procedure TGeradorEFDFiscal.addReg0400{(codigo_natureza: integer)};
var i, x     :integer;
begin

    for i := 0 to ListaNotas.Count - 1 do begin

       { SE FOR NOTA DE ENTRADA DA PROPRIA EMPRESA EMITENTE, NAO DEVE ENTRAR, POIS JA EXISTE ELA COMO SAIDA..
         PODE ACONTECER POIS AS NOTAS ESTAO NO MESMO BD }

     {  if not ((TNotaFiscal( ListaNotas.Items[i] ).Entrada_saida = 'E') and
               (self.FEmpresa.CPF_CNPJ <> TNotaFiscal( ListaNotas.Items[i] ).Emitente.CPF_CNPJ)) then CONTINUE;

       for x := 0 to TNotaFiscal( ListaNotas.Items[i] ).Itens.Count - 1 do begin

         if not FCDSNaturezasOperacao.Locate('CODIGO', TItemNfMateria( TNotaFiscal( ListaNotas.Items[i] ).Itens[x]).NaturezaOperacao.Codigo,[]) then CONTINUE;

         if not Assigned(self.FRegistro0001) then exit;

            with self.FRegistro0001.Registro0400.New(self.FRegistro0001) do
            begin
               COD_NAT   := IntToStr(TItemNfMateria( TNotaFiscal( ListaNotas.Items[i] ).Itens[x]).NaturezaOperacao.Codigo);
               DESCR_NAT := TItemNfMateria( TNotaFiscal( ListaNotas.Items[i] ).Itens[x]).NaturezaOperacao.Descricao;
            end;

         FCDSNaturezasOperacao.Delete;   
       end;
                                  }
    end;

end;

procedure TGeradorEFDFiscal.addRegC001(registroC001: TRegistroC001);
begin
   if not Assigned(registroC001) then exit;

   with registroC001 do
   begin
      IND_MOV := imComDados;

      self.addRegC100(registroC001);
   end;
end;

procedure TGeradorEFDFiscal.addRegC100(registroC001: TRegistroC001);
var
    i             :integer;
    Nota_Fiscal    :TNotaFiscal;
begin
{  try
     if not Assigned(registroC001) then exit;

     self.FTotal_Debitos  := 0;
     self.FTotal_Creditos := 0;
     Nota_Fiscal := nil;

     with registroC001 do begin
        for i := 0 to ListaNotas.Count - 1 do begin

          Nota_Fiscal := (ListaNotas[i] as TNotaFiscal);

          { se for nota de entrada e a empresa emitente for a mesma que esta sendo gerado o arquivo, vai para a proxima, pois
            esta nota ja consta como saida para a empresa }
       {   if (Nota_Fiscal.Entrada_saida = 'E') and (self.FEmpresa.CPF_CNPJ = Nota_Fiscal.Emitente.CPF_CNPJ) then
             continue;

          with RegistroC100.New( registroC001 ) do
          begin
             
             Application.ProcessMessages;

            { Dados de identificação da NF }
      {      if Nota_Fiscal.Entrada_saida = 'E' then begin

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

            if Nota_Fiscal.Status = snfCancelada  then
                COD_SIT := sdCancelado
            else if Nota_Fiscal.Status = snfAutorizada then
            begin
               if formatDateTime('mm',Nota_Fiscal.DataEmissao) <> formatDateTime('mm',Nota_Fiscal.DataSaida) then
                 COD_SIT := sdExtempRegular
               else
                 COD_SIT := sdRegular;
            end;
                                           
            SER             := Nota_Fiscal.Serie;
            NUM_DOC         := IntToStr(Nota_Fiscal.NumeroNotaFiscal);
            CHV_NFE         := Nota_Fiscal.ChaveAcesso;
            DT_DOC          := Nota_Fiscal.DataEmissao;
            DT_E_S          := Nota_Fiscal.DataSaida;
            IND_PGTO        := tpVista;

            { Valores da NF }
      {      VL_DOC          := Nota_Fiscal.Totais.TotalNF;
            VL_DESC         := Nota_Fiscal.Totais.Descontos;
            VL_ABAT_NT      := 0;
            VL_MERC         := Nota_Fiscal.Totais.TotalProdutos;
            VL_SEG          := Nota_Fiscal.Totais.Seguro;
            VL_OUT_DA       := Nota_Fiscal.Totais.OutrasDespesas;

            { Frete }
       {     if Nota_Fiscal.TipoFrete = tfCIF then   IND_FRT := tfPorContaEmitente
                                             else   IND_FRT := tfPorContaDestinatario;

            VL_FRT          := Nota_Fiscal.Totais.Frete;

            { Impostos }
            { ICMS }
       {     VL_BC_ICMS      := IfThen(Nota_Fiscal.Totais.ICMS = 0, 0, Nota_Fiscal.Totais.BaseCalculoICMS);
            VL_ICMS         := Nota_Fiscal.Totais.ICMS;

            if (VL_ICMS > 0) and (IND_OPER = tpSaidaPrestacao) then //Saida
              FTotal_Debitos  := FTotal_Debitos + VL_ICMS
            else
              FTotal_Creditos := FTotal_Creditos + VL_ICMS;

            { ICMS de ST }
         {   VL_BC_ICMS_ST   := Nota_Fiscal.Totais.BaseCalculoST;
            VL_ICMS_ST      := Nota_Fiscal.Totais.ICMSST;

            { IPI }
        {    VL_IPI          := Nota_Fiscal.Totais.IPI;

            { PIS/COFINS }
          {  VL_PIS          := Nota_Fiscal.Totais.PIS;
            VL_COFINS       := Nota_Fiscal.Totais.COFINS;

            { PIS/COFINS de ST }
        {    VL_PIS_ST       := 0;
            VL_COFINS_ST    := 0;

            { NOTAS DE EMISSAO PROPRIA GERAM O C190 E O DE TERCEIROS O C170 }
           { if (Nota_Fiscal.Status = snfAutorizada) or (Nota_Fiscal.Entrada_saida = 'E') then begin

               if (Nota_Fiscal.Entrada_saida = 'E') then begin

                  if Nota_Fiscal.NotaDeMaterias then
                    self.addRegC170Materia( registroC100.Items[i], Nota_Fiscal.Itens )
                  else
                    self.addRegC170( registroC100.Items[i], Nota_Fiscal.Itens );

                    self.addRegC190( RegistroC100.Items[i], Nota_Fiscal.Itens );

               end
               else
                  self.addRegC190( RegistroC100.Items[i], Nota_Fiscal.Itens );

            end;

          end;

        end; //fim for
     end;

  finally
     FreeAndNil( ListaNotas );
  end;                     }
end;

procedure TGeradorEFDFiscal.addRegC170(registroC100: TRegistroC100; ItensNota: TObjectList);
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
         COD_ITEM           := 'P'+IntToStr(ItemFiscal.Produto.Codigo);
         DESCR_COMPL        := '';
         IND_MOV            := mfSim;
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
    {     CST_ICMS           := ItemFiscal.Icms00.CST;
         VL_BC_ICMS         := IfThen(ItemFiscal.Icms00.Aliquota = 0, 0, ItemFiscal.Icms00.BaseDeCalculo);
         ALIQ_ICMS          := ItemFiscal.Icms00.Aliquota;
         VL_BC_ICMS_ST      := 0; }
         ALIQ_ST            := 0;
         VL_ICMS_ST         := 0;

         { IPI }
         IND_APUR           := iaMensal;
     {    CST_IPI            := ItemFiscal.IpiTrib.CST;
         COD_ENQ            := '';
         VL_BC_IPI          := ItemFiscal.IpiTrib.BaseCalculo;
         ALIQ_IPI           := ItemFiscal.IpiTrib.Aliquota;
         VL_IPI             := ItemFiscal.IpiTrib.Valor; }

         { PIS }
       {  CST_PIS            := ItemFiscal.PisAliq.CST;
         VL_BC_PIS          := ItemFiscal.PisAliq.BaseCalculo;
         ALIQ_PIS_PERC      := ItemFiscal.PisAliq.Aliquota;
//         QUANT_BC_PIS       := 0;
//         ALIQ_PIS_R         := 0;
         VL_PIS             := ItemFiscal.PisAliq.Valor;

         { COFINS }
     {    CST_COFINS         := ItemFiscal.CofinsAliq.CST;
         VL_BC_COFINS       := ItemFiscal.CofinsAliq.BaseCalculo;
         ALIQ_COFINS_PERC   := ItemFiscal.CofinsAliq.Aliquota;
//         QUANT_BC_COFINS    := 0;
//         ALIQ_COFINS_R      := 0;
         VL_COFINS          := ItemFiscal.CofinsAliq.Valor;   }
         
      end;

   end;
end;

procedure TGeradorEFDFiscal.addRegC170Materia(registroC100: TRegistroC100; ItensNota: TObjectList);
var i          :integer;
begin
  if not Assigned(registroC100) then exit;

{   ItemFiscal := nil;

   for i := 0 to ItensNota.Count - 1 do
   begin
      Application.ProcessMessages;

      ItemFiscal := (ItensNota[i] as TItemNFMateria );

      with registroC100.RegistroC170.New do
      begin
         { Dados de identificação do item }
     {    NUM_ITEM           := intToStr(i + 1);



         COD_ITEM           := IfThen(((ItemFiscal.cfop = '2124') or (ItemFiscal.cfop = '2125')), 'S', 'M')
                               +IntToStr(ItemFiscal.Materia.codigo);
         DESCR_COMPL        := '';
         IND_MOV            := mfSim;
         CFOP               := ItemFiscal.cfop;
         COD_NAT            := Campo_por_campo('NATUREZAS_OPERACAO','CODIGO','CFOP', ItemFiscal.cfop);
         COD_CTA            := '';

         { Valores do item }
      {   QTD                := ItemFiscal.quantidade;
         UNID               := ItemFiscal.unidade;
         VL_ITEM            := ItemFiscal.valor_unitario * ItemFiscal.quantidade;
         VL_DESC            := ItemFiscal.valor_desconto;

         { Dados de impostos }
         { ICMS }
       {  CST_ICMS           := IfThen(ItemFiscal.csosn <> '', ItemFiscal.csosn, ItemFiscal.cst);
         VL_BC_ICMS         := IfThen(ItemFiscal.per_icm = 0, 0, ItemFiscal.base_icm);
         ALIQ_ICMS          := ItemFiscal.per_icm;
         VL_ICMS            := (ItemFiscal.base_icm * ItemFiscal.per_icm) /100;
         VL_BC_ICMS_ST      := 0;
         ALIQ_ST            := 0;
         VL_ICMS_ST         := 0;

         { IPI }
     {    IND_APUR           := iaMensal;
         CST_IPI            := ItemFiscal.cst;
         COD_ENQ            := '';
         VL_BC_IPI          := ItemFiscal.base_ipi;
         ALIQ_IPI           := ItemFiscal.per_ipi;
         VL_IPI             := ItemFiscal.valor_ipi;

         { PIS }
  {       CST_PIS            := ItemFiscal.cst;
         VL_BC_PIS          := ItemFiscal.base_pis;
         ALIQ_PIS_PERC      := ItemFiscal.per_pis;
         QUANT_BC_PIS       := 0;
         ALIQ_PIS_R         := 0;
         VL_PIS             := ItemFiscal.valor_pis;}

         { COFINS }
      {   CST_COFINS         := ItemFiscal.cst;
         VL_BC_COFINS       := ItemFiscal.base_cofins;
         ALIQ_COFINS_PERC   := ItemFiscal.per_cofins;
         QUANT_BC_COFINS    := 0;
         ALIQ_COFINS_R      := 0;
         VL_COFINS          := ItemFiscal.valor_cofins;  }

  //    end;

//   end;
end;

procedure TGeradorEFDFiscal.addRegC190(registroC100: TRegistroC100;
  Itensnota: TObjectList);
var i :integer;
    ItemFiscal :TItemNotaFiscal;
    vl_bc_icms, vl_opr, vl_icms, vl_ipi :Real;
    Editar :Boolean;
begin
  { primeiramente separa-se os itens por CST_ICMS - CFOP - ALIQ_ICMS }

  self.FCDSItensC190.EmptyDataSet;
  ItemFiscal := nil;

  for i := 0 to Itensnota.Count - 1 do begin

    {try
      ItemFiscal    := (ItensNota[i] as TItemNotaFiscal);
      Editar        := false;

      if self.FCDSItensC190.Locate('CST_ICMS;CFOP;ALIQ_ICMS',
                                   VarArrayOf([StrToInt( ItemFiscal.Icms00.CST ), ItemFiscal.NaturezaOperacao.CFOP, ItemFiscal.Icms00.Aliquota]), []) then
        Editar := true;

    Except
      ItemNFMateria := (ItensNota[i] as TItemNfMateria);

      if self.FCDSItensC190.Locate('CST_ICMS;CFOP;ALIQ_ICMS',
                                  VarArrayOf([StrToInt( IfThen(ItemNFMateria.cst = '',
                                                               ItemNFMateria.CSOSN,
                                                               ItemNFMateria.CST) ), ItemNFMateria.NaturezaOperacao.CFOP, ItemNFMateria.per_icm]), []) then
        Editar := true;
    end;
                      }
    if Editar then
     begin
       self.FCDSItensC190.Edit;
       vl_opr     := self.FCDSItensC190.fieldByName('VL_OPR').AsFloat;
       vl_bc_icms := self.FCDSItensC190.fieldByName('VL_BC_ICMS').AsFloat;
       vl_icms    := self.FCDSItensC190.fieldByName('VL_icms').AsFloat;
       vl_ipi     := self.FCDSItensC190.fieldByName('VL_IPI').AsFloat;
     end
    else
     begin
       self.FCDSItensC190.Append;
       vl_opr     := 0;
       vl_bc_icms := 0;
       vl_icms    := 0;
       vl_ipi     := 0;
     end;

  {  If assigned(ItemFiscal) then begin
      self.FCDSItensC190.fieldByName('CST_ICMS').AsInteger    := StrToInt(  ItemFiscal.Icms00.CST );
      self.FCDSItensC190.fieldByName('CFOP').AsString         :=  ItemFiscal.NaturezaOperacao.CFOP;
      self.FCDSItensC190.fieldByName('ALIQ_ICMS').AsFloat     :=  ItemFiscal.Icms00.Aliquota;
      self.FCDSItensC190.fieldByName('VL_OPR').AsFloat        := vl_opr + (ItemFiscal.ValorUnitario * ItemFiscal.Quantidade);
      self.FCDSItensC190.fieldByName('VL_BC_ICMS').AsFloat    := vl_bc_icms + IfThen(ItemFiscal.Icms00.Valor = 0, 0, ItemFiscal.Icms00.BaseDeCalculo);
      self.FCDSItensC190.fieldByName('VL_ICMS').AsFloat       := vl_icms + ItemFiscal.Icms00.Valor;
      self.FCDSItensC190.fieldByName('VL_IPI').AsFloat        := vl_ipi + ItemFiscal.IpiTrib.Valor;
    end
    else begin
      self.FCDSItensC190.fieldByName('CST_ICMS').AsInteger    := StrToInt( IfThen(ItemNFMateria.cst = '',
                                                                                  ItemNFMateria.CSOSN,
                                                                                  ItemNFMateria.CST) );
      self.FCDSItensC190.fieldByName('CFOP').AsString         := ItemNFMateria.NaturezaOperacao.CFOP;
      self.FCDSItensC190.fieldByName('ALIQ_ICMS').AsFloat     := ItemNFMateria.per_icm;
      self.FCDSItensC190.fieldByName('VL_OPR').AsFloat        := vl_opr + (ItemNFMateria.valor_unitario * ItemNFMateria.quantidade);
      self.FCDSItensC190.fieldByName('VL_BC_ICMS').AsFloat    := vl_bc_icms + IfThen(ItemNFMateria.valor_icm = 0, 0, ItemNFMateria.base_icm);
      self.FCDSItensC190.fieldByName('VL_ICMS').AsFloat       := vl_icms + ItemNFMateria.valor_icm;
      self.FCDSItensC190.fieldByName('VL_IPI').AsFloat        := vl_ipi + ItemNFMateria.valor_ipi;
    end;
                               }
    self.FCDSItensC190.fieldByName('VL_BC_ICMS_ST').AsFloat := 0;
    self.FCDSItensC190.fieldByName('VL_ICMS_ST').AsFloat    := 0;
    self.FCDSItensC190.fieldByName('VL_RED_BC').AsFloat     := 0;
 //   self.FCDSItensC190.fieldByName('COD_OBS').AsString      := '';

    self.FCDSItensC190.Post;

  end;

  self.FCDSItensC190.First;
  while not self.FCDSItensC190.Eof do begin

    with registroC100.RegistroC190.New do begin

       CST_ICMS      := self.FCDSItensC190.fieldByName('CST_ICMS').AsString;
       CFOP          := self.FCDSItensC190.fieldByName('CFOP').AsString;
       ALIQ_ICMS     := self.FCDSItensC190.fieldByName('ALIQ_ICMS').AsFloat;
       VL_OPR        := self.FCDSItensC190.fieldByName('VL_OPR').AsFloat;
       VL_BC_ICMS    := self.FCDSItensC190.fieldByName('VL_BC_ICMS').AsFloat;
       VL_ICMS       := self.FCDSItensC190.fieldByName('VL_ICMS').AsFloat;
       VL_BC_ICMS_ST := self.FCDSItensC190.fieldByName('VL_BC_ICMS_ST').AsFloat;
       VL_ICMS_ST    := self.FCDSItensC190.fieldByName('VL_ICMS_ST').AsFloat;
       VL_RED_BC     := self.FCDSItensC190.fieldByName('VL_RED_BC').AsFloat;
       VL_IPI        := self.FCDSItensC190.fieldByName('VL_IPI').AsFloat;
//       COD_OBS       := self.FCDSItensC190.fieldByName('COD_OBS').AsString;

    end;

    self.FCDSItensC190.Next;
  end;

end;

procedure TGeradorEFDFiscal.addRegE001(registroE001: TRegistroE001);
begin
   if not Assigned(registroE001) then exit;

   with registroE001 do
   begin
      IND_MOV := imComDados;

      self.addRegE100(registroE001.RegistroE100.New(registroE001));
   end;
end;

procedure TGeradorEFDFiscal.addRegE100(registroE100: TRegistroE100);
var vSaldoApurado :Real;
begin
  if not Assigned(registroE100) then exit;

  with registroE100 do begin
    DT_INI := self.FDataInicial;
    DT_FIN := self.FDataFinal;


       with RegistroE110 do begin

         { Valor total dos débitos por "Saídas e prestações  com débito do imposto" }
          VL_TOT_DEBITOS       := (FTotal_Debitos );  //TotaisRegistro110('VL_TOT_DEBITOS');

         {Valor total dos ajustes a débito decorrentes do documento fiscal.}
          VL_AJ_DEBITOS        := 0; //(TotaisRegistro110('VL_AJ_DEBITOS') );

          {Valor total de "Ajustes a débito"}
          VL_TOT_AJ_DEBITOS    := 0; //nao encontrado o campo para calcular VL_AJ_APUR NO E111

          {Valor total de Ajustes “Estornos de créditos”}
          VL_ESTORNOS_CRED     := 0;  //nao encontrado o campo para calcular VL_AJ_APUR NO E111

          {Valor total dos créditos por "Entradas e aquisições com crédito do imposto"}
          VL_TOT_CREDITOS      := (FTotal_Creditos ); //TotaisRegistro110('VL_TOT_CREDITOS');

          {Valor total dos ajustes a crédito decorrentes do documento fiscal.}
          VL_AJ_CREDITOS       := 0;

          {Valor total de "Ajustes a crédito"}
          VL_TOT_AJ_CREDITOS   := 0;

          {Valor total de Ajustes “Estornos de Débitos”}
          VL_ESTORNOS_DEB      := 0;

          vSaldoApurado        := (FTotal_Debitos - FTotal_Creditos);

          if vSaldoApurado >= 0 then
          begin
            {Valor do saldo devedor apurado}
            VL_SLD_APURADO            := vSaldoApurado;
            VL_SLD_CREDOR_TRANSPORTAR := 0;
          end
          else
          begin
            VL_SLD_APURADO            := 0;
            VL_SLD_CREDOR_TRANSPORTAR := Abs(vSaldoApurado);
          end;

          {Valor total de "Saldo credor do período anterior"}
          VL_SLD_CREDOR_ANT    := 0;

          {Valor total de "Deduções"}
          VL_TOT_DED           := 0;

          {Valor total de "ICMS a recolher (11-12)}
        {  if (VL_SLD_APURADO) > 0 then
              VL_ICMS_RECOLHER     := VL_SLD_APURADO - VL_TOT_DED
          else
              VL_ICMS_RECOLHER     := 0;  }

          {Valor total de "Saldo credor a transportar para o
           período seguint
          {Valor total de "Saldo credor a transportar para o
           período seguinte”}
         { if (VL_SLD_APURADO) < 0 then
             VL_SLD_CREDOR_TRANSPORTAR := (VL_SLD_APURADO)*-1 //valor absoluto.
          else
             VL_SLD_CREDOR_TRANSPORTAR := 0;     }


          DEB_ESP := 0;

       {   with RegistroE111.New( RegistroE110 ) do begin
            COD_AJ_APUR    := 'PR029999';
            DESCR_COMPL_AJ := ''
            VL_AJ_APUR     := 0; // ? ? ? ? ? ? ? ? ? ? ?  ? ?? ?? ? ? ? ? ???????????????????
          end;

          with RegistroE116.New( RegistroE110 ) do begin
            COD_OR    := '';
            VL_OR     := 0;
            DT_VCTO   := date;
            COD_REC   := '';
            NUM_PROC  := '';
            IND_PROC  := opSefaz; // ou opNenhum;
            PROC      := '';
            TXT_COMPL := '';
            MES_REF   := ''; // 'mmyyyy'

          end; }

       end;

  end;
end;

function TGeradorEFDFiscal.addUnidades(unidade: String): Boolean;
begin
  unidade := UPPERCASE(unidade);
  result  := false;

  if trim(unidade) = '' then
    Exit;

  if FCDSUnidades.Locate('UNIDADE', unidade, []) then exit;

   FCDSUnidades.Append;
   FCDSUnidades.FieldByName('UNIDADE').AsString   := unidade;
   FCDSUnidades.Post;

  result := true;
end;

constructor TGeradorEFDFiscal.Create(dDataInicial, dDataFinal: TDateTime;
  lGeraBloco0, lGeraBlocoC, lGeraBlocoD, lGeraBlocoE, lGeraBlocoH,
  lGeraBloco1, lGeraBloco9: Boolean; cCaminhoArquivo: String;
  {Empresa: TEmpresa;} Contador: TContador);
begin
  inherited Create;

 // self.FEmpresa  := Empresa;
  self.FContador := Contador;

  self.FConcomitante := True;

  { Atributos de período }
  self.FDataInicial                  := dDataInicial;
  self.FDataFinal                    := dDataFinal;

  { Atributos booleanos para verificação se vai gerar cada bloco }
  self.GerarBloco0 := lGeraBloco0;
  self.GerarBlocoC := lGeraBlocoC;
  self.GerarBlocoD := lGeraBlocoD;
  self.GerarBlocoE := lGeraBlocoE;
  self.GerarBlocoH := lGeraBlocoH;
  self.GerarBloco1 := lGeraBloco1;
  self.GerarBloco9 := lGeraBloco9;

  { Propriedades do ACBr }
  Self.SpedFiscal                := TACBrSPEDFiscal.Create(nil);
  self.SpedFiscal.Path           := cCaminhoArquivo;
  self.SpedFiscal.Arquivo        := self.getNomeArquivo;
  self.SpedFiscal.Delimitador    := '|';
  self.SpedFiscal.TrimString     := True;
  self.SpedFiscal.CurMascara     := '#0.00';
  self.SpedFiscal.DT_INI         := self.FDataInicial;
  self.SpedFiscal.DT_FIN         := self.FDataFinal;
  self.SpedFiscal.LinhasBuffer   := Buffer;

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
  FCDSProdutos.FieldDefs.add('CODIGO',ftString, 15);
  FCDSProdutos.CreateDataSet;

  //inicializa cds de produtos para posterior comparação de repetidos
  FCDSNaturezasOperacao := TClientDataSet.Create(nil);
  FCDSNaturezasOperacao.Close;
  FCDSNaturezasOperacao.FieldDefs.Clear;
  FCDSNaturezasOperacao.FieldDefs.add('CODIGO',ftInteger);
  FCDSNaturezasOperacao.CreateDataSet;

  //inicializa cds de itens para separação dos mesmos por CST_ICMS - CFOP - ALIQ_ICMS
  FCDSItensC190 := TClientDataSet.Create(nil);
  FCDSItensC190.Close;
  FCDSItensC190.FieldDefs.Clear;
  FCDSItensC190.FieldDefs.add('CST_ICMS'     ,ftInteger);
  FCDSItensC190.FieldDefs.add('CFOP'         ,ftInteger);
  FCDSItensC190.FieldDefs.add('ALIQ_ICMS'    ,ftFloat);
  FCDSItensC190.FieldDefs.add('VL_OPR'       ,ftFloat);
  FCDSItensC190.FieldDefs.add('VL_BC_ICMS'   ,ftFloat);
  FCDSItensC190.FieldDefs.add('VL_ICMS'      ,ftFloat);
  FCDSItensC190.FieldDefs.add('VL_BC_ICMS_ST',ftFloat);
  FCDSItensC190.FieldDefs.add('VL_ICMS_ST'   ,ftFloat);
  FCDSItensC190.FieldDefs.add('VL_RED_BC'    ,ftFloat);
  FCDSItensC190.FieldDefs.add('VL_IPI'       ,ftFloat);
  //FCDSItensC190.FieldDefs.add('COD_OBS'      ,ftString);
  FCDSItensC190.CreateDataSet;

  //inicializa cds de produtos para posterior comparação de repetidos
  FCDSUnidades := TClientDataSet.Create(nil);
  FCDSUnidades.Close;
  FCDSUnidades.FieldDefs.Clear;
  FCDSUnidades.FieldDefs.add('UNIDADE',ftString, 10);
  FCDSUnidades.CreateDataSet;
end;

constructor TGeradorEFDFiscal.Destroy;
begin
 // FreeAndNil( FEmpresa );
  FreeAndNil( FContador );
end;

procedure TGeradorEFDFiscal.GeraBloco0;
begin
  { Chamo as funções que escrevem os dados nas listas do ACBr }
   with Self.SpedFiscal.Bloco_0 do
   begin
      self.addReg0000;
      self.addReg0001;
   end;

   if FConcomitante then
   begin
      Self.SpedFiscal.WriteBloco_0;
   end;

end;

procedure TGeradorEFDFiscal.GeraBloco1;
begin
  self.SpedFiscal.Bloco_1.Registro1001New.IND_MOV := imSemDados;

  if Self.FConcomitante then
    Self.SpedFiscal.WriteBloco_1;
end;

procedure TGeradorEFDFiscal.GeraBloco9;
begin
  if Self.FConcomitante then
    Self.SpedFiscal.WriteBloco_9;
end;

procedure TGeradorEFDFiscal.GeraBlocoC;
begin
   with Self.SpedFiscal.Bloco_C do
   begin
      self.addRegC001(registroC001New);
   end;

   if FConcomitante then
      Self.SpedFiscal.WriteBloco_C(True);
end;

procedure TGeradorEFDFiscal.GeraBlocoD;
begin
   { Bloco não implementado }
   self.SpedFiscal.Bloco_D.RegistroD001New.IND_MOV := imSemDados;

   if FConcomitante then Self.SpedFiscal.WriteBloco_D;
end;

procedure TGeradorEFDFiscal.GeraBlocoE;
begin
   with Self.SpedFiscal.Bloco_E do
   begin
      self.addRegE001(RegistroE001New);
   end;

   if FConcomitante then
      Self.SpedFiscal.WriteBloco_E;
end;

procedure TGeradorEFDFiscal.GeraBlocoH;
begin
   { Bloco não implementado }
   self.SpedFiscal.Bloco_H.RegistroH001New.IND_MOV := imSemDados;

   if FConcomitante then Self.SpedFiscal.WriteBloco_H;
end;


procedure TGeradorEFDFiscal.Gera_EFD_Fiscal;
begin
  self.SpedFiscal.IniciaGeracao;

  preenche_lista_nf;
  gera_registros_temporarios;

  if self.GerarBloco0 then  self.GeraBloco0;
  if self.GerarBlocoC then  self.GeraBlocoC;
  if self.GerarBlocoD then  self.GeraBlocoD;
  if self.GerarBlocoE then  self.GeraBlocoE;
  if self.GerarBlocoH then  self.GeraBlocoH;
  if self.GerarBloco1 then  self.GeraBloco1;
  if self.GerarBloco9 then  self.GeraBloco9;

  { Gravando arquivo no disco rígido }
  self.SpedFiscal.SaveFileTXT;
end;

procedure TGeradorEFDFiscal.gera_registros_temporarios;
var ItemNotaFiscal :TItemNotaFiscal;
    i, x           :integer;
    codigo_participante :integer;
    codigo_produto :String;
begin

    for i := 0 to ListaNotas.Count - 1 do begin

       { SE FOR NOTA DE ENTRADA DA PROPRIA EMPRESA EMITENTE, NAO DEVE ENTRAR, POIS JA EXISTE ELA COMO SAIDA..
         PODE ACONTECER POIS AS NOTAS ESTAO NO MESMO BD }
  {   if not(TNotaFiscal( ListaNotas.Items[i] ).Status = snfAutorizada) then
        continue;
        
      if TNotaFiscal( ListaNotas.Items[i] ).Entrada_saida = 'E' then  codigo_participante := TNotaFiscal( ListaNotas.Items[i] ).Emitente.Codigo
                                                                else  codigo_participante := TNotaFiscal( ListaNotas.Items[i] ).Destinatario.Codigo;

      addParticipante( codigo_participante );

      if ((TNotaFiscal( ListaNotas.Items[i] ).Entrada_saida = 'E') and
         (self.FEmpresa.CPF_CNPJ = TNotaFiscal( ListaNotas.Items[i] ).Emitente.CPF_CNPJ)) then CONTINUE;

       for x := 0 to TNotaFiscal( ListaNotas.Items[i] ).Itens.Count - 1 do begin


         if not TNotaFiscal(ListaNotas.Items[i]).NotaDeMaterias then begin
         
           ItemNotaFiscal := (TNotaFiscal(ListaNotas.Items[i]).Itens[x] as TItemNotaFiscal);

           codigo_produto := 'P'+IntToStr( ItemNotaFiscal.Produto.Codigo);

           addProduto( codigo_produto );

           addUnidades(ItemNotaFiscal.Unidade);

           addNaturezaOperacao( TItemNotaFiscal( TNotaFiscal( ListaNotas.Items[i] ).Itens[x]).NaturezaOperacao.Codigo );
         end
         else begin
           ItemNFMateria := (TNotaFiscal(ListaNotas.Items[i]).Itens[x] as TItemNfMateria);
           codigo_produto := IfThen(TNotaFiscal(ListaNotas.Items[i]).NotaDeServico,'S','M')+IntToStr( ItemNFMateria.Materia.codigo );

           addProduto( codigo_produto );

           addUnidades(ItemNFMateria.unidade);

           addNaturezaOperacao( TItemNfMateria( TNotaFiscal( ListaNotas.Items[i] ).Itens[x]).NaturezaOperacao.Codigo );
         end;

       end;            }

    end;
end;

function TGeradorEFDFiscal.getNomeArquivo: String;
begin
  result := 'efd_ICMS_IPI'+ FormatDateTime('mm', self.FDataInicial) + FormatDateTime('yyyy', self.FDataInicial) + '.txt';
end;

procedure TGeradorEFDFiscal.preenche_lista_nf;
var repositorio   :TRepositorio;
    especificacao :TEspecificacaoNotaFiscalPorPeriodoEStatus;
begin
   ListaNotas    := nil;

   repositorio   := TFabricaRepositorio.GetRepositorio(TNotaFiscal.ClassName);
  // especificacao := TEspecificacaoNotaFiscalPorPeriodoEStatus.Create(self.FDataInicial, self.FDataFinal, false, true, false, false, self.FEmpresa.CPF_CNPJ);
   ListaNotas    := repositorio.GetListaPorEspecificacao( especificacao );
end;

end.
