unit uCCe;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, uPadrao,
  DB, Provider, DBClient, ExtCtrls, StdCtrls, DBCtrls, Mask, Grids, DBGrids,
  Buttons, ComCtrls, Dialogs, ACBrNFe, pcnConversao, ACBrNFeDANFEClass, //ACBrNFeDANFERave,
  ACBrUtil, pcnNFeW, pcnNFeRTXT, pcnAuxiliar, XMLIntf, XMLDoc, OleCtrls, SHDocVw,
 // ACBrNFeUtil,
  DBGridCBN, filectrl, frameBuscaNotaFiscal, ImgList,
  frameBuscaEmpresa, System.ImageList, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TfrmCCe = class(TfrmPadrao)
    Timer1: TTimer;
    cdsCorrecoes: TClientDataSet;
    dsCorrecoes: TDataSource;
    dspLotes: TDataSetProvider;
    cdsLotes: TClientDataSet;
    dsLotes: TDataSource;
    cdsLotesCODIGO: TIntegerField;
    cdsLotesDATA: TDateField;
    cdsLotesSTATUS: TStringField;

    cdsLotesMOTIVO: TStringField;
    cdsCorrecoesCORRECAO: TStringField;
    cdsCorrecoesNRNOTA: TIntegerField;
    cdsCorrecoesCHAVENFE: TStringField;
    cdsCorrecoesSTATUS: TStringField;
    cdsCorrecoesMOTIVO: TStringField;
    cdsCorrecoesDT_CORR: TDateTimeField;
    cdsCorrecoesCODIGO: TIntegerField;
    StatusBar1: TStatusBar;
    PC1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Panel2: TPanel;
    gbCorrecao: TGroupBox;
    GroupBox2: TGroupBox;
    btnInc: TSpeedButton;
    btnAlt: TSpeedButton;
    btnEnv: TSpeedButton;
    btnXML: TSpeedButton;
    btnImprimir: TSpeedButton;
    Panel3: TPanel;
    Label5: TLabel;
    memoXML: TMemo;
    dbCodLote: TDBEdit;
    gbInfNota: TGroupBox;
    edID: TEdit;
    Label12: TLabel;
    pnBtn: TPanel;
    btnDeleta: TSpeedButton;
    BtnSalva: TSpeedButton;
    btnCancela: TSpeedButton;
    btnEdita: TSpeedButton;
    bitImprimir: TSpeedButton;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    Label2: TLabel;
    Label3: TLabel;
    btnSalvar: TSpeedButton;
    btnCancelar: TSpeedButton;
    Label1: TLabel;
    qtdCar: TLabel;
    MCorrecao: TMemo;
    GroupBox3: TGroupBox;
    SpeedButton2: TSpeedButton;
    gridCorrecoes: TDBGrid;
    gridLotes: TDBGridCBN;
    BuscaNotaFiscal1: TBuscaNotaFiscal;
    ImageList1: TImageList;
    edtID: TEdit;
    bitIncluir: TBitBtn;
    cdsCorrecoesCODNOTA: TIntegerField;
    BuscaEmpresa1: TBuscaEmpresa;
    btnBuscar: TBitBtn;
    gridNotas: TDBGridCBN;
    DataSource1: TDataSource;
    Label4: TLabel;
    Label6: TLabel;
    cdsDeletados: TClientDataSet;
    cdsDeletadoscodigo_correcao: TIntegerField;
    dtLanc: TMaskEdit;
    qryLotes: TFDQuery;
    procedure BitIncluirClick(Sender: TObject);
    procedure btnIncClick(Sender: TObject);
    procedure btnAltClick(Sender: TObject);
    procedure MCorrecaoKeyPress(Sender: TObject; var Key: Char);
    procedure Timer1Timer(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnEditaClick(Sender: TObject);
    procedure btnDeletaClick(Sender: TObject);
    procedure cdsCorrecoesAfterScroll(DataSet: TDataSet);
    procedure MCorrecaoEnter(Sender: TObject);
    procedure MCorrecaoExit(Sender: TObject);
    procedure BtnSalvaClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnEnvClick(Sender: TObject);
    procedure btnXMLClick(Sender: TObject);
    procedure BitImprimirClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure cdsLotesAfterScroll(DataSet: TDataSet);
    procedure SpeedButton2Click(Sender: TObject);
    procedure gridCorrecoesEnter(Sender: TObject);
    procedure gridCorrecoesExit(Sender: TObject);
    procedure gridCorrecoesDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure BuscaNotaFiscal1Exit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure gridLotesDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure gridLotesEnter(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure BuscaNotaFiscal1edtNrNotaEnter(Sender: TObject);
  private
    FEditCorr  : boolean;
    FEditLote  : boolean;
    FInserindo : boolean;
    AcbrNfe    : TACBrNFe;

    procedure salvar;
    procedure setaPadrao;
    procedure salvaRetorno;
    procedure carregaCorrecoes;
    procedure armazena_deletado;
    procedure efetua_delecao;

    function verificaLotesEnviadas :String;
    function verificaSemEnviar :integer;
    function ultimoLote :integer;
    function geraXmlCorrecoes(lote :integer) :boolean;
    function NumCorrNota(CODNOTA :integer) :integer;
    function ultimoCodRetorno : integer;
    function AcbrCreate :boolean;

    function monta_sql :String;
  public

  end;

var
  frmCCe: TfrmCCe;

implementation

uses uModulo, uImpCCE, pcnCCeNFe, funcoes, Empresa, ConfiguracoesNF,
  ACBrNFeWebServices, StringUtilitario;

{$R *.dfm}

procedure TfrmCCe.BitIncluirClick(Sender: TObject);
var lote :integer;
begin

  if not cdsCorrecoes.IsEmpty then begin
    cdsCorrecoes.First;
    if not (Campo_por_campo('NOTAS_FISCAIS', 'CODIGO_EMITENTE', 'CODIGO', cdsCorrecoesCODNOTA.AsString) =
            Campo_por_campo('NOTAS_FISCAIS', 'CODIGO_EMITENTE', 'CODIGO', intToStr(BuscaNotaFiscal1.codNotaFiscal))) then begin
      avisar('Notas de empresas diferentes não podem ser inseridas no mesmo lote de correção');
      Exit;
    end;
  end;
                                                         
  if trim(BuscaNotaFiscal1.ID) = '' then
    begin
      Avisar('Nenhuma nota foi selecionada.');
      exit;
    end;

    
  if cdsCorrecoes.Active and cdsCorrecoes.Locate('CODNOTA', strToInt(IntToStr(BuscaNotaFiscal1.codNotaFiscal)), [loPartialKey]) then
    begin
      if confirma('Correção para esta nota já existe, deseja edita-la?') Then
         btnEdita.Click;
      exit;
    end;

  lote := verificaSemEnviar;

  if lote > 0 then //Barra ação, se houver uma correção criada desta nota, não autorizada.
    begin
      avisar('Correção para esta nota já existe e não foi enviada, no lote nº '+ intToStr(lote));
      exit;
    end;

  MCorrecao.Text := verificaLotesEnviadas;// adiciona texto das correções anteriores ao memo, se houverem.

  MCorrecao.Lines.Text := MCorrecao.Lines.Text +' '; //Da um espaço no final do texto do memo
  MCorrecao.SelStart := Length(MCorrecao.Text); //move o cursor pra o final da ultima linha

  gbCorrecao.Enabled := true;
  MCorrecao.Color   := clWhite;

  MCorrecao.SetFocus;
  dtLanc.Text := formatDateTime('dd/mm/yyyy',now);

end;

procedure TfrmCCe.btnIncClick(Sender: TObject);
begin
  if self.BuscaEmpresa1.edtRazao.Text = '' then begin
    avisar('Primeiramente selecione uma empresa');
    self.BuscaEmpresa1.edtCodigo.SetFocus;
    exit;
  end;

  bitIncluir.Enabled  := true;
  FInserindo          := true;
  gridLotes.Enabled   := false;
  gbInfNota.Enabled   := true;
  pnBtn.enabled       := true;
  PC1.ActivePageIndex := 1;
  BuscaNotaFiscal1.edtNrNota.SetFocus;
  
  if cdsCorrecoes.active then
    cdsCorrecoes.EmptyDataSet;
end;

procedure TfrmCCe.btnAltClick(Sender: TObject);
begin
  if cdsLotes.IsEmpty then
    Exit;

  gridLotes.Enabled := false;
  if (cdsLotesSTATUS.AsString = '135')or(cdsLotesSTATUS.AsString = '136') then
    begin
      avisar('Não é possível alterar um lote já autorizado!');
      exit;
    end;

  PC1.ActivePageIndex := 1;
  pnBtn.Enabled       := true;
  gbInfNota.Enabled   := true;
  bitIncluir.Enabled  := true;
  label5.Visible      := true;
  dbCodLote.Visible   := true;
  dbCodLote.Visible   := true;
  FEditLote           := true;
end;

procedure TfrmCCe.MCorrecaoKeyPress(Sender: TObject; var Key: Char);
begin
  Timer1.enabled := true;
end;

procedure TfrmCCe.Timer1Timer(Sender: TObject);
begin
  qtdCar.Caption := intToStr( 1000 - length(MCorrecao.Text));
  timer1.Enabled := false;
end;

procedure TfrmCCe.btnSalvarClick(Sender: TObject);
begin
  if length(MCorrecao.Text) < 10 then
    begin
      avisar('Informe as devidas correções!');
      exit;
    end;

  if not cdsCorrecoes.Active then
    cdsCorrecoes.CreateDataSet;

  gridCorrecoes.Enabled := true;

  if FEditCorr then
    cdsCorrecoes.Edit
  else begin
    cdsCorrecoes.Append;
    cdsCorrecoesNRNOTA.AsInteger     := strToInt(BuscaNotaFiscal1.NumeroNotaFiscal);
    cdsCorrecoesCODNOTA.AsInteger     := BuscaNotaFiscal1.codNotaFiscal;
    cdsCorrecoesCHAVENFE.asString    := BuscaNotaFiscal1.ID;
    cdsCorrecoesDT_CORR.asDateTime   := now;
  end;

    cdsCorrecoesCORRECAO.asString    := trim(MCorrecao.Text);

    cdsCorrecoes.Post;

    gridCorrecoes.setFocus;
    gbCorrecao.enabled := false;
    MCorrecao.Color    := $00D8D8D8;

    qtdCar.Caption     := '1000';
    FEditCorr          := false;

    BuscaNotaFiscal1.limpa;
    edtID.Clear;
end;

procedure TfrmCCe.btnCancelarClick(Sender: TObject);
begin
  gridCorrecoes.Enabled := true;
  gridCorrecoes.setFocus;

  gbCorrecao.Enabled := false;
  MCorrecao.Color    := $00D8D8D8;
  qtdCar.Caption     := '1000';
  FEditCorr          := false;
  Finserindo         := false;
end;

procedure TfrmCCe.btnEditaClick(Sender: TObject);
begin
  if cdsCorrecoes.IsEmpty then
    exit;

  if (cdsCorrecoesSTATUS.AsString = '135') or (cdsCorrecoesSTATUS.AsString = '136') then
    begin
      avisar('Uma correção já autorizada não pode ser editada');
      exit;
    end;

  gbCorrecao.enabled := true;
  MCorrecao.Color    := clWhite;
  MCorrecao.Text     := cdsCorrecoesCORRECAO.AsString;
  MCorrecao.SetFocus;

  gridCorrecoes.Enabled := false;
  FEditCorr := true;
  
  MCorrecao.Lines.Text  := MCorrecao.Lines.Text +' '; //Da um espaço no final do texto do memo
  MCorrecao.SelStart    := Length(MCorrecao.Text); //move o cursor pra o final da ultima linha
end;

procedure TfrmCCe.btnDeletaClick(Sender: TObject);
begin
  if not (cdsCorrecoes.Active) or (cdsCorrecoes.IsEmpty) then
    Exit;
     
  if (cdsCorrecoesSTATUS.AsString = '135') or (cdsCorrecoesSTATUS.AsString = '136') then
    begin
      avisar('Uma correção já autorizada não pode ser excluída');
      exit;
    end;

  if confirma('Deseja realmente excluir a correção selecionada?') Then begin

    if cdsCorrecoesCODIGO.AsInteger > 0 then
      armazena_deletado;

    cdsCorrecoes.Delete;
  end;
end;

procedure TfrmCCe.cdsCorrecoesAfterScroll(DataSet: TDataSet);
begin
  if TRIM(cdsCorrecoesCORRECAO.AsString) <> '' then
     MCorrecao.Text := cdsCorrecoesCORRECAO.AsString;
end;

procedure TfrmCCe.MCorrecaoEnter(Sender: TObject);
begin
  label3.visible := true;
  qtdCar.visible := true;
end;

procedure TfrmCCe.MCorrecaoExit(Sender: TObject);
begin
  label3.visible := false;
  qtdCar.visible := false;
end;

function TfrmCCe.verificaLotesEnviadas: String;
begin
   result := '';

   dm.qryGenerica.Close;
   dm.qryGenerica.SQL.Text := 'select cc.correcao from correcoes_cce cc where cc.CODIGO_NOTA = :codnota '+
                              'and cc.codigo in ( select rcc.cod_correcao from return_cce_corr rcc   '+
                              '                   where rcc.status in (''135'',''136''))             '+
                              'order by cod_lote                                                     ';

   dm.qryGenerica.ParamByName('codnota').AsInteger := BuscaNotaFiscal1.codNotaFiscal;
   dm.qryGenerica.Open;

   if dm.qryGenerica.IsEmpty then EXIT;

   while not dm.qryGenerica.Eof do begin

      result := result + dm.qryGenerica.fieldByName('correcao').AsString + #13#10;

      dm.qryGenerica.Next;
   end;
end;

procedure TfrmCCe.BtnSalvaClick(Sender: TObject);
begin
 try
  if cdsCorrecoes.isEmpty then
    exit;

  salvar;
  btnCancela.Click;

  if cdsLotes.Active then
    cdsLotes.Refresh;

 except
   on e : Exception do
     begin
       avisar('Erro ao tentar salvar correções!'+#13#10+e.Message);
     end;
 end;
end;

procedure TfrmCCe.salvar;
var codLote :Integer;
begin
  if FEditLote = true then begin

     dm.qryGenerica.Close;
     dm.qryGenerica.sql.text := 'update or insert into correcoes_cce(codigo, cod_lote, codigo_nota, dt_correcao, correcao) '+
                                ' values (:codigo, :codlot, :codnf, :dtcorr, :corr)                            ';

     cdsCorrecoes.first;
     while not cdsCorrecoes.Eof do begin

       dm.qryGenerica.ParamByName('codigo').AsInteger  := cdsCorrecoesCODIGO.AsInteger;
       dm.qryGenerica.ParamByName('codlot').AsInteger  := cdsLotesCodigo.AsInteger;
       dm.qryGenerica.ParamByName('codnf').AsInteger   := cdsCorrecoesCODNOTA.AsInteger;
       dm.qryGenerica.ParamByName('dtcorr').AsDateTime := cdsCorrecoesDT_CORR.AsDateTime;
       dm.qryGenerica.ParamByName('corr').AsString     := cdsCorrecoesCORRECAO.AsString;
       dm.qryGenerica.ExecSQL;

       cdsCorrecoes.Next;
     end;

     label5.Visible      := false;
     dbCodLote.Visible   := false;
     dbCodLote.Visible   := false;
     FEditLote           := false;

     if not cdsDeletados.IsEmpty then
       efetua_delecao;
  end
  else begin

     // insere novo lote
     dm.qryGenerica.Close;
     dm.qryGenerica.sql.text := 'insert into lotes_cce(codigo, data) values(0,:data)';
     dm.qryGenerica.ParamByName('data').AsDateTime := date;
     dm.qryGenerica.ExecSQL;

     codLote := ultimoLote;

     // insere novas correcoes
     dm.qryGenerica.close;
     dm.qryGenerica.sql.text := 'insert into correcoes_cce(codigo, cod_lote, codigo_NOTA, dt_correcao, correcao) '+
                                ' values (0, :codlot, :codnf, :dtcorr, :corr)                                ';

     cdsCorrecoes.first;
     while not cdsCorrecoes.Eof do begin

       dm.qryGenerica.ParamByName('codlot').AsInteger  := codLote;
       dm.qryGenerica.ParamByName('codnf').AsInteger   := cdsCorrecoesCODNOTA.AsInteger;
       dm.qryGenerica.ParamByName('dtcorr').AsDateTime := cdsCorrecoesDT_CORR.AsDateTime;
       dm.qryGenerica.ParamByName('corr').AsString     := cdsCorrecoesCORRECAO.AsString;
       dm.qryGenerica.ExecSQL;

       cdsCorrecoes.Next;
     end;
     FInserindo := false;
  end;

end;

procedure TfrmCCe.btnCancelaClick(Sender: TObject);
begin
  label5.Visible      := false;
  dbCodLote.Visible   := false;
  dbCodLote.Visible   := false;
  FEditLote           := false;
  FEditCorr           := false;

  setaPadrao;
end;

function TfrmCCe.ultimoLote: integer;
begin
  dm.qryGenerica.close;
  dm.qryGenerica.sql.text := 'select max(l.codigo) codigo from lotes_cce l';
  dm.qryGenerica.Open;

  result := dm.qryGenerica.fieldByName('codigo').AsInteger;
end;

procedure TfrmCCe.carregaCorrecoes;
begin

  dm.qryGenerica.close;
  dm.qryGenerica.sql.text := 'select c.*, re.motivo, re.status, nf.numero_nota_fiscal, nfe.chave_acesso '+
                             'from correcoes_cce c                                                      '+
                             'left join return_cce_corr re    on re.cod_correcao = c.codigo             '+
                             'left join notas_fiscais nf      on nf.codigo = c.codigo_nota              '+
                             'left join notas_fiscais_nfe nfe on nfe.codigo_nota_fiscal = nf.codigo     '+
                             'where cod_lote = :codlot                                                  ';

  dm.qryGenerica.ParamByName('codlot').AsInteger := cdsLotesCODIGO.AsInteger;
  dm.qryGenerica.Open;

  if not dm.qryGenerica.IsEmpty then
    begin

      dm.qryGenerica.First;
      if not cdsCorrecoes.Active then
        cdsCorrecoes.CreateDataSet;

      cdsCorrecoes.EmptyDataSet;

      while not dm.qryGenerica.Eof do begin

        cdsCorrecoes.Append;
        cdsCorrecoesCODIGO.AsInteger   := dm.qryGenerica.fieldByName('codigo').AsInteger;
        cdsCorrecoesSTATUS.AsString    := dm.qryGenerica.fieldByName('status').AsString;
        cdsCorrecoesMOTIVO.AsString    := dm.qryGenerica.fieldByName('motivo').AsString;
        cdsCorrecoesNRNOTA.AsInteger   := dm.qryGenerica.fieldByName('numero_nota_fiscal').AsInteger;
        cdsCorrecoesCORRECAO.AsString  := dm.qryGenerica.fieldByName('correcao').AsString;
        cdsCorrecoesCHAVENFE.AsString  := dm.qryGenerica.fieldByName('chave_acesso').AsString;
        cdsCorrecoesDT_CORR.asDateTime := dm.qryGenerica.fieldByName('dt_correcao').AsDateTime;
        cdsCorrecoesCODNOTA.AsInteger   := dm.qryGenerica.fieldByName('codigo_nota').AsInteger;
        cdsCorrecoes.Post;

        dm.qryGenerica.Next;
      end;
    end;

end;

procedure TfrmCCe.setaPadrao;
begin
  if gbCorrecao.Enabled = true then
    btnCancelar.Click;

  PC1.ActivePageIndex := 0;
  gridLotes.Enabled   := true;
  gridLotes.SetFocus;
  gbInfNota.Enabled   := false;
  pnBtn.Enabled       := false;
  BuscaNotaFiscal1.limpa;
  MCorrecao.Clear;
  edtid.Clear;

end;

procedure TfrmCCe.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if (Key = Vk_F4) and (PC1.ActivePageIndex = 0) then
    btnAlt.Click
  else if (Key = Vk_F4) and (PC1.ActivePageIndex = 1) then
    btnEdita.Click
  else if Key = Vk_F3 then
    btnInc.Click
  else if Key = Vk_F6 then
    BtnSalva.Click
  else if Key = Vk_F5 then
    btnEnv.Click
  else if Key = Vk_Escape then
    begin
      if PC1.ActivePageIndex = 0 then
        close
      else if FEditLote or FInserindo then
        btnCancela.Click
      else
        Close;
    end
  else if Key = Vk_Delete then
    btnDeleta.Click;
end;

function TfrmCCe.verificaSemEnviar: integer;
begin
   result := 0;

   dm.qryGenerica.sql.text := 'select cc.cod_lote from correcoes_cce cc where cc.CODIGO_NOTA = :CODNOTA           '+
                              'and 0 = ( select count(rcc.cod_correcao) from return_cce_corr rcc                 '+
                              '          where rcc.cod_correcao = cc.codigo and rcc.status in (''135'',''136'')) ';

   dm.qryGenerica.ParamByName('CODNOTA').AsInteger := BuscaNotaFiscal1.codNotaFiscal;
   dm.qryGenerica.Open;

   result := dm.qryGenerica.fieldByName('cod_lote').asInteger;
end;

procedure TfrmCCe.btnEnvClick(Sender: TObject);
begin
 try
 try
  if cdsLotes.IsEmpty then
    Exit;

  if not Confirma('Enviar correções do Lote nº '+cdsLotesCODIGO.AsString+' ?') Then
    exit;

  if not AcbrCreate then
    exit;

  carregaCorrecoes;

  Aguarda('Enviando Lote...');

  AcbrNfe.Configuracoes.Certificados.NumeroSerie := BuscaEmpresa1.Empresa.ConfiguracoesNF.num_certificado;
  AcbrNfe.Configuracoes.Certificados.Senha       := BuscaEmpresa1.Empresa.ConfiguracoesNF.SenhaCertificado;

  if not (ACBrNFe.WebServices.StatusServico.Executar) then
    raise exception.Create(ACBrNFe.WebServices.StatusServico.Msg);


  if not geraXmlCorrecoes(cdsLotesCODIGO.AsInteger) then
    raise Exception.Create( 'Erro ao gerar o XML das correções!' );


  if not self.AcbrNfe.EnviarEvento(cdsLotesCODIGO.AsInteger){self.AcbrNfe.EnviarCartaCorrecao(cdsLotesCODIGO.AsInteger)} then
    avisar('Erro ao enviar o lote!');

  salvaRetorno;

  FimAguarda('');
  Avisar('Lote enviado com sucesso!');
 Except
  On E: Exception Do
   begin
    FimAguarda('');
    Avisar(E.Message);
   end;
 end;

 finally
   btnBuscar.Click;
 end;
end;

function TfrmCCe.geraXmlCorrecoes(lote :integer): boolean;
begin
  try
    result := false;

    self.AcbrNfe.EventoNFe.Evento.Clear;

    cdsCorrecoes.First;
    while not cdsCorrecoes.Eof do
    begin
    
      with self.AcbrNfe.EventoNFe.Evento.Add do
      begin
        infEvento.chNFe               := cdsCorrecoesCHAVENFE.asString;;
        infEvento.CNPJ                := Copy(cdsCorrecoesCHAVENFE.asString,7,14);
        infEvento.dhEvento            := now;
        infEvento.tpEvento            := teCCe;
        infEvento.nSeqEvento          := NumCorrNota(cdsCorrecoesCODNOTA.asInteger) + 10;
        infEvento.detEvento.xCorrecao := TStringUtilitario.remove_quebras(cdsCorrecoesCORRECAO.asString);
      end;

      cdsCorrecoes.Next;
    end;

    self.AcbrNfe.EventoNFe.GerarXML;

    result := true;
  except

  end;
end;

function TfrmCCe.NumCorrNota(CODNOTA: integer): integer;
begin
  result := 0;

  dm.qryGenerica.sql.text := 'select count(cc.codigo) ultima from correcoes_cce cc                '+
                             'left join return_cce_corr rcc on rcc.cod_correcao = cc.codigo       '+
                             'where rcc.status in (''135'',''136'') and cc.codigo_nota = :codnota ';
  dm.qryGenerica.ParamByName('codnota').AsInteger := CODNOTA;
  dm.qryGenerica.Open;

  result := dm.qryGenerica.fieldByName('ultima').AsInteger;
end;

procedure TfrmCCe.salvaRetorno;
var i :integer;
    StringStream: TStringStream;
    memo :tmemo;
begin
  try
     { Setando e gravando os dados do XML de retorno pelo objeto do AcBR }
     { Salvando os dados de retorno do lote }

     dm.qryGenerica2.sql.text := 'update or insert into return_cce_lote (codigo, cod_lote, status, motivo) '+
                                 'values (:codigo, :codLote, :Stat, :Motivo)';

     dm.qryGenerica2.ParamByName('codigo').AsInteger  := StrToIntDef(Campo_por_campo('RETURN_CCE_LOTE', 'CODIGO', 'COD_LOTE', cdsLotesCODIGO.AsString) ,0);
     dm.qryGenerica2.ParamByName('codLote').AsInteger := cdsLotesCODIGO.AsInteger;
     dm.qryGenerica2.ParamByName('Stat').AsInteger    := 128;
     dm.qryGenerica2.ParamByName('Motivo').asString   := 'Lote de Evento Processado';

     dm.qryGenerica2.ExecSQL;

     memo := TMemo.Create(nil);
   //  dt := self.ACBrNFe.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.dhRegEvento;
     memo.Text := self.ACBrNFe.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.XML;

     memo.Lines.SaveToFile('C:\Users\User\Desktop\teste.xml');

     { Salvando os dados de retorno dos eventos }
     dm.qryGenerica2.sql.text := 'update or insert into return_cce_corr (codigo, cod_correcao, status, motivo) '+
                                'values (:codigo, :codCorr, :Stat, :Motivo)';
     cdsCorrecoes.First;

     while not cdsCorrecoes.Eof do begin

        i := cdsCorrecoes.RecNo - 1;

        dm.qryGenerica2.ParamByName('codigo').AsInteger  := StrToIntDef(Campo_por_campo('RETURN_CCE_corr', 'CODIGO', 'COD_correcao', cdsCorrecoesCODIGO.AsString) ,0);
        dm.qryGenerica2.ParamByName('codCorr').AsInteger := cdsCorrecoesCODIGO.AsInteger;
        dm.qryGenerica2.ParamByName('Stat').AsInteger    := self.ACBrNFe.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.cStat;
        dm.qryGenerica2.ParamByName('Motivo').asString   := self.ACBrNFe.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.xMotivo;

        dm.qryGenerica2.ExecSQL;

        cdsCorrecoes.Next;

         { Salvando o XML no banco de dados }

         MemoXML.Text := UTF8Encode(self.ACBrNFe.WebServices.EnvEvento.RetWS);

         MemoXML.Lines.SaveToFile(PathWithDelim(ExtractFileDir(application.ExeName))+'Eventotemp.xml');

         StringStream := TStringStream.Create( self.ACBrNFe.WebServices.EnvEvento.RetWS );

         dm.qryGenerica.sql.text := 'insert into cce_xml (codigo, COD_RET_CORR, xml) values (0, :codcorr, :xml)';
         dm.qryGenerica.ParamByName('codcorr').AsInteger := ultimoCodRetorno;
         dm.qryGenerica.ParamByName('xml').LoadFromStream(StringStream, ftBlob);

         dm.qryGenerica.ExecSQL;

     end;

  Except
    on e : Exception do
       raise Exception.Create('Erro ao salvar XML.'+#13#10+e.Message);
  end;
end;

function TfrmCCe.ultimoCodRetorno: integer;
begin

  dm.qryGenerica2.sql.text := 'select max(codigo) codigo from return_cce_corr';
  dm.qryGenerica2.Open;

  result := dm.qryGenerica2.fieldByName('codigo').AsInteger;
end;

function TfrmCCe.AcbrCreate :boolean;
begin
 try
   result := false;

    if self.AcbrNfe = nil then
    begin
      self.AcbrNfe := TACBrNFe.Create(Application);

      { Web Services }
      self.AcbrNfe.Configuracoes.WebServices.UF           := 'PR';
      self.AcbrNfe.Configuracoes.WebServices.Visualizar   := false;              // Visualizar mensagens
      self.AcbrNfe.Configuracoes.Geral.FormaEmissao       := teNormal;

      if BuscaEmpresa1.Empresa.ConfiguracoesNF.ambiente_nfe = 'P' then
        self.AcbrNfe.Configuracoes.WebServices.Ambiente   := taProducao
      else
        self.AcbrNfe.Configuracoes.WebServices.Ambiente   := taHomologacao;

      result := true;
    end
    else
      result := true;
      
 except
   Avisar('Erro ao configurar ACBR!');
 end;
end;

procedure TfrmCCe.btnXMLClick(Sender: TObject);
var
  vCaminho :string;
  i :Integer;
begin
  try

    if cdsLotes.IsEmpty then
      Exit;

    if not SelectDirectory('Selecione o local que o XML será salvo.', '', vCaminho) then
        raise Exception.Create( ' Nenhum diretório identificado ' );

    dm.qryGenerica.sql.text := 'select xml.*, rcc.cod_correcao from cce_xml xml                 '+
                               ' left join return_cce_corr rcc on rcc.codigo = xml.cod_ret_corr '+
                               ' left join correcoes_cce cc on cc.codigo = rcc.cod_correcao     '+
                               ' left join lotes_cce lcc on lcc.codigo = cc.cod_lote            '+
                               ' where lcc.codigo = :cod                                        ';

    dm.qryGenerica.ParamByName('cod').AsInteger := self.cdsLotesCODIGO.AsInteger;
    dm.qryGenerica.Open;

    if dm.qryGenerica.IsEmpty then
      Exit;

    dm.qryGenerica.First;
    for i:= 1 to dm.qryGenerica.RecordCount do begin
      memoXML.Text := dm.qryGenerica.fieldByName('XML').asString;

      memoXML.Lines.SaveToFile( vCaminho   + '\CCe_Lote-' + self.cdsLotesCODIGO.AsString +
                               '_Evento-' + IntToStr(i) + '.xml');

      dm.qryGenerica.Next;
    end;

    Avisar('XML gerado com sucesso!');

  except
   On E: Exception Do begin
     Avisar('Erro ao gerar XML!'+#13#10+e.Message);
   end;
  end;
end;

procedure TfrmCCe.BitImprimirClick(Sender: TObject);
begin
  if not(cdsCorrecoes.active) or (cdsCorrecoes.IsEmpty) then
    exit;

  If cdsCorrecoes.Recno <= 0 then begin
    Avisar('Primeiramente selecione o registro desejado');
    exit;
  end;

  if cdsCorrecoesSTATUS.AsString = '135' then
  begin
    frm_impCCE         := Tfrm_impCCE.Create(self);
    frm_impCCE.CodCorr := self.cdsCorrecoesCODIGO.AsInteger;
    frm_impCCE.ExecutaReport;
    frm_impCCE.Release;
    frm_impCCE := nil;
  end;
end;

procedure TfrmCCe.btnImprimirClick(Sender: TObject);
begin
  if cdsCorrecoes.IsEmpty then
    exit;

  cdsCorrecoes.first;
  while not cdsCorrecoes.Eof do begin

    if cdsCorrecoesSTATUS.AsString = '135' then
      bitImprimir.Click;
      
    cdsCorrecoes.Next;  
  end;
end;

procedure TfrmCCe.cdsLotesAfterScroll(DataSet: TDataSet);
begin
  carregaCorrecoes;
  gridCorrecoes.Repaint;

  btnXML.Enabled      := (cdsLotesSTATUS.asString = '128');
  btnImprimir.Enabled := (cdsLotesSTATUS.asString = '128');

  if (cdsLotesSTATUS.asString = '128') then begin

     btnEnv.Enabled := false;
     cdsCorrecoes.First;
     while not cdsCorrecoes.Eof do begin
       if cdsCorrecoesSTATUS.AsInteger <> 135 then
         btnEnv.Enabled := true;
         
       cdsCorrecoes.Next;
     end;
     cdsCorrecoes.First;
  end;
end;

procedure TfrmCCe.SpeedButton2Click(Sender: TObject);
begin
  Avisar('             ..:: CONDIÇÕES DE USO ::..'+#13+#10+#13+#10+
         '"A Carta de Correção e disciplinada pelo parágrafo 1o-A do art. 7o do Convênio S/N.'+#13+#10+
         'de 15 de dezembro de 1970 e pode ser utilizada para regularização do erro ocorrido'+#13+#10+
         'na emissaão do documento fiscal, desde que o erro não esteja relacionado com:'+#13+#13+#10+
         'I - as variaveis que determinam o valor do imposto tais como: base de cálculo,'+#13+#10+
         '     alíquota, diferenca de preco, quantidade, valor da operação ou da prestação;'+#13+#10+
         'II - a correção de dados cadastrais que implique mudanca do remetente ou do  destinatário;'+#13+#10+
         'III - a data de emissão ou de saída."');
end;

procedure TfrmCCe.gridCorrecoesEnter(Sender: TObject);
begin
  btnEdita.Enabled  := (cdsCorrecoes.Active and not cdsCorrecoes.IsEmpty);
  btnDeleta.Enabled := (cdsCorrecoes.Active and not cdsCorrecoes.IsEmpty);

  cdsCorrecoesAfterScroll(nil);
end;

procedure TfrmCCe.gridCorrecoesExit(Sender: TObject);
begin
  btnEdita.Enabled  := false;
  btnDeleta.Enabled := false;
end;

procedure TfrmCCe.gridCorrecoesDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  if Column.Field = cdsCorrecoesSTATUS then begin
    TDBGrid(Sender).Canvas.FillRect(Rect);

    if cdsCorrecoesSTATUS.asString = '135' then
      ImageList1.Draw(TDBGrid(Sender).Canvas, Rect.Left +12, Rect.Top , 1, true)
    else if cdsCorrecoesSTATUS.asString = '' then
      ImageList1.Draw(TDBGrid(Sender).Canvas, Rect.Left +12, Rect.Top , 2, true)
    else
      ImageList1.Draw(TDBGrid(Sender).Canvas, Rect.Left +12, Rect.Top , 0, true);
  end;

end;

procedure TfrmCCe.BuscaNotaFiscal1Exit(Sender: TObject);
begin
  inherited;
  edtID.Text := BuscaNotaFiscal1.ID;
end;

procedure TfrmCCe.FormShow(Sender: TObject);
begin
  FEditCorr           := false;
  FEditLote           := false;
  FInserindo          := false;
  PC1.ActivePageIndex := 0;
  BuscaEmpresa1.edtCodigo.SetFocus;
  cdsDeletados.CreateDataSet;
end;

procedure TfrmCCe.gridLotesDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  if Column.Field = cdsLotesSTATUS then begin
    TDBGrid(Sender).Canvas.FillRect(Rect);

    if cdsLotesSTATUS.asString = '128' then
      ImageList1.Draw(TDBGrid(Sender).Canvas, Rect.Left +12, Rect.Top , 1, true)
    else if cdsLotesSTATUS.asString = '' then
      ImageList1.Draw(TDBGrid(Sender).Canvas, Rect.Left +12, Rect.Top , 2, true)
    else
      ImageList1.Draw(TDBGrid(Sender).Canvas, Rect.Left +12, Rect.Top , 0, true);
  end;
end;

procedure TfrmCCe.gridLotesEnter(Sender: TObject);
begin
  if not cdsLotes.IsEmpty then
    carregaCorrecoes;
end;

procedure TfrmCCe.btnBuscarClick(Sender: TObject);
begin
  if BuscaEmpresa1.edtRazao.Text = '' then begin
    avisar('A empresa deve ser selecionada');
    Exit;
  end;

  cdsLotes.Close;
  qryLotes.SQL.Text := monta_sql;
  cdsLotes.Open;

  gridLotes.SetFocus;
end;

function TfrmCCe.monta_sql: String;
var condicao_empresa :String;
begin
  result := '';

  if BuscaEmpresa1.edtRazao.Text <> '' then
    condicao_empresa := ' where lc.codigo in                                                     '+
                        ' (select cc.cod_lote from correcoes_cce cc                              '+
                        '  left join notas_fiscais    nf  on nf.codigo = cc.codigo_nota          '+
                        '  where nf.codigo_emitente = '+intToStr(BuscaEmpresa1.Empresa.Codigo)+')'
  else
    condicao_empresa := '';

  result := ' select lc.codigo, lc.data, rlc.status, rlc.motivo from lotes_cce lc '+
            ' left join return_cce_lote  rlc on rlc.cod_lote = lc.codigo          '+
            condicao_empresa;

end;

procedure TfrmCCe.BuscaNotaFiscal1edtNrNotaEnter(Sender: TObject);
begin
  inherited;
  BuscaNotaFiscal1.codigo_empresa := IntToStr(BuscaEmpresa1.Empresa.Codigo);
end;

procedure TfrmCCe.armazena_deletado;
begin
  cdsDeletados.Append;
  cdsDeletadoscodigo_correcao.AsInteger := cdsCorrecoesCODIGO.AsInteger;
  cdsDeletados.Post;
end;

procedure TfrmCCe.efetua_delecao;
begin
  cdsDeletados.First;
  while not cdsCorrecoes.Eof do begin

    dm.qryGenerica.Close;
    dm.qryGenerica.SQL.Text := 'delete from correcoes_cce where codigo = :codigo';
    dm.qryGenerica.ParamByName('codigo').AsInteger := cdsDeletadoscodigo_correcao.AsInteger;
    dm.qryGenerica.ExecSQL;

  cdsDeletados.Next;
  end;

  cdsDeletados.EmptyDataSet;
end;

end.

