unit EFDPisCofinsFuncoes;

interface

uses
    ACBrEPCBlocos;

type TRegistroC170 = class

  public
     class function GetIndMov       (const    cIndMov     :String)      :TACBrMovimentacaoFisica;
     class function GetIndApur      (const    cIndApur    :String)      :TACBrApuracaoIPI;
     class function GetCSTIcms      (const    cCSTIcms    :String)      :TACBrSituacaoTribICMS;
     class function GetCSTIpi       (const    cCSTIpi     :String)      :TACBrSituacaoTribIPI;
     class function GetCSTCofins    (const nCSTCofins     :String)      :TACBrSituacaoTribCOFINS;
     class function GetCSTPis       (const nCSTPis        :String)      :TACBrSituacaoTribPIS;
     class function GetBaseCalcCred (const cBaseCalcCred  :String)      :TACBrBaseCalculoCredito;
     class function GetIndFrt       (const nIndFrt        :Integer)     :TACBrTipoFrete;
end;

implementation

{ TRegistroC170 }

class function TRegistroC170.GetBaseCalcCred(
  const cBaseCalcCred: String): TACBrBaseCalculoCredito;
begin
  if      (cBaseCalcCred = '')   then result := bccVazio                         // ''   // vazio.
  else if (cBaseCalcCred = '01') then result := bccAqBensRevenda                 // '01' // Aquisi��o de bens para revenda
  else if (cBaseCalcCred = '02') then result := bccAqBensUtiComoInsumo           // '02' // Aquisi��o de bens utilizados como insumo
  else if (cBaseCalcCred = '03') then result := bccAqServUtiComoInsumo           // '03' // Aquisi��o de servi�os utilizados como insumo
  else if (cBaseCalcCred = '04') then result := bccEnergiaEletricaTermica        // '04' // Energia el�trica e t�rmica, inclusive sob a forma de vapor
  else if (cBaseCalcCred = '05') then result := bccAluguelPredios                // '05' // Alugu�is de pr�dios
  else if (cBaseCalcCred = '06') then result := bccAluguelMaqEquipamentos        // '06' // Alugu�is de m�quinas e equipamentos
  else if (cBaseCalcCred = '07') then result := bccArmazenagemMercadoria         // '07' // Armazenagem de mercadoria e frete na opera��o de venda
  else if (cBaseCalcCred = '08') then result := bccConArrendamentoMercantil      // '08' // Contrapresta��es de arrendamento mercantil
  else if (cBaseCalcCred = '09') then result := bccMaqCredDepreciacao            // '09' // M�quinas, equipamentos e outros bens incorporados ao ativo imobilizado (cr�dito sobre encargos de deprecia��o).
  else if (cBaseCalcCred = '10') then result := bccMaqCredAquisicao              // '10' // M�quinas, equipamentos e outros bens incorporados ao ativo imobilizado (cr�dito com base no valor de aquisi��o).
  else if (cBaseCalcCred = '11') then result := bccAmortizacaoDepreciacaoImoveis // '11' // Amortiza��o e Deprecia��o de edifica��es e benfeitorias em im�veis
  else if (cBaseCalcCred = '12') then result := bccDevolucaoSujeita              // '12' // Devolu��o de Vendas Sujeitas � Incid�ncia N�o-Cumulativa
  else if (cBaseCalcCred = '13') then result := bccOutrasOpeComDirCredito        // '13' // Outras Opera��es com Direito a Cr�dito
  else if (cBaseCalcCred = '14') then result := bccAtTransporteSubcontratacao    // '14' // Atividade de Transporte de Cargas � Subcontrata��o
  else if (cBaseCalcCred = '15') then result := bccAtImobCustoIncorrido          // '15' // Atividade Imobili�ria � Custo Incorrido de Unidade Imobili�ria
  else if (cBaseCalcCred = '16') then result := bccAtImobCustoOrcado             // '16' // Atividade Imobili�ria � Custo Or�ado de unidade n�o conclu�da
  else if (cBaseCalcCred = '17') then result := bccAtPresServ                    // '17' // Atividade de Presta��o de Servi�os de Limpeza, Conserva��o e Manuten��o � vale-transporte, vale-refei��o ou vale-alimenta��o, fardamento ou uniforme.
  else if (cBaseCalcCred = '18') then result := bccEstoqueAberturaBens           // '18' // Estoque de abertura de bens
  else                                result := bccVazio;
end;

class function TRegistroC170.GetCSTCofins(
  const nCSTCofins: String): TACBrSituacaoTribCOFINS;
begin
   if      (nCSTCofins = '01') then result := stcofinsValorAliquotaNormal                           // '01' // Opera��o Tribut�vel com Al�quota B�sica                           // valor da opera��o al�quota normal (cumulativo/n�o cumulativo)).
   else if (nCSTCofins = '02') then result := stcofinsValorAliquotaDiferenciada                     // '02' // Opera��o Tribut�vel com Al�quota Diferenciada                     // valor da opera��o (al�quota diferenciada)).
   else if (nCSTCofins = '03') then result := stcofinsQtdeAliquotaUnidade                           // '03' // Opera��o Tribut�vel com Al�quota por Unidade de Medida de Produto // quantidade vendida x al�quota por unidade de produto).
   else if (nCSTCofins = '04') then result := stcofinsMonofaticaAliquotaZero                        // '04' // Opera��o Tribut�vel Monof�sica - Revenda a Al�quota Zero
   else if (nCSTCofins = '05') then result := stcofinsValorAliquotaPorST                            // '05' // Opera��o Tribut�vel por Substitui��o Tribut�ria
   else if (nCSTCofins = '06') then result := stcofinsAliquotaZero                                  // '06' // Opera��o Tribut�vel a Al�quota Zero
   else if (nCSTCofins = '07') then result := stcofinsIsentaContribuicao                            // '07' // Opera��o Isenta da Contribui��o
   else if (nCSTCofins = '08') then result := stcofinsSemIncidenciaContribuicao                     // '08' // Opera��o sem Incid�ncia da Contribui��o
   else if (nCSTCofins = '09') then result := stcofinsSuspensaoContribuicao                         // '09' // Opera��o com Suspens�o da Contribui��o
   else if (nCSTCofins = '49') then result := stcofinsOutrasOperacoesSaida                          // '49' // Outras Opera��es de Sa�da
   else if (nCSTCofins = '50') then result := stcofinsOperCredExcRecTribMercInt                     // '50' // Opera��o com Direito a Cr�dito - Vinculada Exclusivamente a Receita Tributada no Mercado Interno
   else if (nCSTCofins = '51') then result := stcofinsOperCredExcRecNaoTribMercInt                  // '51' // Opera��o com Direito a Cr�dito - Vinculada Exclusivamente a Receita N�o-Tributada no Mercado Interno
   else if (nCSTCofins = '52') then result := stcofinsOperCredExcRecExportacao                      // '52' // Opera��o com Direito a Cr�dito - Vinculada Exclusivamente a Receita de Exporta��o
   else if (nCSTCofins = '53') then result := stcofinsOperCredRecTribNaoTribMercInt                 // '53' // Opera��o com Direito a Cr�dito - Vinculada a Receitas Tributadas e N�o-Tributadas no Mercado Interno
   else if (nCSTCofins = '54') then result := stcofinsOperCredRecTribMercIntEExportacao             // '54' // Opera��o com Direito a Cr�dito - Vinculada a Receitas Tributadas no Mercado Interno e de Exporta��o
   else if (nCSTCofins = '55') then result := stcofinsOperCredRecNaoTribMercIntEExportacao          // '55' // Opera��o com Direito a Cr�dito - Vinculada a Receitas N�o Tributadas no Mercado Interno e de Exporta��o
   else if (nCSTCofins = '56') then result := stcofinsOperCredRecTribENaoTribMercIntEExportacao     // '56' // Opera��o com Direito a Cr�dito - Vinculada a Receitas Tributadas e N�o-Tributadas no Mercado Interno e de Exporta��o
   else if (nCSTCofins = '60') then result := stcofinsCredPresAquiExcRecTribMercInt                 // '60' // Cr�dito Presumido - Opera��o de Aquisi��o Vinculada Exclusivamente a Receita Tributada no Mercado Interno
   else if (nCSTCofins = '61') then result := stcofinsCredPresAquiExcRecNaoTribMercInt              // '61' // Cr�dito Presumido - Opera��o de Aquisi��o Vinculada Exclusivamente a Receita N�o-Tributada no Mercado Interno
   else if (nCSTCofins = '62') then result := stcofinsCredPresAquiExcExcRecExportacao               // '62' // Cr�dito Presumido - Opera��o de Aquisi��o Vinculada Exclusivamente a Receita de Exporta��o
   else if (nCSTCofins = '63') then result := stcofinsCredPresAquiRecTribNaoTribMercInt             // '63' // Cr�dito Presumido - Opera��o de Aquisi��o Vinculada a Receitas Tributadas e N�o-Tributadas no Mercado Interno
   else if (nCSTCofins = '64') then result := stcofinsCredPresAquiRecTribMercIntEExportacao         // '64' // Cr�dito Presumido - Opera��o de Aquisi��o Vinculada a Receitas Tributadas no Mercado Interno e de Exporta��o
   else if (nCSTCofins = '65') then result := stcofinsCredPresAquiRecNaoTribMercIntEExportacao      // '65' // Cr�dito Presumido - Opera��o de Aquisi��o Vinculada a Receitas N�o-Tributadas no Mercado Interno e de Exporta��o
   else if (nCSTCofins = '66') then result := stcofinsCredPresAquiRecTribENaoTribMercIntEExportacao // '66' // Cr�dito Presumido - Opera��o de Aquisi��o Vinculada a Receitas Tributadas e N�o-Tributadas no Mercado Interno e de Exporta��o
   else if (nCSTCofins = '67') then result := stcofinsOutrasOperacoes_CredPresumido                 // '67' // Cr�dito Presumido - Outras Opera��es
   else if (nCSTCofins = '70') then result := stcofinsOperAquiSemDirCredito                         // '70' // Opera��o de Aquisi��o sem Direito a Cr�dito
   else if (nCSTCofins = '71') then result := stcofinsOperAquiComIsensao                            // '71' // Opera��o de Aquisi��o com Isen��o
   else if (nCSTCofins = '72') then result := stcofinsOperAquiComSuspensao                          // '72' // Opera��o de Aquisi��o com Suspens�o
   else if (nCSTCofins = '73') then result := stcofinsOperAquiAliquotaZero                          // '73' // Opera��o de Aquisi��o a Al�quota Zero
   else if (nCSTCofins = '74') then result := stcofinsOperAqui_SemIncidenciaContribuicao            // '74' // Opera��o de Aquisi��o sem Incid�ncia da Contribui��o
   else if (nCSTCofins = '75') then result := stcofinsOperAquiPorST                                 // '75' // Opera��o de Aquisi��o por Substitui��o Tribut�ria
   else if (nCSTCofins = '98') then result := stcofinsOutrasOperacoesEntrada                        // '98' // Outras Opera��es de Entrada
   else                             result := stcofinsOutrasOperacoes;                              // '99' // Outras Opera��es
end;

class function TRegistroC170.GetCSTIcms(
  const cCSTIcms: String): TACBrSituacaoTribICMS;
begin
if      (cCSTIcms = '000') then result := sticmsTributadaIntegralmente                               // '000' //	Tributada integralmente
   else if (cCSTIcms = '010') then result := sticmsTributadaComCobracaPorST                             // '010' //	Tributada e com cobran�a do ICMS por substitui��o tribut�ria
   else if (cCSTIcms = '020') then result := sticmsComReducao                                           // '020' //	Com redu��o de base de c�lculo
   else if (cCSTIcms = '030') then result := sticmsIsentaComCobracaPorST                                // '030' //	Isenta ou n�o tributada e com cobran�a do ICMS por substitui��o tribut�ria
   else if (cCSTIcms = '040') then result := sticmsIsenta                                               // '040' //	Isenta
   else if (cCSTIcms = '041') then result := sticmsNaoTributada                                         // '041' //	N�o tributada
   else if (cCSTIcms = '050') then result := sticmsSuspensao                                            // '050' //	Suspens�o
   else if (cCSTIcms = '051') then result := sticmsDiferimento                                          // '051' //	Diferimento
   else if (cCSTIcms = '060') then result := sticmsCobradoAnteriormentePorST                            // '060' //	ICMS cobrado anteriormente por substitui��o tribut�ria
   else if (cCSTIcms = '070') then result := sticmsComReducaoPorST                                      // '070' //	Com redu��o de base de c�lculo e cobran�a do ICMS por substitui��o tribut�ria
   else if (cCSTIcms = '090') then result := sticmsOutros                                               // '090' //	Outros
   else if (cCSTIcms = '100') then result := sticmsEstrangeiraImportacaoDiretaTributadaIntegralmente    // '100' // Estrangeira - Importa��o direta - Tributada integralmente
   else if (cCSTIcms = '110') then result := sticmsEstrangeiraImportacaoDiretaTributadaComCobracaPorST  // '110' // Estrangeira - Importa��o direta - Tributada e com cobran�a do ICMS por substitui��o tribut�ria
   else if (cCSTIcms = '120') then result := sticmsEstrangeiraImportacaoDiretaComReducao                // '120' // Estrangeira - Importa��o direta - Com redu��o de base de c�lculo
   else if (cCSTIcms = '130') then result := sticmsEstrangeiraImportacaoDiretaIsentaComCobracaPorST     // '130' // Estrangeira - Importa��o direta - Isenta ou n�o tributada e com cobran�a do ICMS por substitui��o tribut�ria
   else if (cCSTIcms = '140') then result := sticmsEstrangeiraImportacaoDiretaIsenta                    // '140' // Estrangeira - Importa��o direta - Isenta
   else if (cCSTIcms = '141') then result := sticmsEstrangeiraImportacaoDiretaNaoTributada              // '141' // Estrangeira - Importa��o direta - N�o tributada
   else if (cCSTIcms = '150') then result := sticmsEstrangeiraImportacaoDiretaSuspensao                 // '150' // Estrangeira - Importa��o direta - Suspens�o
   else if (cCSTIcms = '151') then result := sticmsEstrangeiraImportacaoDiretaDiferimento               // '151' // Estrangeira - Importa��o direta - Diferimento
   else if (cCSTIcms = '160') then result := sticmsEstrangeiraImportacaoDiretaCobradoAnteriormentePorST // '160' // Estrangeira - Importa��o direta - ICMS cobrado anteriormente por substitui��o tribut�ria
   else if (cCSTIcms = '170') then result := sticmsEstrangeiraImportacaoDiretaComReducaoPorST           // '170' // Estrangeira - Importa��o direta - Com redu��o de base de c�lculo e cobran�a do ICMS por substitui��o tribut�ria
   else if (cCSTIcms = '190') then result := sticmsEstrangeiraImportacaoDiretaOutros                    // '190' // Estrangeira - Importa��o direta - Outras
   else if (cCSTIcms = '200') then result := sticmsEstrangeiraAdqMercIntTributadaIntegralmente          // '200' // Estrangeira - Adquirida no mercado interno - Tributada integralmente
   else if (cCSTIcms = '210') then result := sticmsEstrangeiraAdqMercIntTributadaComCobracaPorST        // '210' // Estrangeira - Adquirida no mercado interno - Tributada e com cobran�a do ICMS por substitui��o tribut�ria
   else if (cCSTIcms = '220') then result := sticmsEstrangeiraAdqMercIntComReducao                      // '220' // Estrangeira - Adquirida no mercado interno - Com redu��o de base de c�lculo
   else if (cCSTIcms = '230') then result := sticmsEstrangeiraAdqMercIntIsentaComCobracaPorST           // '230' // Estrangeira - Adquirida no mercado interno - Isenta ou n�o tributada e com cobran�a do ICMS por substitui��o tribut�ria
   else if (cCSTIcms = '240') then result := sticmsEstrangeiraAdqMercIntIsenta                          // '240' // Estrangeira - Adquirida no mercado interno - Isenta
   else if (cCSTIcms = '241') then result := sticmsEstrangeiraAdqMercIntNaoTributada                    // '241' // Estrangeira - Adquirida no mercado interno - N�o tributada
   else if (cCSTIcms = '250') then result := sticmsEstrangeiraAdqMercIntSuspensao                       // '250' // Estrangeira - Adquirida no mercado interno - Suspens�o
   else if (cCSTIcms = '251') then result := sticmsEstrangeiraAdqMercIntDiferimento                     // '251' // Estrangeira - Adquirida no mercado interno - Diferimento
   else if (cCSTIcms = '260') then result := sticmsEstrangeiraAdqMercIntCobradoAnteriormentePorST       // '260' // Estrangeira - Adquirida no mercado interno - ICMS cobrado anteriormente por substitui��o tribut�ria
   else if (cCSTIcms = '270') then result := sticmsEstrangeiraAdqMercIntComReducaoPorST                 // '270' // Estrangeira - Adquirida no mercado interno - Com redu��o de base de c�lculo e cobran�a do ICMS por substitui��o tribut�ria
   else if (cCSTIcms = '290') then result := sticmsEstrangeiraAdqMercIntOutros                          // '290' // Estrangeira - Adquirida no mercado interno - Outras
   else if (cCSTIcms = '101') then result := sticmsSimplesNacionalTributadaComPermissaoCredito          // '101' // Simples Nacional - Tributada pelo Simples Nacional com permiss�o de cr�dito
   else if (cCSTIcms = '102') then result := sticmsSimplesNacionalTributadaSemPermissaoCredito          // '102' // Simples Nacional - Tributada pelo Simples Nacional sem permiss�o de cr�dito
   else if (cCSTIcms = '103') then result := sticmsSimplesNacionalIsencaoPorFaixaReceitaBruta           // '103' // Simples Nacional - Isen��o do ICMS no Simples Nacional para faixa de receita bruta
   else if (cCSTIcms = '201') then result := sticmsSimplesNacionalTributadaComPermissaoCreditoComST     // '201' // Simples Nacional - Tributada pelo Simples Nacional com permiss�o de cr�dito e com cobran�a do ICMS por substitui��o tribut�ria
   else if (cCSTIcms = '202') then result := sticmsSimplesNacionalTributadaSemPermissaoCreditoComST     // '202' // Simples Nacional - Tributada pelo Simples Nacional sem permiss�o de cr�dito e com cobran�a do ICMS por substitui��o tribut�ria
   else if (cCSTIcms = '203') then result := sticmsSimplesNacionalIsencaoPorFaixaReceitaBrutaComST      // '203' // Simples Nacional - Isen��o do ICMS no Simples Nacional para faixa de receita bruta e com cobran�a do ICMS por substitui��o tribut�ria
   else if (cCSTIcms = '300') then result := sticmsSimplesNacionalImune                                 // '300' // Simples Nacional - Imune
   else if (cCSTIcms = '400') then result := sticmsSimplesNacionalNaoTributada                          // '400' // Simples Nacional - N�o tributada pelo Simples Nacional
   else if (cCSTIcms = '500') then result := sticmsSimplesNacionalCobradoAnteriormentePorST             // '500' // Simples Nacional - ICMS cobrado anteriormente por substitui��o tribut�ria (substitu�do) ou por antecipa��o
   else if (cCSTIcms = '900') then result := sticmsSimplesNacionalOutros;                               // '900' // Simples Nacional - Outros   
end;

class function TRegistroC170.GetCSTIpi(
  const cCSTIpi: String): TACBrSituacaoTribIPI;
begin
   if      (cCSTIpi = '00') then result := stipiEntradaRecuperacaoCredito // '00' // Entrada com recupera��o de cr�dito
   else if (cCSTIpi = '01') then result := stipiEntradaTributradaZero     // '01' // Entrada tributada com al�quota zero
   else if (cCSTIpi = '02') then result := stipiEntradaIsenta             // '02' // Entrada isenta
   else if (cCSTIpi = '03') then result := stipiEntradaNaoTributada       // '03' // Entrada n�o-tributada
   else if (cCSTIpi = '04') then result := stipiEntradaImune              // '04' // Entrada imune
   else if (cCSTIpi = '05') then result := stipiEntradaComSuspensao       // '05' // Entrada com suspens�o
   else if (cCSTIpi = '49') then result := stipiOutrasEntradas            // '49' // Outras entradas
   else if (cCSTIpi = '50') then result := stipiSaidaTributada            // '50' // Sa�da tributada
   else if (cCSTIpi = '51') then result := stipiSaidaTributadaZero        // '51' // Sa�da tributada com al�quota zero
   else if (cCSTIpi = '52') then result := stipiSaidaIsenta               // '52' // Sa�da isenta
   else if (cCSTIpi = '53') then result := stipiSaidaNaoTributada         // '53' // Sa�da n�o-tributada
   else if (cCSTIpi = '54') then result := stipiSaidaImune                // '54' // Sa�da imune
   else if (cCSTIpi = '55') then result := stipiSaidaComSuspensao         // '55' // Sa�da com suspens�o
   else if (cCSTIpi = '99') then result := stipiOutrasSaidas;             // '99' // Outras sa�das
end;

class function TRegistroC170.GetCSTPis(
  const nCSTPis: String): TACBrSituacaoTribPIS;
begin
   if      (nCSTPis = '01') then result := stpisValorAliquotaNormal                           // '01' // Opera��o Tribut�vel com Al�quota B�sica   // valor da opera��o al�quota normal (cumulativo/n�o cumulativo)).
   else if (nCSTPis = '02') then result := stpisValorAliquotaDiferenciada                     // '02' // Opera��o Tribut�vel com Al�quota Diferenciada // valor da opera��o (al�quota diferenciada)).
   else if (nCSTPis = '03') then result := stpisQtdeAliquotaUnidade                           // '03' // Opera��o Tribut�vel com Al�quota por Unidade de Medida de Produto // quantidade vendida x al�quota por unidade de produto).
   else if (nCSTPis = '04') then result := stpisMonofaticaAliquotaZero                        // '04' // Opera��o Tribut�vel Monof�sica - Revenda a Al�quota Zero
   else if (nCSTPis = '05') then result := stpisValorAliquotaPorST                            // '05' // Opera��o Tribut�vel por Substitui��o Tribut�ria
   else if (nCSTPis = '06') then result := stpisAliquotaZero                                  // '06' // Opera��o Tribut�vel a Al�quota Zero
   else if (nCSTPis = '07') then result := stpisIsentaContribuicao                            // '07' // Opera��o Isenta da Contribui��o
   else if (nCSTPis = '08') then result := stpisSemIncidenciaContribuicao                     // '08' // Opera��o sem Incid�ncia da Contribui��o
   else if (nCSTPis = '09') then result := stpisSuspensaoContribuicao                         // '09' // Opera��o com Suspens�o da Contribui��o
   else if (nCSTPis = '49') then result := stpisOutrasOperacoesSaida                          // '49' // Outras Opera��es de Sa�da
   else if (nCSTPis = '50') then result := stpisOperCredExcRecTribMercInt                     // '50' // Opera��o com Direito a Cr�dito - Vinculada Exclusivamente a Receita Tributada no Mercado Interno
   else if (nCSTPis = '51') then result := stpisOperCredExcRecNaoTribMercInt                  // '51' // Opera��o com Direito a Cr�dito � Vinculada Exclusivamente a Receita N�o Tributada no Mercado Interno
   else if (nCSTPis = '52') then result := stpisOperCredExcRecExportacao                      // '52' // Opera��o com Direito a Cr�dito - Vinculada Exclusivamente a Receita de Exporta��o
   else if (nCSTPis = '53') then result := stpisOperCredRecTribNaoTribMercInt                 // '53' // Opera��o com Direito a Cr�dito - Vinculada a Receitas Tributadas e N�o-Tributadas no Mercado Interno
   else if (nCSTPis = '54') then result := stpisOperCredRecTribMercIntEExportacao             // '54' // Opera��o com Direito a Cr�dito - Vinculada a Receitas Tributadas no Mercado Interno e de Exporta��o
   else if (nCSTPis = '55') then result := stpisOperCredRecNaoTribMercIntEExportacao          // '55' // Opera��o com Direito a Cr�dito - Vinculada a Receitas N�o-Tributadas no Mercado Interno e de Exporta��o
   else if (nCSTPis = '56') then result := stpisOperCredRecTribENaoTribMercIntEExportacao     // '56' // Opera��o com Direito a Cr�dito - Vinculada a Receitas Tributadas e N�o-Tributadas no Mercado Interno, e de Exporta��o
   else if (nCSTPis = '60') then result := stpisCredPresAquiExcRecTribMercInt                 // '60' // Cr�dito Presumido - Opera��o de Aquisi��o Vinculada Exclusivamente a Receita Tributada no Mercado Interno
   else if (nCSTPis = '61') then result := stpisCredPresAquiExcRecNaoTribMercInt              // '61' // Cr�dito Presumido - Opera��o de Aquisi��o Vinculada Exclusivamente a Receita N�o-Tributada no Mercado Interno
   else if (nCSTPis = '62') then result := stpisCredPresAquiExcExcRecExportacao               // '62' // Cr�dito Presumido - Opera��o de Aquisi��o Vinculada Exclusivamente a Receita de Exporta��o
   else if (nCSTPis = '63') then result := stpisCredPresAquiRecTribNaoTribMercInt             // '63' // Cr�dito Presumido - Opera��o de Aquisi��o Vinculada a Receitas Tributadas e N�o-Tributadas no Mercado Interno
   else if (nCSTPis = '64') then result := stpisCredPresAquiRecTribMercIntEExportacao         // '64' // Cr�dito Presumido - Opera��o de Aquisi��o Vinculada a Receitas Tributadas no Mercado Interno e de Exporta��o
   else if (nCSTPis = '65') then result := stpisCredPresAquiRecNaoTribMercIntEExportacao      // '65' // Cr�dito Presumido - Opera��o de Aquisi��o Vinculada a Receitas N�o-Tributadas no Mercado Interno e de Exporta��o
   else if (nCSTPis = '66') then result := stpisCredPresAquiRecTribENaoTribMercIntEExportacao // '66' // Cr�dito Presumido - Opera��o de Aquisi��o Vinculada a Receitas Tributadas e N�o-Tributadas no Mercado Interno, e de Exporta��o
   else if (nCSTPis = '67') then result := stpisOutrasOperacoes_CredPresumido                 // '67' // Cr�dito Presumido - Outras Opera��es
   else if (nCSTPis = '70') then result := stpisOperAquiSemDirCredito                         // '70' // Opera��o de Aquisi��o sem Direito a Cr�dito
   else if (nCSTPis = '71') then result := stpisOperAquiComIsensao                            // '71' // Opera��o de Aquisi��o com Isen��o
   else if (nCSTPis = '72') then result := stpisOperAquiComSuspensao                          // '72' // Opera��o de Aquisi��o com Suspens�o
   else if (nCSTPis = '73') then result := stpisOperAquiAliquotaZero                          // '73' // Opera��o de Aquisi��o a Al�quota Zero
   else if (nCSTPis = '74') then result := stpisOperAqui_SemIncidenciaContribuicao            // '74' // Opera��o de Aquisi��o sem Incid�ncia da Contribui��o
   else if (nCSTPis = '75') then result := stpisOperAquiPorST                                 // '75' // Opera��o de Aquisi��o por Substitui��o Tribut�ria
   else if (nCSTPis = '98') then result := stpisOutrasOperacoesEntrada                        // '98' // Outras Opera��es de Entrada
   else                          result := stpisOutrasOperacoes;                              // '99' // Outras Opera��es
end;

class function TRegistroC170.GetIndApur(
  const cIndApur: String): TACBrApuracaoIPI;
begin
   result                               := iaMensal;
   if      (cIndApur = '0') then result := iaMensal     // 0 - Mensal
   else if (cIndApur = '1') then result := iaDecendial; // 1 - Decendial
end;

class function TRegistroC170.GetIndFrt(
  const nIndFrt: Integer): TACBrTipoFrete;
begin
   if       (nIndFrt = 0) then result := tfPorContaEmitente      // 1 - Por conta do emitente
   else if  (nIndFrt = 1) then result := tfPorContaDestinatario  // 2 - Por conta do destinat�rio
   else                        result := tfPorContaEmitente;
end;

class function TRegistroC170.GetIndMov(
  const cIndMov: String): TACBrMovimentacaoFisica;
begin
       if cIndMov = '0' then  result := mfSim
  else if cIndMov = '1' then result  := mfNao;
end;

end.
