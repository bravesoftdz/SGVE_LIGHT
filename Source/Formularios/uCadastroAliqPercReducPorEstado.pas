unit uCadastroAliqPercReducPorEstado;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroPadrao, Data.DB, Vcl.StdCtrls, Vcl.Mask, RxToolEdit, RxCurrEdit, Datasnap.DBClient, Vcl.Grids,
  Vcl.DBGrids, DBGridCBN, Vcl.ComCtrls, Vcl.Buttons, Vcl.ExtCtrls, IcmsEstado, contnrs;

type
  TfrmCadastroAliqPercReducPorEstado = class(TfrmCadastroPadrao)
    cdsCODIDO_ESTADO: TIntegerField;
    cdsUF: TStringField;
    cdsALIQUOTA: TFloatField;
    cdsPERC_REDUCAO: TFloatField;
    edtAliquota: TCurrencyEdit;
    Label2: TLabel;
    edtPercReducao: TCurrencyEdit;
    Label1: TLabel;
    cdsCODIGO: TIntegerField;
    edtCodigo: TCurrencyEdit;
    edtCodigoUf: TCurrencyEdit;
    edtUF: TEdit;
    Label3: TLabel;
    procedure FormShow(Sender: TObject);
    procedure pgGeralChange(Sender: TObject);
  private
    { Altera um registro existente no CDS de consulta }
    procedure AlterarRegistroNoCDS(Registro :TObject); override;

    { Carrega todos os registros pra aba de Consulta }
    procedure CarregarDados;                           override;

    procedure ExecutarDepoisAlterar;                   override;
    procedure ExecutarDepoisIncluir;                   override;
    procedure ExecutarDepoisSalvar;                    override;
    procedure ExecutarDepoisConsultar;                 override;

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
  frmCadastroAliqPercReducPorEstado: TfrmCadastroAliqPercReducPorEstado;

implementation

uses Repositorio, FabricaRepositorio;

{$R *.dfm}

{ TfrmCadastroAliqPercReducPorEstado }

procedure TfrmCadastroAliqPercReducPorEstado.AlterarRegistroNoCDS(Registro: TObject);
var
  Aliquota :TIcmsEstado;
begin
  inherited;

  Aliquota := (Registro as TIcmsEstado);

  self.cds.Edit;
  self.cdsCODIGO.AsInteger        := Aliquota.codigo;
  self.cdsCODIDO_ESTADO.AsInteger := Aliquota.codigo_estado;
  self.cdsALIQUOTA.AsFloat        := Aliquota.aliquota_icms;
  self.cdsPERC_REDUCAO.AsFloat    := Aliquota.perc_reducao_bc;
  self.cdsUF.AsString             := Aliquota.Estado.sigla;
  self.cds.Post;
end;

procedure TfrmCadastroAliqPercReducPorEstado.CarregarDados;
var
  Aliquotas   :TObjectList;
  Repositorio :TRepositorio;
  nX          :Integer;
begin
  inherited;

  Repositorio := nil;
  Aliquotas    := nil;

  try
    Repositorio := TFabricaRepositorio.GetRepositorio(TIcmsEstado.ClassName);
    Aliquotas   := Repositorio.GetAll;

    if Assigned(Aliquotas) and (Aliquotas.Count > 0) then begin

       for nX := 0 to (Aliquotas.Count-1) do
         self.IncluirRegistroNoCDS(Aliquotas.Items[nX]);

    end;
  finally
    FreeAndNil(Repositorio);
    FreeAndNil(Aliquotas);
  end;
end;

procedure TfrmCadastroAliqPercReducPorEstado.ExecutarDepoisAlterar;
begin
  inherited;
  edtAliquota.SetFocus;
end;

procedure TfrmCadastroAliqPercReducPorEstado.ExecutarDepoisConsultar;
begin
  inherited;
  btnIncluir.Enabled := false;
end;

procedure TfrmCadastroAliqPercReducPorEstado.ExecutarDepoisIncluir;
begin
  inherited;
  edtAliquota.SetFocus;
end;

procedure TfrmCadastroAliqPercReducPorEstado.ExecutarDepoisSalvar;
begin
  inherited;
  btnIncluir.Enabled := false;
end;

procedure TfrmCadastroAliqPercReducPorEstado.FormShow(Sender: TObject);
begin
  inherited;
  btnIncluir.Enabled := false;
end;

function TfrmCadastroAliqPercReducPorEstado.GravarDados: TObject;
var
  Aliquota            :TIcmsEstado;
  RepositorioAliquota :TRepositorio;
begin
   Aliquota         := nil;

   RepositorioAliquota  := nil;

   try
     RepositorioAliquota  := TFabricaRepositorio.GetRepositorio(TIcmsEstado.ClassName);
     Aliquota             := TIcmsEstado(RepositorioAliquota.Get(StrToIntDef(self.edtCodigo.Text, 0)));

     if not Assigned(Aliquota) then
      Aliquota := TIcmsEstado.Create;

     Aliquota.aliquota_icms         := self.edtAliquota.Value;
     Aliquota.perc_reducao_bc       := self.edtPercReducao.Value;
     Aliquota.codigo_estado         := self.edtCodigoUf.AsInteger;

     RepositorioAliquota.Salvar(Aliquota);

     result := Aliquota;

   finally
     FreeAndNil(RepositorioAliquota);
   end;
end;

procedure TfrmCadastroAliqPercReducPorEstado.IncluirRegistroNoCDS(Registro: TObject);
var
  Aliquota :TIcmsEstado;
begin
  inherited;

  Aliquota := (Registro as TIcmsEstado);

  self.cds.Append;
  self.cdsCODIGO.AsInteger        := Aliquota.codigo;
  self.cdsCODIDO_ESTADO.AsInteger := Aliquota.codigo_estado;
  self.cdsALIQUOTA.AsFloat        := Aliquota.aliquota_icms;
  self.cdsPERC_REDUCAO.AsFloat    := Aliquota.perc_reducao_bc;
  self.cdsUF.AsString             := Aliquota.Estado.sigla;
  self.cds.Post;
end;

procedure TfrmCadastroAliqPercReducPorEstado.LimparDados;
begin
  edtCodigo.Clear;
  edtAliquota.Clear;
  edtPercReducao.Clear;
end;

procedure TfrmCadastroAliqPercReducPorEstado.MostrarDados;
var
  Aliquota                          :TIcmsEstado;
  RepositorioAliquota               :TRepositorio;
begin
  inherited;

  Aliquota                          := nil;
  RepositorioAliquota               := nil;

  try
    RepositorioAliquota  := TFabricaRepositorio.GetRepositorio(TIcmsEstado.ClassName);
    Aliquota             := TIcmsEstado(RepositorioAliquota.Get(self.ds.DataSet.FieldByName('CODIGO').AsInteger));//*f Aliquota             := TIcmsEstado(RepositorioAliquota.Get(self.cdsCODIGO.AsInteger));

    if not Assigned(Aliquota) then exit;

    self.edtCodigo.AsInteger    := Aliquota.codigo;
    self.edtCodigoUf.AsInteger  := Aliquota.codigo_estado;
    self.edtAliquota.Value      := Aliquota.aliquota_icms;
    self.edtPercReducao.Value   := Aliquota.perc_reducao_bc;
    self.edtUF.Text             := Aliquota.Estado.sigla;

  finally
    FreeAndNil(RepositorioAliquota);
    FreeAndNil(Aliquota);
  end;
end;

procedure TfrmCadastroAliqPercReducPorEstado.pgGeralChange(Sender: TObject);
begin
  inherited;
  if pgGeral.TabIndex = 1 then //*f
    MostrarDados;

end;

function TfrmCadastroAliqPercReducPorEstado.VerificaDados: Boolean;
begin
  result := false;

  if edtAliquota.Value <= 0 then begin
    avisar(1,'Favor informar a alíquota de ICMS.');
    edtAliquota.SetFocus;
  end
  else if edtPercReducao.Value <= 0 then
  begin
    avisar(1,'Favor informar a % de redução da base de cálculo.');
    edtPercReducao.SetFocus;
  end
  else
    result := true;
end;

end.
