unit uCadastroCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, contNrs, System.StrUtils,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroPadrao, Data.DB, Datasnap.DBClient, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, DBGridCBN,
  Vcl.ComCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Mask, frameBuscaCidade, frameMaskCpfCnpj, frameFone, RxToolEdit, RxCurrEdit;

type
  TfrmCadastroCliente = class(TfrmCadastroPadrao)
    gpbEmail: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    Label15: TLabel;
    DBGrid1: TDBGrid;
    btnCancela: TBitBtn;
    edtEmail: TEdit;
    btnConfirma: TBitBtn;
    gpbContato: TGroupBox;
    Fone1: TFone;
    Fone2: TFone;
    gpbDados: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    lbRgIe: TLabel;
    Label33: TLabel;
    lbIE: TLabel;
    edtRazao: TEdit;
    edtFantasia: TEdit;
    CpfCnpj: TMaskCpfCnpj;
    edtDataCadastro: TEdit;
    edtIe: TEdit;
    gpbEndereco: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label12: TLabel;
    Label8: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    edtLogradouro: TEdit;
    edtNumero: TEdit;
    edtBairro: TEdit;
    BuscaCidade1: TBuscaCidade;
    edtComplento: TEdit;
    edtCEP: TMaskEdit;
    dsEmails: TDataSource;
    cdsEmails: TClientDataSet;
    cdsEmailsEMAIL: TStringField;
    edtCodigo: TCurrencyEdit;
    cdsCODIGO: TIntegerField;
    cdsRAZAO: TStringField;
    Label17: TLabel;
    edtCodigoEndereco: TCurrencyEdit;
    cdsFANTASIA: TStringField;
    cdsCPF_CNPJ: TStringField;
    cdsENDERECO: TStringField;
    cdsCIDADE: TStringField;
    cdsFONE: TStringField;
    cdsCELULAR: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure edtEmailChange(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CpfCnpjedtCpfChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
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
    { Persiste os dados no banco de dados }
    function GravarDados   :TObject;                   override;

    { Verifica os dados antes de persistir }
    function VerificaDados :Boolean;                   override;

  private
    function concatenaEmails :String;
    procedure carregaEmails(emails :String);

  public
    FSemConsumidor :Boolean;
  end;

var
  frmCadastroCliente: TfrmCadastroCliente;

implementation

uses Pessoa, Cliente, repositorio, fabricaRepositorio, funcoes;

{$R *.dfm}

{ TfrmCadastroCliente }

procedure TfrmCadastroCliente.AlterarRegistroNoCDS(Registro: TObject);
var
  Cliente :TPessoa;
begin
  inherited;

  Cliente := (Registro as TPessoa);

  self.cds.Edit;
  self.cdsCODIGO.AsInteger      := Cliente.codigo;
  self.cdsRAZAO.AsString        := Cliente.razao;
  self.cdsFANTASIA.AsString     := Cliente.nome_fantasia;
  self.cdsCPF_CNPJ.AsString     := Cliente.cpf_cnpj;
  self.cdsENDERECO.AsString     := Cliente.Endereco.logradouro + ', '+ Cliente.Endereco.numero;
  self.cdsCIDADE.AsString       := Cliente.Endereco.Cidade.nome + ' / '+Cliente.Endereco.Cidade.Estado.sigla;
  self.cdsFONE.AsString         := Cliente.fone1;
  self.cdsCELULAR.AsString      := Cliente.fone2;
  self.cds.Post;
end;

procedure TfrmCadastroCliente.btnCancelaClick(Sender: TObject);
begin
  inherited;
  edtEmail.Clear;
  btnCancela.Enabled := false;
  cdsEmails.Cancel;
end;

procedure TfrmCadastroCliente.btnConfirmaClick(Sender: TObject);
begin
  if pos('@',edtEmail.Text) = 0 then
  begin
    avisar(1,'Favor informar um e-mail válido');
    edtEmail.SetFocus;
    exit;
  end;

  if not (cdsEmails.State in [dsInsert, dsEdit]) then
    cdsEmails.Append;

  cdsEmailsEMAIL.Text := edtEmail.Text;
  cdsEmails.Post;

  btnCancela.Click;
end;

procedure TfrmCadastroCliente.carregaEmails(emails: String);
begin
  while emails <> '' do begin
    cdsEmails.Append;
    cdsEmailsEMAIL.AsString := copy( emails, 1, ( pos( ';', emails ) -1 ) );
    cdsEmails.Post;

    emails := trim( copy( emails, (pos(';',emails) +1), length(emails) ) );
  end;
end;

procedure TfrmCadastroCliente.CarregarDados;
var
  Clientes     :TObjectList;
  Repositorio  :TRepositorio;
  nX           :Integer;
begin
  inherited;

  Repositorio := nil;
  Clientes    := nil;

  try
    Repositorio     := TFabricaRepositorio.GetRepositorio(TCliente.ClassName);
    Clientes    := Repositorio.GetAll;

    if Assigned(Clientes) and (Clientes.Count > 0) then begin

       for nX := 0 to (Clientes.Count-1) do
         if not FSemConsumidor or (FSemConsumidor and ((TCliente(Clientes.Items[nX])).codigo > 1))then
           self.IncluirRegistroNoCDS(Clientes.Items[nX]);

    end;
  finally
    FreeAndNil(Repositorio);
    FreeAndNil(Clientes);
  end;
end;

function TfrmCadastroCliente.concatenaEmails: String;
begin
  Result := '';

  if not (cdsEmails.Active) or (cdsEmails.IsEmpty) then
    exit;

  cdsEmails.First;
  while not cdsEmails.Eof do begin
    Result := Result + cdsEmailsEMAIL.AsString + ';';

    cdsemails.Next;
  end;
end;

procedure TfrmCadastroCliente.CpfCnpjedtCpfChange(Sender: TObject);
begin
  inherited;
  lbIE.Visible   := (CpfCnpj.pessoa = 'J');
  edtIE.Visible  := (CpfCnpj.pessoa = 'J');
  lbRgIe.Caption := IfThen(CpfCnpj.pessoa = 'J','IE','RG');
  lbRgIe.Visible := (CpfCnpj.pessoa = 'J');
end;

procedure TfrmCadastroCliente.DBGrid1DblClick(Sender: TObject);
begin
  edtEmail.Text := cdsEmailsEMAIL.AsString;
  cdsEmails.Edit;
  edtEmail.SetFocus;
  btnCancela.Enabled := true;
end;

procedure TfrmCadastroCliente.DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = VK_DELETE then
    if not cdsEmails.IsEmpty then
       cdsEmails.Delete;
end;

procedure TfrmCadastroCliente.edtEmailChange(Sender: TObject);
begin
  btnConfirma.Enabled := (pos('@',edtEmail.Text) > 0);
end;

procedure TfrmCadastroCliente.ExecutarDepoisAlterar;
begin
  inherited;
  edtRazao.SetFocus;
end;

procedure TfrmCadastroCliente.ExecutarDepoisIncluir;
begin
  inherited;
  edtRazao.SetFocus;
end;

procedure TfrmCadastroCliente.FormCreate(Sender: TObject);
begin
  inherited;
  CpfCnpj.pessoa := 'F';
  cdsEmails.CreateDataSet;
  FSemConsumidor := false;
end;

procedure TfrmCadastroCliente.FormShow(Sender: TObject);
begin
  inherited;
  cds.Filtered := false;
  if self.FSemConsumidor then
  begin
    cds.Filter   := 'CODIGO > 1';
    cds.Filtered := true;
  end;
end;

function TfrmCadastroCliente.GravarDados: TObject;
var
  Cliente        :TCliente;
  Repositorio    :TRepositorio;
begin
   Cliente            := nil;
   Repositorio  := nil;

   try
     Repositorio   := TFabricaRepositorio.GetRepositorio(TCliente.ClassName);
     Cliente       := TCliente(Repositorio.Get(StrToIntDef(self.edtCodigo.Text, 0)));

     if not Assigned(Cliente) then
      Cliente := TCliente.Create;

     Cliente.razao                  := self.edtRazao.Text;
     Cliente.nome_fantasia          := edtFantasia.Text;
     Cliente.pessoa                 := CpfCnpj.pessoa;
     Cliente.cpf_cnpj               := CpfCnpj.edtCpf.Text;
     Cliente.rg_ie                  := edtIe.Text;
     Cliente.dtcadastro             := StrToDate(edtDataCadastro.Text);
     Cliente.fone1                  := Fone1.Fone;
     Cliente.fone2                  := Fone2.Fone;
     Cliente.email                  := concatenaEmails;

     { Endereço }
     Cliente.adicionaEndereco(edtLogradouro.Text,
                              edtNumero.Text,
                              edtBairro.Text,
                              edtCEP.Text,
                              edtComplento.Text,
                              BuscaCidade1.Cidade.codibge,
                              edtCodigoEndereco.AsInteger);

     Repositorio.Salvar(Cliente);

     result := Cliente;

   finally
     FreeAndNil(Repositorio);
   end;
end;

procedure TfrmCadastroCliente.IncluirRegistroNoCDS(Registro: TObject);
var
  Cliente :TPessoa;
begin
  inherited;

  Cliente := (Registro as TPessoa);

  self.cds.Append;
  self.cdsCODIGO.AsInteger      := Cliente.codigo;
  self.cdsRAZAO.AsString        := Cliente.razao;
  self.cdsFANTASIA.AsString     := Cliente.nome_fantasia;
  self.cdsCPF_CNPJ.AsString     := Cliente.cpf_cnpj;

  if assigned(Cliente.Endereco) then
  begin
    self.cdsENDERECO.AsString     := Cliente.Endereco.logradouro + ', '+ Cliente.Endereco.numero;
    self.cdsCIDADE.AsString       := Cliente.Endereco.Cidade.nome + ' / '+Cliente.Endereco.Cidade.Estado.sigla;
  end;
  self.cdsFONE.AsString         := Cliente.fone1;
  self.cdsCELULAR.AsString      := Cliente.fone2;
  self.cds.Post;
end;

procedure TfrmCadastroCliente.LimparDados;
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
  edtLogradouro.Clear;
  edtNumero.Clear;
  edtBairro.Clear;
  BuscaCidade1.limpa;
  edtCEP.Clear;
  edtComplento.Clear;
  btnCancela.Click;
  cdsEmails.EmptyDataSet;
end;

procedure TfrmCadastroCliente.MostrarDados;
var
  Cliente                             :TPessoa;
  RepositorioPessoa                   :TRepositorio;
begin
  inherited;

  Cliente                              := nil;
  RepositorioPessoa                   := nil;

  try
    RepositorioPessoa  := TFabricaRepositorio.GetRepositorio(TPessoa.ClassName);
    Cliente             := TPessoa(RepositorioPessoa.Get(self.cdsCODIGO.AsInteger));

    if not Assigned(Cliente) then exit;

    edtCodigo.AsInteger         := Cliente.codigo;
    edtRazao.Text               := Cliente.razao;
    edtFantasia.Text            := Cliente.nome_fantasia;
    CpfCnpj.pessoa              := Cliente.pessoa;
    CpfCnpj.edtCpf.Text         := Cliente.cpf_cnpj;
    edtIe.Text                  := Cliente.rg_ie;
    edtDataCadastro.Text        := DateToStr(Cliente.dtcadastro);
    Fone1.Fone                  := Cliente.fone1;
    Fone2.Fone                  := Cliente.fone2;
    carregaEmails(Cliente.email);

    {Endereco}
    if Assigned(Cliente.Endereco) then
    begin
      edtCodigoEndereco.AsInteger  := Cliente.Endereco.codigo;
      edtLogradouro.Text           := Cliente.Endereco.logradouro;
      edtNumero.Text               := Cliente.Endereco.numero;
      edtBairro.Text               := Cliente.Endereco.bairro;
      edtCEP.Text                  := Cliente.Endereco.cep;
      BuscaCidade1.codigo          := Cliente.Endereco.codcidade;
      edtComplento.Text            := Cliente.Endereco.complemento;
    end;

  finally
    FreeAndNil(RepositorioPessoa);
    FreeAndNil(Cliente);
  end;
end;

function TfrmCadastroCliente.VerificaDados: Boolean;
begin
  if trim(edtRazao.Text) = '' then begin
    avisar(1,'Favor informar a razão social da empresa.'+#13#10+'Favor informar a razão social da empresa.'+#13#10+'Favor informar a razão social da empresa.'+#13#10);
    edtRazao.SetFocus;
  end
  else if apenasNumeros(CpfCnpj.edtCpf.Text) = '' then begin
    avisar(1,'Favor informar a razão social da empresa.');
    CpfCnpj.edtCpf.SetFocus;
  end
  else if (CpfCnpj.pessoa = 'J') and (TRIM(edtIe.Text) = '') then begin
    avisar(1,'Favor informar a inscrição estadual.');
    edtIe.SetFocus;
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
