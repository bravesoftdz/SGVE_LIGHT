unit GeradorSintegra;

interface

uses ACBrSintegra, Forms, SysUtils, Variants, Empresa, Contnrs, StrUtils, DBClient, DB, ItemNotaFiscal, Dialogs,
     Generics.Collections, NotaFiscal;

type
  TGeradorSintegra = class

  private
    Fsintegra: TACBrSintegra;
    FdataFinal: TDateTime;
    FdataInicial: TDateTime;
    Ftipo: String;
    FnomeArquivo: String;
    FfinDoArq: String;
    FEmpresa :TEmpresa;
    FNotasFiscais :TObjectList<TNotaFiscal>;

    procedure pregeracao_registro50;

    procedure gerarRegistro10;
    procedure gerarRegistro11;
    procedure gerarRegistro50( NotasFiscais :TObjectList<TNotaFiscal>);
    procedure gerarRegistro54( NotasFiscais :TObjectList<TNotaFiscal>);
    procedure gerarRegistro75( Item :TObject; itens_de_materias :Boolean);

    procedure Setsintegra(const Value: TACBrSintegra);


    procedure agrupa_CFOP_ALIQUOTA(CDS :TClientDataSet; ListaItens :TObjectList<TItemNotaFiscal>; itens_de_materias :Boolean);
    function seleciona_notas_fiscais :TObjectList<TNotaFiscal>;

  public

    procedure gerarSintegra;

    constructor create(const dataInicial :TDateTime; const dataFinal :TDateTime;
                       const nomeArquivo, finDoArq :String; Empresa :TEmpresa);
    destructor Destroy;

  public
    property NotasFiscais :TObjectList<TNotaFiscal> read FNotasFiscais;

end;

implementation

uses Repositorio, FabricaRepositorio, EspecificacaoNotaFiscalPorPeriodoEStatus,
  Pessoa, Endereco,  TipoSerie, TotaisNotaFiscal, EspecificacaoItemNfCfopAliq, Especificacao,
  TipoRegimeTributario, IcmsSn101, TipoStatusNotaFiscal, Classes, StringUtilitario;

{ TGeradorSintegra }

procedure TGeradorSintegra.agrupa_CFOP_ALIQUOTA(CDS: TClientDataSet; ListaItens: TObjectList<TItemNotaFiscal>; itens_de_materias :Boolean);
var i :integer;
    cfop :String;
    aliquota :Real;
begin
 try
   for i := 0 to ListaItens.Count - 1 do begin
     cfop     := '';
     aliquota := 0;
     cfop     := (ListaItens.Items[i] as TItemNotaFiscal).NaturezaOperacao.CFOP;

     if assigned((ListaItens.Items[i] as TItemNotaFiscal).icms00) then
       aliquota  := (ListaItens.Items[i] as TItemNotaFiscal).icms00.aliquota
     else
       aliquota := 0;

     if not ( CDS.Locate('CFOP;Aliquota',VarArrayOf([ cfop, aliquota ]), []) ) then begin
       cds.Append;

       cds.FieldByName('CFOP').AsString    := cfop;
       cds.FieldByName('Aliquota').AsFloat := aliquota;

       cds.Post;
     end;
   end;

 except
   on e : Exception do
      begin
        raise Exception.create( e.Message );
      end;
 end;
end;

constructor TGeradorSintegra.create(const dataInicial,
  dataFinal: TDateTime; const nomeArquivo, finDoArq: String; Empresa :TEmpresa);
begin
   self.FSintegra     := TACBrSintegra.Create(nil);

   self.FDataInicial  := dataInicial;
   self.FDataFinal    := dataFinal;
   self.FFinDoArq     := finDoArq;
   self.FNomeArquivo  := nomeArquivo;
   self.FEmpresa      := Empresa;
   FNotasFiscais      := nil;
   FNotasFiscais      := seleciona_notas_fiscais;
end;

destructor TGeradorSintegra.Destroy;
begin
  if Assigned(FNotasFiscais) then
    FreeAndNil(FNotasFiscais);

  self.FSintegra.Free;
  self.FSintegra := nil;
end;

procedure TGeradorSintegra.gerarSintegra;
begin

  self.FSintegra.FileName := Self.FnomeArquivo;

  self.gerarRegistro10;
  self.gerarRegistro11;
  self.pregeracao_registro50;

  self.FSintegra.GeraArquivo;
end;

procedure TGeradorSintegra.gerarRegistro10;
begin
  if assigned(self.FSintegra) then
     begin
        if not assigned(self.FSintegra.Registro10) then
          self.FSintegra.Registro10 := TRegistro10.Create;

        self.FSintegra.Registro10.CNPJ                := trim(Fempresa.CPF_CNPJ);
        self.FSintegra.Registro10.Inscricao           := trim(Fempresa.RG_IE);
        self.FSintegra.Registro10.RazaoSocial         := trim(Fempresa.Razao);
        self.FSintegra.Registro10.Cidade              := intToStr(Fempresa.Endereco.CodCidade);
        self.FSintegra.Registro10.Estado              := trim(Fempresa.Endereco.Cidade.Estado.Sigla);
        self.FSintegra.Registro10.Telefone            := trim(Fempresa.Fone1);
        self.FSintegra.Registro10.DataInicial         := self.FdataInicial;
        self.FSintegra.Registro10.DataFinal           := self.FdataFinal;
        self.FSintegra.Registro10.CodigoConvenio      := '3';  { 3 - Convênio 57/95 Alt. 76/03 }
        self.FSintegra.Registro10.NaturezaInformacoes := '3'; { 3 - Totalidade das operações do informante }
        self.FSintegra.Registro10.FinalidadeArquivo   := self.FfinDoArq;

     end;
end;

procedure TGeradorSintegra.gerarRegistro11;
begin
  if assigned(self.FSintegra) then
    begin
       if not assigned(self.FSintegra.Registro11) then
         self.FSintegra.Registro11 := TRegistro11.Create;

       self.FSintegra.Registro11.Endereco         := trim(Fempresa.Endereco.Logradouro);
       self.FSintegra.Registro11.Numero           := trim(Fempresa.Endereco.Numero);
       self.FSintegra.Registro11.Bairro           := trim(Fempresa.Endereco.Bairro);
       self.FSintegra.Registro11.Cep              := trim(Fempresa.Endereco.CEP);
       self.FSintegra.Registro11.Responsavel      := trim('RESPONSÁVEL'); showmessage('responsavel');
       self.FSintegra.Registro11.Telefone         := trim(Fempresa.Fone1);
    end;
end;

procedure TGeradorSintegra.pregeracao_registro50;
var
  i, n          :integer;
  Aliquota      :Real;
  index_item    :integer;
begin
  self.gerarRegistro50(NotasFiscais);
  self.gerarRegistro54(NotasFiscais);

    { if TTipoRegimeTributarioUtilitario.DeEnumeradoParaInteger((NotasFiscais[n] as TNotaFiscal).Empresa.RegimeTributario) = 1 then //lucro presumido
        Aliquota := (ItensNota.Items[i] as TItemNotaFiscal).Icms00.Aliquota
      else if TTipoRegimeTributarioUtilitario.DeEnumeradoParaInteger((NotasFiscais[n] as TNotaFiscal).Empresa.RegimeTributario) = 0 then // simples n.
        Aliquota := (ItensNota.Items[i] as TItemNotaFiscal).IcmsSn101.AliquotaCreditoSN;

      Especificacao    := TEspecificacaoItemNfCfopAliq.Create( TItemNotaFiscal(ItensNota.Items[i]).NaturezaOperacao.CFOP,
                                                               Aliquota,
                                                               (NotasFiscais[n] as TNotaFiscal).Empresa.RegimeTributario);
      index_item := ItensNota.Contains(Especificacao);}
end;

procedure TGeradorSintegra.gerarRegistro50(NotasFiscais :TObjectList<TNotaFiscal>);
var cds         :TClientDataSet;
    registro50  :TRegistro50;
    n, i        :integer;
    entrada_saida :String;
begin
  CDS := TClientDataSet.Create(nil);
  CDS.FieldDefs.Clear;
  CDS.FieldDefs.Add('CFOP',ftString, 4, false);
  CDS.FieldDefs.Add('Aliquota',ftFloat);
  CDS.CreateDataSet;

  if not assigned(self.FSintegra.Registros50) then
     self.FSintegra.Registros50 := TRegistros50.Create;


  for n := 0 to NotasFiscais.Count - 1 do begin

    Application.ProcessMessages;
    cds.EmptyDataSet;

     entrada_saida := NotasFiscais[n].Entrada_saida;

     if NotasFiscais[n].Status = snfCancelada then begin

        registro50 := TRegistro50.Create;

        registro50.Modelo           := '55';
        registro50.Serie            :=  NotasFiscais[n].Serie;
        registro50.Numero           := IntToStr( NotasFiscais[n].NumeroNotaFiscal );
        registro50.Situacao         := 'S';
        registro50.DataDocumento    := NotasFiscais[n].DataEmissao;
        registro50.Cfop             := NotasFiscais[n].CFOP.CFOP;
        registro50.EmissorDocumento := IfThen(entrada_saida = 'E','T','P'); //emissor: Próprio contribuinte ou Terceiros

        self.FSintegra.Registros50.Add(registro50);

     end                                           //coloco condicao se for entrada tbm, pois notas de entradas importadas pelo XML nao vinculam status
     else if (NotasFiscais[n].Status = snfAutorizada) or ((entrada_saida = 'E') and (NotasFiscais[n].NotaDeMaterias)) then begin

        agrupa_CFOP_ALIQUOTA(CDS, NotasFiscais[n].Itens, NotasFiscais[n].NotaDeMaterias );

        cds.First;
        while not cds.Eof do begin

          registro50 := TRegistro50.Create;

          if entrada_saida = 'E' then begin
            registro50.CPFCNPJ        := NotasFiscais[n].Emitente.CPF_CNPJ;
            registro50.Inscricao      := NotasFiscais[n].Emitente.RG_IE;
            registro50.DataDocumento  := NotasFiscais[n].DataEmissao;
            registro50.UF             := NotasFiscais[n].Emitente.Endereco.Cidade.estado.sigla;
          end
          else begin
            registro50.CPFCNPJ        := NotasFiscais[n].Destinatario.CPF_CNPJ;
            registro50.Inscricao      := NotasFiscais[n].Destinatario.RG_IE;
            registro50.DataDocumento  := NotasFiscais[n].DataEmissao;
            registro50.UF             := NotasFiscais[n].Destinatario.Endereco.Cidade.estado.sigla;
          end;

          registro50.Modelo           := '55';
          registro50.Serie            := NotasFiscais[n].Serie;
          registro50.Numero           := IntToStr( NotasFiscais[n].NumeroNotaFiscal );
          registro50.Cfop             := cds.fieldByName('CFOP').asString;
          registro50.EmissorDocumento := IfThen(entrada_saida = 'E','T','P'); //emissor: Próprio contribuinte ou Terceiros
          registro50.ValorContabil    := NotasFiscais[n].Totais.TotalNF;
          registro50.BasedeCalculo    := NotasFiscais[n].Totais.BaseCalculoICMS;
          registro50.Icms             := NotasFiscais[n].Totais.ICMS;
          registro50.Isentas          := 0;
          registro50.Outras           := 0;
          registro50.Aliquota         := cds.fieldByName('ALIQUOTA').asFloat;
          registro50.Situacao         := 'N';

          self.FSintegra.Registros50.Add(registro50);

          cds.Next;
        end; //Fim do While

     end; //fim do if que verifica se é cancelada, autorizada ou de entrada

  end; //fim do for

end;

procedure TGeradorSintegra.gerarRegistro54(NotasFiscais :TObjectList<TNotaFiscal>);
var registro54 :TRegistro54;
    n , i      :Integer;
    entrada_saida :String;
begin
  if not assigned(self.FSintegra.Registros54) then
    self.FSintegra.Registros54 := TRegistros54.Create;

  for n := 0 to NotasFiscais.Count - 1 do begin

    for i := 0 to NotasFiscais.Items[n].Itens.Count - 1 do begin
       Application.ProcessMessages;

       entrada_saida := NotasFiscais[n].Entrada_saida;
       
       registro54 := TRegistro54.Create;

       registro54.Modelo               := '55';
       registro54.Serie                := NotasFiscais[n].Serie;
       registro54.Numero               := IntToStr( NotasFiscais[n].NumeroNotaFiscal );

       registro54.CFOP            := NotasFiscais.Items[n].Itens[i].NaturezaOperacao.CFOP;
       registro54.CPFCNPJ         := NotasFiscais[n].Destinatario.CPF_CNPJ;

       if assigned( NotasFiscais.Items[n].Itens[i].Icms00 ) then begin
         registro54.CST                  := TStringUtilitario.CaracterAEsquerda('0', NotasFiscais.Items[n].Itens[i].Icms00.CST, 3);
         registro54.Aliquota             := NotasFiscais.Items[n].Itens[i].Icms00.Aliquota;
       end
       else  begin
         registro54.CST                  := TStringUtilitario.CaracterAEsquerda('0',NotasFiscais.Items[n].Itens[i].IcmsSn101.CSOSN, 3);
         registro54.Aliquota             := 0;
       end;

       registro54.NumeroItem           := i+1;
       registro54.Codigo               := 'P' + intToStr(NotasFiscais.Items[n].Itens[i].Produto.Codigo);
       registro54.Descricao            := NotasFiscais.Items[n].Itens[i].Produto.Descricao;
       registro54.Quantidade           := NotasFiscais.Items[n].Itens[i].Quantidade;
       registro54.Valor                := NotasFiscais.Items[n].Itens[i].ValorUnitario *
                                          NotasFiscais.Items[n].Itens[i].Quantidade;
       registro54.ValorDescontoDespesa := NotasFiscais.Items[n].Itens[i].ValorDesconto;
       registro54.BasedeCalculo        := NotasFiscais.Items[n].Itens[i].BaseCalculoICMS;
       registro54.BaseST               := 0;
       registro54.ValorIpi             := NotasFiscais.Items[n].Itens[i].ValorIPI;

       self.FSintegra.Registros54.Add(registro54);

       self.gerarRegistro75( NotasFiscais.Items[n].Itens[i], NotasFiscais.Items[n].NotaDeMaterias );

    end;//for itens

  end;//for notas
end;

procedure TGeradorSintegra.gerarRegistro75( Item :TObject; itens_de_materias :Boolean);
var registro75 :TRegistro75;
begin

  if not assigned(self.FSintegra.Registros50) then
    self.FSintegra.Registros75 := TRegistros75.Create;

  registro75 := TRegistro75.Create;

  registro75.DataInicial  := self.FdataInicial;
  registro75.DataFinal    := self.FdataFinal;
  registro75.Codigo       := 'P'+IntToStr((Item as TItemNotaFiscal).Produto.Codigo);
  registro75.NCM          := (Item as TItemNotaFiscal).Produto.NCMIbpt.ncm_ibpt;
  registro75.Descricao    := (Item as TItemNotaFiscal).Produto.Descricao;
  registro75.Unidade      := (Item as TItemNotaFiscal).Unidade;//'UN';

  if assigned( (Item as TItemNotaFiscal).IpiTrib ) then
    registro75.AliquotaIpi  := (Item as TItemNotaFiscal).IpiTrib.Aliquota;

  if assigned( (Item as TItemNotaFiscal).Icms00 ) then
    registro75.AliquotaICMS := (Item as TItemNotaFiscal).Icms00.Aliquota
  else
    registro75.AliquotaICMS := (Item as TItemNotaFiscal).IcmsSn101.AliquotaCreditoSN;

  registro75.Reducao        := 0;
  registro75.BaseST         := 0;

  self.FSintegra.Registros75.Add(registro75);

end;


function TGeradorSintegra.seleciona_notas_fiscais: TObjectList<TNotaFiscal>;
var
  Esp          :TEspecificacao;
  Repositorio  :TRepositorio;
begin
  Esp          := nil;
  Repositorio  := nil;

  try
                                                                                          //apenas enviadas
    Esp := TEspecificacaoNotaFiscalPorPeriodoEStatus.Create(self.FdataInicial, self.FdataFinal, false, true, false, true, self.FEmpresa.CPF_CNPJ);

    Repositorio  := TFabricaRepositorio.GetRepositorio(TNotaFiscal.ClassName);
    Result       := Repositorio.GetListaPorEspecificacao<TNotaFiscal>(Esp);

  finally
    FreeAndNil(Esp);
    FreeAndNil(Repositorio);
  end;
end;

procedure TGeradorSintegra.Setsintegra(const Value: TACBrSintegra);
begin
  Fsintegra := Value;
end;

end.
