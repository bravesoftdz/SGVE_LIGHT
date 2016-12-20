unit uEFDFiscal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uPadrao, StdCtrls, Buttons, ComCtrls, frameBuscaContador,
  frameBuscaEmpresa, DateUtils, FileCtrl;

type
  TfrmEFDFiscal = class(TfrmPadrao)
    GroupBox1: TGroupBox;
    chk0: TCheckBox;
    chkC: TCheckBox;
    chkD: TCheckBox;
    chkE: TCheckBox;
    chkH: TCheckBox;
    chk1: TCheckBox;
    chk9: TCheckBox;
    BuscaEmpresa1: TBuscaEmpresa;
    gpbContador: TGroupBox;
    BuscaContador1: TBuscaContador;
    gpbPeriodo: TGroupBox;
    Label6: TLabel;
    Label1: TLabel;
    edtAno: TEdit;
    UpDown1: TUpDown;
    cbMes: TComboBox;
    gpbCaminho: TGroupBox;
    edtCaminho: TEdit;
    btnSeleciona: TBitBtn;
    btnCancelar: TBitBtn;
    btnGerar: TBitBtn;
    procedure btnCancelarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnGerarClick(Sender: TObject);
    procedure btnSelecionaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    function verifica_obrigatorios :Boolean;
  public
    { Public declarations }
  end;

var
  frmEFDFiscal: TfrmEFDFiscal;

implementation

uses GeradorEFDFiscal, uModulo, StrUtils;

{$R *.dfm}

procedure TfrmEFDFiscal.btnCancelarClick(Sender: TObject);
begin
  inherited;
  self.Close;
end;

procedure TfrmEFDFiscal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = VK_F3 then
    btnGerar.Click;
end;

procedure TfrmEFDFiscal.btnGerarClick(Sender: TObject);
var gerador            :TGeradorEFDFiscal;
    nome_arq, resposta :String;
    data_i, data_f     :TDateTime;
begin
    try

      if not verifica_obrigatorios then Exit;
      
      gerador := nil;

      if not confirma('Deseja gerar o arquivo do EFD Contribuições?') then exit;

      try
         self.Aguarda('Gerando arquivo, favor aguarde');
         
         data_i := strToDate( '01/'+intToStr(cbMes.ItemIndex)+'/'+edtAno.Text );
         data_f := strToDateTime( intToStr(DaysInMonth(data_i) )+ '/' + formatDateTime('mm/yyyy 23:59:59', data_i) );

         Application.ProcessMessages;
         gerador := TGeradorEFDFiscal.Create(data_i,
                                             data_f,
                                             self.chk0.Checked,
                                             self.chkC.Checked,
                                             self.chkD.Checked,
                                             self.chkE.Checked,
                                             self.chkH.Checked,
                                             self.chk1.Checked,
                                             self.chk9.Checked,
                                             Trim(self.edtCaminho.Text),
                                            // BuscaEmpresa1.Empresa,
                                             BuscaContador1.contador);

         gerador.Gera_EFD_Fiscal;
         
        resposta := 'Arquivo gerado com sucesso!';

      except
       on e: Exception do
        begin
           resposta := 'Não foi possível gerar o arquivo do EFD Fiscal '+#13#10+ 'Erro: '+e.Message ;
        end;
      end;

  finally
    if Assigned(gerador) then FreeAndNil(gerador);
    self.FimAguarda( resposta );
  end;

end;

procedure TfrmEFDFiscal.btnSelecionaClick(Sender: TObject);
var caminho :String;
begin
  SelectDirectory('Selecione a pasta destino','', caminho);

  if caminho <> '' then
    edtCaminho.Text := caminho;
end;

procedure TfrmEFDFiscal.FormShow(Sender: TObject);
begin
  if not FileExists( ExtractFilePath( Application.ExeName ) + 'EFD') then
    CreateDir( ExtractFilePath( Application.ExeName ) + 'EFD' );

  if not FileExists( ExtractFilePath( Application.ExeName ) + 'EFD\Fiscal') then
    CreateDir( ExtractFilePath( Application.ExeName ) + 'EFD\Fiscal' );

  edtCaminho.Text := ExtractFilePath( Application.ExeName ) + 'EFD\Fiscal';

  edtAno.Text := FormatDateTime('yyyy',Date);
end;

function TfrmEFDFiscal.verifica_obrigatorios: Boolean;
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

end.
