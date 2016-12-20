unit uRecebimentoPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uPadrao, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.Mask, RxToolEdit, RxCurrEdit, Data.DB, Datasnap.DBClient,
  Vcl.Grids, Vcl.DBGrids, DBGridCBN, Funcoes;

type
  TfrmRecebimentoPedido = class(TfrmPadrao)
    cmbMoeda: TComboBox;
    edtValorPago: TCurrencyEdit;
    edtTroco: TCurrencyEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtTotalPedido: TCurrencyEdit;
    Label4: TLabel;
    pnlBotoes: TPanel;
    btnConfirmar: TBitBtn;
    btnVoltar: TBitBtn;
    DBGridCBN1: TDBGridCBN;
    cdsMoedas: TClientDataSet;
    dsMoedas: TDataSource;
    cdsMoedasMOEDA: TStringField;
    cdsMoedasVALOR: TFloatField;
    edtValorRestante: TCurrencyEdit;
    Label5: TLabel;
    cdsMoedasCODIGO_MOEDA: TIntegerField;
    btnLanca: TBitBtn;
    Label6: TLabel;
    Label7: TLabel;
    lbCpf: TLabel;
    edtCpf: TEdit;
    procedure btnVoltarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnLancaClick(Sender: TObject);
    procedure edtValorPagoChange(Sender: TObject);
    procedure edtTotalPedidoChange(Sender: TObject);
    procedure edtTrocoChange(Sender: TObject);
    procedure DBGridCBN1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtCpfChange(Sender: TObject);
    procedure edtCpfExit(Sender: TObject);
    procedure edtCpfKeyPress(Sender: TObject; var Key: Char);
    procedure edtCpfKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cmbMoedaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FCc: Boolean;
    FFinalizaRapido :Boolean;

    function verificaObrigatorios :Boolean;

    procedure lancaPagamento;
    procedure extornaRecebimento;

  public
    procedure salvaRecebimentoPedido(codigoPedido :Integer);

    property cc :Boolean read FCc write FCc;
    property finalizaRapido :Boolean read FFinalizaRapido write FFinalizaRapido;
  end;

var
  frmRecebimentoPedido: TfrmRecebimentoPedido;

implementation

uses Movimento, repositorio, fabricarepositorio;

{$R *.dfm}

procedure TfrmRecebimentoPedido.btnLancaClick(Sender: TObject);
begin
  if verificaObrigatorios then
    lancaPagamento;
end;

procedure TfrmRecebimentoPedido.btnConfirmarClick(Sender: TObject);
begin
  if edtValorRestante.Value = 0 then
    self.ModalResult := mrOk
  else
    avisar(0,'Ainda resta um valor a ser pago. [ '+FormatFloat('R$ ,0.00; -,0.00', edtValorRestante.Value)+' ]');
end;

procedure TfrmRecebimentoPedido.btnVoltarClick(Sender: TObject);
begin
  self.ModalResult := mrCancel;
end;

procedure TfrmRecebimentoPedido.cmbMoedaClick(Sender: TObject);
begin
  edtValorPago.SetFocus;
end;

procedure TfrmRecebimentoPedido.DBGridCBN1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_DELETE then
    extornaRecebimento;
end;

procedure TfrmRecebimentoPedido.edtCpfKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_RETURN then
  begin
    key := 0;
    btnVoltar.SetFocus;
  end;
end;

procedure TfrmRecebimentoPedido.edtCpfKeyPress(Sender: TObject; var Key: Char);
begin
  If not( key in['0'..'9',#08] ) then
    key:=#0;
end;

procedure TfrmRecebimentoPedido.edtCpfChange(Sender: TObject);
begin
  inherited;
  if Valida_CPF_CNPJ(edtCpf.Text) then
  begin
    lbCpf.Caption    := 'CPF válido';
    lbCpf.Font.Color := clGreen;
  end
  else
  begin
    lbCpf.Caption    := 'CPF inválido';
    lbCpf.Font.Color := clMaroon;
  end;
  
end;

procedure TfrmRecebimentoPedido.edtCpfExit(Sender: TObject);
begin
  if not Valida_CPF_CNPJ(edtCpf.Text) then
    edtCpf.Clear;
end;

procedure TfrmRecebimentoPedido.edtTotalPedidoChange(Sender: TObject);
begin
  edtValorRestante.Value := edtTotalPedido.Value;
end;

procedure TfrmRecebimentoPedido.edtTrocoChange(Sender: TObject);
begin
  if edtTroco.Value < 0 then
    edtTroco.Clear;
end;

procedure TfrmRecebimentoPedido.edtValorPagoChange(Sender: TObject);
begin
  edtTroco.Value := edtValorPago.Value - edtValorRestante.Value;

end;

procedure TfrmRecebimentoPedido.extornaRecebimento;
begin
  edtValorRestante.Value := edtValorRestante.Value + cdsMoedasVALOR.AsFloat;
  cdsMoedas.Delete;
end;

procedure TfrmRecebimentoPedido.FormCreate(Sender: TObject);
begin
  inherited;
  cdsMoedas.CreateDataSet;
  FCc := true;
end;

procedure TfrmRecebimentoPedido.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (key = VK_F7) or (key = VK_F6) then
  begin
    if (key = VK_F10) and (edtCpf.Text = '') then
      FCc := false;
    btnConfirmar.Click;
  end;
end;

procedure TfrmRecebimentoPedido.FormShow(Sender: TObject);
begin
  if FFinalizaRapido then
  begin
    edtValorPago.Value := edtValorRestante.Value;
    cmbMoeda.ItemIndex := 1;
    btnLanca.Click;
    edtCpf.SetFocus;
  end;
end;

procedure TfrmRecebimentoPedido.lancaPagamento;
begin
   if cdsMoedas.Locate('CODIGO_MOEDA',cmbMoeda.ItemIndex,[]) then
     cdsMoedas.Edit
   else
     cdsMoedas.Append;

   cdsMoedasCODIGO_MOEDA.AsInteger := cmbMoeda.ItemIndex;
   cdsMoedasMOEDA.AsString         := cmbMoeda.Items[cmbMoeda.ItemIndex];
   cdsMoedasVALOR.AsFloat          := (edtValorPago.Value - edtTroco.Value);
   cdsMoedas.Post;

   edtValorRestante.Value := edtValorRestante.Value - (edtValorPago.Value - edtTroco.Value);
   edtTroco.Clear;
   edtValorPago.Clear;
   cmbMoeda.ItemIndex := 0;
   if edtValorRestante.Value = 0 then
     btnConfirmar.SetFocus;
end;

procedure TfrmRecebimentoPedido.salvaRecebimentoPedido(codigoPedido: Integer);
var repositorio :TRepositorio;
    movimento   :TMovimento;
begin
  repositorio := nil;
  movimento := nil;

  try
  try
    repositorio := TFabricaRepositorio.GetRepositorio(TMovimento.ClassName);
    cdsMoedas.First;
    while not cdsMoedas.Eof do
    begin
      movimento := TMovimento.Create;
      movimento.tipo_moeda    := cdsMoedasCODIGO_MOEDA.AsInteger;
      movimento.codigo_pedido := codigoPedido;
      movimento.data          := now;
      movimento.valor_pago    := cdsMoedasVALOR.AsFloat;

      repositorio.Salvar(movimento);

      FreeAndNil(movimento);
      cdsMoedas.Next;
    end;

  finally
    FreeAndNil(repositorio);
  end;
  Except
    on E :Exception do
    begin
      avisar(0,'Erro ao salvar recebimento!'+#13#10+E.Message);
    end;
  end;
end;

function TfrmRecebimentoPedido.verificaObrigatorios: Boolean;
begin
  result := false;

  if cmbMoeda.ItemIndex <= 0 then
  begin
    avisar(1,'Favor informar o tipo de moeda usada para o pagamento.');
    cmbMoeda.SetFocus;
    cmbMoeda.DroppedDown := true;
  end
  else if edtValorPago.Value <= 0 then
  begin
    avisar(1,'Favor informar o valor pago.');
    edtValorPago.SetFocus;
  end
  else
    result := true;

end;

end.
