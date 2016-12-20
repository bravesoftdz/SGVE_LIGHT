unit uCadastroDadosEmpresa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, System.Math,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroPadrao, Data.DB, Datasnap.DBClient, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, DBGridCBN,
  Vcl.ComCtrls, Vcl.Buttons, Vcl.ExtCtrls, frameMaskCpfCnpj, Vcl.Mask, RxToolEdit, RxCurrEdit, frameBuscaCidade, frameFone, RxDBCurrEdit,
  Vcl.Samples.Spin, contnrs;

type
  TfrmCadastroDadosEmpresa = class(TfrmCadastroPadrao)
    edtCodigo: TCurrencyEdit;
    GroupBox1: TGroupBox;
    edtRazao: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    edtFantasia: TEdit;
    CpfCnpj: TMaskCpfCnpj;
    Label3: TLabel;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    edtLogradouro: TEdit;
    Label5: TLabel;
    edtNumero: TEdit;
    edtBairro: TEdit;
    Label6: TLabel;
    BuscaCidade1: TBuscaCidade;
    Label7: TLabel;
    edtComplento: TEdit;
    GroupBox3: TGroupBox;
    Fone1: TFone;
    Label8: TLabel;
    edtEmail: TEdit;
    edtCEP: TMaskEdit;
    Label12: TLabel;
    Fone2: TFone;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    PageControl2: TPageControl;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    cmbTipoEmissao: TComboBox;
    Label13: TLabel;
    gpbAliquotas: TGroupBox;
    edtCreditoSN: TDBCurrencyEdit;
    edtIcms: TDBCurrencyEdit;
    edtCofins: TDBCurrencyEdit;
    edtPis: TDBCurrencyEdit;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    edtHost: TEdit;
    edtPort: TCurrencyEdit;
    Label19: TLabel;
    edtUser: TEdit;
    Label20: TLabel;
    edtPassword: TEdit;
    Label21: TLabel;
    edtAssunto: TEdit;
    Label22: TLabel;
    Label23: TLabel;
    memoMensagem: TMemo;
    rgpRegime: TRadioGroup;
    edtCodigoToken: TCurrencyEdit;
    Label26: TLabel;
    edtToken: TEdit;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    cmbFormaEmissao: TComboBox;
    cmbVersaoDF: TComboBox;
    spnIntervaloTentativas: TSpinEdit;
    spnNumTentativas: TSpinEdit;
    Label31: TLabel;
    Label32: TLabel;
    rgpVisualizaImpressao: TRadioGroup;
    rgpViaConsumidor: TRadioGroup;
    rgpImprimeItens: TRadioGroup;
    cdsCODIGO: TIntegerField;
    cdsRAZAO: TStringField;
    edtDataCadastro: TEdit;
    Label33: TLabel;
    Label9: TLabel;
    edtCertificado: TEdit;
    Label10: TLabel;
    edtSenhaNFe: TEdit;
    btnCertificadoNFe: TSpeedButton;
    Label30: TLabel;
    cmbAmbiente: TComboBox;
    edtIe: TEdit;
    edtCodigoEndereco: TCurrencyEdit;
    cdsFANTASIA: TStringField;
    cdsCPF_CNPJ: TStringField;
    cdsENDERECO: TStringField;
    cdsCIDADE: TStringField;
    cdsFONE: TStringField;
    cdsCELULAR: TStringField;
    memoObsGeradaSistema: TMemo;
    BitBtn1: TBitBtn;
    Label11: TLabel;
    cmbModeloImpressao: TComboBox;
    rgpImpComprovante: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure edtIeKeyPress(Sender: TObject; var Key: Char);
    procedure PageControl1Change(Sender: TObject);
    procedure btnCertificadoNFeClick(Sender: TObject);
    procedure edtCreditoSNChange(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Altera um registro existente no CDS de consulta }
    procedure AlterarRegistroNoCDS(Registro :TObject); override;

    { Carrega todos os registros pra aba de Consulta }
    procedure CarregarDados;                           override;

    procedure ExecutarDepoisAlterar;                   override;
    procedure ExecutarDepoisIncluir;                   override;

    { Inclui um registro no CDS }
    procedure IncluirRegistroNoCDS(Registro :TObject); override;

    { Limpa as informações da aba Dados }
    procedure LimparDados;                             override;

    { Mostra um registro detalhado na aba de Dados   }
    procedure MostrarDados;                            override;

  private
    FCodigoNCM: integer;

    { Persiste os dados no banco de dados }
    function GravarDados   :TObject;                   override;

    { Verifica os dados antes de persistir }
    function VerificaDados :Boolean;                   override;
  end;

var
  frmCadastroDadosEmpresa: TfrmCadastroDadosEmpresa;

implementation

uses Pessoa, Repositorio, FabricaRepositorio, Funcoes, Empresa, ExcecaoParametroInvalido, repositorioEmpresa, GeradorNFe, uModulo;

{$R *.dfm}

{ TfrmCadastroDadosEmpresa }

procedure TfrmCadastroDadosEmpresa.AlterarRegistroNoCDS(Registro: TObject);
var
  Empresa :TEmpresa;
begin
  inherited;

  Empresa := (Registro as TEmpresa);

  self.cds.Edit;
  self.cdsCODIGO.AsInteger      := Empresa.CodigoEmpresa;
  self.cdsRAZAO.AsString        := Empresa.razao;
  self.cdsFANTASIA.AsString     := Empresa.nome_fantasia;
  self.cdsCPF_CNPJ.AsString     := Empresa.cpf_cnpj;
  self.cdsENDERECO.AsString     := Empresa.Endereco.logradouro + ', '+ Empresa.Endereco.numero;
  self.cdsCIDADE.AsString       := Empresa.Endereco.Cidade.nome + ' / '+ Empresa.Endereco.Cidade.Estado.sigla;
  self.cdsFONE.AsString         := Empresa.fone1;
  self.cdsCELULAR.AsString      := Empresa.fone2;
  self.cds.Post;
end;

procedure TfrmCadastroDadosEmpresa.BitBtn1Click(Sender: TObject);
begin
  memoObsGeradaSistema.Clear;
end;

procedure TfrmCadastroDadosEmpresa.btnCertificadoNFeClick(Sender: TObject);
var
  GeradorNFe :TGeradorNFe;
begin
   GeradorNFe := nil;

   try
     GeradorNFe               := TGeradorNFe.Create;
     self.edtCertificado.Text := GeradorNFe.ObterCertificado;
   finally
     FreeAndNil(GeradorNFe);
   end;
end;

procedure TfrmCadastroDadosEmpresa.CarregarDados;
var
  Empresas    :TObjectList;
  Repositorio :TRepositorio;
  nX          :Integer;
begin
  inherited;

  Repositorio := nil;
  Empresas    := nil;

  try
    Repositorio := TFabricaRepositorio.GetRepositorio(TEmpresa.ClassName);
    Empresas    := Repositorio.GetAll;

    if Assigned(Empresas) and (Empresas.Count > 0) then begin

       for nX := 0 to (Empresas.Count-1) do
         self.IncluirRegistroNoCDS(Empresas.Items[nX]);

    end;
  finally
    FreeAndNil(Repositorio);
    FreeAndNil(Empresas);
  end;
end;

procedure TfrmCadastroDadosEmpresa.edtCreditoSNChange(Sender: TObject);
begin
  memoObsGeradaSistema.Text :=
  'DOCUMENTO EMITIDO POR ME OU EPP OPTANTE PELO SIMPLES NACIONAL NAO GERA DIREITO A CREDITO FISCAL DE IPI. '                     +
  'PERMITE O APROVEITAMENTO DO CREDITO DE ICMS NO VALOR DE '+ FormatFloat('R$ ,0.00;R$ -,0.00', self.edtCreditoSN.Value)+' '+
  'CORRESPONDENTE A ALÍQUOTA DE '+FormatFloat('#0.00%', self.edtCreditoSN.Value)+', NOS TERMOS DO ART.23 DA '            +
  'LC 123/2006 VLR. DO ICMS DESTACADO EM S/NF = '+FormatFloat('R$ ,0.00;R$ -,0.00', self.edtCreditoSN.Value);
end;

procedure TfrmCadastroDadosEmpresa.edtIeKeyPress(Sender: TObject; var Key: Char);
begin
  If not( key in['0'..'9',#08] ) then
    key:=#0;
end;

procedure TfrmCadastroDadosEmpresa.ExecutarDepoisAlterar;
begin
  inherited;
  edtRazao.SetFocus;
end;

procedure TfrmCadastroDadosEmpresa.ExecutarDepoisIncluir;
begin
  inherited;
  edtRazao.SetFocus;
end;

procedure TfrmCadastroDadosEmpresa.FormCreate(Sender: TObject);
begin
  inherited;
  CpfCnpj.pessoa := 'J';
end;

function TfrmCadastroDadosEmpresa.GravarDados: TObject;
var
  Empresa        :TEmpresa;
  Repositorio    :TRepositorio;
begin
   Empresa            := nil;
   Repositorio  := nil;

   try
     Repositorio   := TFabricaRepositorio.GetRepositorio(TEmpresa.ClassName);
     Empresa       := TEmpresa(Repositorio.Get(StrToIntDef(self.edtCodigo.Text, 0)));

     if not Assigned(Empresa) then
      Empresa := TEmpresa.Create;

     Empresa.razao                  := self.edtRazao.Text;
     Empresa.nome_fantasia          := edtFantasia.Text;
     Empresa.pessoa                 := 'J';
     Empresa.cpf_cnpj               := CpfCnpj.edtCpf.Text;
     Empresa.rg_ie                  := edtIe.Text;
     Empresa.dtcadastro             := StrToDate(edtDataCadastro.Text);
     Empresa.fone1                  := Fone1.Fone;
     Empresa.fone2                  := Fone2.Fone;
     Empresa.email                  := edtEmail.Text;

     { Configurações NF }
     try
       Empresa.AdicionarConfiguracoesNFe(edtCreditoSN.Value, edtIcms.Value,
                                         edtPis.Value, edtCofins.Value,
                                         edtCertificado.Text, cmbAmbiente.Items[cmbAmbiente.ItemIndex][1],
                                         self.edtSenhaNFe.Text,
                                         StrToInt(copy(cmbTipoEmissao.Items[cmbTipoEmissao.ItemIndex],1,1)),
                                         rgpRegime.ItemIndex,
                                         memoObsGeradaSistema.Text);

       Empresa.ConfiguracoesNF.AdicionarConfiguracoesNFCe(StrToInt(copy(cmbFormaEmissao.Items[cmbFormaEmissao.ItemIndex],1,1))-1,
                                                          spnIntervaloTentativas.Value,
                                                          spnNumTentativas.Value,
                                                          cmbVersaoDF.ItemIndex,
                                                          edtCodigoToken.text,
                                                          edtToken.Text,
                                                          rgpVisualizaImpressao.Items[rgpVisualizaImpressao.ItemIndex][1],
                                                          rgpViaConsumidor.Items[rgpViaConsumidor.ItemIndex][1],
                                                          rgpImprimeItens.Items[rgpImprimeItens.ItemIndex][1],
                                                          cmbModeloImpressao.ItemIndex,
                                                          rgpImpComprovante.Items[rgpImpComprovante.ItemIndex][1]);
     except
       on E: Exception do begin
          if (Pos('AmbienteNFe', e.Message) > 0) then begin
            self.cmbAmbiente.SetFocus;
            raise Exception.Create('Ambiente é um campo obrigatório!');
          end;
       end;
     end;

     { Configurações E-mail }
     Empresa.AdicionarConfiguracoesEmail(self.edtHost.Text,
                                         self.edtPort.Text,
                                         self.edtUser.Text,
                                         self.edtPassword.Text,
                                         self.edtAssunto.Text,
                                         self.memoMensagem.Text);

     { Endereço }
     Empresa.adicionaEndereco(edtLogradouro.Text,
                              edtNumero.Text,
                              edtBairro.Text,
                              edtCEP.Text,
                              edtComplento.Text,
                              BuscaCidade1.Cidade.codibge,
                              edtCodigoEndereco.AsInteger);

     Repositorio.Salvar(Empresa);

     result := Empresa;

     dm.Empresa.Free;
     dm.Empresa := nil;

   finally
     FreeAndNil(Repositorio);
   end;
end;

procedure TfrmCadastroDadosEmpresa.IncluirRegistroNoCDS(Registro: TObject);
var
  Empresa :TEmpresa;
begin
  inherited;

  Empresa := (Registro as TEmpresa);

  self.cds.Append;
  self.cdsCODIGO.AsInteger            := Empresa.codigoEmpresa;
  self.cdsRAZAO.AsString              := Empresa.razao;
  self.cdsFANTASIA.AsString     := Empresa.nome_fantasia;
  self.cdsCPF_CNPJ.AsString     := Empresa.cpf_cnpj;
  self.cdsENDERECO.AsString     := Empresa.Endereco.logradouro + ', '+ Empresa.Endereco.numero;
  self.cdsCIDADE.AsString       := Empresa.Endereco.Cidade.nome + ' / '+Empresa.Endereco.Cidade.Estado.sigla;
  self.cdsFONE.AsString         := Empresa.fone1;
  self.cdsCELULAR.AsString      := Empresa.fone2;
  self.cds.Post;
end;

procedure TfrmCadastroDadosEmpresa.LimparDados;
begin
  inherited;
  edtCodigo.Clear;
  edtRazao.Clear;
  edtFantasia.Clear;
  CpfCnpj.edtCpf.Clear;
  edtIe.Clear;
  edtDataCadastro.Text := DateToStr(Date);
  Fone1.limpa;
  Fone2.limpa;
  edtEmail.Clear;
  edtCodigoEndereco.Clear;
  edtLogradouro.Clear;
  edtNumero.Clear;
  edtBairro.Clear;
  BuscaCidade1.limpa;
  edtCEP.Clear;
  edtComplento.Clear;
  rgpRegime.ItemIndex := -1;
  edtCertificado.Clear;
  edtSenhaNFe.Clear;
  cmbAmbiente.ItemIndex := 0;
  cmbTipoEmissao.ItemIndex := 0;
  edtCreditoSN.Clear;
  edtIcms.Clear;
  edtPis.Clear;
  edtCofins.Clear;
  edtCodigoToken.Clear;
  edtToken.Clear;
  cmbFormaEmissao.ItemIndex := 0;
  cmbVersaoDF.ItemIndex := 0;
  spnIntervaloTentativas.Value := 1000;
  spnNumTentativas.Value := 4;
  rgpVisualizaImpressao.ItemIndex := 0;
  rgpViaConsumidor.ItemIndex := 0;
  rgpImprimeItens.ItemIndex := 0;
  edtHost.Clear;
  edtPort.Clear;
  edtUser.Clear;
  edtPassword.Clear;
  edtAssunto.Clear;
  memoMensagem.Clear;
  memoObsGeradaSistema.Clear;
  cmbModeloImpressao.ItemIndex := 0;
  rgpImprimeItens.ItemIndex := 1;
end;

procedure TfrmCadastroDadosEmpresa.MostrarDados;
var
  Empresa                             :TEmpresa;
  RepositorioPessoa                   :TRepositorio;
begin
  inherited;

  Empresa                              := nil;
  RepositorioPessoa                   := nil;

  try
    RepositorioPessoa  := TFabricaRepositorio.GetRepositorio(TEmpresa.ClassName);
    Empresa             := TEmpresa(RepositorioPessoa.Get(self.cdsCODIGO.AsInteger));

    if not Assigned(Empresa) then exit;

    edtCodigo.AsInteger         := Empresa.CodigoEmpresa;
    edtRazao.Text               := Empresa.razao;
    edtFantasia.Text            := Empresa.nome_fantasia;
    CpfCnpj.edtCpf.Text         := Empresa.cpf_cnpj;
    edtIe.Text                  := Empresa.rg_ie;
    edtDataCadastro.Text        := DateToStr(Empresa.dtcadastro);
    Fone1.Fone                  := Empresa.fone1;
    Fone2.Fone                  := Empresa.fone2;
    edtEmail.Text               := Empresa.email;

    { Configurações NF }
    if Assigned(Empresa.ConfiguracoesNF) then begin
      self.edtCertificado.Text    := Empresa.ConfiguracoesNF.num_certificado;
      self.edtSenhaNFe.Text       := Empresa.ConfiguracoesNF.senha_certificado;
      self.rgpRegime.ItemIndex    := Empresa.ConfiguracoesNF.CRT;

      if (Empresa.ConfiguracoesNF.ambiente_nfe = 'P') then
        self.cmbAmbiente.ItemIndex := 0
      else
        self.cmbAmbiente.ItemIndex := 1;

      self.cmbTipoEmissao.ItemIndex := IfThen(Empresa.ConfiguracoesNF.Tipo_emissao = 1, 0, 1);

      self.edtCreditoSN.Value   := Empresa.ConfiguracoesNF.aliq_cred_sn;
      self.edtIcms.Value        := Empresa.ConfiguracoesNF.aliq_icms;
      self.edtPis.Value         := Empresa.ConfiguracoesNF.aliq_pis;
      self.edtCofins.Value      := Empresa.ConfiguracoesNF.aliq_cofins;
      memoObsGeradaSistema.Text := Empresa.ConfiguracoesNF.ObsGeradaPeloSistema;

      { Configurações NFCe }
      if Assigned(Empresa.ConfiguracoesNF.ParametrosNFCe) then begin
        edtCodigoToken.Text             := Empresa.ConfiguracoesNF.ParametrosNFCe.id_token;
        edtToken.Text                   := Empresa.ConfiguracoesNF.ParametrosNFCe.token;
        cmbFormaEmissao.ItemIndex       := IfThen(Empresa.ConfiguracoesNF.ParametrosNFCe.forma_emissao = 0, 0, 1);
        cmbVersaoDF.ItemIndex           := Empresa.ConfiguracoesNF.ParametrosNFCe.versao_df;
        spnIntervaloTentativas.Value    := Empresa.ConfiguracoesNF.ParametrosNFCe.intervalo_tentativas;
        spnNumTentativas.Value          := Empresa.ConfiguracoesNF.ParametrosNFCe.tentativas;
        rgpVisualizaImpressao.ItemIndex := IfThen(Empresa.ConfiguracoesNF.ParametrosNFCe.visualiza_impressao,0,1);
        rgpViaConsumidor.ItemIndex      := IfThen(Empresa.ConfiguracoesNF.ParametrosNFCe.via_consumidor,0,1);
        rgpImprimeItens.ItemIndex       := IfThen(Empresa.ConfiguracoesNF.ParametrosNFCe.imprime_itens,0,1);
        cmbModeloImpressao.ItemIndex    := Empresa.ConfiguracoesNF.ParametrosNFCe.leiaute_impressao;
        rgpImpComprovante.ItemIndex     := IfThen(Empresa.ConfiguracoesNF.ParametrosNFCe.imp_comp_pedido,0,1);
      end;
    end;

    { Configurações de E-mail }
    if Assigned(Empresa.ConfiguracoesEmail) then begin
       self.edtHost.Text          := Empresa.ConfiguracoesEmail.smtp_host;
       self.edtPort.Text          := Empresa.ConfiguracoesEmail.smtp_port;
       self.edtUser.Text          := Empresa.ConfiguracoesEmail.smtp_user;
       self.edtPassword.Text      := Empresa.ConfiguracoesEmail.smtp_password;
       self.edtAssunto.Text       := Empresa.ConfiguracoesEmail.Assunto;
       self.memoMensagem.Text     := Empresa.ConfiguracoesEmail.mensagem.Text;
    end;

    {Endereco}
    if Assigned(Empresa.Endereco) then
    begin
      edtCodigoEndereco.AsInteger  := Empresa.Endereco.codigo;
      edtLogradouro.Text           := Empresa.Endereco.logradouro;
      edtNumero.Text               := Empresa.Endereco.numero;
      edtBairro.Text               := Empresa.Endereco.bairro;
      edtCEP.Text                  := Empresa.Endereco.cep;
      BuscaCidade1.codigo          := Empresa.Endereco.codcidade;
      edtComplento.Text            := Empresa.Endereco.complemento;
    end;

  finally
    FreeAndNil(RepositorioPessoa);
    FreeAndNil(Empresa);
  end;
end;

procedure TfrmCadastroDadosEmpresa.PageControl1Change(Sender: TObject);
begin
  if PageControl1.ActivePageIndex = 1 then
     edtHost.SetFocus;
end;

function TfrmCadastroDadosEmpresa.VerificaDados: Boolean;
begin
  result := false;

  if trim(edtRazao.Text) = '' then begin
    avisar(1,'Favor informar a razão social da empresa.'+#13#10+'Favor informar a razão social da empresa.'+#13#10+'Favor informar a razão social da empresa.'+#13#10);
    edtRazao.SetFocus;
  end
  else if apenasNumeros(CpfCnpj.edtCpf.Text) = '' then begin
    avisar(1,'Favor informar a razão social da empresa.');
    CpfCnpj.edtCpf.SetFocus;
  end
  else if apenasNumeros(edtIe.Text) = '' then begin
    avisar(1,'Favor informar a inscrição estadual da empresa.');
    edtIe.SetFocus;
  end
  else if rgpRegime.ItemIndex < 0 then begin
    avisar(1,'Favor informar o regime tributário no qual a empresa se enquadra.');
    PageControl1.ActivePageIndex := 0;
    PageControl2.ActivePageIndex := 0;
    rgpRegime.SetFocus;
  end
  else if edtLogradouro.Text = '' then begin
    avisar(1,'Favor informar a Rua/Logradouro.');
    edtLogradouro.SetFocus;
  end
  else if edtNumero.Text = '' then begin
    avisar(1,'Favor informar o Número.');
    edtNumero.SetFocus;
  end
  else if edtBairro.Text = '' then begin
    avisar(1,'Favor informar o Bairro.');
    edtBairro.SetFocus;
  end
  else if BuscaCidade1.edtCidade.Text = '' then begin
    avisar(1,'Favor informar a Cidade.');
    BuscaCidade1.edtCodCid.SetFocus;
  end
  else
    result := true;
end;

end.
