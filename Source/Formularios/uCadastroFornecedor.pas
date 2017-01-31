unit uCadastroFornecedor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroPadrao, Data.DB, Vcl.Mask, frameBuscaCidade, frameFone, frameMaskCpfCnpj, Vcl.StdCtrls,
  Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids, DBGridCBN, Vcl.ComCtrls, Vcl.Buttons, Vcl.ExtCtrls, ContNrs, RxToolEdit, RxCurrEdit, Vcl.DBCtrls;

type
  TfrmCadastroFornecedor = class(TfrmCadastroPadrao)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label33: TLabel;
    edtRazao: TEdit;
    edtFantasia: TEdit;
    CpfCnpj: TMaskCpfCnpj;
    edtDataCadastro: TEdit;
    edtIe: TEdit;
    GroupBox3: TGroupBox;
    Fone1: TFone;
    Fone2: TFone;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label12: TLabel;
    edtLogradouro: TEdit;
    edtNumero: TEdit;
    edtBairro: TEdit;
    BuscaCidade1: TBuscaCidade;
    edtComplento: TEdit;
    edtCEP: TMaskEdit;
    cdsCODIGO: TIntegerField;
    cdsRAZAO: TStringField;
    edtCodigo: TCurrencyEdit;
    GroupBox7: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    DBGrid1: TDBGrid;
    dsEmails: TDataSource;
    cdsEmails: TClientDataSet;
    cdsEmailsEMAIL: TStringField;
    Label8: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label16: TLabel;
    btnCancela: TBitBtn;
    edtEmail: TEdit;
    btnConfirma: TBitBtn;
    Label15: TLabel;
    edtCodigoEndereco: TCurrencyEdit;
    procedure DBGrid1DblClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure edtEmailChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure pgGeralChange(Sender: TObject);
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
  end;

var
  frmCadastroFornecedor: TfrmCadastroFornecedor;

implementation

uses Pessoa, repositorio, fabricaRepositorio, funcoes, Fornecedor;

{$R *.dfm}

{ TfrmCadastroFornecedor }

procedure TfrmCadastroFornecedor.AlterarRegistroNoCDS(Registro: TObject);
var
  Fornecedor :TPessoa;
begin
  inherited;

  Fornecedor := (Registro as TPessoa);

  self.cds.Edit;
  self.cdsCODIGO.AsInteger      := Fornecedor.codigo;
  self.cdsRAZAO.AsString        := Fornecedor.razao;
  self.cds.Post;
end;

function TfrmCadastroFornecedor.concatenaEmails: String;
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

procedure TfrmCadastroFornecedor.DBGrid1DblClick(Sender: TObject);
begin
  edtEmail.Text := cdsEmailsEMAIL.AsString;
  cdsEmails.Edit;
  edtEmail.SetFocus;
  btnCancela.Enabled := true;
end;

procedure TfrmCadastroFornecedor.DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = VK_DELETE then
    if not cdsEmails.IsEmpty then
       cdsEmails.Delete;
end;

procedure TfrmCadastroFornecedor.edtEmailChange(Sender: TObject);
begin
  btnConfirma.Enabled := (pos('@',edtEmail.Text) > 0);
end;

procedure TfrmCadastroFornecedor.btnCancelaClick(Sender: TObject);
begin
  inherited;
  edtEmail.Clear;
  btnCancela.Enabled := false;
  cdsEmails.Cancel;
end;

procedure TfrmCadastroFornecedor.btnConfirmaClick(Sender: TObject);
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

procedure TfrmCadastroFornecedor.carregaEmails(emails: String);
begin
  while emails <> '' do begin
    cdsEmails.Append;
    cdsEmailsEMAIL.AsString := copy( emails, 1, ( pos( ';', emails ) -1 ) );
    cdsEmails.Post;

    emails := trim( copy( emails, (pos(';',emails) +1), length(emails) ) );
  end;
end;

procedure TfrmCadastroFornecedor.CarregarDados;
var
  Fornecedores :TObjectList;
  Repositorio  :TRepositorio;
  nX           :Integer;
begin
  inherited;

  Repositorio := nil;
  Fornecedores    := nil;

  try
    Repositorio     := TFabricaRepositorio.GetRepositorio(TFornecedor.ClassName);
    Fornecedores    := Repositorio.GetAll;

    if Assigned(Fornecedores) and (Fornecedores.Count > 0) then begin

       for nX := 0 to (Fornecedores.Count-1) do
         self.IncluirRegistroNoCDS(Fornecedores.Items[nX]);

    end;
  finally
    FreeAndNil(Repositorio);
    FreeAndNil(Fornecedores);
  end;
end;

procedure TfrmCadastroFornecedor.ExecutarDepoisAlterar;
begin
  inherited;
  edtRazao.SetFocus;
end;

procedure TfrmCadastroFornecedor.ExecutarDepoisIncluir;
begin
  inherited;
  edtRazao.SetFocus;
end;

procedure TfrmCadastroFornecedor.FormCreate(Sender: TObject);
begin
  inherited;
  CpfCnpj.pessoa := 'J';
  cdsEmails.CreateDataSet;
end;

procedure TfrmCadastroFornecedor.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  avisar(1,'');
end;

procedure TfrmCadastroFornecedor.FormShow(Sender: TObject);
begin
  inherited;
  gridConsulta.SelectedIndex := 1;
end;

function TfrmCadastroFornecedor.GravarDados: TObject;
var
  Fornecedor        :TFornecedor;
  Repositorio       :TRepositorio;
begin
   Fornecedor            := nil;
   Repositorio  := nil;

   try
     Repositorio      := TFabricaRepositorio.GetRepositorio(TFornecedor.ClassName);
     Fornecedor       := TFornecedor(Repositorio.Get(StrToIntDef(self.edtCodigo.Text, 0)));

     if not Assigned(Fornecedor) then
      Fornecedor := TFornecedor.Create;

     Fornecedor.razao                  := self.edtRazao.Text;
     Fornecedor.nome_fantasia          := edtFantasia.Text;
     Fornecedor.pessoa                 := 'J';
     Fornecedor.cpf_cnpj               := CpfCnpj.edtCpf.Text;
     Fornecedor.rg_ie                  := edtIe.Text;
     Fornecedor.dtcadastro             := StrToDate(edtDataCadastro.Text);
     Fornecedor.fone1                  := Fone1.Fone;
     Fornecedor.fone2                  := Fone2.Fone;
     Fornecedor.email                  := concatenaEmails;

     { Endereço }
     Fornecedor.adicionaEndereco(edtLogradouro.Text,
                                 edtNumero.Text,
                                 edtBairro.Text,
                                 edtCEP.Text,
                                 edtComplento.Text,
                                 BuscaCidade1.Cidade.codibge,
                                 edtCodigoEndereco.AsInteger);

     Repositorio.Salvar(Fornecedor);

     result := Fornecedor;

   finally
     FreeAndNil(Repositorio);
   end;
end;

procedure TfrmCadastroFornecedor.IncluirRegistroNoCDS(Registro: TObject);
var
  Fornecedor :TPessoa;
begin
  inherited;

  Fornecedor := (Registro as TPessoa);

  self.cds.Append;
  self.cdsCODIGO.AsInteger            := Fornecedor.codigo;
  self.cdsRAZAO.AsString              := Fornecedor.razao;

  self.cds.Post;
end;

procedure TfrmCadastroFornecedor.LimparDados;
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
  edtCodigoEndereco.Clear;
  edtLogradouro.Clear;
  edtNumero.Clear;
  edtBairro.Clear;
  BuscaCidade1.limpa;
  edtCEP.Clear;
  edtComplento.Clear;
  btnCancela.Click;
  cdsEmails.EmptyDataSet;
end;

procedure TfrmCadastroFornecedor.MostrarDados;
var
  Fornecedor                             :TPessoa;
  RepositorioPessoa                   :TRepositorio;
begin
  inherited;

  Fornecedor                              := nil;
  RepositorioPessoa                   := nil;

  try
    RepositorioPessoa  := TFabricaRepositorio.GetRepositorio(TPessoa.ClassName);
    Fornecedor             := TPessoa(RepositorioPessoa.Get(self.ds.DataSet.FieldByName('CODIGO').AsInteger));//*f Fornecedor             := TPessoa(RepositorioPessoa.Get(self.cdsCODIGO.AsInteger));

    if not Assigned(Fornecedor) then exit;

    edtCodigo.AsInteger         := Fornecedor.codigo;
    edtRazao.Text               := Fornecedor.razao;
    edtFantasia.Text            := Fornecedor.nome_fantasia;
    CpfCnpj.edtCpf.Text         := Fornecedor.cpf_cnpj;
    edtIe.Text                  := Fornecedor.rg_ie;
    edtDataCadastro.Text        := DateToStr(Fornecedor.dtcadastro);
    Fone1.Fone                  := Fornecedor.fone1;
    Fone2.Fone                  := Fornecedor.fone2;
    carregaEmails(Fornecedor.email);

    {Endereco}
    if Assigned(Fornecedor.Endereco) then
    begin
      edtCodigoEndereco.AsInteger  := Fornecedor.Endereco.codigo;
      edtLogradouro.Text           := Fornecedor.Endereco.logradouro;
      edtNumero.Text               := Fornecedor.Endereco.numero;
      edtBairro.Text               := Fornecedor.Endereco.bairro;
      edtCEP.Text                  := Fornecedor.Endereco.cep;
      BuscaCidade1.codigo          := Fornecedor.Endereco.codcidade;
      edtComplento.Text            := Fornecedor.Endereco.complemento;
    end;

  finally
    FreeAndNil(RepositorioPessoa);
    FreeAndNil(Fornecedor);
  end;
end;

procedure TfrmCadastroFornecedor.pgGeralChange(Sender: TObject);
begin
  inherited;
  if pgGeral.TabIndex = 1 then //*f
    MostrarDados;

end;

function TfrmCadastroFornecedor.VerificaDados: Boolean;
begin
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
