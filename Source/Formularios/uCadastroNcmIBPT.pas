unit uCadastroNcmIBPT;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroPadrao, Data.DB, Vcl.StdCtrls, Vcl.Mask, RxToolEdit, RxCurrEdit, Datasnap.DBClient, Vcl.Grids,
  Vcl.DBGrids, DBGridCBN, Vcl.ComCtrls, Vcl.Buttons, Vcl.ExtCtrls, contNrs, frameBuscaCFOP;

type
  TfrmCadastroNcmIBPT = class(TfrmCadastroPadrao)
    edtCodigo: TCurrencyEdit;
    Label1: TLabel;
    edtNCM: TEdit;
    edtAliqNacional: TCurrencyEdit;
    Label2: TLabel;
    Label3: TLabel;
    edtAliqInternacional: TCurrencyEdit;
    Label4: TLabel;
    cdsCODIGO: TIntegerField;
    cdsNCM: TStringField;
    cdsALIQ_NACIONAL: TFloatField;
    cdsALIQ_INTERNACIONAL: TFloatField;
    cdsCST: TStringField;
    BuscaCFOP1: TBuscaCFOP;
    cmbCSOSN: TComboBox;
    Label5: TLabel;
    cmbCST: TComboBox;
    BuscaCFOP2: TBuscaCFOP;
    procedure edtNCMKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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
    FCodigoNCM: integer;

    { Persiste os dados no banco de dados }
    function GravarDados   :TObject;                   override;

    { Verifica os dados antes de persistir }
    function VerificaDados :Boolean;                   override;

  public
    property codigoNCM   :integer write FCodigoNCM;
  end;

var
  frmCadastroNcmIBPT: TfrmCadastroNcmIBPT;

implementation

uses NcmIBPT, repositorio, FabricaRepositorio, uModulo;

{$R *.dfm}

procedure TfrmCadastroNcmIBPT.AlterarRegistroNoCDS(Registro: TObject);
var
  NcmIBPT :TNcmIBPT;
begin
  inherited;

  NcmIBPT := (Registro as TNcmIBPT);

  self.cds.Edit;
  self.cdsCODIGO.AsInteger      := NcmIBPT.codigo;
  self.cdsNCM.AsString          := NcmIBPT.ncm_ibpt;
  self.cdsALIQ_NACIONAL.AsFloat := NcmIBPT.aliqnacional_ibpt;
  self.cdsCST.AsString          := NcmIBPT.cst;
  self.cds.Post;
end;

procedure TfrmCadastroNcmIBPT.CarregarDados;
var
  NcmIBPTs    :TObjectList;
  Repositorio :TRepositorio;
  nX          :Integer;
begin
  inherited;

  Repositorio := nil;
  NcmIBPTs    := nil;

  try
    Repositorio := TFabricaRepositorio.GetRepositorio(TNcmIBPT.ClassName);
    NcmIBPTs    := Repositorio.GetAll;

    if Assigned(NcmIBPTs) and (NcmIBPTs.Count > 0) then begin

       for nX := 0 to (NcmIBPTs.Count-1) do
         self.IncluirRegistroNoCDS(NcmIBPTs.Items[nX]);

    end;
  finally
    FreeAndNil(Repositorio);
    FreeAndNil(NcmIBPTs);
  end;
end;

procedure TfrmCadastroNcmIBPT.edtNCMKeyPress(Sender: TObject; var Key: Char);
begin
  If not( key in['0'..'9',#08] ) then
    key:=#0;
end;

procedure TfrmCadastroNcmIBPT.ExecutarDepoisAlterar;
begin
  inherited;
  edtNCM.SetFocus;
end;

procedure TfrmCadastroNcmIBPT.ExecutarDepoisIncluir;
begin
  inherited;
  edtNCM.SetFocus;
end;

procedure TfrmCadastroNcmIBPT.FormCreate(Sender: TObject);
begin
  cmbCSOSN.Enabled := dm.Empresa.ConfiguracoesNF.CRT = 0;
  cmbCST.Enabled   := dm.Empresa.ConfiguracoesNF.CRT > 0;
end;

procedure TfrmCadastroNcmIBPT.FormShow(Sender: TObject);
begin
  inherited;
  if self.FCodigoNCM > 0 then
  begin
    cds.Locate('CODIGO',self.FCodigoNCM,[]);
    btnAlterar.Click;
    cmbCST.SetFocus;
  end;
end;

function TfrmCadastroNcmIBPT.GravarDados: TObject;
var
  NcmIBPT             :TNcmIBPT;
  RepositorioNcmIBPT  :TRepositorio;
begin
   NcmIBPT             := nil;
   RepositorioNcmIBPT  := nil;

   try
     RepositorioNcmIBPT  := TFabricaRepositorio.GetRepositorio(TNcmIBPT.ClassName);
     NcmIBPT             := TNcmIBPT(RepositorioNcmIBPT.Get(StrToIntDef(self.edtCodigo.Text, 0)));

     if not Assigned(NcmIBPT) then
      NcmIBPT := TNcmIBPT.Create;

     NcmIBPT.ncm_ibpt               := self.edtNCM.Text;
     NcmIBPT.aliqnacional_ibpt      := self.edtAliqNacional.Value;
     NcmIBPT.aliqinternacional_ibpt := self.edtAliqInternacional.Value;

     if cmbCSOSN.ItemIndex > 0 then
       NcmIBPT.cst := cmbCSOSN.Items[cmbCSOSN.ItemIndex]
     else
       NcmIBPT.cst := cmbCST.Items[cmbCST.ItemIndex];

     NcmIBPT.codigo_cfop            := self.BuscaCFOP1.edtCodigo.AsInteger;
     NcmIBPT.codigo_cfop_fora       := self.BuscaCFOP2.edtCodigo.AsInteger;

     RepositorioNcmIBPT.Salvar(NcmIBPT);

     result := NcmIBPT;

   finally
     FreeAndNil(RepositorioNcmIBPT);
   end;
end;

procedure TfrmCadastroNcmIBPT.IncluirRegistroNoCDS(Registro: TObject);
var
  NcmIBPT :TNcmIBPT;
begin
  inherited;

  NcmIBPT := (Registro as TNcmIBPT);

  self.cds.Append;
  self.cdsCODIGO.AsInteger            := NcmIBPT.codigo;
  self.cdsNCM.AsString                := NcmIBPT.ncm_ibpt;
  self.cdsALIQ_NACIONAL.AsFloat       := NcmIBPT.aliqnacional_ibpt;
  self.cdsALIQ_INTERNACIONAL.AsFloat  := NcmIBPT.aliqinternacional_ibpt;
  self.cdsCST.AsString                := NcmIBPT.cst;

  self.cds.Post;
end;

procedure TfrmCadastroNcmIBPT.LimparDados;
begin
  inherited;
  edtNCM.Clear;
  cmbCSOSN.ItemIndex := 0;
  cmbCST.ItemIndex := 0;
  BuscaCFOP1.Limpa;
  BuscaCFOP2.Limpa;
  edtAliqNacional.Clear;
  edtAliqInternacional.Clear;
end;

procedure TfrmCadastroNcmIBPT.MostrarDados;
var
  NcmIBPT                              :TNcmIBPT;
  RepositorioNcmIBPT                   :TRepositorio;
begin
  inherited;

  NcmIBPT                              := nil;
  RepositorioNcmIBPT                   := nil;

  try
    RepositorioNcmIBPT  := TFabricaRepositorio.GetRepositorio(TNcmIBPT.ClassName);
    NcmIBPT             := TNcmIBPT(RepositorioNcmIBPT.Get(self.ds.DataSet.FieldByName('CODIGO').AsInteger));//*f NcmIBPT             := TNcmIBPT(RepositorioNcmIBPT.Get(self.cdsCODIGO.AsInteger));

    if not Assigned(NcmIBPT) then exit;

    self.edtCodigo.AsInteger        := NcmIBPT.codigo;
    self.edtNCM.Text                := NcmIBPT.ncm_ibpt;
    self.edtAliqNacional.Value      := NcmIBPT.aliqnacional_ibpt;
    self.edtAliqInternacional.Value := NcmIBPT.aliqinternacional_ibpt;

    if copy(NcmIBPT.cst,1,1) = '0' then
      self.cmbCST.ItemIndex    := cmbCST.Items.IndexOf(NcmIBPT.cst)
    else
      self.cmbCSOSN.ItemIndex  := cmbCSOSN.Items.IndexOf(NcmIBPT.cst);

    self.BuscaCFOP1.codigo          := NcmIBPT.codigo_cfop;
    self.BuscaCFOP2.codigo          := NcmIBPT.codigo_cfop_fora;

  finally
    FreeAndNil(RepositorioNcmIBPT);
    FreeAndNil(NcmIBPT);
  end;
end;

procedure TfrmCadastroNcmIBPT.pgGeralChange(Sender: TObject);
begin
  inherited;
  if pgGeral.TabIndex = 1 then //*f
    MostrarDados;

end;

function TfrmCadastroNcmIBPT.VerificaDados: Boolean;
begin
  result := false;

  if trim(edtNCM.Text) = '' then begin
    avisar(1,'Favor informar o código ncm.');
    edtNCM.SetFocus;
  end
  else if (edtAliqNacional.Value <= 0) then begin
    avisar(1,'Favor informar o valor da aliquota nacional.');
    edtAliqNacional.SetFocus;
  end
  else if (cmbCST.Enabled) and (cmbCST.ItemIndex <= 0) then
  begin
    avisar(1,'Favor informar o CST equivalente ao NCM.');
    cmbCST.SetFocus;
  end
  else if (cmbCSOSN.Enabled) and (cmbCSOSN.ItemIndex <= 0) then
  begin
    avisar(1,'Favor informar o CSOSN equivalente ao NCM.');
    cmbCSOSN.SetFocus;
  end
  else if (BuscaCFOP1.edtCFOP.Text = '') then
  begin
    avisar(1,'Favor informar o CFOP equivalente ao NCM.');
    BuscaCFOP1.edtCFOP.SetFocus;
  end
  else
    result := true;
end;

end.
