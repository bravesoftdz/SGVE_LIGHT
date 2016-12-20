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
  else if (cBaseCalcCred = '01') then result := bccAqBensRevenda                 // '01' // Aquisição de bens para revenda
  else if (cBaseCalcCred = '02') then result := bccAqBensUtiComoInsumo           // '02' // Aquisição de bens utilizados como insumo
  else if (cBaseCalcCred = '03') then result := bccAqServUtiComoInsumo           // '03' // Aquisição de serviços utilizados como insumo
  else if (cBaseCalcCred = '04') then result := bccEnergiaEletricaTermica        // '04' // Energia elétrica e térmica, inclusive sob a forma de vapor
  else if (cBaseCalcCred = '05') then result := bccAluguelPredios                // '05' // Aluguéis de prédios
  else if (cBaseCalcCred = '06') then result := bccAluguelMaqEquipamentos        // '06' // Aluguéis de máquinas e equipamentos
  else if (cBaseCalcCred = '07') then result := bccArmazenagemMercadoria         // '07' // Armazenagem de mercadoria e frete na operação de venda
  else if (cBaseCalcCred = '08') then result := bccConArrendamentoMercantil      // '08' // Contraprestações de arrendamento mercantil
  else if (cBaseCalcCred = '09') then result := bccMaqCredDepreciacao            // '09' // Máquinas, equipamentos e outros bens incorporados ao ativo imobilizado (crédito sobre encargos de depreciação).
  else if (cBaseCalcCred = '10') then result := bccMaqCredAquisicao              // '10' // Máquinas, equipamentos e outros bens incorporados ao ativo imobilizado (crédito com base no valor de aquisição).
  else if (cBaseCalcCred = '11') then result := bccAmortizacaoDepreciacaoImoveis // '11' // Amortização e Depreciação de edificações e benfeitorias em imóveis
  else if (cBaseCalcCred = '12') then result := bccDevolucaoSujeita              // '12' // Devolução de Vendas Sujeitas à Incidência Não-Cumulativa
  else if (cBaseCalcCred = '13') then result := bccOutrasOpeComDirCredito        // '13' // Outras Operações com Direito a Crédito
  else if (cBaseCalcCred = '14') then result := bccAtTransporteSubcontratacao    // '14' // Atividade de Transporte de Cargas – Subcontratação
  else if (cBaseCalcCred = '15') then result := bccAtImobCustoIncorrido          // '15' // Atividade Imobiliária – Custo Incorrido de Unidade Imobiliária
  else if (cBaseCalcCred = '16') then result := bccAtImobCustoOrcado             // '16' // Atividade Imobiliária – Custo Orçado de unidade não concluída
  else if (cBaseCalcCred = '17') then result := bccAtPresServ                    // '17' // Atividade de Prestação de Serviços de Limpeza, Conservação e Manutenção – vale-transporte, vale-refeição ou vale-alimentação, fardamento ou uniforme.
  else if (cBaseCalcCred = '18') then result := bccEstoqueAberturaBens           // '18' // Estoque de abertura de bens
  else                                result := bccVazio;
end;

class function TRegistroC170.GetCSTCofins(
  const nCSTCofins: String): TACBrSituacaoTribCOFINS;
begin
   if      (nCSTCofins = '01') then result := stcofinsValorAliquotaNormal                           // '01' // Operação Tributável com Alíquota Básica                           // valor da operação alíquota normal (cumulativo/não cumulativo)).
   else if (nCSTCofins = '02') then result := stcofinsValorAliquotaDiferenciada                     // '02' // Operação Tributável com Alíquota Diferenciada                     // valor da operação (alíquota diferenciada)).
   else if (nCSTCofins = '03') then result := stcofinsQtdeAliquotaUnidade                           // '03' // Operação Tributável com Alíquota por Unidade de Medida de Produto // quantidade vendida x alíquota por unidade de produto).
   else if (nCSTCofins = '04') then result := stcofinsMonofaticaAliquotaZero                        // '04' // Operação Tributável Monofásica - Revenda a Alíquota Zero
   else if (nCSTCofins = '05') then result := stcofinsValorAliquotaPorST                            // '05' // Operação Tributável por Substituição Tributária
   else if (nCSTCofins = '06') then result := stcofinsAliquotaZero                                  // '06' // Operação Tributável a Alíquota Zero
   else if (nCSTCofins = '07') then result := stcofinsIsentaContribuicao                            // '07' // Operação Isenta da Contribuição
   else if (nCSTCofins = '08') then result := stcofinsSemIncidenciaContribuicao                     // '08' // Operação sem Incidência da Contribuição
   else if (nCSTCofins = '09') then result := stcofinsSuspensaoContribuicao                         // '09' // Operação com Suspensão da Contribuição
   else if (nCSTCofins = '49') then result := stcofinsOutrasOperacoesSaida                          // '49' // Outras Operações de Saída
   else if (nCSTCofins = '50') then result := stcofinsOperCredExcRecTribMercInt                     // '50' // Operação com Direito a Crédito - Vinculada Exclusivamente a Receita Tributada no Mercado Interno
   else if (nCSTCofins = '51') then result := stcofinsOperCredExcRecNaoTribMercInt                  // '51' // Operação com Direito a Crédito - Vinculada Exclusivamente a Receita Não-Tributada no Mercado Interno
   else if (nCSTCofins = '52') then result := stcofinsOperCredExcRecExportacao                      // '52' // Operação com Direito a Crédito - Vinculada Exclusivamente a Receita de Exportação
   else if (nCSTCofins = '53') then result := stcofinsOperCredRecTribNaoTribMercInt                 // '53' // Operação com Direito a Crédito - Vinculada a Receitas Tributadas e Não-Tributadas no Mercado Interno
   else if (nCSTCofins = '54') then result := stcofinsOperCredRecTribMercIntEExportacao             // '54' // Operação com Direito a Crédito - Vinculada a Receitas Tributadas no Mercado Interno e de Exportação
   else if (nCSTCofins = '55') then result := stcofinsOperCredRecNaoTribMercIntEExportacao          // '55' // Operação com Direito a Crédito - Vinculada a Receitas Não Tributadas no Mercado Interno e de Exportação
   else if (nCSTCofins = '56') then result := stcofinsOperCredRecTribENaoTribMercIntEExportacao     // '56' // Operação com Direito a Crédito - Vinculada a Receitas Tributadas e Não-Tributadas no Mercado Interno e de Exportação
   else if (nCSTCofins = '60') then result := stcofinsCredPresAquiExcRecTribMercInt                 // '60' // Crédito Presumido - Operação de Aquisição Vinculada Exclusivamente a Receita Tributada no Mercado Interno
   else if (nCSTCofins = '61') then result := stcofinsCredPresAquiExcRecNaoTribMercInt              // '61' // Crédito Presumido - Operação de Aquisição Vinculada Exclusivamente a Receita Não-Tributada no Mercado Interno
   else if (nCSTCofins = '62') then result := stcofinsCredPresAquiExcExcRecExportacao               // '62' // Crédito Presumido - Operação de Aquisição Vinculada Exclusivamente a Receita de Exportação
   else if (nCSTCofins = '63') then result := stcofinsCredPresAquiRecTribNaoTribMercInt             // '63' // Crédito Presumido - Operação de Aquisição Vinculada a Receitas Tributadas e Não-Tributadas no Mercado Interno
   else if (nCSTCofins = '64') then result := stcofinsCredPresAquiRecTribMercIntEExportacao         // '64' // Crédito Presumido - Operação de Aquisição Vinculada a Receitas Tributadas no Mercado Interno e de Exportação
   else if (nCSTCofins = '65') then result := stcofinsCredPresAquiRecNaoTribMercIntEExportacao      // '65' // Crédito Presumido - Operação de Aquisição Vinculada a Receitas Não-Tributadas no Mercado Interno e de Exportação
   else if (nCSTCofins = '66') then result := stcofinsCredPresAquiRecTribENaoTribMercIntEExportacao // '66' // Crédito Presumido - Operação de Aquisição Vinculada a Receitas Tributadas e Não-Tributadas no Mercado Interno e de Exportação
   else if (nCSTCofins = '67') then result := stcofinsOutrasOperacoes_CredPresumido                 // '67' // Crédito Presumido - Outras Operações
   else if (nCSTCofins = '70') then result := stcofinsOperAquiSemDirCredito                         // '70' // Operação de Aquisição sem Direito a Crédito
   else if (nCSTCofins = '71') then result := stcofinsOperAquiComIsensao                            // '71' // Operação de Aquisição com Isenção
   else if (nCSTCofins = '72') then result := stcofinsOperAquiComSuspensao                          // '72' // Operação de Aquisição com Suspensão
   else if (nCSTCofins = '73') then result := stcofinsOperAquiAliquotaZero                          // '73' // Operação de Aquisição a Alíquota Zero
   else if (nCSTCofins = '74') then result := stcofinsOperAqui_SemIncidenciaContribuicao            // '74' // Operação de Aquisição sem Incidência da Contribuição
   else if (nCSTCofins = '75') then result := stcofinsOperAquiPorST                                 // '75' // Operação de Aquisição por Substituição Tributária
   else if (nCSTCofins = '98') then result := stcofinsOutrasOperacoesEntrada                        // '98' // Outras Operações de Entrada
   else                             result := stcofinsOutrasOperacoes;                              // '99' // Outras Operações
end;

class function TRegistroC170.GetCSTIcms(
  const cCSTIcms: String): TACBrSituacaoTribICMS;
begin
if      (cCSTIcms = '000') then result := sticmsTributadaIntegralmente                               // '000' //	Tributada integralmente
   else if (cCSTIcms = '010') then result := sticmsTributadaComCobracaPorST                             // '010' //	Tributada e com cobrança do ICMS por substituição tributária
   else if (cCSTIcms = '020') then result := sticmsComReducao                                           // '020' //	Com redução de base de cálculo
   else if (cCSTIcms = '030') then result := sticmsIsentaComCobracaPorST                                // '030' //	Isenta ou não tributada e com cobrança do ICMS por substituição tributária
   else if (cCSTIcms = '040') then result := sticmsIsenta                                               // '040' //	Isenta
   else if (cCSTIcms = '041') then result := sticmsNaoTributada                                         // '041' //	Não tributada
   else if (cCSTIcms = '050') then result := sticmsSuspensao                                            // '050' //	Suspensão
   else if (cCSTIcms = '051') then result := sticmsDiferimento                                          // '051' //	Diferimento
   else if (cCSTIcms = '060') then result := sticmsCobradoAnteriormentePorST                            // '060' //	ICMS cobrado anteriormente por substituição tributária
   else if (cCSTIcms = '070') then result := sticmsComReducaoPorST                                      // '070' //	Com redução de base de cálculo e cobrança do ICMS por substituição tributária
   else if (cCSTIcms = '090') then result := sticmsOutros                                               // '090' //	Outros
   else if (cCSTIcms = '100') then result := sticmsEstrangeiraImportacaoDiretaTributadaIntegralmente    // '100' // Estrangeira - Importação direta - Tributada integralmente
   else if (cCSTIcms = '110') then result := sticmsEstrangeiraImportacaoDiretaTributadaComCobracaPorST  // '110' // Estrangeira - Importação direta - Tributada e com cobrança do ICMS por substituição tributária
   else if (cCSTIcms = '120') then result := sticmsEstrangeiraImportacaoDiretaComReducao                // '120' // Estrangeira - Importação direta - Com redução de base de cálculo
   else if (cCSTIcms = '130') then result := sticmsEstrangeiraImportacaoDiretaIsentaComCobracaPorST     // '130' // Estrangeira - Importação direta - Isenta ou não tributada e com cobrança do ICMS por substituição tributária
   else if (cCSTIcms = '140') then result := sticmsEstrangeiraImportacaoDiretaIsenta                    // '140' // Estrangeira - Importação direta - Isenta
   else if (cCSTIcms = '141') then result := sticmsEstrangeiraImportacaoDiretaNaoTributada              // '141' // Estrangeira - Importação direta - Não tributada
   else if (cCSTIcms = '150') then result := sticmsEstrangeiraImportacaoDiretaSuspensao                 // '150' // Estrangeira - Importação direta - Suspensão
   else if (cCSTIcms = '151') then result := sticmsEstrangeiraImportacaoDiretaDiferimento               // '151' // Estrangeira - Importação direta - Diferimento
   else if (cCSTIcms = '160') then result := sticmsEstrangeiraImportacaoDiretaCobradoAnteriormentePorST // '160' // Estrangeira - Importação direta - ICMS cobrado anteriormente por substituição tributária
   else if (cCSTIcms = '170') then result := sticmsEstrangeiraImportacaoDiretaComReducaoPorST           // '170' // Estrangeira - Importação direta - Com redução de base de cálculo e cobrança do ICMS por substituição tributária
   else if (cCSTIcms = '190') then result := sticmsEstrangeiraImportacaoDiretaOutros                    // '190' // Estrangeira - Importação direta - Outras
   else if (cCSTIcms = '200') then result := sticmsEstrangeiraAdqMercIntTributadaIntegralmente          // '200' // Estrangeira - Adquirida no mercado interno - Tributada integralmente
   else if (cCSTIcms = '210') then result := sticmsEstrangeiraAdqMercIntTributadaComCobracaPorST        // '210' // Estrangeira - Adquirida no mercado interno - Tributada e com cobrança do ICMS por substituição tributária
   else if (cCSTIcms = '220') then result := sticmsEstrangeiraAdqMercIntComReducao                      // '220' // Estrangeira - Adquirida no mercado interno - Com redução de base de cálculo
   else if (cCSTIcms = '230') then result := sticmsEstrangeiraAdqMercIntIsentaComCobracaPorST           // '230' // Estrangeira - Adquirida no mercado interno - Isenta ou não tributada e com cobrança do ICMS por substituição tributária
   else if (cCSTIcms = '240') then result := sticmsEstrangeiraAdqMercIntIsenta                          // '240' // Estrangeira - Adquirida no mercado interno - Isenta
   else if (cCSTIcms = '241') then result := sticmsEstrangeiraAdqMercIntNaoTributada                    // '241' // Estrangeira - Adquirida no mercado interno - Não tributada
   else if (cCSTIcms = '250') then result := sticmsEstrangeiraAdqMercIntSuspensao                       // '250' // Estrangeira - Adquirida no mercado interno - Suspensão
   else if (cCSTIcms = '251') then result := sticmsEstrangeiraAdqMercIntDiferimento                     // '251' // Estrangeira - Adquirida no mercado interno - Diferimento
   else if (cCSTIcms = '260') then result := sticmsEstrangeiraAdqMercIntCobradoAnteriormentePorST       // '260' // Estrangeira - Adquirida no mercado interno - ICMS cobrado anteriormente por substituição tributária
   else if (cCSTIcms = '270') then result := sticmsEstrangeiraAdqMercIntComReducaoPorST                 // '270' // Estrangeira - Adquirida no mercado interno - Com redução de base de cálculo e cobrança do ICMS por substituição tributária
   else if (cCSTIcms = '290') then result := sticmsEstrangeiraAdqMercIntOutros                          // '290' // Estrangeira - Adquirida no mercado interno - Outras
   else if (cCSTIcms = '101') then result := sticmsSimplesNacionalTributadaComPermissaoCredito          // '101' // Simples Nacional - Tributada pelo Simples Nacional com permissão de crédito
   else if (cCSTIcms = '102') then result := sticmsSimplesNacionalTributadaSemPermissaoCredito          // '102' // Simples Nacional - Tributada pelo Simples Nacional sem permissão de crédito
   else if (cCSTIcms = '103') then result := sticmsSimplesNacionalIsencaoPorFaixaReceitaBruta           // '103' // Simples Nacional - Isenção do ICMS no Simples Nacional para faixa de receita bruta
   else if (cCSTIcms = '201') then result := sticmsSimplesNacionalTributadaComPermissaoCreditoComST     // '201' // Simples Nacional - Tributada pelo Simples Nacional com permissão de crédito e com cobrança do ICMS por substituição tributária
   else if (cCSTIcms = '202') then result := sticmsSimplesNacionalTributadaSemPermissaoCreditoComST     // '202' // Simples Nacional - Tributada pelo Simples Nacional sem permissão de crédito e com cobrança do ICMS por substituição tributária
   else if (cCSTIcms = '203') then result := sticmsSimplesNacionalIsencaoPorFaixaReceitaBrutaComST      // '203' // Simples Nacional - Isenção do ICMS no Simples Nacional para faixa de receita bruta e com cobrança do ICMS por substituição tributária
   else if (cCSTIcms = '300') then result := sticmsSimplesNacionalImune                                 // '300' // Simples Nacional - Imune
   else if (cCSTIcms = '400') then result := sticmsSimplesNacionalNaoTributada                          // '400' // Simples Nacional - Não tributada pelo Simples Nacional
   else if (cCSTIcms = '500') then result := sticmsSimplesNacionalCobradoAnteriormentePorST             // '500' // Simples Nacional - ICMS cobrado anteriormente por substituição tributária (substituído) ou por antecipação
   else if (cCSTIcms = '900') then result := sticmsSimplesNacionalOutros;                               // '900' // Simples Nacional - Outros   
end;

class function TRegistroC170.GetCSTIpi(
  const cCSTIpi: String): TACBrSituacaoTribIPI;
begin
   if      (cCSTIpi = '00') then result := stipiEntradaRecuperacaoCredito // '00' // Entrada com recuperação de crédito
   else if (cCSTIpi = '01') then result := stipiEntradaTributradaZero     // '01' // Entrada tributada com alíquota zero
   else if (cCSTIpi = '02') then result := stipiEntradaIsenta             // '02' // Entrada isenta
   else if (cCSTIpi = '03') then result := stipiEntradaNaoTributada       // '03' // Entrada não-tributada
   else if (cCSTIpi = '04') then result := stipiEntradaImune              // '04' // Entrada imune
   else if (cCSTIpi = '05') then result := stipiEntradaComSuspensao       // '05' // Entrada com suspensão
   else if (cCSTIpi = '49') then result := stipiOutrasEntradas            // '49' // Outras entradas
   else if (cCSTIpi = '50') then result := stipiSaidaTributada            // '50' // Saída tributada
   else if (cCSTIpi = '51') then result := stipiSaidaTributadaZero        // '51' // Saída tributada com alíquota zero
   else if (cCSTIpi = '52') then result := stipiSaidaIsenta               // '52' // Saída isenta
   else if (cCSTIpi = '53') then result := stipiSaidaNaoTributada         // '53' // Saída não-tributada
   else if (cCSTIpi = '54') then result := stipiSaidaImune                // '54' // Saída imune
   else if (cCSTIpi = '55') then result := stipiSaidaComSuspensao         // '55' // Saída com suspensão
   else if (cCSTIpi = '99') then result := stipiOutrasSaidas;             // '99' // Outras saídas
end;

class function TRegistroC170.GetCSTPis(
  const nCSTPis: String): TACBrSituacaoTribPIS;
begin
   if      (nCSTPis = '01') then result := stpisValorAliquotaNormal                           // '01' // Operação Tributável com Alíquota Básica   // valor da operação alíquota normal (cumulativo/não cumulativo)).
   else if (nCSTPis = '02') then result := stpisValorAliquotaDiferenciada                     // '02' // Operação Tributável com Alíquota Diferenciada // valor da operação (alíquota diferenciada)).
   else if (nCSTPis = '03') then result := stpisQtdeAliquotaUnidade                           // '03' // Operação Tributável com Alíquota por Unidade de Medida de Produto // quantidade vendida x alíquota por unidade de produto).
   else if (nCSTPis = '04') then result := stpisMonofaticaAliquotaZero                        // '04' // Operação Tributável Monofásica - Revenda a Alíquota Zero
   else if (nCSTPis = '05') then result := stpisValorAliquotaPorST                            // '05' // Operação Tributável por Substituição Tributária
   else if (nCSTPis = '06') then result := stpisAliquotaZero                                  // '06' // Operação Tributável a Alíquota Zero
   else if (nCSTPis = '07') then result := stpisIsentaContribuicao                            // '07' // Operação Isenta da Contribuição
   else if (nCSTPis = '08') then result := stpisSemIncidenciaContribuicao                     // '08' // Operação sem Incidência da Contribuição
   else if (nCSTPis = '09') then result := stpisSuspensaoContribuicao                         // '09' // Operação com Suspensão da Contribuição
   else if (nCSTPis = '49') then result := stpisOutrasOperacoesSaida                          // '49' // Outras Operações de Saída
   else if (nCSTPis = '50') then result := stpisOperCredExcRecTribMercInt                     // '50' // Operação com Direito a Crédito - Vinculada Exclusivamente a Receita Tributada no Mercado Interno
   else if (nCSTPis = '51') then result := stpisOperCredExcRecNaoTribMercInt                  // '51' // Operação com Direito a Crédito – Vinculada Exclusivamente a Receita Não Tributada no Mercado Interno
   else if (nCSTPis = '52') then result := stpisOperCredExcRecExportacao                      // '52' // Operação com Direito a Crédito - Vinculada Exclusivamente a Receita de Exportação
   else if (nCSTPis = '53') then result := stpisOperCredRecTribNaoTribMercInt                 // '53' // Operação com Direito a Crédito - Vinculada a Receitas Tributadas e Não-Tributadas no Mercado Interno
   else if (nCSTPis = '54') then result := stpisOperCredRecTribMercIntEExportacao             // '54' // Operação com Direito a Crédito - Vinculada a Receitas Tributadas no Mercado Interno e de Exportação
   else if (nCSTPis = '55') then result := stpisOperCredRecNaoTribMercIntEExportacao          // '55' // Operação com Direito a Crédito - Vinculada a Receitas Não-Tributadas no Mercado Interno e de Exportação
   else if (nCSTPis = '56') then result := stpisOperCredRecTribENaoTribMercIntEExportacao     // '56' // Operação com Direito a Crédito - Vinculada a Receitas Tributadas e Não-Tributadas no Mercado Interno, e de Exportação
   else if (nCSTPis = '60') then result := stpisCredPresAquiExcRecTribMercInt                 // '60' // Crédito Presumido - Operação de Aquisição Vinculada Exclusivamente a Receita Tributada no Mercado Interno
   else if (nCSTPis = '61') then result := stpisCredPresAquiExcRecNaoTribMercInt              // '61' // Crédito Presumido - Operação de Aquisição Vinculada Exclusivamente a Receita Não-Tributada no Mercado Interno
   else if (nCSTPis = '62') then result := stpisCredPresAquiExcExcRecExportacao               // '62' // Crédito Presumido - Operação de Aquisição Vinculada Exclusivamente a Receita de Exportação
   else if (nCSTPis = '63') then result := stpisCredPresAquiRecTribNaoTribMercInt             // '63' // Crédito Presumido - Operação de Aquisição Vinculada a Receitas Tributadas e Não-Tributadas no Mercado Interno
   else if (nCSTPis = '64') then result := stpisCredPresAquiRecTribMercIntEExportacao         // '64' // Crédito Presumido - Operação de Aquisição Vinculada a Receitas Tributadas no Mercado Interno e de Exportação
   else if (nCSTPis = '65') then result := stpisCredPresAquiRecNaoTribMercIntEExportacao      // '65' // Crédito Presumido - Operação de Aquisição Vinculada a Receitas Não-Tributadas no Mercado Interno e de Exportação
   else if (nCSTPis = '66') then result := stpisCredPresAquiRecTribENaoTribMercIntEExportacao // '66' // Crédito Presumido - Operação de Aquisição Vinculada a Receitas Tributadas e Não-Tributadas no Mercado Interno, e de Exportação
   else if (nCSTPis = '67') then result := stpisOutrasOperacoes_CredPresumido                 // '67' // Crédito Presumido - Outras Operações
   else if (nCSTPis = '70') then result := stpisOperAquiSemDirCredito                         // '70' // Operação de Aquisição sem Direito a Crédito
   else if (nCSTPis = '71') then result := stpisOperAquiComIsensao                            // '71' // Operação de Aquisição com Isenção
   else if (nCSTPis = '72') then result := stpisOperAquiComSuspensao                          // '72' // Operação de Aquisição com Suspensão
   else if (nCSTPis = '73') then result := stpisOperAquiAliquotaZero                          // '73' // Operação de Aquisição a Alíquota Zero
   else if (nCSTPis = '74') then result := stpisOperAqui_SemIncidenciaContribuicao            // '74' // Operação de Aquisição sem Incidência da Contribuição
   else if (nCSTPis = '75') then result := stpisOperAquiPorST                                 // '75' // Operação de Aquisição por Substituição Tributária
   else if (nCSTPis = '98') then result := stpisOutrasOperacoesEntrada                        // '98' // Outras Operações de Entrada
   else                          result := stpisOutrasOperacoes;                              // '99' // Outras Operações
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
   else if  (nIndFrt = 1) then result := tfPorContaDestinatario  // 2 - Por conta do destinatário
   else                        result := tfPorContaEmitente;
end;

class function TRegistroC170.GetIndMov(
  const cIndMov: String): TACBrMovimentacaoFisica;
begin
       if cIndMov = '0' then  result := mfSim
  else if cIndMov = '1' then result  := mfNao;
end;

end.
