unit uEnviaXMLsContador;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uPadrao, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, frameBuscaContador,
  System.DateUtils, ACBrBase, ACBrMail, System.StrUtils;

type
  TfrmEnviaXMLsContador = class(TfrmPadrao)
    GroupBox1: TGroupBox;
    cmbAno: TComboBox;
    GroupBox2: TGroupBox;
    cmbMes: TComboBox;
    pnlBotoes: TPanel;
    btnEnviar: TBitBtn;
    btnVoltar: TBitBtn;
    gpbContador: TGroupBox;
    BuscaContador1: TBuscaContador;
    ACBrMail1: TACBrMail;
    procedure FormShow(Sender: TObject);
    procedure btnEnviarClick(Sender: TObject);
    procedure cmbAnoClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    procedure enviarPorEmail;
    procedure limparDiretorio(diretorio: String);
  public
    { Public declarations }
  end;

var
  frmEnviaXMLsContador: TfrmEnviaXMLsContador;

implementation

uses Funcoes, uRelatorioNFCes, uRelatorioNFes, uModulo;

{$R *.dfm}

procedure TfrmEnviaXMLsContador.btnEnviarClick(Sender: TObject);
var gerouNFCe, gerouNFe :Boolean;
begin
  try
    Aguarda('Enviando Arquivos para o contador');
    Application.ProcessMessages;

    frmRelatorioNFCes := TfrmRelatorioNFCes.Create(nil);
    frmRelatorioNFCes.cmbMes.ItemIndex := frmRelatorioNFCes.cmbMes.Items.IndexOf(cmbMes.Items[cmbMes.ItemIndex]);
    frmRelatorioNFCes.cmbAno.ItemIndex := frmRelatorioNFCes.cmbAno.Items.IndexOf(cmbAno.Items[cmbAno.ItemIndex]);
    gerouNFCe := frmRelatorioNFCes.gerarPdf;
    frmRelatorioNFCes.Release;
    frmRelatorioNFCes := nil;

    sleep(1000);

    frmRelatorioNFes := TfrmRelatorioNFes.Create(nil);
    frmRelatorioNFes.cmbMes.ItemIndex := frmRelatorioNFes.cmbMes.Items.IndexOf(cmbMes.Items[cmbMes.ItemIndex]);
    frmRelatorioNFes.cmbAno.ItemIndex := frmRelatorioNFes.cmbAno.Items.IndexOf(cmbAno.Items[cmbAno.ItemIndex]);
    gerouNFe := frmRelatorioNFes.gerarPdf;
    frmRelatorioNFes.Release;
    frmRelatorioNFes := nil;

    if not gerouNFCe and not gerouNFe then
      avisar(1,'Nenhum arquivo foi encontrado no período informado')
    else
      enviarPorEmail;
  finally
    FimAguarda();
  end;
end;

procedure TfrmEnviaXMLsContador.cmbAnoClick(Sender: TObject);
begin
  inherited;
  BuscaContador1.edtCodigo.SetFocus;
end;

procedure TfrmEnviaXMLsContador.enviarPorEmail;
var arquivoNFes, arquivoNFCes :String;
begin
  arquivoNFes      := 'XMLsNFe'+cmbMes.Items[cmbMes.ItemIndex]+cmbAno.Items[cmbAno.ItemIndex]+'.rar';
  arquivoNFCes     := 'XMLsNFCe'+cmbMes.Items[cmbMes.ItemIndex]+cmbAno.Items[cmbAno.ItemIndex]+'.rar';

  if not FileExists(diretorioExecutavel+'Docs\XMLs\'+arquivoNFes) and not FileExists(diretorioExecutavel+'Docs\XMLs\'+arquivoNFCes) then
  begin
    avisar(1,'Nenhum arquivo, referente aos XMLs, foi encontrado para o envio');
    exit;
  end;

  try
    if assigned(dm.Empresa.ConfiguracoesEmail) then
    begin
      ACBrMail1.Clear;
      ACBrMail1.Host         := dm.Empresa.ConfiguracoesEmail.smtp_host;
      ACBrMail1.Port         := dm.Empresa.ConfiguracoesEmail.smtp_port;
      ACBrMail1.Username     := dm.Empresa.ConfiguracoesEmail.smtp_user;
      ACBrMail1.Password     := dm.Empresa.ConfiguracoesEmail.smtp_password;
      ACBrMail1.AddAddress(buscaContador1.edtEmail.Text);

      ACBrMail1.FromName     := dm.Empresa.razao;
      ACBrMail1.From         := dm.Empresa.ConfiguracoesEmail.smtp_user;
      ACBrMail1.IsHTML       := false;

      ACBrMail1.Subject      := 'Notas Fiscais '+cmbMes.Items[cmbMes.ItemIndex]+' - '+cmbAno.Items[cmbAno.ItemIndex];
      ACBrMail1.Body.Text    := 'ATENÇÃO, favor não responder. E-mail enviado automaticamente. '+
                                'Para contato: '+#13#10+
                                ifThen(dm.Empresa.email <> '', 'E-mail: '+dm.Empresa.email,'')+#13#10+
                                'Fone: '+ ifThen(apenasNumeros(dm.Empresa.fone1) <> '',dm.Empresa.fone1,dm.Empresa.fone2)+ #13#10+
                                 dm.Empresa.ConfiguracoesEmail.mensagem.Text +
                                'Email gerado automaticamente pelo Sistema SGVE 2.0 '+
                                'CBN Informática - (43) 3534-2350                   ';

      ACBrMail1.AltBody.Text := ACBrMail1.Body.Text;
      if FileExists(diretorioExecutavel+'Docs\XMLs\'+arquivoNFes) then
        ACBrMail1.AddAttachment(TFileName( diretorioExecutavel+'Docs\XMLs\'+arquivoNFes));
      if FileExists(diretorioExecutavel+'Docs\XMLs\'+arquivoNFCes) then
        ACBrMail1.AddAttachment(TFileName( diretorioExecutavel+'Docs\XMLs\'+arquivoNFCes));

      Application.ProcessMessages;
      ACBrMail1.Send;

      avisar(1,'Arquivos enviados com sucesso!', 3);
    end
    else avisar(0,'Não foi possível enviar e-mail, pois não há configurações de e-mail cadastradas');

  Except
    on e : Exception do
      begin
        raise Exception.Create(e.Message);
      end;
  end;
end;

procedure TfrmEnviaXMLsContador.limparDiretorio(diretorio: String);
var
  i: integer;
  sr: TSearchRec;
begin
  I := FindFirst(diretorio+'*.*', faAnyFile, SR);
  while I = 0 do
  begin
    if (pos('.XML',UPPERCASE(SR.Name)) > 0) or (pos('.PDF',UPPERCASE(SR.Name)) > 0) then
      DeleteFile(diretorio + SR.Name);

    I := FindNext(SR);
  end;
end;

procedure TfrmEnviaXMLsContador.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if ( (ssCtrl in Shift) AND (Key = ord('E')) ) then  btnEnviar.Click;
end;

procedure TfrmEnviaXMLsContador.FormShow(Sender: TObject);
var index :integer;
begin
  index            := MonthOf(Date)-1;

  if index = 0 then
    index := 11
  else
    dec(index);

  cmbMes.ItemIndex := index;
  cmbAno.ItemIndex := cmbAno.Items.IndexOf(formatDateTime('yyyy',Date));
end;

end.
