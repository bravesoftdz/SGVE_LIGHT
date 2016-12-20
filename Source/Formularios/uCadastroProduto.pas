unit uCadastroProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, contNrs,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroPadrao, Data.DB, Datasnap.DBClient, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, DBGridCBN,
  Vcl.ComCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Mask, RxToolEdit, RxCurrEdit, frameBuscaNCMIbpt, Produto;

type
  TfrmCadastroProduto = class(TfrmCadastroPadrao)
    edtDescricao: TEdit;
    edtValor: TCurrencyEdit;
    Label1: TLabel;
    Label2: TLabel;
    BuscaNCM: TBuscaNCMIbpt;
    cmbUnidadeMedida: TComboBox;
    cdsCODIGO: TIntegerField;
    cdsDESCRICAO: TStringField;
    cdsVALOR: TFloatField;
    edtCodigo: TCurrencyEdit;
    edtCodigoBarras: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    cdsNCM: TStringField;
    cdsCFOP: TStringField;
    memoInfAdicionais: TMemo;
    Label8: TLabel;
    procedure edtCodigoBarrasKeyPress(Sender: TObject; var Key: Char);
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
  end;

var
  frmCadastroProduto: TfrmCadastroProduto;

implementation

uses Repositorio, FabricaRepositorio;

{$R *.dfm}

{ TfrmCadastroProduto }

procedure TfrmCadastroProduto.AlterarRegistroNoCDS(Registro: TObject);
var
  Produto :TProduto;
begin
  inherited;

  Produto := (Registro as TProduto);

  self.cds.Edit;
  self.cdsCODIGO.AsInteger    := Produto.codigo;
  self.cdsDESCRICAO.AsString  := Produto.descricao;
  self.cdsVALOR.AsFloat       := Produto.valor;
  self.cdsNCM.AsString        := Produto.NCMIbpt.ncm_ibpt;
  self.cdsCFOP.AsString       := Produto.NCMIbpt.cfop.cfop;
  self.cds.Post;
end;

procedure TfrmCadastroProduto.CarregarDados;
var
  Produtos    :TObjectList;
  Repositorio :TRepositorio;
  nX          :Integer;
begin
  inherited;

  Repositorio := nil;
  Produtos    := nil;

  try
    Repositorio := TFabricaRepositorio.GetRepositorio(TProduto.ClassName);
    Produtos    := Repositorio.GetAll;

    if Assigned(Produtos) and (Produtos.Count > 0) then begin

       for nX := 0 to (Produtos.Count-1) do
         self.IncluirRegistroNoCDS(Produtos.Items[nX]);

    end;
  finally
    FreeAndNil(Repositorio);
    FreeAndNil(Produtos);
  end;
end;

procedure TfrmCadastroProduto.edtCodigoBarrasKeyPress(Sender: TObject; var Key: Char);
begin
  If not( key in['0'..'9',#08] ) then
    key:=#0;
end;

procedure TfrmCadastroProduto.ExecutarDepoisAlterar;
begin
  inherited;
  edtDescricao.SetFocus;
end;

procedure TfrmCadastroProduto.ExecutarDepoisIncluir;
begin
  inherited;
  edtDescricao.SetFocus;
end;

function TfrmCadastroProduto.GravarDados: TObject;
var
  Produto             :TProduto;
  RepositorioProduto  :TRepositorio;
begin
   Produto             := nil;
   RepositorioProduto  := nil;

   try
     RepositorioProduto  := TFabricaRepositorio.GetRepositorio(TProduto.ClassName);
     Produto             := TProduto(RepositorioProduto.Get(StrToIntDef(self.edtCodigo.Text, 0)));

     if not Assigned(Produto) then
      Produto := TProduto.Create;

     Produto.Descricao      := self.edtDescricao.Text;
     Produto.Valor          := self.edtValor.Value;
     Produto.codigo_ibpt    := BuscaNCM.edtCodigo.AsInteger;
     Produto.codigo_barras  := edtCodigoBarras.Text;
     Produto.unidade_medida := cmbUnidadeMedida.Items[cmbUnidadeMedida.ItemIndex];
     Produto.inf_adicionais := memoInfAdicionais.Text;

     RepositorioProduto.Salvar(Produto);

     result := Produto;

   finally
     FreeAndNil(RepositorioProduto);
   end;
end;

procedure TfrmCadastroProduto.IncluirRegistroNoCDS(Registro: TObject);
var
  Produto :TProduto;
begin
  inherited;

  Produto := (Registro as TProduto);

  self.cds.Append;
  self.cdsCODIGO.AsInteger    := Produto.codigo;
  self.cdsDESCRICAO.AsString  := Produto.descricao;
  self.cdsVALOR.AsFloat       := Produto.valor;
  self.cdsNCM.AsString        := Produto.NCMIbpt.ncm_ibpt;
  self.cdsCFOP.AsString       := Produto.NCMIbpt.cfop.cfop;
  self.cds.Post;
end;

procedure TfrmCadastroProduto.LimparDados;
begin
  inherited;
  edtCodigo.Clear;
  edtDescricao.Clear;
  edtValor.Clear;
  cmbUnidadeMedida.ItemIndex := 0;
  edtCodigoBarras.Clear;
  BuscaNCM.limpa;
  memoInfAdicionais.Clear;
end;

procedure TfrmCadastroProduto.MostrarDados;
var
  Produto                              :TProduto;
  RepositorioProduto                   :TRepositorio;
begin
  inherited;

  Produto                              := nil;
  RepositorioProduto                   := nil;

  try
    RepositorioProduto  := TFabricaRepositorio.GetRepositorio(TProduto.ClassName);
    Produto             := TProduto(RepositorioProduto.Get(self.cdsCODIGO.AsInteger));

    if not Assigned(Produto) then exit;

    self.edtCodigo.AsInteger        := Produto.codigo;
    self.edtDescricao.Text          := Produto.descricao;
    self.edtValor.Value             := Produto.valor;
    self.edtCodigoBarras.Text       := Produto.codigo_barras;
    self.cmbUnidadeMedida.ItemIndex := cmbUnidadeMedida.Items.IndexOf(Produto.unidade_medida);
    BuscaNCM.codigo                 := Produto.codigo_ibpt;
    memoInfAdicionais.Text          := Produto.inf_adicionais;

  finally
    FreeAndNil(RepositorioProduto);
    FreeAndNil(Produto);
  end;
end;

function TfrmCadastroProduto.VerificaDados: Boolean;
begin
  result := false;

  if trim(edtDescricao.Text) = '' then begin
    avisar(1,'Favor informar uma descrição para o produto.');
    edtDescricao.SetFocus;
  end
  else if (BuscaNCM.edtCodigo.AsInteger <= 0) then
  begin
    avisar(1,'Favor informar o ncm do produto.');
    BuscaNCM.edtNCM.SetFocus;
  end
  else if (BuscaNCM.edtCodigo.AsInteger > 0) and ((BuscaNCM.edtCST.Text = '')or(BuscaNCM.edtCFOP.Text = '')) then
  begin
    avisar(1,'O NCM selecionado deve possuir CFOP e CST/CSOSN vinculado.'+#13#10+'Favor Vincular.');
    BuscaNCM.edtNCM.SetFocus;
  end
  else
    result := true;
end;

end.
