unit uRelatorioNFCes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, filectrl,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uPadrao, RLReport, RLFilters, RLPDFFilter, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, System.StrUtils, System.DateUtils, Math, ZLib, ShellAPI, ACBrBase, ACBrMail;

type
  TfrmRelatorioNFCes = class(TfrmPadrao)
    RLReport1: TRLReport;
    RLBand1: TRLBand;
    RLGroup1: TRLGroup;
    RLPDFFilter1: TRLPDFFilter;
    RLBand2: TRLBand;
    RLLabel1: TRLLabel;
    RLBand3: TRLBand;
    RLSystemInfo1: TRLSystemInfo;
    RLLabel3: TRLLabel;
    RLSystemInfo2: TRLSystemInfo;
    RLLabel4: TRLLabel;
    qryNFCe: TFDQuery;
    qryNFCeNR_NOTA: TIntegerField;
    qryNFCeCODIGO_PEDIDO: TIntegerField;
    qryNFCeSTATUS: TStringField;
    qryNFCeMOTIVO: TStringField;
    qryNFCeCHAVE: TStringField;
    dsNFCe: TDataSource;
    RLSystemInfo3: TRLSystemInfo;
    RLLabel5: TRLLabel;
    RLSystemInfo4: TRLSystemInfo;
    RLDBText2: TRLDBText;
    RLLabel6: TRLLabel;
    RLLabel7: TRLLabel;
    RLLabel8: TRLLabel;
    RLLabel9: TRLLabel;
    RLLabel10: TRLLabel;
    qryNFCeVALOR_TOTAL: TBCDField;
    RLLabel13: TRLLabel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    chkEnviadas: TCheckBox;
    chkCanceladas: TCheckBox;
    chkNaoEnviadas: TCheckBox;
    cmbAno: TComboBox;
    cmbMes: TComboBox;
    pnlBotoes: TPanel;
    btnImprimir: TBitBtn;
    btnVoltar: TBitBtn;
    qryNFCeDATA: TDateField;
    RLLabel2: TRLLabel;
    rlbReferente: TRLLabel;
    RLDraw1: TRLDraw;
    RLLabel14: TRLLabel;
    RLDraw2: TRLDraw;
    RLDraw3: TRLDraw;
    RLLabel15: TRLLabel;
    RLGroup2: TRLGroup;
    RLBand4: TRLBand;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    RLDBText6: TRLDBText;
    RLLabel11: TRLLabel;
    RLDBText7: TRLDBText;
    RLDBText8: TRLDBText;
    RLBand5: TRLBand;
    RLDBText1: TRLDBText;
    qryNFCePRODUTO: TStringField;
    qryNFCeNCM_IBPT: TStringField;
    qryNFCeQUANTIDADE: TBCDField;
    RLDBText9: TRLDBText;
    RLDBText10: TRLDBText;
    RLBand6: TRLBand;
    RLLabel16: TRLLabel;
    lbTotalDia: TRLLabel;
    lbTotalGeral: TRLLabel;
    lbQtde: TRLLabel;
    lbNCM: TRLLabel;
    rgpLeiaute: TRadioGroup;
    lbEnviadas: TRLLabel;
    lbCanceladas: TRLLabel;
    lbNaoEnviadas: TRLLabel;
    qryNFCeXML: TBlobField;
    ACBrMail1: TACBrMail;
    procedure btnVoltarClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure RLReport1BeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure FormShow(Sender: TObject);
    procedure RLDBText8BeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
    procedure lbTotalDiaBeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
    procedure lbTotalGeralBeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
    procedure lbQtdeAfterPrint(Sender: TObject);
    procedure RLDBText3BeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
    procedure lbNCMAfterPrint(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    totalDia :Real;
    totalGeral :Real;

    procedure buscar;
    procedure imprimir;
    function gerarXMLs :integer;
    procedure compactar;
    procedure limparDiretorio(diretorio :String);
  public
    procedure gerarPdf;
    procedure enviarPorEmail(mes, ano :String; emailContador :String);
  end;

var
  frmRelatorioNFCes: TfrmRelatorioNFCes;

implementation

uses funcoes, repositorio, fabricaRepositorio, umodulo, StringUtilitario;

{$R *.dfm}

procedure TfrmRelatorioNFCes.btnImprimirClick(Sender: TObject);
begin
  imprimir;
end;

procedure TfrmRelatorioNFCes.btnVoltarClick(Sender: TObject);
begin
  self.Close;
end;

procedure TfrmRelatorioNFCes.buscar;
var condicaoStatus :String;
begin
  if (chkEnviadas.Checked and chkCanceladas.Checked and chkNaoEnviadas.Checked) or
     (not chkEnviadas.Checked and not chkCanceladas.Checked and not chkNaoEnviadas.Checked) then
    condicaoStatus := ''
  else
  begin
    condicaoStatus := condicaoStatus + IfThen(chkEnviadas.Checked,',''100''','');
    condicaoStatus := condicaoStatus + IfThen(chkCanceladas.Checked,',''101''','');
    condicaoStatus := copy(condicaoStatus, 2, length(condicaoStatus));

    if condicaoStatus <> '' then
      condicaoStatus := ' and (NFCE.STATUS in ('+condicaoStatus+')';

    if chkNaoEnviadas.Checked then
    begin
      condicaoStatus := condicaoStatus + IfThen(condicaoStatus = '','and (','or')+
                                         ' not(NFCE.STATUS in (''100'',''101''))) ';
    end
    else
      condicaoStatus := condicaoStatus + ')';
  end;

  self.qryNFCe.Close;
  self.qryNFCe.SQL.Text := 'select nfce.nr_nota, nfce.codigo_pedido, nfce.status, nfce.motivo, nfce.chave, nfce.XML, '+
                           ' CAST(nfce.dh_recebimento as DATE) data , ped.valor_total, pro.descricao produto, '+
                           ' ibpt.ncm_ibpt, i.quantidade                            from NFCE                 '+
                           ' inner join pedidos ped on ped.codigo = nfce.codigo_pedido                        '+
                           ' inner join itens    i   on i.codigo_pedido = ped.codigo                          '+
                           ' inner join produtos pro on pro.codigo = i.codigo_produto                         '+
                           ' inner join ibpt         on ibpt.codigo = pro.codigo_ibpt                         '+
                           ' where (extract(year from nfce.dh_recebimento) = :ano and                         '+
                           '        extract(month from nfce.dh_recebimento) = :mes) '+ condicaoStatus+
                           ' order by nfce.dh_recebimento, ped.codigo ';

  self.qryNFCe.ParamByName('ano').AsString  := cmbAno.Items[cmbAno.ItemIndex];
  self.qryNFCe.ParamByName('mes').AsInteger := cmbMes.ItemIndex+1;
  self.qryNFCe.Open;
end;

procedure TfrmRelatorioNFCes.compactar;
var caminhoWinRAR, comando, nomeArquivo :String;
begin
  nomeArquivo  := 'XMLsNFCe'+cmbMes.Items[cmbMes.ItemIndex]+cmbAno.Items[cmbAno.ItemIndex]+'.rar ';

  if FileExists(diretorioExecutavel+'WinRAR.exe') then
    caminhoWinRAR := diretorioExecutavel+'WinRAR.exe'
  else if FileExists('C:\Program Files\WinRAR\WinRAR.exe') then
    caminhoWinRAR := 'C:\Program Files\WinRAR\WinRAR.exe';

  comando := 'a -ep '+diretorioExecutavel+'Docs\XMLs\'+nomeArquivo + diretorioExecutavel+'Docs\';

  ShellExecute(0, 'open', PChar(caminhoWinRAR), PChar(comando), '', SW_HIDE);
end;

procedure TfrmRelatorioNFCes.enviarPorEmail(mes, ano :String; emailContador :String);
var nomeArquivo :String;
begin
  nomeArquivo      := 'XMLs'+cmbMes.Items[cmbMes.ItemIndex]+cmbAno.Items[cmbAno.ItemIndex]+'.rar';
  try
    gerarPdf;

    if not FileExists(diretorioExecutavel+'Docs\XMLs\'+nomeArquivo) then
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
        ACBrMail1.AddAddress(emailContador);

        ACBrMail1.FromName  := dm.Empresa.razao;
        ACBrMail1.From      := dm.Empresa.ConfiguracoesEmail.smtp_user;
        //ACBrMail1.SetTLS    := true;
        //ACBrMail1.SetSSL    := true;
        ACBrMail1.IsHTML    := false;

        ACBrMail1.Subject   := 'NFC-es '+cmbMes.Items[cmbMes.ItemIndex]+' - '+cmbAno.Items[cmbAno.ItemIndex];
        ACBrMail1.Body.Text := 'ATENÇÃO, favor não responder. E-mail enviado automaticamente. '+
                               'Para contato utilize o e-mail: '+dm.Empresa.email +#13#10+
                                dm.Empresa.ConfiguracoesEmail.mensagem.Text +
                               'Email gerado automaticamente pelo Sistema SGVE 2.0 '+
                               'CBN Informática - (43) 3534-2350                   '+
                               'www.cbninfo.com.br';

        ACBrMail1.AltBody.Text := ACBrMail1.Body.Text;

        //ACBrMail1.AltBody.Text := 'teste';
        ACBrMail1.AddAttachment(TFileName( diretorioExecutavel+'Docs\XMLs\'+nomeArquivo));

        Application.ProcessMessages;
        ACBrMail1.Send;

      end
      else avisar(0,'Não foi possível enviar e-mail, pois não há configurações de e-mail cadastradas');

    Except
      on e : Exception do
        begin
          raise Exception.Create(e.Message);
        end;
    end;
  finally
    limparDiretorio(diretorioExecutavel+'Docs\');
  end;
end;

procedure TfrmRelatorioNFCes.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if ( (ssCtrl in Shift) AND (Key = ord('P')) ) then  btnImprimir.Click;
end;

procedure TfrmRelatorioNFCes.FormShow(Sender: TObject);
begin
  cmbMes.ItemIndex := MonthOf(Date)-1;
  cmbAno.ItemIndex := cmbAno.Items.IndexOf(formatDateTime('yyyy',Date));
end;

procedure TfrmRelatorioNFCes.gerarPdf;
var xmlsGerados :integer;
    tempoMedio :integer;
begin
  xmlsGerados := 0;

  if not DirectoryExists(diretorioExecutavel+'\Docs\XMLs') then
    CreateDir(diretorioExecutavel+'\Docs\XMLs');

  buscar;
  xmlsGerados := gerarXMLs;
  SetRoundMode(rmUp);
  //50 é uma média aproximada de xmls compactados por segundo
  tempoMedio  := Round(xmlsGerados/50);
  //1000 corresponde a 1 segundo
  tempoMedio  := tempoMedio * 100;
  SetRoundMode(rmNearest);

  RLPDFFilter1.ShowProgress := false;
  RLPDFFilter1.FileName     := diretorioExecutavel+'\Docs\NFCes' + cmbMes.Items[cmbMes.ItemIndex]+cmbAno.Items[cmbAno.ItemIndex]+'.PDF';
  RLReport1.ShowProgress    := false;
  RLReport1.Prepare;
  RLPDFFilter1.FilterPages(RLReport1.Pages);

  compactar;
  //aguarda o tempo da compactação
  sleep(tempoMedio);
  limparDiretorio(diretorioExecutavel+'Docs\');
end;

function TfrmRelatorioNFCes.gerarXMLs :integer;
begin
  result := 0;
  qryNFCe.First;
  while not qryNFCe.Eof do
  begin
    if not FileExists(diretorioExecutavel+'\Docs\NFe'+qryNFCeNR_NOTA.AsString+'.xml') then
    begin
      qryNFCeXML.SaveToFile(diretorioExecutavel+'\Docs\NFCe'+qryNFCeNR_NOTA.AsString+'.xml');
      inc(Result);
    end;
    qryNFCe.Next;
  end;
end;

procedure TfrmRelatorioNFCes.imprimir;
begin
  buscar;

  if self.qryNFCe.IsEmpty then
    avisar(1,'Nenhuma NFC-e foi encontrada utilizando os filtros fornecidos')
  else
    RLReport1.PreviewModal;
end;

procedure TfrmRelatorioNFCes.lbTotalDiaBeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
begin
  Text := FormatFloat(' ,0.00; -,0.00', totalDia);

  totalGeral := totalGeral + totalDia;
  totalDia   := 0;
end;

procedure TfrmRelatorioNFCes.lbTotalGeralBeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
begin
  Text := FormatFloat(' ,0.00; -,0.00', totalGeral);
  totalGeral := 0;
end;

procedure TfrmRelatorioNFCes.limparDiretorio(diretorio: String);
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

procedure TfrmRelatorioNFCes.RLDBText3BeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
begin
   lbQtde.Visible := true;
   lbNCM.Visible  := true;
end;

procedure TfrmRelatorioNFCes.RLDBText8BeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
begin
  totalDia := totalDia + StrToFloat( TStringUtilitario.RemoveCaracter(Text,'.'));
end;

procedure TfrmRelatorioNFCes.lbNCMAfterPrint(Sender: TObject);
begin
  lbNCM.Visible := false;
end;

procedure TfrmRelatorioNFCes.lbQtdeAfterPrint(Sender: TObject);
begin
  lbQtde.Visible := false;
end;

procedure TfrmRelatorioNFCes.RLReport1BeforePrint(Sender: TObject; var PrintIt: Boolean);
var todasSelecionadas :Boolean;
begin
  todasSelecionadas := (chkEnviadas.Checked and chkCanceladas.Checked and chkNaoEnviadas.Checked) or
                       (not chkEnviadas.Checked and not chkCanceladas.Checked and not chkNaoEnviadas.Checked);

  lbEnviadas.Visible    := chkEnviadas.Checked or todasSelecionadas;
  lbCanceladas.Visible  := chkCanceladas.Checked or todasSelecionadas;
  lbNaoEnviadas.Visible := chkNaoEnviadas.Checked or todasSelecionadas;

  rlbReferente.Caption   := 'Referente à '+cmbMes.Items[cmbMes.ItemIndex]+' de '+cmbAno.Items[cmbAno.ItemIndex];

  RLBand5.Height             := IfThen(rgpLeiaute.ItemIndex = 0, 23, 0);
  RLBand4.Borders.DrawBottom := (rgpLeiaute.ItemIndex = 0);

  totalDia   := 0;
  totalGeral := 0;
end;

end.
