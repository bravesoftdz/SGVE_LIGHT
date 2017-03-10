unit uRelatorioNFEs;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, filectrl, Funcoes,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uPadrao, RLReport, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, ACBrBase,
  ACBrMail, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.StrUtils, System.DateUtils, Math, ZLib, ShellAPI, RLFilters, RLPDFFilter;

type
  TfrmRelatorioNFEs = class(TfrmPadrao)
    GroupBox1: TGroupBox;
    cmbAno: TComboBox;
    GroupBox2: TGroupBox;
    cmbMes: TComboBox;
    GroupBox3: TGroupBox;
    chkEnviadas: TCheckBox;
    chkCanceladas: TCheckBox;
    chkNaoEnviadas: TCheckBox;
    rgpLeiaute: TRadioGroup;
    pnlBotoes: TPanel;
    btnImprimir: TBitBtn;
    btnVoltar: TBitBtn;
    RLReport1: TRLReport;
    RLBand1: TRLBand;
    RLLabel14: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel1: TRLLabel;
    RLSystemInfo1: TRLSystemInfo;
    RLLabel3: TRLLabel;
    RLSystemInfo2: TRLSystemInfo;
    RLLabel4: TRLLabel;
    RLSystemInfo3: TRLSystemInfo;
    RLLabel5: TRLLabel;
    RLSystemInfo4: TRLSystemInfo;
    rlbReferente: TRLLabel;
    RLDraw1: TRLDraw;
    RLDraw2: TRLDraw;
    RLDraw3: TRLDraw;
    RLLabel15: TRLLabel;
    lbEnviadas: TRLLabel;
    lbCanceladas: TRLLabel;
    lbNaoEnviadas: TRLLabel;
    RLGroup1: TRLGroup;
    RLBand3: TRLBand;
    RLDBText2: TRLDBText;
    RLLabel7: TRLLabel;
    RLLabel8: TRLLabel;
    RLLabel9: TRLLabel;
    RLLabel10: TRLLabel;
    RLGroup2: TRLGroup;
    RLBand4: TRLBand;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    RLDBText6: TRLDBText;
    RLLabel11: TRLLabel;
    RLDBText7: TRLDBText;
    RLDBText8: TRLDBText;
    RLBand5: TRLBand;
    RLDBText1: TRLDBText;
    RLDBText9: TRLDBText;
    RLDBText10: TRLDBText;
    lbQtde: TRLLabel;
    lbNCM: TRLLabel;
    RLBand6: TRLBand;
    RLLabel16: TRLLabel;
    lbTotalDia: TRLLabel;
    RLBand2: TRLBand;
    RLLabel13: TRLLabel;
    lbTotalGeral: TRLLabel;
    dsNFe: TDataSource;
    qryNFe: TFDQuery;
    ACBrMail1: TACBrMail;
    qryNFeNUMERO_NOTA_FISCAL: TIntegerField;
    qryNFeSTATUS: TStringField;
    qryNFeMOTIVO: TStringField;
    qryNFeCHAVE_ACESSO: TStringField;
    qryNFeXML: TMemoField;
    qryNFeDATA: TDateField;
    qryNFeTOTAL: TBCDField;
    qryNFePRODUTO: TStringField;
    qryNFeNCM_IBPT: TStringField;
    qryNFeQUANTIDADE: TBCDField;
    RLPDFFilter1: TRLPDFFilter;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure RLReport1BeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure lbQtdeAfterPrint(Sender: TObject);
    procedure lbNCMAfterPrint(Sender: TObject);
    procedure RLDBText8BeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
    procedure RLDBText4BeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
    procedure lbTotalGeralBeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
    procedure lbTotalDiaBeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
    procedure FormShow(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
  private
    totalDia :Real;
    totalGeral :Real;

    procedure buscar;
    procedure imprimir;
    function gerarXMLs :integer;
    procedure compactar;
    procedure limparDiretorio(diretorio :String);
  public
    function gerarPdf :Boolean;
    procedure enviarPorEmail(mes, ano :String; emailContador :String);
  end;

var
  frmRelatorioNFEs: TfrmRelatorioNFEs;

implementation

{$R *.dfm}

uses uModulo, StringUtilitario;

{ TfrmRelatorioNFEs }

procedure TfrmRelatorioNFEs.btnImprimirClick(Sender: TObject);
begin
  imprimir;
end;

procedure TfrmRelatorioNFEs.btnVoltarClick(Sender: TObject);
begin
  self.Close;
end;

procedure TfrmRelatorioNFEs.buscar;
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
      condicaoStatus := ' and (NFER.STATUS in ('+condicaoStatus+')';

    if chkNaoEnviadas.Checked then
    begin
      condicaoStatus := condicaoStatus + IfThen(condicaoStatus = '','and (','or')+
                                         ' not(NFER.STATUS in (''100'',''101''))) ';
    end
    else
      condicaoStatus := condicaoStatus + ')';
  end;

  self.qryNFe.Close;
  self.qryNFe.SQL.Text := 'select NF.numero_nota_fiscal, NFER.status, NFER.motivo, NFE.chave_acesso, NFE.XML,'+
                           ' CAST(NF.data_saida as DATE) data, TNF.total, PRO.descricao produto,               '+
                           ' ibpt.ncm_ibpt, INF.quantidade                           from NOTAS_FISCAIS NF     '+
                           ' left join NOTAS_FISCAIS_NFE NFE on NFE.CODIGO_NOTA_FISCAL = NF.CODIGO             '+
                           ' left join NOTAS_FISCAIS_NFE_RETORNO NFER ON NFER.CODIGO_NOTA_FISCAL = NF.CODIGO   '+
                           ' inner join ITENS_NOTAS_FISCAIS INF on INF.CODIGO_NOTA_FISCAL = NF.CODIGO          '+
                           ' inner join PRODUTOS PRO on PRO.CODIGO = INF.CODIGO_PRODUTO                        '+
                           ' inner join TOTAIS_NOTAS_FISCAIS TNF on TNF.CODIGO_NOTA_FISCAL = NF.CODIGO         '+
                           ' inner join ibpt         on ibpt.codigo = pro.codigo_ibpt                          '+
                           ' where (extract(year from NF.data_saida) = :ano and                                '+
                           '        extract(month from NF.data_saida) = :mes)                                  '+ condicaoStatus+
                           ' order by NF.data_saida, NF.numero_nota_fiscal                                     ';

  self.qryNFe.ParamByName('ano').AsString  := cmbAno.Items[cmbAno.ItemIndex];
  self.qryNFe.ParamByName('mes').AsInteger := cmbMes.ItemIndex+1;
  self.qryNFe.Open;
end;

procedure TfrmRelatorioNFEs.compactar;
var caminhoWinRAR, comando, nomeArquivo :String;
begin
  nomeArquivo  := 'XMLsNFe'+cmbMes.Items[cmbMes.ItemIndex]+cmbAno.Items[cmbAno.ItemIndex]+'.rar ';

  if FileExists(diretorioExecutavel+'WinRAR.exe') then
    caminhoWinRAR := diretorioExecutavel+'WinRAR.exe'
  else if FileExists('C:\Program Files\WinRAR\WinRAR.exe') then
    caminhoWinRAR := 'C:\Program Files\WinRAR\WinRAR.exe';

  comando := 'a -ep '+diretorioExecutavel+'Docs\XMLs\'+nomeArquivo + diretorioExecutavel+'Docs\';

  ShellExecute(0, 'open', PChar(caminhoWinRAR), PChar(comando), '', SW_HIDE);
end;

procedure TfrmRelatorioNFEs.enviarPorEmail(mes, ano, emailContador: String);
var nomeArquivo :String;
begin
  cmbMes.ItemIndex := cmbMes.Items.IndexOf(mes);
  cmbAno.ItemIndex := cmbAno.Items.IndexOf(ano);
  nomeArquivo      := 'XMLsNFe'+cmbMes.Items[cmbMes.ItemIndex]+cmbAno.Items[cmbAno.ItemIndex]+'.rar';
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

        ACBrMail1.FromName     := dm.Empresa.razao;
        ACBrMail1.From         := dm.Empresa.ConfiguracoesEmail.smtp_user;
        ACBrMail1.IsHTML       := false;

        ACBrMail1.Subject      := 'NF-es '+cmbMes.Items[cmbMes.ItemIndex]+' - '+cmbAno.Items[cmbAno.ItemIndex];
        ACBrMail1.Body.Text    := 'ATENÇÃO, favor não responder. E-mail enviado automaticamente. '+
                                  'Para contato utilize o e-mail: '+dm.Empresa.email +#13#10+
                                   dm.Empresa.ConfiguracoesEmail.mensagem.Text +
                                  'Email gerado automaticamente pelo Sistema SGVE 2.0 '+
                                  'CBN Informática - (43) 3534-2350                   '+
                                  'www.cbninfo.com.br';

        ACBrMail1.AltBody.Text := ACBrMail1.Body.Text;
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

procedure TfrmRelatorioNFEs.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if ( (ssCtrl in Shift) AND (Key = ord('P')) ) then  btnImprimir.Click;
end;

procedure TfrmRelatorioNFEs.FormShow(Sender: TObject);
begin
  cmbMes.ItemIndex := MonthOf(Date)-1;
  cmbAno.ItemIndex := cmbAno.Items.IndexOf(formatDateTime('yyyy',Date));
end;

function TfrmRelatorioNFEs.gerarPdf :Boolean;
var xmlsGerados :integer;
    tempoMedio :integer;
    RLPDFFilter :TRLPDFFilter;
begin
  xmlsGerados := 0;

  if not DirectoryExists(diretorioExecutavel+'\Docs\XMLs') then
    CreateDir(diretorioExecutavel+'\Docs\XMLs');

  buscar;
  xmlsGerados := gerarXMLs;

  if xmlsGerados = 0 then
    Exit(false);

  SetRoundMode(rmUp);
  //30 é uma média aproximada de xmls compactados por segundo
  tempoMedio  := Round(xmlsGerados/30);
  //1000 corresponde a 1 segundo
  tempoMedio  := tempoMedio * 1000;

  if tempoMedio < 1000 then
    tempoMedio := 1000;

  SetRoundMode(rmNearest);

  try
    RLPDFFilter              := TRLPDFFilter.Create(self);
    RLPDFFilter.ShowProgress := false;
    RLPDFFilter.FileName     := diretorioExecutavel+'\Docs\NFes' + cmbMes.Items[cmbMes.ItemIndex]+cmbAno.Items[cmbAno.ItemIndex]+'.PDF';
    RLReport1.ShowProgress   := false;
    RLReport1.Prepare;
    RLPDFFilter.FilterPages(RLReport1.Pages);

  finally
    FreeandNil(RLPDFFilter);
  end;

  sleep(tempoMedio);
  compactar;
  //aguarda o tempo da compactação
  sleep(tempoMedio);
  limparDiretorio(diretorioExecutavel+'Docs\');

  result := true;
end;

function TfrmRelatorioNFEs.gerarXMLs :integer;
begin
  result := 0;
  qryNFe.First;
  while not qryNFe.Eof do
  begin
    if FileExists(diretorioExecutavel+'\Docs\NFe'+qryNFeNUMERO_NOTA_FISCAL.AsString+'.xml') then
      DeleteFile(diretorioExecutavel+'\Docs\NFe'+qryNFeNUMERO_NOTA_FISCAL.AsString+'.xml');

    qryNFeXML.SaveToFile(diretorioExecutavel+'\Docs\NFe'+qryNFeNUMERO_NOTA_FISCAL.AsString+'.xml');
    inc(result);

    qryNFe.Next;
  end;

  result := qryNFe.RecordCount;
end;

procedure TfrmRelatorioNFEs.imprimir;
begin
  buscar;

  if self.qryNFe.IsEmpty then
    avisar(1,'Nenhuma NF-e foi encontrada utilizando os filtros fornecidos')
  else
    RLReport1.PreviewModal;
end;

procedure TfrmRelatorioNFEs.lbNCMAfterPrint(Sender: TObject);
begin
  lbNCM.Visible := false;
end;

procedure TfrmRelatorioNFEs.lbQtdeAfterPrint(Sender: TObject);
begin
  lbQtde.Visible := false;
end;

procedure TfrmRelatorioNFEs.lbTotalDiaBeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
begin
  Text := FormatFloat(' ,0.00; -,0.00', totalDia);

  totalGeral := totalGeral + totalDia;
  totalDia   := 0;
end;

procedure TfrmRelatorioNFEs.lbTotalGeralBeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
begin
  Text := FormatFloat(' ,0.00; -,0.00', totalGeral);
  totalGeral := 0;
end;

procedure TfrmRelatorioNFEs.limparDiretorio(diretorio: String);
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

procedure TfrmRelatorioNFEs.RLDBText4BeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
begin
   lbQtde.Visible := true;
   lbNCM.Visible  := true;
end;

procedure TfrmRelatorioNFEs.RLDBText8BeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
begin
  totalDia := totalDia + StrToFloat( TStringUtilitario.RemoveCaracter(Text,'.'));
end;

procedure TfrmRelatorioNFEs.RLReport1BeforePrint(Sender: TObject; var PrintIt: Boolean);
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
