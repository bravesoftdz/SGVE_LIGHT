unit uEFDContribuicoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uPadrao, StdCtrls, Buttons, ComCtrls, ExtCtrls, DateUtils, fileCtrl,
  frameBuscaEmpresa, frameBuscaContador, DB,
  frameBuscaNaturezaOperacao, Grids, DBGrids, DBClient;

type
  TfrmEFDContribuicoes = class(TfrmPadrao)
    gpbBlocos: TGroupBox;
    chk0: TCheckBox;
    chkA: TCheckBox;
    chkC: TCheckBox;
    chkD: TCheckBox;
    chkF: TCheckBox;
    chkM: TCheckBox;
    chk1: TCheckBox;
    rgRegime: TRadioGroup;
    gpbPeriodo: TGroupBox;
    Label6: TLabel;
    Label1: TLabel;
    edtAno: TEdit;
    UpDown1: TUpDown;
    cbMes: TComboBox;
    btnCancelar: TBitBtn;
    btnGerar: TBitBtn;
    gpbCaminho: TGroupBox;
    edtCaminho: TEdit;
    btnSeleciona: TBitBtn;
    BuscaEmpresa1: TBuscaEmpresa;
    StaticText1: TStaticText;
    gpbContador: TGroupBox;
    Label2: TLabel;
    BuscaContador1: TBuscaContador;
    cds: TClientDataSet;
    DBGrid1: TDBGrid;
    BuscaNaturezaOperacao1: TBuscaNaturezaOperacao;
    rgCfops: TRadioGroup;
    StaticText2: TStaticText;
    ds: TDataSource;
    cdsCODIGO_NATUREZA: TIntegerField;
    cdsCFOP: TStringField;
    btnAddNatOp: TBitBtn;
    Edit1: TEdit;
    BitBtn2: TBitBtn;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnGerarClick(Sender: TObject);
    procedure btnSelecionaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnAddNatOpClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    function verifica_obrigatorios :Boolean;
  public
    { Public declarations }
  end;

var
  frmEFDContribuicoes: TfrmEFDContribuicoes;

implementation

uses GeradorEFDContribuicoes, uModulo, StrUtils;

{$R *.dfm}

procedure TfrmEFDContribuicoes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = VK_F3 then
    btnGerar.Click;
end;

procedure TfrmEFDContribuicoes.btnGerarClick(Sender: TObject);
var gerador            :TGeradorEFDContribuicoes;
    nome_arq, resposta :String;
    data_i, data_f     :TDateTime;
    regime_da_empresa  :String;
begin
  try
      if not verifica_obrigatorios then Exit;
      
      gerador := nil;

      if not confirma('Deseja gerar o arquivo do EFD Contribuições?') then exit;

      try
         self.Aguarda('Gerando arquivo, favor aguarde');
         
         data_i := strToDate( '01/'+intToStr(cbMes.ItemIndex)+'/'+edtAno.Text );
         data_f := strToDateTime( intToStr(DaysInMonth(data_i) )+ '/' + formatDateTime('mm/yyyy 23:59:59', data_i) );

         regime_da_empresa := IfThen(rgRegime.itemIndex = 0 , 'LR' , 'LP' );

         Application.ProcessMessages;
         gerador := TGeradorEFDContribuicoes.Create(data_i,
                                                    data_f,
                                                    self.chk0.Checked,
                                                    self.chkA.Checked,
                                                    self.chkC.Checked,
                                                    self.chkD.Checked,
                                                    self.chkF.Checked,
                                                    self.chkM.Checked,
                                                    self.chk1.Checked,
                                                    Trim(self.edtCaminho.Text),
                                                    regime_da_empresa,
                                                    //BuscaEmpresa1.Empresa,
                                                    BuscaContador1.contador,
                                                    cds,
                                                    (rgCfops.ItemIndex = 0));

         gerador.Gera_EFD_Contribuicoes;

        resposta := 'Arquivo gerado com sucesso!';

      except
       on e: Exception do
        begin
           resposta := 'Não foi possível gerar o arquivo do EFD Contribuições '+#13#10+ 'Erro: '+e.Message ;
        end;
      end;

  finally
    if Assigned(gerador) then FreeAndNil(gerador);
    self.FimAguarda( resposta );
  end;

end;

procedure TfrmEFDContribuicoes.btnSelecionaClick(Sender: TObject);
var caminho :String;
begin
  SelectDirectory('Selecione a pasta destino','', caminho);

  if caminho <> '' then
    edtCaminho.Text := caminho;
end;

procedure TfrmEFDContribuicoes.FormShow(Sender: TObject);
begin
  if not FileExists( ExtractFilePath( Application.ExeName ) + 'EFD') then
    CreateDir( ExtractFilePath( Application.ExeName ) + 'EFD' );

  if not FileExists( ExtractFilePath( Application.ExeName ) + 'EFD\Contribuicoes') then
    CreateDir( ExtractFilePath( Application.ExeName ) + 'EFD\Contribuicoes' );

  edtCaminho.Text := ExtractFilePath( Application.ExeName ) + 'EFD\Contribuicoes';
  edtAno.Text := FormatDateTime('yyyy',Date);
end;

procedure TfrmEFDContribuicoes.btnCancelarClick(Sender: TObject);
begin
  inherited;
  Close;
end;

function TfrmEFDContribuicoes.verifica_obrigatorios: Boolean;
begin
  Result := false;

  if BuscaEmpresa1.edtRazao.Text = '' then begin
    avisar('Favor informar a empresa');
    BuscaEmpresa1.edtCodigo.SetFocus;
  end
  else if BuscaContador1.codigo = 0 then begin
    avisar('Favor informar o contador');
    BuscaContador1.edtCodigo.SetFocus;
  end
  else if cbMes.ItemIndex = 0 then begin
    avisar('Favor informar o mês');
    cbMes.SetFocus;
  end
  else
    Result := true;
end;

procedure TfrmEFDContribuicoes.btnAddNatOpClick(Sender: TObject);
begin
  if not cds.Active then
    cds.CreateDataSet;

  if cds.Locate('cfop',BuscaNaturezaOperacao1.NaturezaOperacao.CFOP, []) then exit;

  cds.Append;
  cdsCODIGO_NATUREZA.AsInteger := BuscaNaturezaOperacao1.NaturezaOperacao.Codigo;
  cdsCFOP.AsString             := BuscaNaturezaOperacao1.NaturezaOperacao.CFOP;
  cds.Post;

  BuscaNaturezaOperacao1.Clear;
  BuscaNaturezaOperacao1.edtCFOP.SetFocus;
end;

procedure TfrmEFDContribuicoes.BitBtn2Click(Sender: TObject);
begin
  //TCriaBalaoInformacao.ShowBalloonTip(edit1.Handle,'[ DELETE ] Remove o CFOP selecionado', 'Informação', 1);
end;

procedure TfrmEFDContribuicoes.DBGrid1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = VK_Delete then begin
    if ( cds.Active ) and ( cds.RecordCount > 0 ) then
      cds.Delete;
  end;
end;

end.
