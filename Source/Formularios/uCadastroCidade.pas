unit uCadastroCidade;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, System.Contnrs,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroPadrao, Data.DB, Datasnap.DBClient, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, DBGridCBN,
  Vcl.ComCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Mask, RxToolEdit, RxCurrEdit;

type
  TfrmCadastroCidade = class(TfrmCadastroPadrao)
    cdsCODIGO: TIntegerField;
    cdsCIDADE: TStringField;
    edtCidade: TEdit;
    Label1: TLabel;
    edtCodigo: TEdit;
    cmbUF: TComboBox;
    edtCodigoIBGE: TCurrencyEdit;
    Label2: TLabel;
    Label3: TLabel;
    cdsCODIGO_IBGE: TIntegerField;
    cdsUF: TStringField;
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
  frmCadastroCidade: TfrmCadastroCidade;

implementation

uses Cidade, repositorio, fabricaREpositorio, funcoes;

{$R *.dfm}

{ TfrmCadastroCidade }

procedure TfrmCadastroCidade.AlterarRegistroNoCDS(Registro: TObject);
var
  Cidade :TCidade;
begin
  inherited;

  Cidade := (Registro as TCidade);

  self.cds.Edit;
  self.cdsCODIGO.AsInteger      := Cidade.codigo;
  self.cdsCIDADE.AsString       := Cidade.nome;
  self.cdsCODIGO_IBGE.AsInteger := Cidade.codibge;
  self.cdsUF.AsString           := UfPorCodigoEstado(Cidade.codest);
  self.cds.Post;
end;

procedure TfrmCadastroCidade.CarregarDados;
var
  Cidades      :TObjectList;
  Repositorio  :TRepositorio;
  nX           :Integer;
begin
  inherited;

  Repositorio := nil;
  Cidades     := nil;

  try
    Repositorio := TFabricaRepositorio.GetRepositorio(TCidade.ClassName);
    Cidades     := Repositorio.GetAll;

    if Assigned(Cidades) and (Cidades.Count > 0) then begin

       for nX := 0 to (Cidades.Count-1) do
         self.IncluirRegistroNoCDS(Cidades.Items[nX]);

    end;
  finally
    FreeAndNil(Repositorio);
    FreeAndNil(Cidades);
  end;
end;

procedure TfrmCadastroCidade.ExecutarDepoisAlterar;
begin
  inherited;
  edtCodigoIBGE.SetFocus;
end;

procedure TfrmCadastroCidade.ExecutarDepoisIncluir;
begin
  inherited;
  edtCodigoIBGE.SetFocus;
end;

function TfrmCadastroCidade.GravarDados: TObject;
var
  Cidade       :TCidade;
  Repositorio  :TRepositorio;
begin
   Cidade       := nil;
   Repositorio  := nil;

   try
     Repositorio    := TFabricaRepositorio.GetRepositorio(TCidade.ClassName);
     Cidade         := TCidade(Repositorio.Get( StrToIntDef(self.edtCodigo.Text,0)));

     if not Assigned(Cidade) then
      Cidade := TCidade.Create;

     Cidade.nome    := TRIM( self.edtCidade.Text );
     Cidade.codibge := edtCodigoIBGE.AsInteger;
     Cidade.codest  := cmbUF.ItemIndex;

     Repositorio.Salvar(Cidade);

     result := Cidade;

   finally
     FreeAndNil(Repositorio);
   end;
end;

procedure TfrmCadastroCidade.IncluirRegistroNoCDS(Registro: TObject);
var
  Cidade :TCidade;
begin
  inherited;

  Cidade := (Registro as TCidade);

  self.cds.Append;
  self.cdsCODIGO.AsInteger      := Cidade.codigo;
  self.cdsCIDADE.AsString       := Cidade.nome;
  self.cdsCODIGO_IBGE.AsInteger := Cidade.codibge;
  self.cdsUF.AsString           := UfPorCodigoEstado(Cidade.codest);
  self.cds.Post;
end;

procedure TfrmCadastroCidade.LimparDados;
begin
  cmbUF.ItemIndex := 0;
  edtCodigo.Clear;
  edtCidade.Clear;
  edtCodigoIBGE.Clear;
end;

procedure TfrmCadastroCidade.MostrarDados;
var
  Cidade       :TCidade;
  Repositorio  :TRepositorio;
begin
  inherited;

  Cidade         := nil;
  Repositorio    := nil;

  try
    Repositorio := TFabricaRepositorio.GetRepositorio(TCidade.ClassName);
    Cidade      := TCidade(Repositorio.Get(self.cdsCODIGO.AsInteger));

    if not Assigned(Cidade) then exit;

    self.edtCodigo.Text   := intToStr(Cidade.codigo);
    self.edtCidade.Text   := Cidade.nome;
    self.edtCodigoIBGE.AsInteger := Cidade.codibge;
    self.cmbUF.ItemIndex  := Cidade.codest;

  finally
    FreeAndNil(Repositorio);
    FreeAndNil(Cidade);
  end;
end;

function TfrmCadastroCidade.VerificaDados: Boolean;
begin
  result := false;

  if length(edtCodigoIBGE.Text) < 7 then
  begin
    avisar(1,'Código IBGE da cidade, inválido.');
    edtCodigoIBGE.SetFocus;
  end
  else if cmbUF.ItemIndex <= 0 then
  begin
    avisar(1,'Unidade de federação deve ser informada.');
    cmbUF.SetFocus;
  end
  else if TRIM(edtCidade.Text) = '' then
  begin
    avisar(1,'O nome da cidade deve ser informado.');
    edtCidade.SetFocus;
  end
  else
    result := true;

end;

end.
