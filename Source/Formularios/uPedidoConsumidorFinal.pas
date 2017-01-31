unit uPedidoConsumidorFinal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, System.StrUtils,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uPadrao, Data.DB, Vcl.StdCtrls, Vcl.Mask, RxToolEdit, RxCurrEdit, RLParser, Datasnap.DBClient,
  Vcl.Buttons, RLReport, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, frameBuscaPessoa, frameBuscaCliente, frameBuscaProduto, frameBuscaPedido,
  frameMaskCpfCnpj, Pedido, ConfiguracoesNFCe, Empresa, Math, funcoes;

type
  TEstadoItem = (teInserindo, teAlterando);

type
  TfrmPedidoConsumidorFinal = class(TfrmPadrao)
    pnlTopo: TPanel;
    gridItens: TDBGrid;
    RLReport1: TRLReport;
    RLBand1: TRLBand;
    RLLabel14: TRLLabel;
    RLDraw2: TRLDraw;
    RLDraw1: TRLDraw;
    RLSystemInfo1: TRLSystemInfo;
    RLLabel1: TRLLabel;
    RLLabel2: TRLLabel;
    rlbPedido: TRLLabel;
    RLLabel3: TRLLabel;
    rlbRazao: TRLLabel;
    rlbEmail: TRLLabel;
    rlbFone: TRLLabel;
    RLBand2: TRLBand;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText5: TRLDBText;
    RLLabel4: TRLLabel;
    RLLabel6: TRLLabel;
    RLBand3: TRLBand;
    RLLabel7: TRLLabel;
    RLLabel9: TRLLabel;
    RLDBResult1: TRLDBResult;
    RLDBResult3: TRLDBResult;
    rlbTotal: TRLLabel;
    RLLabel10: TRLLabel;
    rlbDesconto: TRLLabel;
    pnlBotoes: TPanel;
    btnVoltar: TBitBtn;
    btnAlteraItem: TBitBtn;
    btnCancelaAlteracao: TBitBtn;
    btnFinalizaPedido: TBitBtn;
    dsItens: TDataSource;
    cdsItens: TClientDataSet;
    cdsItensCOD_PRODUTO: TIntegerField;
    cdsItensPRODUTO: TStringField;
    cdsItensVALOR_ITEM: TFloatField;
    cdsItensCODIGO_ITEM: TIntegerField;
    RLExpressionParser1: TRLExpressionParser;
    cdsItensPRECO: TFloatField;
    BuscaCliente1: TBuscaCliente;
    BuscaProduto1: TBuscaProduto;
    cdsItensQUANTIDADE: TFloatField;
    BuscaPedido1: TBuscaPedido;
    pnlValores: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label7: TLabel;
    Label5: TLabel;
    Label1: TLabel;
    edtQuantidade: TCurrencyEdit;
    edtPreco: TCurrencyEdit;
    btnAddItem: TBitBtn;
    edtDesconto: TCurrencyEdit;
    edtTotalPedido: TCurrencyEdit;
    edtAcrescimo: TCurrencyEdit;
    RLLabel16: TRLLabel;
    rlbAcrescimo: TRLLabel;
    Label4: TLabel;
    btnFinalizaRapido: TBitBtn;
    procedure btnVoltarClick(Sender: TObject);
    procedure BuscaProduto1Exit(Sender: TObject);
    procedure btnAddItemClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnAlteraItemClick(Sender: TObject);
    procedure BuscaPedido1btnNovoClick(Sender: TObject);
    procedure BuscaPedido1btnBuscaClick(Sender: TObject);
    procedure btnFinalizaPedidoClick(Sender: TObject);
    procedure BuscaPedido1btnCancelarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BuscaPedido1Exit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtDescontoChange(Sender: TObject);
    procedure edtAcrescimoChange(Sender: TObject);
    procedure gridItensKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCancelaAlteracaoClick(Sender: TObject);
    procedure gridItensDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnFinalizaRapidoClick(Sender: TObject);
  private
    FEstadoItem           :TEstadoItem;
    FFinalizando          :Boolean;
    FCupomPendente        :Boolean;
    FTotalPedido          :Real;

  private
    function verificaObrigatoriosItem :Boolean;
    function verificaObrigatoriosPedido :Boolean;
    procedure imprimePedido(pedido :TPedido);
    procedure adicionaItem(codProduto :integer; produto :String; preco, qtde :Real; const codItem :integer = 0);
    procedure cancelaItem;
    procedure carregaItem;
    procedure deletaItem;
    procedure limpaCamposItem;
    procedure limpaCamposPedido;
    procedure carregarPedido(Pedido :TPedido);
    procedure camposHabilitados(boleana :Boolean);
    procedure calculaTotal;
    function criaPedido :TPedido;
    function confirmaSaida :Boolean;
    function efetuaRecebimento(finalizaRapido :Boolean) :Boolean;
    function geraCupomEletronico(codigoPedido :integer; CPF_Cliente :String) :boolean;

    procedure finalizaPedido(const finalizaRapido :Boolean = false);
  public
    { Public declarations }
  end;

var
  frmPedidoConsumidorFinal: TfrmPedidoConsumidorFinal;

implementation

uses repositorio, fabricaRepositorio, Item, uModulo, uRecebimentoPedido, Venda, ServicoEmissorNFCe, Produto, RepositorioItem;

{$R *.dfm}

procedure TfrmPedidoConsumidorFinal.adicionaItem(codProduto :integer; produto :String; preco, qtde :Real; const codItem :integer);
begin
  if FEstadoItem = teInserindo then
  begin
    cdsItens.Append;
  end
  else
  begin
    edtTotalPedido.Value := edtTotalPedido.Value - cdsItensVALOR_ITEM.AsFloat;
    cdsItens.Edit;
    FEstadoItem              := teInserindo;
  end;

  cdsItensCOD_PRODUTO.AsInteger    := codProduto;
  cdsItensPRODUTO.AsString         := produto;
  cdsItensPRECO.AsFloat            := preco;
  cdsItensQUANTIDADE.AsFloat       := qtde;
  cdsItensVALOR_ITEM.AsFloat       := cdsItensPRECO.AsFloat * cdsItensQUANTIDADE.AsFloat;

  cdsItens.Post;

  edtTotalPedido.Value             := edtTotalPedido.Value + cdsItensVALOR_ITEM.AsFloat;
  FTotalPedido                     := edtTotalPedido.Value + edtDesconto.Value - edtAcrescimo.Value;

  btnCancelaAlteracao.Click;
end;

procedure TfrmPedidoConsumidorFinal.btnAddItemClick(Sender: TObject);
begin
  if verificaObrigatoriosItem then
    adicionaItem(BuscaProduto1.Produto.codigo,
                 BuscaProduto1.Produto.descricao,
                 edtPreco.Value,
                 edtQuantidade.Value);
end;

procedure TfrmPedidoConsumidorFinal.btnAlteraItemClick(Sender: TObject);
begin
  if cdsItens.IsEmpty then
    exit;

  FEstadoItem := teAlterando;
  btnCancelaAlteracao.Enabled := true;
  carregaItem;
end;

procedure TfrmPedidoConsumidorFinal.btnCancelaAlteracaoClick(Sender: TObject);
begin
  gridItens.Enabled        := true;
  BuscaProduto1.Enabled    := true;
  limpaCamposItem;
  btnCancelaAlteracao.Enabled := false;
end;

procedure TfrmPedidoConsumidorFinal.btnFinalizaPedidoClick(Sender: TObject);
begin
  finalizaPedido;
end;

procedure TfrmPedidoConsumidorFinal.btnFinalizaRapidoClick(Sender: TObject);
begin
  finalizaPedido(true);
end;

function TfrmPedidoConsumidorFinal.geraCupomEletronico(codigoPedido :integer; CPF_Cliente :String) :boolean;
var
   NFCe  :TServicoEmissorNFCe;
begin
   NFCe   := nil;
   result := false;

 try
 try

   NFCe := TServicoEmissorNFCe.Create(dm.Empresa);
   NFCe.Emitir(codigoPedido, CPF_Cliente);

   result := true;

 Except
   On E: Exception do
     raise Exception.Create('Ocorreu um erro ao enviar nota fiscal.'+#13#10+e.Message);
 end;

 finally
   FreeAndNil(NFCe);
 end;
end;

procedure TfrmPedidoConsumidorFinal.gridItensDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin

  if gdSelected in State then
  begin
    gridItens.Canvas.Font.Color := clBlack; //Fundo
    gridItens.Canvas.Font.Style := [fsBold];
    gridItens.Canvas.Brush.Color:= $00EFD6AB; //Fonte
  end
  else
  begin
    gridItens.Canvas.Font.Color := $00454545;

    If odd(cdsItens.RecNo) then
      gridItens.Canvas.Brush.Color:= $00F4F4F4
    else
      gridItens.Canvas.Brush.Color:= $00F0E8D9;
  end;

  gridItens.Canvas.FillRect(Rect);
  gridItens.DefaultDrawDataCell(rect, column.Field, state);
end;

procedure TfrmPedidoConsumidorFinal.gridItensKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (key = VK_F4) and btnAlteraItem.Enabled then
    btnAlteraItem.Click
  else if (key = VK_DELETE) then
    deletaItem;
end;

procedure TfrmPedidoConsumidorFinal.imprimePedido(pedido: TPedido);
var Arq   :TextFile;
    i :integer;
    qtd, peso, valor :String;
    qtdTot, pesoTot, valorTot :Real;
begin
  rlbRazao.Caption     := dm.Empresa.razao;
  rlbFone.Caption      := dm.Empresa.fone1;
  rlbEmail.Caption     := dm.Empresa.email;
  rlbPedido.Caption    := IntToStr(pedido.codigo);
  rlbDesconto.Caption  := FormatFloat(' ,0.00; -,0.00', pedido.desconto);
  rlbAcrescimo.Caption := FormatFloat(' ,0.00; -,0.00', pedido.acrescimo);
  rlbTotal.Caption     := FormatFloat(' ,0.00; -,0.00', pedido.valor_total);

  rlbEmail.Visible := (dm.Empresa.email <> '');

  RLReport1.PreviewModal;
end;

procedure TfrmPedidoConsumidorFinal.btnVoltarClick(Sender: TObject);
begin
  inherited;
  if confirmaSaida then
    self.Close;
end;

procedure TfrmPedidoConsumidorFinal.BuscaPedido1btnBuscaClick(Sender: TObject);
begin
  if not cdsItens.IsEmpty then
    if not confirma('Ao abrir um pedido para alteração, a criação do pedido em andamento será abortada. Deseja continuar?') then
      exit;

  inherited;
  BuscaPedido1.btnBuscaClick(Sender);
end;

procedure TfrmPedidoConsumidorFinal.BuscaPedido1btnCancelarClick(Sender: TObject);
begin
  inherited;
  BuscaPedido1.btnCancelarClick(Sender);
  BuscaPedido1.btnNovo.Click;
end;

procedure TfrmPedidoConsumidorFinal.BuscaPedido1btnNovoClick(Sender: TObject);
begin
  inherited;
  if not (cdsItens.IsEmpty) and not FFinalizando then
    if not confirma('Deseja cancelar a '+IfThen(assigned(BuscaPedido1.Pedido),'alteração', 'criação')+' do pedido?') then
      exit;

  BuscaPedido1.btnNovoClick(Sender);
  limpaCamposPedido;
  BuscaCliente1.codigo := 1;

end;

procedure TfrmPedidoConsumidorFinal.BuscaPedido1Exit(Sender: TObject);
begin
  inherited;
  if assigned(BuscaPedido1.Pedido) then
  begin
    limpaCamposPedido;
    carregarPedido(BuscaPedido1.Pedido);
    FCupomPendente := true;
    btnFinalizaPedido.Caption := '[ F6 ] Enviar Cupom';
    camposHabilitados(false); 
    btnFinalizaPedido.SetFocus;
  end;
end;

procedure TfrmPedidoConsumidorFinal.BuscaProduto1Exit(Sender: TObject);
begin
  inherited;
  if assigned(BuscaProduto1.Produto) then
    edtPreco.Value := BuscaProduto1.Produto.valor;
end;

procedure TfrmPedidoConsumidorFinal.calculaTotal;
begin
  edtTotalPedido.Clear;
  cdsItens.First;
  while not cdsItens.Eof do
  begin
    edtTotalPedido.Value := edtTotalPedido.Value + cdsItensVALOR_ITEM.AsFloat;
    cdsItens.Next;
  end;

  edtTotalPedido.Value := edtTotalPedido.Value - edtDesconto.Value + edtAcrescimo.Value;
end;

procedure TfrmPedidoConsumidorFinal.camposHabilitados(boleana: Boolean);
begin
  pnlValores.Enabled      := boleana;
  BuscaProduto1.Enabled   := boleana;
  btnAlteraItem.Enabled   := boleana;
end;

procedure TfrmPedidoConsumidorFinal.cancelaItem;
begin
  edtTotalPedido.Value := edtTotalPedido.Value - cdsItensVALOR_ITEM.AsFloat;
  FTotalPedido         := edtTotalPedido.Value + edtDesconto.Value - edtAcrescimo.Value;
  cdsItens.Delete;
end;

procedure TfrmPedidoConsumidorFinal.carregaItem;
begin
  BuscaProduto1.codigo     := cdsItensCOD_PRODUTO.AsInteger;
  edtQuantidade.Value      := cdsItensQUANTIDADE.AsFloat;
  edtPreco.Value           := cdsItensPRECO.AsFloat;
  BuscaProduto1.Enabled    := false;
  gridItens.Enabled        := false;
  edtQuantidade.SetFocus;
end;

procedure TfrmPedidoConsumidorFinal.carregarPedido(Pedido: TPedido);
var Item :TItem;
begin
  edtDesconto.OnChange := nil;
  edtAcrescimo.OnChange := nil;
  BuscaCliente1.codigo := Pedido.codigo_cliente;
  for Item in Pedido.Itens do
    adicionaItem(Item.Produto.codigo,
                 Item.Produto.descricao,
                 Item.valor_unitario,
                 Item.quantidade,
                 Item.codigo);

  edtDesconto.Value    := Pedido.desconto;
  edtAcrescimo.Value   := Pedido.acrescimo;
  edtTotalPedido.Value := Pedido.valor_total;

  edtDesconto.OnChange := edtDescontoChange;
  edtAcrescimo.OnChange := edtAcrescimoChange;
end;

function TfrmPedidoConsumidorFinal.confirmaSaida: Boolean;
begin
  result := true;
  if not cdsItens.IsEmpty then
    if not confirma('Um pedido está em processo de '+IfThen(assigned(BuscaPedido1.Pedido),'alteração', 'criação')+
                    ', deseja cancelar e voltar à tela inicial?') then
      result := false;
end;

function TfrmPedidoConsumidorFinal.criaPedido: TPedido;
var
   repositorioItem :TRepositorio;
   item            :TItem;   
begin
  try
    result                   := TPedido.Create;
    result.codigo            := dm.GetValorGenerator('GEN_PEDIDOS_ID', 1);

    result.codigo_cliente    := BuscaCliente1.Pessoa.codigo;

    result.dt_cadastro       := Date;
    result.desconto          := edtDesconto.Value;
    result.acrescimo         := edtAcrescimo.Value;
    result.valor_total       := edtTotalPedido.Value;

    cdsItens.First;
    repositorioItem := TFabricaRepositorio.GetRepositorio(TItem.ClassName);
    while not cdsItens.Eof do begin
      Item := TItem(repositorioItem.Get(cdsItensCODIGO_ITEM.AsInteger ));

      if not assigned(Item) then
        Item := TItem.Create;

      Item.codigo_produto     := cdsItensCOD_PRODUTO.AsInteger;
      Item.valor_unitario     := cdsItensPRECO.AsFloat;
      Item.quantidade         := cdsItensQUANTIDADE.AsFloat;

      result.adicionaItem(Item);

      cdsItens.Next;
    end;  

  finally
     FreeAndNil(repositorioItem);
  end;
end;

procedure TfrmPedidoConsumidorFinal.deletaItem;
begin
  if cdsItens.IsEmpty then
    exit;

  if confirma('Deseja realmente remover o produto selecionado?'+#13#10+'[ '+cdsItensPRODUTO.AsString+' ] quantidade: '+cdsItensQUANTIDADE.AsString) then
    cancelaItem;
end;

procedure TfrmPedidoConsumidorFinal.edtAcrescimoChange(Sender: TObject);
begin
  calculaTotal;
end;

procedure TfrmPedidoConsumidorFinal.edtDescontoChange(Sender: TObject);
begin
  calculaTotal;
end;

function TfrmPedidoConsumidorFinal.efetuaRecebimento(finalizaRapido :Boolean): Boolean;
begin
  frmRecebimentoPedido                      := TfrmRecebimentoPedido.Create(nil);
  frmRecebimentoPedido.edtTotalPedido.Value := edtTotalPedido.Value;
  frmRecebimentoPedido.finalizaRapido       := finalizaRapido;
  result := (frmRecebimentoPedido.ShowModal = mrOk);
end;

procedure TfrmPedidoConsumidorFinal.finalizaPedido(const finalizaRapido: Boolean);
var repositorio :TRepositorio;
    pedido      :TPedido;
    CPF_Cliente :String;
begin
  if not verificaObrigatoriosPedido then
    Exit;

  repositorio := nil;
  pedido      := nil;
  try

    if not assigned(BuscaPedido1.Pedido) then
      if not efetuaRecebimento(finalizaRapido) then
      begin
        avisar(0,'O recebimento não foi efetuado. Finalização abortada.');
        Exit;
      end;
  try
     FFinalizando := true;
     repositorio  := TFabricaRepositorio.GetRepositorio(TPedido.ClassName);
     pedido       := TPedido( repositorio.Get(BuscaPedido1.edtCodigo.AsInteger));

     if not assigned(pedido) then
     begin
       pedido := criaPedido;
       repositorio.Salvar(Pedido);

       if not dm.Empresa.ConfiguracoesNF.ParametrosNFCe.imp_comp_pedido then
         //*f avisar(1,'Pedido criado com sucesso!',2);
     end;

     //BuscaPedido1.edtCodigo.AsInteger := Pedido.Codigo;

     if assigned(frmRecebimentoPedido) then
       frmRecebimentoPedido.salvaRecebimentoPedido(Pedido.Codigo);

     if not FCupomPendente and dm.Empresa.ConfiguracoesNF.ParametrosNFCe.imp_comp_pedido then
       imprimePedido(Pedido);

     try
       if (FCupomPendente) or (assigned(frmRecebimentoPedido) and (frmRecebimentoPedido.cc)) then
       begin
         if assigned(frmRecebimentoPedido) then
           CPF_Cliente := frmRecebimentoPedido.edtCpf.Text;

         FCupomPendente := true;
         FCupomPendente := not geraCupomEletronico(Pedido.Codigo, CPF_Cliente);
       end;

       BuscaPedido1.btnCancelar.Click;

     Except
       On E: Exception Do begin
         avisar(0,'Erro ao enviar cupom.'+#13#10+e.Message);
       end;
     end;

  Except
    On E: Exception Do begin
      avisar(0,'Erro ao finalizar pedido.'+#13#10+e.Message);
    end;
  end;

  finally
    FreeAndNil(repositorio);
    FFinalizando := false;

    if FCupomPendente then
    begin
      BuscaPedido1.codigo := BuscaPedido1.edtCodigo.AsInteger;
      BuscaPedido1Exit(nil);
      //btnFinalizaPedido.Caption := '[ F6 ] Enviar Cupom';
    end;

    verificaGenerator('GEN_PEDIDOS_ID', 'PEDIDOS');

    if assigned(frmRecebimentoPedido) then
    begin
      frmRecebimentoPedido.Release;
      frmRecebimentoPedido := nil;
    end;
  end;
end;

procedure TfrmPedidoConsumidorFinal.FormCreate(Sender: TObject);
begin
  inherited;
  cdsItens.CreateDataSet;
end;

procedure TfrmPedidoConsumidorFinal.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) and not confirmaSaida then
    exit
  else if (key = VK_F6) then
    btnFinalizaPedido.Click
  else if (key = VK_F7) then
    btnFinalizaRapido.Click;

  inherited;
end;

procedure TfrmPedidoConsumidorFinal.FormShow(Sender: TObject);
begin
  inherited;
  BuscaPedido1.btnNovo.Click;
end;

procedure TfrmPedidoConsumidorFinal.limpaCamposItem;
begin
  edtPreco.Clear;
  edtQuantidade.Clear;
  BuscaProduto1.Limpa;

  BuscaProduto1.edtCodigo.SetFocus;
end;

procedure TfrmPedidoConsumidorFinal.limpaCamposPedido;
begin
  camposHabilitados(true);
  btnFinalizaPedido.Caption := '[ F6 ] Finalizar Pedido';

  if FEstadoItem = teAlterando then
    btnCancelaAlteracao.Click
  else
    limpaCamposItem;

  edtDesconto.Clear;
  edtAcrescimo.Clear;
  edtTotalPedido.Clear;
  cdsItens.EmptyDataSet;
end;

function TfrmPedidoConsumidorFinal.verificaObrigatoriosItem: Boolean;
begin
  result := false;

  if not assigned(BuscaProduto1.Produto) then
  begin
    avisar(1,'Favor informar o produto a ser adicionado');
    BuscaProduto1.edtCodigo.SetFocus;
  end
  else if edtQuantidade.Value < 1 then
  begin
    avisar(1,'Favor informar a quantidade do produto');
    edtQuantidade.SetFocus;
  end
  else if edtPreco.Value <= 0 then
  begin
    avisar(1,'Favor informar o preço do produto');
    edtPreco.SetFocus;
  end
  else
    result := true;
end;

function TfrmPedidoConsumidorFinal.verificaObrigatoriosPedido: Boolean;
begin
  result := false;

  if not assigned(BuscaCliente1.Pessoa) then
  begin
    avisar(1,'Favor informar um cliente para o pedido');
    BuscaCliente1.edtCodigo.SetFocus;
  end
  else if cdsItens.IsEmpty then
  begin
    avisar(1,'Ao menos um item deve ser incluído ao pedido');
    BuscaProduto1.edtCodigo.SetFocus;
  end
  else
    result := true;
end;

end.
