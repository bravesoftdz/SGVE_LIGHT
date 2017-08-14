unit uNFCes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, System.StrUtils, FileCtrl,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uPadrao, Data.DB, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, DBGridCBN,
  framePeriodo, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Mask, RxToolEdit, RxCurrEdit,
  NFCe;

type
  TTipoSelecionado = (tsNenhuma=0, tsEnviadas=1, tsCanceladas=2, tsRejeitadasContingencia=3);
type
  TfrmNFCes = class(TfrmPadrao)
    gridNFce: TDBGridCBN;
    pnlBotoes: TPanel;
    btnInutilizar: TBitBtn;
    btnCancelar: TBitBtn;
    btnEnviar: TBitBtn;
    qry: TFDQuery;
    ds: TDataSource;
    qryCODIGO: TIntegerField;
    qryNR_NOTA: TIntegerField;
    qryCODIGO_PEDIDO: TIntegerField;
    qrySERIE: TStringField;
    qryCHAVE: TStringField;
    qryPROTOCOLO: TStringField;
    qryDH_RECEBIMENTO: TSQLTimeStampField;
    qrySTATUS: TStringField;
    qryMOTIVO: TStringField;
    qryJUSTIFICATIVA: TStringField;
    qryXML: TBlobField;
    btnImprimir: TBitBtn;
    Shape1: TShape;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtAutorizadas: TCurrencyEdit;
    edtCanceladas: TCurrencyEdit;
    edtRejeitadas: TCurrencyEdit;
    edtTotal: TCurrencyEdit;
    qryTAG: TIntegerField;
    Panel1: TPanel;
    gpbPeriodo: TGroupBox;
    Periodo1: TPeriodo;
    gpbStatus: TGroupBox;
    chkAutorizada: TCheckBox;
    chkCancelada: TCheckBox;
    chkRejeitada: TCheckBox;
    btnBuscar: TBitBtn;
    btnConsultar: TBitBtn;
    btnGerarXML: TBitBtn;
    chkContingencia: TCheckBox;
    qryCPF_CLIENTE: TStringField;
    qryVALOR_TOTAL: TBCDField;
    BitBtn1: TBitBtn;
    procedure btnCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure gridNFceDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnImprimirClick(Sender: TObject);
    procedure btnInutilizarClick(Sender: TObject);
    procedure chkAutorizadaClick(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure btnGerarXMLClick(Sender: TObject);
    procedure gridNFceKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnEnviarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure gridNFceDblClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    selecionados :integer;
    tipoSelecionadas :TTipoSelecionado;

  private
    procedure buscarNFCes;
    procedure inutilizarNumeracao;
    procedure imprimirNfce;
    procedure consultarNFCe;
    procedure adicionaOuRemove;
    procedure enviarNFCe;
    procedure salvaInutilizacao(nIni, nFim :integer; justificativa :String);
    procedure desabilitaHabilita;
    procedure consultaStatusServico;
  private
    function getTipoSelecionadas(tipo :String) :TTipoSelecionado;

  public
    { Public declarations }
  end;

var
  frmNFCes: TfrmNFCes;

implementation

uses ServicoEmissorNFCe, uModulo, uInutilizaNumeracao, Math, repositorio, fabricaRepositorio, NotaInutilizada;

{$R *.dfm}

procedure TfrmNFCes.adicionaOuRemove;
var marcando :boolean;
    tipo     :TTipoSelecionado;
    linha    :Word;
begin
  try
    linha    := qry.RecNo;
    marcando := qryTAG.AsInteger = 0;
    selecionados := selecionados + IfThen(marcando, 1, -1);

    if (selecionados = 0) or ((selecionados = 1) and marcando) then
    begin
      if marcando then
      begin
        tipoSelecionadas := getTipoSelecionadas(qrySTATUS.AsString);
        desabilitaHabilita;
      end
      else
      begin
        tipoSelecionadas := tsNenhuma;
        desabilitaHabilita;
      end;
    end
    else if (tipoSelecionadas <> tsNenhuma) and (getTipoSelecionadas(qrySTATUS.AsString) <> tipoSelecionadas) then
    begin
      dec(selecionados);
      exit;
    end;

    qry.Edit;
    qryTAG.AsInteger := IfThen(qryTAG.AsInteger = 0, 1, 0);
    qry.Post;
  finally
    qry.RecNo := linha;
  end;
end;

procedure TfrmNFCes.btnConsultarClick(Sender: TObject);
begin
  try
    Aguarda('Consultando nfce...');
    qry.Filtered := false;
    qry.Filter   := 'TAG = 1';
    qry.Filtered := true;
    qry.First;

    while not qry.Eof do
    begin
      consultarNFCe;
      qry.Next;
    end;

    qry.Filtered := false;
    btnBuscar.Click;
    gridNFce.SetFocus;
  finally
    FimAguarda;
  end;
end;

procedure TfrmNFCes.btnEnviarClick(Sender: TObject);
begin
 try
    qry.Filtered := false;
    qry.Filter   := 'TAG = 1';
    qry.Filtered := true;
    qry.First;

    Aguarda('Aguarde, enviando NFC-e(s)');
    while not qry.Eof do
    begin
      try
        enviarNFCe;
      Except
      end;

      qry.Next;
    end;

    qry.Filtered := false;

    btnBuscar.Click;
 finally
   FimAguarda;
 end;
end;

procedure TfrmNFCes.btnGerarXMLClick(Sender: TObject);
var
  Dir: string;
begin
 try
   Dir := '';
   qry.Filtered := false;
   qry.Filter   := 'TAG = 1';
   qry.Filtered := true;

   if SelectDirectory('Selecione a pasta de destino','',Dir) then begin

     qry.first;
     while not qry.Eof do
     begin
       qryXML.SaveToFile(Dir+'/'+qryCHAVE.AsString+'.xml');

       qry.Next;
     end;

     btnBuscar.Click;
     Avisar(1,'Operação realizada com sucesso!');
   end;

   qry.Filtered   := false;

 Except
   On E: Exception do begin
     Avisar(0,'Erro ao gerar arquivos.'+#13#10+e.Message);
   end;
 end;
end;

procedure TfrmNFCes.BitBtn1Click(Sender: TObject);
begin
  consultaStatusServico;
end;

procedure TfrmNFCes.btnBuscarClick(Sender: TObject);
begin
  buscarNFCes;
  gridNFce.SetFocus;
end;

procedure TfrmNFCes.btnCancelarClick(Sender: TObject);
var
  idLote,vAux : String;
  XML         : TStringStream;
  Servico     : TServicoEmissorNFCe;
  Justificativa :String;
  NFCe : TNFCe;
  repositorio : TRepositorio;
begin
 try
   if not confirma('Deseja realmente cancelar a(s) NFC-e(s) selecionadas?') then
     Exit;

   Servico    := TServicoEmissorNFCe.Create(dm.Empresa);

   Justificativa := inputBox('Justificativa de cancelamento');

   if Justificativa = '' then
     avisar(1,'Operação abortada')
   else
   begin
     qry.Filtered := false;
     qry.Filter   := 'TAG = 1';
     qry.Filtered := true;
     qry.First;


     while not qry.Eof do
     begin
       repositorio := TFabricaRepositorio.GetRepositorio(TNFCe.ClassName);
       NFCe        := TNFCe(repositorio.Get(qryCODIGO.AsInteger));
       XML := TStringStream.Create(qryXML.AsString);
       Servico.CancelarNFCe( XML , Justificativa, NFCe);
       qry.Next;

       FreeAndNil(XML);
       FreeAndNil(NFCe);
       FreeAndNil(repositorio);
     end;

     qry.Filtered := false;

     avisar(1,'Operação realizada com sucesso!');
   end;

   btnBuscar.Click;
 Except
   On E: Exception do begin
     Avisar(0,'Erro ao cancelar NFC-e.'+#13#10+e.Message);
   end;
 end;
end;

procedure TfrmNFCes.btnImprimirClick(Sender: TObject);
begin
  try
    qry.Filtered := false;
    qry.Filter   := 'TAG = 1';
    qry.Filtered := true;
    qry.First;

    dm.Empresa.ConfiguracoesNF.ParametrosNFCe.visualiza_impressao := not(qry.RecordCount > 2);

    while not qry.Eof do
    begin
      imprimirNfce;
      qry.Next;
    end;

  finally
    dm.Empresa.ConfiguracoesNF.ParametrosNFCe.visualiza_impressao := true;
    qry.Filtered := false;
  end;
end;

procedure TfrmNFCes.btnInutilizarClick(Sender: TObject);
begin
  inutilizarNumeracao;
end;

procedure TfrmNFCes.buscarNFCes;
var condicaoStatus :String;
begin
  tipoSelecionadas := tsNenhuma;
  desabilitaHabilita;
  selecionados := 0;
  qry.Close;

  if not (chkAutorizada.Checked and chkCancelada.Checked and chkRejeitada.Checked and chkContingencia.Checked) and
     not (not chkAutorizada.Checked and  not chkCancelada.Checked and not chkRejeitada.Checked and not chkContingencia.Checked) then
  begin
    condicaoStatus := condicaoStatus + IfThen(chkAutorizada.Checked,',''100''','');
    condicaoStatus := condicaoStatus + IfThen(chkCancelada.Checked,',''101''','');
    condicaoStatus := condicaoStatus + IfThen(chkContingencia.Checked,',''0''','');
    condicaoStatus := copy(condicaoStatus, 2, length(condicaoStatus));

    if condicaoStatus <> '' then
      condicaoStatus := ' and (NFCE.STATUS in ('+condicaoStatus+')';

    if chkRejeitada.Checked then
    begin
      condicaoStatus := condicaoStatus + IfThen(condicaoStatus = '','and','or')+
                                         ' not(NFCE.STATUS in (''100'',''101'',''0''))) ';
    end
    else
      condicaoStatus := condicaoStatus + ')';

  end;


  qry.SQL.Text := 'select nfce.codigo,nfce.nr_nota, nfce.codigo_pedido, nfce.chave, nfce.protocolo, nfce.dh_recebimento, nfce.status, nfce.serie,'+
                  ' iif(nfce.motivo = '''', ''CONTINGÊNCIA'', nfce.motivo) motivo, nfce.justificativa, nfce.xml, ped.cpf_cliente, ped.valor_total from NFCE '+
                  ' inner join pedidos ped on ped.codigo = nfce.codigo_pedido '+
                  ' WHERE NFCE.dh_recebimento between :dti and :dtf '+ condicaoStatus +
                  ' order by NFCE.dh_recebimento                       ';

  qry.ParamByName('dti').AsDateTime := Periodo1.dtpInicio.DateTime;
  qry.ParamByName('dtf').AsDateTime := Periodo1.dtpFim.DateTime;
  qry.Open;

  edtAutorizadas.Clear;
  edtCanceladas.Clear;
  edtRejeitadas.Clear;
  edtTotal.Clear;

  qry.First;
  while not qry.Eof do
  begin
    case AnsiIndexStr(UpperCase(qrySTATUS.AsString), ['100', '101']) of
      0 : edtAutorizadas.AsInteger := edtAutorizadas.AsInteger + 1;
      1 : edtCanceladas.AsInteger  := edtCanceladas.AsInteger + 1;
      else
          edtRejeitadas.AsInteger  := edtRejeitadas.AsInteger + 1;
    end;

    qry.Next;
  end;

  edtTotal.AsInteger := qry.RecordCount;
end;

procedure TfrmNFCes.chkAutorizadaClick(Sender: TObject);
begin
  btnBuscar.Click;
end;

procedure TfrmNFCes.consultarNFCe;
var
  Servico     :TServicoEmissorNFCe;
  NFCe        :TNFCe;
  repositorio :TRepositorio;
begin
 try
 try
   Servico     := TServicoEmissorNFCe.Create(dm.Empresa);
   repositorio := TFabricaRepositorio.GetRepositorio(TNFCe.ClassName);
   NFCe        := TNFCe(repositorio.Get(qryCODIGO.AsInteger));

   Servico.ConsultaNFCe(NFCe);
   repositorio.Salvar(NFCe);
 Except
   On E: Exception do begin
     Avisar(0,'Erro ao consultar NFC-e.'+#13#10+e.Message);
   end;
 end;
 finally
   FreeAndNil(NFCe);
   FreeAndNil(Servico);
 end;
end;

procedure TfrmNFCes.consultaStatusServico;
var
  Servico     :TServicoEmissorNFCe;
begin
 try
 try
   Servico := TServicoEmissorNFCe.Create(dm.Empresa);
   Servico.consultaStatus;
 Except
   On E: Exception do
     avisar(1,e.Message);
 end;
 finally
   FreeAndNil(Servico);
 end;
end;

procedure TfrmNFCes.gridNFceDblClick(Sender: TObject);
begin
  if not(qry.IsEmpty) then
    adicionaOuRemove;
end;

procedure TfrmNFCes.gridNFceDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if (Column.Field = qrySTATUS)or(Column.Field = qryNR_NOTA) then begin
     TDBGridCBN(Sender).Canvas.FillRect(Rect);
     TDBgridCBN(Sender).Canvas.Font.Style := [fsBold];

     if (Column.Field = qrySTATUS)and(self.qrySTATUS.AsString = '100') then begin
        TDBgridCBN(Sender).Canvas.Font.Color := clGreen;
     end
     else if (Column.Field = qrySTATUS)and(self.qrySTATUS.AsString = '101') then begin
        TDBgridCBN(Sender).Canvas.Font.Color := clRed;
     end
     else if (Column.Field = qrySTATUS) and not( StrToIntDef(self.qrySTATUS.AsString,0) in [100,101]) then
        TDBgridCBN(Sender).Canvas.Font.Color := clGray;

     TDBgridCBN(Sender).DefaultDrawDataCell(Rect, Column.Field, State);
  end;

  if qryTAG.AsInteger = 1 then
    begin
      //TDBGridCBN(Sender).Canvas.Font.Color := clGray;
      TDBGridCBN(Sender).Canvas.Brush.Color := $00D0C895;
      TDBGridCBN(Sender).DefaultDrawDataCell(Rect, TDBGridCBN(Sender).columns[datacol].field, State);

      if Column.Field = qrySTATUS then begin

        if (self.qrySTATUS.AsString = '100') then begin
          TDBGridCBN(Sender).Canvas.FillRect(Rect);
          TDBgridCBN(Sender).Canvas.Font.Color := clLime;
          TDBgridCBN(Sender).DefaultDrawDataCell(Rect, Column.Field, State);
        end;
      end;
    end;
end;

procedure TfrmNFCes.gridNFceKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (key = vk_space) and not(qry.IsEmpty) then
    adicionaOuRemove;
end;

procedure TfrmNFCes.desabilitaHabilita;
begin
  btnEnviar.Enabled      := tipoSelecionadas = tsRejeitadasContingencia;
  btnCancelar.Enabled    := tipoSelecionadas = tsEnviadas;
  btnImprimir.Enabled    := tipoSelecionadas = tsEnviadas;
  btnConsultar.Enabled   := (tipoSelecionadas = tsEnviadas) or (tipoSelecionadas = tsCanceladas) or (tipoSelecionadas = tsRejeitadasContingencia);
  btnGerarXML.Enabled    := tipoSelecionadas = tsEnviadas;
end;

procedure TfrmNFCes.enviarNFCe;
var
  Servico     :TServicoEmissorNFCe;
  NFCe        :TNFCe;
  repositorio :TRepositorio;
begin
   NFCe   := nil;
 try
 try
   Servico := TServicoEmissorNFCe.Create(dm.Empresa);
   Servico.Emitir(qryCODIGO_PEDIDO.AsInteger, qryCPF_CLIENTE.AsString);

   repositorio := TFabricaRepositorio.GetRepositorio(TNFCe.ClassName);
   NFCe        := TNFCe(repositorio.Get(qryCODIGO.AsInteger));
 Except
   On E: Exception do
     raise Exception.Create('Ocorreu um erro ao enviar NFC-e nº '+qryNR_NOTA.AsString+#13#10+e.Message);
 end;

 finally
   FreeAndNil(NFCe);
   FreeAndNil(Servico);
 end;
end;

procedure TfrmNFCes.FormCreate(Sender: TObject);
begin
  tipoSelecionadas := tsNenhuma;
end;

procedure TfrmNFCes.FormShow(Sender: TObject);
begin
  Periodo1.dtpInicio.Date := Date;
  Periodo1.dtpFim.Date    := Date;
  btnBuscar.Click;
end;

procedure TfrmNFCes.imprimirNfce;
var
  NFCe        :TServicoEmissorNFCe;
begin
  if qry.IsEmpty then
    exit;

  try
    NFCe       := TServicoEmissorNFCe.Create(dm.Empresa);
    NFCe.reimprimir(qryXML.AsString);

  finally
    FreeAndNil(NFCe);
  end;
end;

procedure TfrmNFCes.inutilizarNumeracao;
var
  Servico     : TServicoEmissorNFCe;
begin
  try
    frmInutilizaNumeracao := TFrmInutilizaNumeracao.Create(nil);

    if frmInutilizaNumeracao.ShowModal = mrOk then
    begin
      Servico    := TServicoEmissorNFCe.Create(dm.Empresa);
      if Servico.inutilizarNumeracao(frmInutilizaNumeracao.edtInicial.AsInteger,
                                     frmInutilizaNumeracao.edtFinal.Value,
                                     frmInutilizaNumeracao.memoJustificativa.Text) then
      begin
        salvaInutilizacao(frmInutilizaNumeracao.edtInicial.AsInteger, frmInutilizaNumeracao.edtFinal.Value, frmInutilizaNumeracao.memoJustificativa.Text);
        avisar(1,'Numeração ['+frmInutilizaNumeracao.edtInicial.Text+' ao '+frmInutilizaNumeracao.edtFinal.Text+'] inutilizada com sucesso.', 2);
      end;
    end;

    frmInutilizaNumeracao.Release;
    frmInutilizaNumeracao := nil;

  Except
    on e :Exception do
      avisar(0,'Erro ao inutilizar numeração.'+#13#10+e.Message);
  end;
end;

procedure TfrmNFCes.salvaInutilizacao(nIni, nFim: integer; justificativa: String);
var repositorio :TRepositorio;
    NotaInutilizada :TNotaInutilizada;
begin
  try
    repositorio     := TFabricaRepositorio.GetRepositorio(TNotaInutilizada.ClassName);
    NotaInutilizada := TNotaInutilizada.Create;

    NotaInutilizada.modelo := '65';
    NotaInutilizada.serie  := '1';
    NotaInutilizada.inicio := nIni;
    NotaInutilizada.fim    := nFim;
    NotaInutilizada.justificativa := justificativa;

    repositorio.Salvar(NotaInutilizada);
  finally
    FreeAndNil(repositorio);
    FreeAndNil(NotaInutilizada);
  end;
end;

function TfrmNFCes.getTipoSelecionadas(tipo :String) :TTipoSelecionado;
begin
  if tipo = '100' then
    result := tsEnviadas
  else if tipo = '101' then
    result := tsCanceladas
  else if (tipo <> '101') and (tipo <> '100') then
    result := tsRejeitadasContingencia;
end;

end.
