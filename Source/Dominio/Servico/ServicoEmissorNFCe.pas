unit ServicoEmissorNFCe;

interface

uses
  ConfiguracoesNFCe,
  Venda,
  //Pessoa,
  ACBrNFeNotasFiscais,
  ACBrDANFCeFortesFr, ACBrDANFCeFortesFrA4,
  ContNrs, Funcoes, Classes, AcbrNfe,  pcnConversao, pcnNFe, Generics.Collections,
  pcnRetInutNFe, pcnRetConsSitNFe, pcnCCeNFe, ACBrNFeWebServices, Movimento,
  pcnEventoNFe, pcnConversaoNFe, pcnProcNFe, Empresa, NFCe, DATA.DB;

type
  TServicoEmissorNFCe = class

  private
    FACBrNFe :TACBrNFe;
    //FACBrNFeDANFe :TACBrNFeDANFCeFortes;
    FEmpresa :TEmpresa;
    NFCe :ACBrNFeNotasFiscais.NotaFiscal;
    FModoSilencioso: Boolean;

  private
    procedure GerarNFCe(Venda :TVenda);
    procedure GerarIdentificacao(Empresa :TEmpresa;
                                 Venda :TVenda;
                                 NFCe :NotaFiscal);
    procedure GerarEmitente(Empresa :TEmpresa;
                            NFCe :NotaFiscal);
    procedure GerarDestinatario(Venda :TVenda; NFCe :NotaFiscal);
    procedure GerarDadosProdutos(Venda :TVenda; NFCe :NotaFiscal);
    procedure GerarValoresTotais(Venda :TVenda; NFCe :NotaFiscal);
    procedure GerarTransportador(Venda :TVenda; NFCe :NotaFiscal);
    procedure GerarPagamentos (Venda :TVenda; NFCe :NotaFiscal);

    procedure Salva_retorno_envio(codigo_pedido, numero_lote :integer);
    procedure Salva_retorno_cancelamento(Justificativa :String; NFCe: TNFCe);

  private
    function getVenda(codigoPedido :integer) :TVenda;
    function erroConexaoServidor(retorno :String) :Boolean;

  public
    constructor Create(Empresa :TEmpresa; const modoSilencioso :Boolean = false);
    destructor Destroy; override;
    procedure enviaContingencia(codigo_pedido :integer);

  public
    function servicoOperante :Boolean;

    procedure Emitir(codigoPedido :integer; cpfCliente :String);
    procedure CancelarNFCe(XML: TStringStream; Justificativa :String; NFCe: TNFCe);
    procedure reimprimir(XML :String);
    function inutilizarNumeracao(nIni, nFim :integer; justificativa :String) :Boolean;
    procedure ConsultaNFCe(NFCe :TNFCe);
    procedure GerarXML(NFCe :TNFCe);
    procedure consultaStatus;

end;

implementation

uses
  SysUtils, DateUtils,
  ParametrosNFCe, Pedido, EspecificacaoNFCePorNrNota,
 // endereco,
//  Item,
  Produto, uPadrao,
  Token,// Movimento,
  ParametrosDANFE, NcmIBPT, ItemVenda, Dialogs, Repositorio, FabricaRepositorio, uModulo, StrUtils, Math, EspecificacaoFiltraNFCe,
  EspecificacaoMovimentosPorCodigoPedido, MaskUtils{, EspecificacaoMovimentosPorCodigoPedido};

{ TServicoEmissorNFCe }

procedure TServicoEmissorNFCe.CancelarNFCe(XML: TStringStream; Justificativa :String; NFCe: TNFCe);
var
  DhEvento  :TDateTime;
  Stream: TStringStream;
begin
   {if (Justificativa = '') then
     Justificativa := 'CANCELAMENTO DE NF-E';

   self.FACBrNFe.NotasFiscais.Clear;
   self.FACBrNFe.NotasFiscais.LoadFromStream(XML);

   self.FACBrNFe.EventoNFe.Evento.Clear;

   with self.FACBrNFe.EventoNFe.Evento.Add do
    begin
      infEvento.chNFe           := FACBrNFe.NotasFiscais.Items[0].NFe.procNFe.chNFe;
      infEvento.CNPJ            := FACBrNFe.NotasFiscais.Items[0].NFe.Emit.CNPJCPF;
      infEvento.dhEvento        := now;
      infEvento.tpEvento        := teCancelamento;
      infEvento.detEvento.xJust := Justificativa;
      infEvento.detEvento.nProt := FACBrNFe.NotasFiscais.Items[0].NFe.procNFe.nProt;
    end;

   if self.FACBrNFe.EnviarEvento(1) then
      self.Salva_retorno_cancelamento( Justificativa );}

  self.FACBrNFe.EventoNFe.Evento.Clear;

   with self.FACBrNFe.EventoNFe.Evento.Add do
    begin
      infEvento.chNFe           := NFCe.chave;
      infEvento.CNPJ            := dm.Empresa.cpf_cnpj;
      infEvento.dhEvento        := now;
      infEvento.tpEvento        := teCancelamento;
      infEvento.detEvento.xJust := Justificativa;
      infEvento.detEvento.nProt := NFCe.protocolo;
    end;
    self.FACBrNFe.EventoNFe.idLote:= NFCe.nr_nota;
    self.FACBrNFe.EnviarEvento(NFCe.nr_nota);
      self.Salva_retorno_cancelamento( Justificativa, NFCe );


end;

procedure TServicoEmissorNFCe.GerarXML(NFCe: TNFCe);
var
  XMLStream :TStringStream;
begin
   XMLStream := nil;

   try
     if      (NFCe.Status <> '101') then begin
       XMLStream := TStringStream.Create('');
       XMLStream:= TStringStream.Create(UTF8Encode(self.FACBrNFe.NotasFiscais.Items[0].GerarXML));//*f self.FACBrNFe.NotasFiscais.Items[0].GravarStream(XMLStream);
       NFCe.XML.LoadFromStream( XMLStream );
     end
     else if (NFCe.Status = '101') then begin
       XMLStream := TStringStream.Create(self.FACBrNFe.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.XMl);
       NFCe.XML.LoadFromStream( XMLStream );
     end;
  finally
    FreeAndNil(XMLStream);
  end;
end;

procedure TServicoEmissorNFCe.ConsultaNFCe(NFCe :TNFCe);
var Venda :TVenda;
    StringStream: TStringStream;
begin
   FACBrNFe.Configuracoes.Geral.ValidarDigest := False;
  { FACBrNFe.NotasFiscais.Clear;
   FACBrNFe.NotasFiscais.LoadFromString(NFCe.XMLText);
   FACBrNFe.Consultar;
   NFCe.status := intToStr(self.FACBrNFe.WebServices.Consulta.cStat);
   NFCe.motivo := self.FACBrNFe.WebServices.Consulta.XMotivo;
   self.GerarXML(NFCe); }

  GerarNFCe(getVenda(NFCe.codigo_pedido));
  FACBrNFe.NotasFiscais.Assinar;
  FACBrNFe.Consultar;
  FACBrNFe.NotasFiscais.GerarNFe;
  FACBrNFe.WebServices.Consulta.NFeChave := NFCe.chave;
  FACBrNFe.WebServices.Consulta.Executar;

  FACBrNFe.Configuracoes.Geral.ValidarDigest := true;
  NFCe.status          := intToStr(FACBrNFe.WebServices.Consulta.cStat);
  NFCe.motivo          := FACBrNFe.WebServices.Consulta.XMotivo;
  NFCe.protocolo       := FACBrNFe.WebServices.Consulta.Protocolo;
  NFCe.dh_recebimento  := FACBrNFe.WebServices.Consulta.DhRecbto;

  if NFCe.dh_recebimento < strToDate('01/01/1900') then
    NFCe.dh_recebimento  := Date;

  StringStream         := TStringStream.Create( FACBrNFe.NotasFiscais.Items[0].gerarXML );

  NFCe.XML.LoadFromStream(StringStream);
end;

procedure TServicoEmissorNFCe.consultaStatus;
begin
 try
   FACBrNFe.WebServices.StatusServico.Executar;
 Except
   on e :Exception do
     raise Exception.Create('Ocorreu um erro consultar status'+#13#10+e.message);
 end;

 {MemoResp.Lines.Text := ACBrNFe1.WebServices.StatusServico.RetWS;
 memoRespWS.Lines.Text := ACBrNFe1.WebServices.StatusServico.RetornoWS;
 LoadXML(ACBrNFe1.WebServices.StatusServico.RetornoWS, WBResposta); }

 raise Exception.Create('STATUS DO SERVIÇO'+#13#10+
                        'Código do status    >'     +IntToStr(FACBrNFe.WebServices.StatusServico.cStat)+#13#10+
                        'Descrição do status >'     +FACBrNFe.WebServices.StatusServico.xMotivo);
end;

constructor TServicoEmissorNFCe.Create(Empresa: TEmpresa; const modoSilencioso :Boolean);
begin
   FEmpresa := Empresa;
   FModoSilencioso := modoSilencioso;

   { ACBrNFe (Configurações do WebService) }
   FACBrNFe := TACBrNFe.Create(nil);
   FACBrNFe.Configuracoes.WebServices.IntervaloTentativas := FEmpresa.ConfiguracoesNF.ParametrosNFCe.intervalo_tentativas;
   FACBrNFe.Configuracoes.WebServices.Tentativas          := FEmpresa.ConfiguracoesNF.ParametrosNFCe.tentativas;
   FACBrNFe.Configuracoes.WebServices.UF                  := FEmpresa.Endereco.Cidade.estado.sigla;
   FACbrNFe.Configuracoes.WebServices.Ambiente            := TpcnTipoAmbiente( IfThen( copy(FEmpresa.ConfiguracoesNF.ambiente_nfe,1,1) = 'P',0,1) );
   FACBrNFe.Configuracoes.WebServices.Visualizar          := false; // Mensagens
   FACBrNFe.Configuracoes.Geral.FormaEmissao              := TpcnTipoEmissao(FEmpresa.ConfiguracoesNF.ParametrosNFCe.forma_emissao);
   FACBrNFe.Configuracoes.Geral.ModeloDF                  := moNFCe;
   FACBrNFe.Configuracoes.Geral.VersaoDF                  := TPcnVersaoDF(FEmpresa.ConfiguracoesNF.ParametrosNFCe.versao_df);
   FACBrNFe.Configuracoes.Geral.IncluirQRCodeXMLNFCe      := true;

   try
     FACBrNFe.Configuracoes.Geral.IdCSC := FEmpresa.ConfiguracoesNF.ParametrosNFCe.id_token;
     FACBrNFe.Configuracoes.Geral.CSC   := FEmpresa.ConfiguracoesNF.ParametrosNFCe.token;
   except
   end;

   FACBrNFe.Configuracoes.Geral.Salvar := false;

   try
     FAcbrNfe.Configuracoes.Certificados.NumeroSerie := FEmpresa.ConfiguracoesNF.num_certificado;
     FAcbrNfe.Configuracoes.Certificados.Senha       := FEmpresa.ConfiguracoesNF.senha_certificado;
   except
   end;


   { DANFE (Configurações da Impressão do DANFE)}
   if FEmpresa.ConfiguracoesNF.ParametrosNFCe.leiaute_impressao = 0 then
   begin
     FACBrNFe.DANFE                 := TACBrNFeDANFCeFortes.Create(nil);
     FACBrNFe.DANFE.TipoDANFE       := tiNFCe;//tiNFCeA4;//tiRetrato;//tiNFCe;
     FACBrNFe.DANFE.ACBrNFe         := self.FACBrNFe;
   end
   else
   begin
     FACBrNFe.DANFE                 := TACBrNFeDANFCeFortesA4.Create(nil);
     FACBrNFe.DANFE.TipoDANFE       := tiNFCeA4;//tiNFCeA4;//tiRetrato;//tiNFCe;
     FACBrNFe.DANFE.ACBrNFe         := self.FACBrNFe;
   end;

   FACBrNFe.DANFE.MostrarPreview    := FEmpresa.ConfiguracoesNF.ParametrosNFCe.visualiza_impressao;
   FACBrNFe.DANFE.ViaConsumidor     := FEmpresa.ConfiguracoesNF.ParametrosNFCe.via_consumidor;
   FACBrNFe.DANFE.ImprimirItens     := FEmpresa.ConfiguracoesNF.ParametrosNFCe.imprime_itens;
   FACBrNFe.DANFE.Impressora        := impressoraPadrao;

   FACBrNFe.DANFE.ProdutosPorPagina := 30;
   FACBrNFe.DANFE.Sistema           := 'SGVE Light';
end;

destructor TServicoEmissorNFCe.Destroy;
begin
   FreeAndNil(FACBrNFe);
   FEmpresa := nil;
   
   inherited;
end;

procedure TServicoEmissorNFCe.Emitir(codigoPedido :integer; cpfCliente :String);
const
  IMPRIMIR = true;
  SINCRONO = true;
var
  Venda :TVenda;
  numeroLote :integer;
  erroConexao, erroGeracao :Boolean;
begin
  try
  try
    try
      erroConexao    := false;
      erroGeracao    := false;
      Venda          := getVenda(codigoPedido);

      if Venda.NumeroNFe = 0 then
      begin
        NumeroLote        := dm.GetValorGenerator('gen_lote_nfce',1);
        Venda.NumeroNFe := dm.GetValorGenerator('gen_nrnota_nfce',1);
      end
      else
        NumeroLote        := dm.GetValorGenerator('gen_lote_nfce',0);

      if cpfCliente <> '' then
        Venda.Cpf_cliente := cpfCliente;

      GerarNFCe(Venda);

    Except
      On E: Exception do begin
        erroGeracao := true;
        dm.GetValorGenerator('gen_lote_nfce',-1);
        dm.GetValorGenerator('gen_nrnota_nfce',-1); //*f
        raise Exception.Create('Erro na geração do NFCe. '+e.message);
      end;
    end;

    try
    try
       if NFCe.NFe.Ide.tpEmis = teOffLine then
       begin
         FACBrNFe.NotasFiscais.Assinar;
         FACBrNFe.NotasFiscais.Validar;
         FACBrNFe.NotasFiscais.Imprimir;
       end
    else
      FACBrNFe.Enviar(NumeroLote, IMPRIMIR{, SINCRONO});

    Except
      On E: Exception do begin
        dm.LogErros.AdicionaErro('ServicoEmissorNFCe','Envio',e.Message);

        erroConexao := erroConexaoServidor(e.Message);

        if erroConexao then
        begin
          {se houve erro na geração, o generator já foi retornado}
          if not erroGeracao then
          begin
            dm.GetValorGenerator('gen_lote_nfce',-1);
            dm.GetValorGenerator('gen_nrnota_nfce',-1);
          end;
          enviaContingencia(codigoPedido);
        end
        else if not FModoSilencioso then
          raise Exception.Create(e.Message);
      end;
    end;
    finally
      {se nao for em contingencia, salva xml}
      if not erroConexao then
        Salva_retorno_envio(Venda.Codigo_pedido, NumeroLote);
    end;

  Except
    On E: Exception do begin
      dm.LogErros.AdicionaErro('ServicoEmissorNFCe','',e.Message);

      if not FModoSilencioso then
        raise Exception.Create(e.Message);
    end;
  end;
  finally
    FreeAndNil(Venda);
  end;
end;

procedure TServicoEmissorNFCe.enviaContingencia(codigo_pedido: integer);
begin
  try
    frmPadrao := TFrmPadrao.Create(nil);
    frmPadrao.Aguarda('Falha ao enviar no modo normal. '+#13#10'Enviando em contingência Off-line...');
    FEmpresa.ConfiguracoesNF.ParametrosNFCe.forma_emissao := 8;
    self.Emitir(codigo_pedido,'');
    FEmpresa.ConfiguracoesNF.ParametrosNFCe.forma_emissao := 0; //*f 1;
  finally
    frmPadrao.FimAguarda;
    FreeAndNil(frmPadrao);
  end;
end;

function TServicoEmissorNFCe.erroConexaoServidor(retorno :String): Boolean;
begin
  result := (pos('O nome ou o endereço do servidor não pôde ser resolvido',Trim(retorno)) > 0) or
            (pos('Erro no suporte a canais seguros', Trim(retorno)) > 0) or
            (pos('Servico Paralisado Momentaneamente (curto prazo)', Trim(retorno)) > 0) or
            (pos('Erro ao ler Chave do certificado', Trim(retorno)) > 0) or
            (pos('O nome ou o endereço do servidor não pôde ser resolvido', Trim(retorno)) > 0) or
            (pos('Não foi possível estabelecer conexão com o servidor', Trim(retorno)) > 0) or
            (pos('Erro: Requisição não enviada.', Trim(retorno)) > 0) or
            (pos('Não existem mais arquivos', Trim(retorno)) > 0);
end;

procedure TServicoEmissorNFCe.GerarDadosProdutos(Venda: TVenda;
  NFCe: NotaFiscal);
var
  nX :Integer;
  total_itens, percent_correspondente :Real;
begin
   //total_itens := ((Venda.Total + Venda.Desconto) - Venda.Tx_servico) - Venda.Couvert;

   for nX := 0 to (Venda.Itens.Count-1) do begin
    with NFCe.NFe.Det.Add do begin
      { Dados do Produto }
      Prod.nItem    := (nX+1);
      Prod.cProd    := IntToStr(Venda.Itens.Items[nX].Produto.codigo);
      Prod.cEAN     := '';//Venda.Itens.Items[nX].Produto.codigo_barras;
      Prod.xProd    := Venda.Itens.Items[nX].Produto.descricao;
      Prod.NCM      := Venda.Itens.Items[nX].Produto.NCMIbpt.ncm_ibpt;
      Prod.EXTIPI   := '';
      Prod.CFOP     := '5102';
      Prod.uCom     := Venda.Itens.Items[nX].Produto.unidade_medida;
      Prod.qCom     := Venda.Itens.Items[nX].Quantidade;
      Prod.vUnCom   := Venda.Itens.Items[nX].ValorUnitario;
      Prod.vProd    := Venda.Itens.Items[nX].Total;
      Prod.cEANTrib := '';//Venda.Itens.Items[nX].Produto.Codbar;
      Prod.uTrib    := Venda.Itens.Items[nX].Produto.unidade_medida;
      Prod.qTrib    := Venda.Itens.Items[nX].Quantidade;
      Prod.vUnTrib  := Venda.Itens.Items[nX].ValorUnitario;
      Prod.vOutro   := 0;
      Prod.vFrete   := 0;
      Prod.vSeg     := 0;

      if Venda.Desconto > 0 then begin
        percent_correspondente := (Venda.Itens.Items[nX].Total * 100) / Venda.Total;

        Prod.vDesc    := (percent_correspondente * Venda.Desconto)/100;
      end
      else
        Prod.vDesc    := 0;

      { Imposto }
      with Imposto do begin

        { ICMS }
        vTotTrib := Venda.Itens.Items[nX].ValorImpostos;

        with ICMS do begin
           with ICMS do begin

              CSOSN        := csosn102;
              ICMS.orig    := oeNacional;
              ICMS.modBC   := dbiValorOperacao;
              ICMS.vBC     := 0;//Venda.Itens[nX].CST00.Base;
              ICMS.pICMS   := 0;//Venda.Itens[nX].CST00.Aliquota;
              ICMS.vICMS   := 0;//Venda.Itens[nX].CST00.Valor;
              ICMS.modBCST := dbisMargemValorAgregado;
              ICMS.pMVAST  := 0;
              ICMS.pRedBCST:= 0;
              ICMS.vBCST   := 0;
              ICMS.pICMSST := 0;
              ICMS.vICMSST := 0;
              ICMS.pRedBC  := 0;
           end;
        end;

     end; //with do imposto

    end;
   end;

end;

procedure TServicoEmissorNFCe.GerarDestinatario(Venda :TVenda; NFCe: NotaFiscal);
var
    repositorio :TRepositorio;
begin
  try
   repositorio := nil;

   NFCe.NFe.Dest.xNome             := IfThen((Venda.Cpf_cliente = '')or(length(Venda.Cpf_cliente)<10), 'CONSUMIDOR', Venda.nome_cliente);
   NFCe.NFe.Dest.CNPJCPF           := IfThen( not (length(Venda.Cpf_cliente) in [11,14]), '', Venda.Cpf_cliente);
   NFCe.NFe.Dest.indIEDest         := inNaoContribuinte;
  {
   NFCe.NFe.Dest.indIEDest         := inContribuinte;
   NFCe.NFe.Dest.CNPJCPF           := '13038824000100';
   NFCe.NFe.Dest.IE                := '9054398120';
   NFCe.NFe.Dest.xNome             := 'COMERCIO DE CARNES ICE BULL LTDA';
   NFCe.NFe.Dest.EnderDest.xLgr    := 'RUI BARBOSA';
   NFCe.NFe.Dest.EnderDest.cPais   := 1058;
   NFCe.NFe.Dest.EnderDest.xPais   := 'BRASIL';
   NFCe.NFe.Dest.EnderDest.nro     := '1';
   NFCe.NFe.Dest.EnderDest.xBairro := 'CENTRO';
   NFCe.NFe.Dest.EnderDest.cMun    := 4124103;
   NFCe.NFe.Dest.EnderDest.xMun    := 'SANTO ANTÔNIO DA PLATINA';
   NFCe.NFe.Dest.EnderDest.UF      := 'PR';
   NFCe.NFe.Dest.EnderDest.CEP     := 86430000;
   NFCe.NFe.Dest.EnderDest.fone    := '';      }

  finally
    FreeAndNil(repositorio);
  end;
end;

procedure TServicoEmissorNFCe.GerarEmitente(Empresa: TEmpresa; NFCe: NotaFiscal);
begin
   NFCe.NFe.Emit.CNPJCPF := Empresa.CPF_CNPJ;
   NFCe.NFe.Emit.IE      := Empresa.RG_IE;
   NFCe.NFe.Emit.xNome   := Empresa.Razao;
   NFCe.NFe.Emit.xFant   := Empresa.nome_fantasia;

   { Endereco }
   NFCe.NFe.Emit.EnderEmit.fone    := Empresa.Fone1;
   NFCe.NFe.Emit.EnderEmit.CEP     := StrToIntDef(Empresa.Endereco.CEP ,0);
   NFCe.NFe.Emit.EnderEmit.xLgr    := Empresa.Endereco.Logradouro;
   NFCe.NFe.Emit.EnderEmit.nro     := Empresa.Endereco.numero;
   NFCe.NFe.Emit.EnderEmit.xCpl    := Empresa.Endereco.complemento;
   NFCe.NFe.Emit.EnderEmit.xBairro := Empresa.Endereco.bairro;
   NFCe.NFe.Emit.EnderEmit.cMun    := Empresa.Endereco.Cidade.codibge;
   NFCe.NFe.Emit.EnderEmit.xMun    := Empresa.Endereco.Cidade.nome;
   NFCe.NFe.Emit.EnderEmit.UF      := Empresa.Endereco.Cidade.estado.sigla;
   NFCe.NFe.Emit.EnderEmit.cPais   := 1058;
   NFCe.NFe.Emit.EnderEmit.xPais   := 'BRASIL';

   NFCe.NFe.Emit.CRT := TpcnCRT(crtSimplesNacional); // (1-crtSimplesNacional, 2-crtSimplesExcessoReceita, 3-crtRegimeNormal)
end;

procedure TServicoEmissorNFCe.GerarIdentificacao(
  Empresa :TEmpresa; Venda: TVenda; NFCe: NotaFiscal);
begin
   NFCe.NFe.Ide.cNF      := Venda.NumeroNFe;
   NFCe.NFe.Ide.natOp    := 'VENDA';
   NFCe.NFe.Ide.indPag   := ipVista;
   NFCe.NFe.Ide.modelo   := 65;
   NFCe.NFe.Ide.serie    := 1;
   NFCe.NFe.Ide.nNF      := Venda.NumeroNFe;
   NFCe.NFe.Ide.dEmi     := Now;
   NFCe.NFe.Ide.dSaiEnt  := Now;
   NFCe.NFe.Ide.hSaiEnt  := Now;
   NFCe.NFe.Ide.tpNF     := tnSaida;
   NFCe.NFe.Ide.tpEmis   := TpcnTipoEmissao(Empresa.ConfiguracoesNF.ParametrosNFCe.forma_emissao);
   NFCe.NFe.Ide.tpAmb    := TpcnTipoAmbiente( IfThen( copy(FEmpresa.ConfiguracoesNF.ambiente_nfe,1,1) = 'P',0,1) );
   NFCe.NFe.Ide.cUF      := UF_TO_CODUF(Empresa.Endereco.Cidade.estado.sigla);
   NFCe.NFe.Ide.cMunFG   := Empresa.Endereco.Cidade.codibge;
   NFCe.NFe.Ide.finNFe   := fnNormal;

   if FEmpresa.ConfiguracoesNF.ParametrosNFCe.leiaute_impressao = 0 then
     NFCe.NFe.Ide.tpImp    := tiNFCe
   else
     NFCe.NFe.Ide.tpImp    := tiNFCeA4;

   NFCe.NFe.Ide.indFinal := cfConsumidorFinal;
   NFCe.NFe.Ide.indPres  := pcPresencial;
end;

procedure TServicoEmissorNFCe.GerarNFCe(Venda: TVenda);
begin
   FACBrNFe.NotasFiscais.Clear;
   NFCe              := FACBrNFe.NotasFiscais.Add;

   GerarIdentificacao  (FEmpresa, Venda, NFCe);
   GerarEmitente       (FEmpresa, NFCe);
   GerarDestinatario   (Venda, NFCe);
   GerarDadosProdutos  (Venda, NFCe);
   GerarValoresTotais  (Venda, NFCe);
   GerarTransportador  (Venda, NFCe);
   GerarPagamentos     (Venda, NFCe);
end;

procedure TServicoEmissorNFCe.GerarPagamentos(Venda: TVenda; NFCe: NotaFiscal);
var
    Especificacao :TEspecificacaoMovimentosPorCodigoPedido;
    repositorio   :TREpositorio;
    Movimentos    :TObjectList<TMovimento>;
    i             :integer;
begin
   repositorio   := nil;
   Movimentos    := nil;

  try
    Especificacao := TEspecificacaoMovimentosPorCodigoPedido.Create(Venda.Codigo_pedido);
    repositorio   := TFabricaRepositorio.GetRepositorio(TMovimento.ClassName);
    Movimentos    := repositorio.GetListaPorEspecificacao<TMovimento>( Especificacao, 'codigo_pedido = '+inttostr(Venda.Codigo_pedido));

    if not assigned(Movimentos) then
      raise Exception.Create('Nenhum pagamento encontrado.');

   for i := 0 to Movimentos.Count -1 do begin
     with NFCe.NFe.pag.Add do begin

       case TMovimento(Movimentos[i]).tipo_moeda of
         1 :  tPag := fpDinheiro;
         2 :  tPag := fpCheque;
         3 :  tPag := fpCartaoCredito;
         4 :  tPag := fpCartaoDebito;
       end;

       if tPag in [fpCartaoCredito, fpCartaoDebito] then
       begin
         tpIntegra := tiPagIntegrado;
         CNPJ      := '99999999999999';
         tBand     := bcOutros;
         cAut      := '99999999999999999999';
       end;

       vPag := TMovimento(Movimentos[i]).valor_pago;
     end;
   end;

  Finally
    FreeAndNil(Especificacao);
    FreeAndNil(repositorio);
    FreeAndNil(Movimentos);
  end;
end;

procedure TServicoEmissorNFCe.GerarTransportador(Venda: TVenda;
  NFCe: NotaFiscal);
begin
   // NFC-e não pode ter frete
   NFCe.NFe.Transp.modFrete := mfSemFrete;
end;

procedure TServicoEmissorNFCe.GerarValoresTotais(Venda: TVenda;
  NFCe: NotaFiscal);
begin
   NFCe.NFe.Total.ICMSTot.vBC      := 0;
   NFCe.NFe.Total.ICMSTot.vICMS    := Venda.Icms;
   NFCe.NFe.Total.ICMSTot.vBCST    := Venda.BaseSt;
   NFCe.NFe.Total.ICMSTot.vST      := Venda.St;
   NFCe.NFe.Total.ICMSTot.vProd    := Venda.TotalBruto;
   NFCe.NFe.Total.ICMSTot.vFrete   := Venda.Frete;
   NFCe.NFe.Total.ICMSTot.vSeg     := Venda.Seguro;
   NFCe.NFe.Total.ICMSTot.vDesc    := Venda.Desconto;
   NFCe.NFe.Total.ICMSTot.vII      := 0; //Venda.ImpostoImportacao;
   NFCe.NFe.Total.ICMSTot.vIPI     := 0; //Venda.Ipi;
   NFCe.NFe.Total.ICMSTot.vPIS     := Venda.Pis;
   NFCe.NFe.Total.ICMSTot.vCOFINS  := Venda.Cofins;
   NFCe.NFe.Total.ICMSTot.vOutro   := 0; //Venda.OutrasDespesas;
   NFCe.NFe.Total.ICMSTot.vNF      := Venda.Total - Venda.Desconto;
   NFCe.NFe.Total.ICMSTot.vTotTrib := Venda.TotalTributos;
end;

function TServicoEmissorNFCe.getVenda(codigoPedido: integer): TVenda;
var Pedido :TPedido;
    repositorio :TRepositorio;
    i :integer;
begin
 try
   result              := TVenda.Create;
   result.NumeroNFe    := 0;

   repositorio   := TFabricaRepositorio.GetRepositorio(TPedido.ClassName);
   Pedido        := TPedido(repositorio.Get(codigoPedido));

   if assigned(Pedido.NFCe) then
     result.NumeroNFe     := Pedido.NFCe.nr_nota;

   result.Data          := Pedido.dt_cadastro;
   result.Codigo_pedido := Pedido.codigo;
   result.Desconto      := Pedido.desconto;
   result.nome_cliente  := Pedido.Cliente.Razao;
   result.Cpf_cliente   := Pedido.cpf_cliente;

   for i := 0 to Pedido.Itens.Count - 1 do begin

     result.AdicionarItem( Pedido.Itens[i].Produto.Codigo,
                           Pedido.Itens[i].valor_unitario,
                           Pedido.Itens[i].quantidade );
   end;

 finally
   FreeAndNil(repositorio);
   FreeAndNil(Pedido);
 end;
end;

function TServicoEmissorNFCe.inutilizarNumeracao(nIni, nFim: integer; justificativa: String) :Boolean;
var retorno :Integer;
begin
  try
  try
    result := false;
    self.FACBrNFe.WebServices.Inutiliza(self.FEmpresa.cpf_cnpj,
                                        justificativa,
                                        YearOf(Date), //ano
                                        65, //modelo
                                        1, //serie
                                        nIni,
                                        nFim);
    result := true;
  Except
    on e :Exception do
    begin
      raise Exception.Create(e.Message)
    end;
  end;
  finally
    retorno := FACBrNFe.WebServices.Inutilizacao.cStat;
  end;
end;

procedure TServicoEmissorNFCe.reimprimir(XML :String);
begin
  self.FACBrNFe.NotasFiscais.LoadFromString(XML);
  self.FACBrNFe.NotasFiscais.Items[0].Imprimir;
end;

procedure TServicoEmissorNFCe.Salva_retorno_cancelamento(Justificativa :String; NFCe          :TNFCe);
var  StringStream :TStringStream;
     repositorio  :TRepositorio;
     Especificacao :TEspecificacaoFiltraNFCe;
     //*f NFCe          :TNFCe;
     status, motivo :String;
begin
    //*f NFCe := nil;
    Especificacao := nil;
    repositorio   := nil;
  try
  try

    repositorio   := TFabricaRepositorio.GetRepositorio(TNFCe.ClassName);
    //*f Especificacao := TEspecificacaoFiltraNFCe.Create(Date, Date, FACBrNFe.NotasFiscais.Items[0].NFe.Ide.nNF);
    //*f NFCe          := TNFCe( repositorio.GetPorEspecificacao( Especificacao ) );

    StringStream := TStringStream.Create( UTF8Encode(self.FACBrNFe.WebServices.EnvEvento.RetWS) );

    NFCe.XML.LoadFromStream(StringStream);

    if self.FACBrNFe.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.cStat <> 135 then
      raise Exception.Create('Falha ao enviar.'+#13#10+self.FACBrNFe.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.xMotivo);

    status              := IntToStr( self.FACBrNFe.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.cStat );
    motivo              := self.FACBrNFe.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.xMotivo;
    NFCe.status         := IfThen(status = '135','101',status);
    NFCe.Motivo         := IfThen(status = '135','Cancelamento da NFC-e homologado',motivo);
    NFCe.protocolo      := self.FACBrNFe.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.nProt;
    NFCe.dh_recebimento := self.FACBrNFe.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.dhRegEvento;
    NFCe.justificativa  := Justificativa;

    repositorio.Salvar( NFCe );

  Except
    On E: Exception do begin
      raise Exception.Create(e.Message);
    end;
  end;

  Finally
    freeAndNil(repositorio);
    freeAndNil(Especificacao);
    //*f freeAndNil(NFCe);
  end;
end;

procedure TServicoEmissorNFCe.Salva_retorno_envio(codigo_pedido, numero_lote: integer);
var NFCe :TNFCe;
    repositorio :TRepositorio;
    StringStream: TStringStream;
    especificacao :TEspecificacaoNFCePorNrNota;
begin
  NFCe        := nil;
  repositorio := nil;
  try
    repositorio   := TFabricaRepositorio.GetRepositorio(TNFCE.ClassName);
    especificacao := TEspecificacaoNFCePorNrNota.Create(FACBrNFe.NotasFiscais.Items[0].NFe.Ide.nNF);
    NFCe          := TNFCe(repositorio.GetPorEspecificacao(especificacao));

    if not assigned(NFCe) then
      NFCe          := TNFCE.Create;

    NFCe.nr_nota        := FACBrNFe.NotasFiscais.Items[0].NFe.Ide.nNF;
    NFCe.codigo_pedido  := codigo_pedido;
    NFCe.serie          := IntToStr(FACBrNFe.NotasFiscais.Items[0].NFe.Ide.serie);
    NFCe.chave          := copy(FACBrNFe.NotasFiscais.Items[0].NFe.infNFe.ID, 4,44);
    NFCe.protocolo      := FACBrNFe.NotasFiscais.Items[0].NFe.procNFe.nProt;
    NFCe.dh_recebimento := now;
    NFCe.status         := IfThen(FEmpresa.ConfiguracoesNF.ParametrosNFCe.forma_emissao = 8, '0', intToStr( FACBrNFe.WebServices.Retorno.cStat ) );
    NFCe.motivo         := FACBrNFe.WebServices.Retorno.xMotivo;

    StringStream := TStringStream.Create( FACBrNFe.NotasFiscais.Items[0].XMLOriginal );

    NFCe.XML.LoadFromStream(StringStream);
    repositorio.Salvar( NFCe );

  Except
    On E: Exception do begin
      raise Exception.Create(e.Message);
    end;
  end;
end;

function TServicoEmissorNFCe.servicoOperante: Boolean;
var texto :String;
begin
  try
  try
    FACBrNFe.WebServices.StatusServico.Executar;
  except
  end;
  finally
    result := FACBrNFe.WebServices.StatusServico.cStat = 107;
  end;
end;

end.
