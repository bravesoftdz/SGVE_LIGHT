unit uInicial;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, MIDASLIB,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls, uPadrao, Vcl.Imaging.jpeg, Vcl.ExtCtrls, Vcl.Imaging.pngimage, RxAnimate,
  RxGIFCtrl, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Buttons;

type
  TfrmInicial = class(TfrmPadrao)
    MainMenu1: TMainMenu;
    Cadastros1: TMenuItem;
    GeradordeArquivos1: TMenuItem;
    Produtos1: TMenuItem;
    NCM1: TMenuItem;
    CFOP1: TMenuItem;
    DadosdaEmpresa1: TMenuItem;
    Fornecedores1: TMenuItem;
    Clientes1: TMenuItem;
    Vendas1: TMenuItem;
    Pedidoconsumidorfinal1: TMenuItem;
    NFCes1: TMenuItem;
    Timer1: TTimer;
    Shape1: TShape;
    Shape2: TShape;
    Label3: TLabel;
    lbPendentes: TLabel;
    Image1: TImage;
    Image2: TImage;
    RelatriodeNFCes1: TMenuItem;
    Contador1: TMenuItem;
    OpenDialog1: TOpenDialog;
    Utilitrios1: TMenuItem;
    XMLsaocontador1: TMenuItem;
    Image3: TImage;
    imgNFCe: TImage;
    lbVenda: TLabel;
    lbNFCes: TLabel;
    qry: TFDQuery;
    Timer2: TTimer;
    NFes1: TMenuItem;
    ransportadoras1: TMenuItem;
    MonitorNFe1: TMenuItem;
    Image5: TImage;
    lbProdutos: TLabel;
    lbNFes: TLabel;
    Image6: TImage;
    RelatriodeNFes1: TMenuItem;
    Atualizaodosistema1: TMenuItem;
    Arquivosfiscais1: TMenuItem;
    EFDContribuies1: TMenuItem;
    EFDFiscal1: TMenuItem;
    Sintegra1: TMenuItem;
    AlqeReduoBC1: TMenuItem;
    SAT1: TMenuItem;
    imgSAT: TImage;
    procedure Produtos1Click(Sender: TObject);
    procedure NCM1Click(Sender: TObject);
    procedure CFOP1Click(Sender: TObject);
    procedure DadosdaEmpresa1Click(Sender: TObject);
    procedure Fornecedores1Click(Sender: TObject);
    procedure Clientes1Click(Sender: TObject);
    procedure Pedidoconsumidorfinal1Click(Sender: TObject);
    procedure NFCes1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RelatriodeNFCes1Click(Sender: TObject);
    procedure Contador1Click(Sender: TObject);
    procedure XMLsaocontador1Click(Sender: TObject);
    procedure Image3MouseEnter(Sender: TObject);
    procedure Image3MouseLeave(Sender: TObject);
    procedure imgNFCeMouseEnter(Sender: TObject);
    procedure imgNFCeMouseLeave(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure imgNFCeClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Timer2Timer(Sender: TObject);
    procedure ransportadoras1Click(Sender: TObject);
    procedure MonitorNFe1Click(Sender: TObject);
    procedure Image5MouseEnter(Sender: TObject);
    procedure Image5MouseLeave(Sender: TObject);
    procedure Image5Click(Sender: TObject);
    procedure Image6MouseEnter(Sender: TObject);
    procedure Image6MouseLeave(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure RelatriodeNFes1Click(Sender: TObject);
    procedure Atualizaodosistema1Click(Sender: TObject);
    procedure EFDContribuies1Click(Sender: TObject);
    procedure EFDFiscal1Click(Sender: TObject);
    procedure Sintegra1Click(Sender: TObject);
    procedure AlqeReduoBC1Click(Sender: TObject);
    procedure SAT1Click(Sender: TObject);
    procedure imgSATClick(Sender: TObject);
  private
    function existeNotasEmContingencia :Boolean;
    function servicoOperante :Boolean;

    procedure enviaNotasPendentes;
    procedure verificaNFCesPendentes;
    procedure conectaServidor;
    procedure verificaLiberacao;
    procedure atualizaParametros(status :integer; datafinal :TDateTime; mensagem :String; ultimaConexao :TDateTime);
    function  buscaDadosLiberacao :Boolean;
    procedure pedeSenha;
    procedure configuraTela;
  public
    { Public declarations }
  end;

var
  frmInicial: TfrmInicial;

implementation

uses uCadastroProduto, uCadastroCFOP, uCadastroNcmIBPT, uCadastroPadrao, uCadastroDadosEmpresa, uCadastroFornecedor, uCadastroCliente,
     uPedidoConsumidorFinal, uNFCes, uModulo, ServicoEmissorNFCe, ParametrosNFCe, Repositorio, FabricaRepositorio, uRelatorioNFCes,
     uCadastroContador, uEnviaXMLsContador, Parametros, TipoStatusUso, uTelaDesbloqueio, Criptografia, uMonitorControleNFe,
     uCadastroTransportadora, uRelatorioNFes, uAtualizacaoSistema, Funcoes, uEFDFiscal, uEFDContribuicoes, uSintegra,
     uCadastroAliqPercReducPorEstado, uSAT, system.StrUtils;

{$R *.dfm}

procedure TfrmInicial.AlqeReduoBC1Click(Sender: TObject);
begin
  inherited;
  self.AbreForm(TfrmCadastroAliqPercReducPorEstado);
end;

procedure TfrmInicial.Atualizaodosistema1Click(Sender: TObject);
begin
  if not existeConexaoComInternet then
    avisar(1,'Nenhuma conexão com a internet foi detectada')
  else
    self.AbreForm(TfrmAtualizacaoSistema);
end;

procedure TfrmInicial.atualizaParametros(status :integer; datafinal :TDateTime; mensagem :String; ultimaConexao :TDateTime);
var
    Repositorio :TRepositorio;
begin
  try
    Repositorio := TFabricaRepositorio.GetRepositorio(TParametros.ClassName);

    dm.Parametros.SetUsoInteger( status );
    dm.Parametros.data_final     := datafinal;
    dm.Parametros.mensagem       := mensagem;
    dm.Parametros.ultima_conexao := ultimaConexao;

    Repositorio.Salvar(dm.Parametros);
  finally
    FreeAndNil(Repositorio);
  end;
end;

procedure TfrmInicial.CFOP1Click(Sender: TObject);
begin
  self.AbreForm(TfrmCadastroCFOP);
end;

procedure TfrmInicial.Clientes1Click(Sender: TObject);
begin
  self.AbreForm(TfrmCadastroCliente);
end;

function TfrmInicial.buscaDadosLiberacao: Boolean;
begin
  try
    qry.Close;
    qry.ParamByName('cnpj').AsString := dm.Empresa.cpf_cnpj;
    qry.Open;

    result := true;
  Except
    result := false;
  end;
end;

procedure TfrmInicial.conectaServidor;
var conectou :Boolean;
begin
  try
  try
    dm.FDConnectionServidor.Connected := true;
    conectou := true;

    if dm.Parametros.ultima_conexao = date then
      exit
    else
      conectou := buscaDadosLiberacao;

    if conectou then
      atualizaParametros(qry.FieldByName('Status').AsInteger,
                         qry.FieldByName('datafinal').AsDateTime,
                         qry.FieldByName('mensagem').AsString,
                         Date);
  Except
  end;
  finally
    dm.FDConnectionServidor.Connected := false;
  end;
end;

procedure TfrmInicial.configuraTela;
var vSAT :boolean;
begin
  vSAT := dm.Empresa.Endereco.Cidade.Estado.sigla = 'SP';

  imgNFCe.Visible := not vSAT;
  imgSAT.Visible  := vSAT;
  lbNFCes.Caption := IfThen(vSAT, 'F4 - SAT', 'F4 - NFC-es');
end;

procedure TfrmInicial.Contador1Click(Sender: TObject);
begin
  self.AbreForm(TfrmCadastroContador);
end;

procedure TfrmInicial.DadosdaEmpresa1Click(Sender: TObject);
begin
  self.AbreForm(TfrmCadastroDadosEmpresa);
  configuraTela;
end;

procedure TfrmInicial.EFDContribuies1Click(Sender: TObject);
begin
  self.AbreForm(TfrmEFDContribuicoes);
end;

procedure TfrmInicial.EFDFiscal1Click(Sender: TObject);
begin
  self.AbreForm(TfrmEFDFiscal);
end;

procedure TfrmInicial.enviaNotasPendentes;
var Servico :TServicoEmissorNFCe;
    parametrosNfce :TParametrosNFCe;
    repositorio :TRepositorio;
begin
  try
    if not (dm.Empresa.ConfiguracoesNF.ParametrosNFCe.forma_emissao = 0) then
    begin
      try
        dm.Empresa.ConfiguracoesNF.ParametrosNFCe.forma_emissao := 0;
        repositorio := TFabricaRepositorio.GetRepositorio(TParametrosNFCe.ClassName);
        repositorio.Salvar(dm.Empresa.ConfiguracoesNF.ParametrosNFCe);
      finally
        FreeAndNil(repositorio);
      end;
    end;

    dm.qryGenerica2.Close;
    dm.qryGenerica2.SQL.Text := 'select nfce.codigo_pedido from nfce '+
                                ' where nfce.status = ''0''          ';
    dm.qryGenerica2.Open;

    dm.Empresa.ConfiguracoesNF.ParametrosNFCe.visualiza_impressao := false;
    Servico := TServicoEmissorNFCe.Create(dm.Empresa, true);

    dm.qryGenerica2.First;
    while not dm.qryGenerica2.Eof do
    begin
      Servico.Emitir(dm.qryGenerica2.FieldByName('codigo_pedido').AsInteger,'');

      dm.qryGenerica2.Next;
    end;
    dm.Empresa.ConfiguracoesNF.ParametrosNFCe.visualiza_impressao := true;

    verificaNFCesPendentes;
  finally
    FreeAndNil(Servico);
  end;
end;

function TfrmInicial.existeNotasEmContingencia: Boolean;
begin
  dm.qryGenerica.Close;
  dm.qryGenerica.SQL.Text := 'select count(NFCE.codigo) from NFCE '+
                             ' where NFCE.status = ''0''          ';
  dm.qryGenerica.Open;

  result := not dm.qryGenerica.IsEmpty;
end;

procedure TfrmInicial.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if not confirma('Deseja realmente sair do sistema?') then
    abort;
end;

procedure TfrmInicial.FormCreate(Sender: TObject);
begin
  inherited;
  self.DoubleBuffered := true;
end;

procedure TfrmInicial.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  if key = VK_F3 then
    Pedidoconsumidorfinal1Click(nil)
  else if key = VK_F4 then
  begin
    if (dm.Empresa.Endereco.Cidade.Estado.sigla <> 'SP') then
      NFCes1Click(nil)
    else
      SAT1Click(nil);
  end
  else if key = VK_F2 then
    Produtos1Click(nil)
  else if key = VK_F5 then
    MonitorNFe1Click(nil);
end;

procedure TfrmInicial.FormShow(Sender: TObject);
begin
  configuraTela;
  verificaNFCesPendentes;
  if dm.Parametros.versao_banco_de_dados > 5 then
  begin
    conectaServidor;
    verificaLiberacao;
  end;
end;

procedure TfrmInicial.Fornecedores1Click(Sender: TObject);
begin
  self.AbreForm(TfrmCadastroFornecedor);
end;

procedure TfrmInicial.Image3Click(Sender: TObject);
begin
  Pedidoconsumidorfinal1Click(nil);
end;

procedure TfrmInicial.Image3MouseEnter(Sender: TObject);
begin
  lbVenda.Font.Color := $00F4F0B9;
end;

procedure TfrmInicial.Image3MouseLeave(Sender: TObject);
begin
  lbVenda.Font.Color := $008BE9D1;
end;

procedure TfrmInicial.imgNFCeClick(Sender: TObject);
begin
  NFCes1Click(nil);
end;

procedure TfrmInicial.imgNFCeMouseEnter(Sender: TObject);
begin
  lbNFCes.Font.Color := $00F4F0B9;
end;

procedure TfrmInicial.imgNFCeMouseLeave(Sender: TObject);
begin
  lbNFCes.Font.Color := $008BE9D1;
end;

procedure TfrmInicial.imgSATClick(Sender: TObject);
begin
  SAT1Click(nil);
end;

procedure TfrmInicial.Image5Click(Sender: TObject);
begin
  Produtos1Click(nil);
end;

procedure TfrmInicial.Image5MouseEnter(Sender: TObject);
begin
  lbProdutos.Font.Color := $00F4F0B9;
end;

procedure TfrmInicial.Image5MouseLeave(Sender: TObject);
begin
  lbProdutos.Font.Color := $008BE9D1;
end;

procedure TfrmInicial.Image6Click(Sender: TObject);
begin
  MonitorNFe1Click(nil);
end;

procedure TfrmInicial.Image6MouseEnter(Sender: TObject);
begin
  lbNFes.Font.Color := $00F4F0B9;
end;

procedure TfrmInicial.Image6MouseLeave(Sender: TObject);
begin
  lbNFes.Font.Color := $008BE9D1;
end;

procedure TfrmInicial.MonitorNFe1Click(Sender: TObject);
begin
  self.AbreForm(TfrmMonitorControleNFe);
end;

procedure TfrmInicial.NCM1Click(Sender: TObject);
begin
  self.AbreForm(TfrmCadastroNcmIBPT);
end;

procedure TfrmInicial.NFCes1Click(Sender: TObject);
begin
  self.AbreForm(TFrmNFCes);
end;

procedure TfrmInicial.pedeSenha;
var senhaCorreta :Boolean;
    repositorio  :TRepositorio;
    msgPadrao    :String;
begin
  try
    timer2.Enabled := false;
    msgPadrao := 'Sistema bloqueado, favor ';
    frmTelaDesbloqueio := TfrmTelaDesbloqueio.Create(nil, msgPadrao + dm.Parametros.mensagem);
    senhaCorreta       := frmTelaDesbloqueio.ShowModal = mrOk;
    frmTelaDesbloqueio := nil;

    if not senhaCorreta then
    begin
      Application.Terminate;
    end
    else
    begin
      try
        repositorio              := TFabricaRepositorio.GetRepositorio(TParametros.ClassName);
        dm.Parametros.data_senha := TCriptografia.Encripta( DateToStr(Date) );
        repositorio.Salvar(dm.Parametros);
      finally
        FreeAndNil(repositorio);
      end;
    end;

  finally
    timer2.Enabled := true;
  end;
end;

procedure TfrmInicial.Pedidoconsumidorfinal1Click(Sender: TObject);
begin
  self.AbreForm(TFrmPedidoConsumidorFinal);
  verificaNFCesPendentes;
end;

procedure TfrmInicial.Produtos1Click(Sender: TObject);
begin
  self.AbreForm(TfrmCadastroProduto);
end;

procedure TfrmInicial.ransportadoras1Click(Sender: TObject);
begin
  self.AbreForm(TfrmCadastroTransportadora);
end;

procedure TfrmInicial.RelatriodeNFCes1Click(Sender: TObject);
begin
  self.AbreForm(TfrmRelatorioNFCes);
end;

procedure TfrmInicial.RelatriodeNFes1Click(Sender: TObject);
begin
  self.AbreForm(TfrmRelatorioNFes);
end;

procedure TfrmInicial.SAT1Click(Sender: TObject);
begin
  self.AbreForm(TFrmSAT);
end;

function TfrmInicial.servicoOperante: Boolean;
var Servico :TServicoEmissorNFCe;
begin
  try
    Servico := TServicoEmissorNFCe.Create(dm.Empresa);
    result  := Servico.servicoOperante;
  finally
    FreeAndNil(Servico);
  end;
end;

procedure TfrmInicial.Sintegra1Click(Sender: TObject);
begin
  self.AbreForm(TfrmSintegra);
end;

procedure TfrmInicial.Timer1Timer(Sender: TObject);
begin
  try
    Timer1.Enabled := false;
    //atualiza a tabela parametros, para bloqueio caso seja necessário
    conectaServidor;
    if existeNotasEmContingencia and servicoOperante then
      enviaNotasPendentes;
  finally
    Timer1.Enabled := true;
  end;
end;

procedure TfrmInicial.Timer2Timer(Sender: TObject);
begin
   verificaLiberacao;
end;

procedure TfrmInicial.verificaLiberacao;
begin
  if dm.Parametros.status_uso = tsuLiberado then
    exit
  else if (dm.Parametros.status_uso = tsuBloqueado) and ((dm.Parametros.data_senha = '')or(StrToDate(TCriptografia.Desencripta(dm.Parametros.data_senha)) <> date)) then
    pedeSenha
  else if (dm.Parametros.status_uso = tsuLimitado) and ((dm.Parametros.data_senha = '')or(StrToDate(TCriptografia.Desencripta(dm.Parametros.data_senha)) <> date)) then
  begin
    if dm.Parametros.data_final < Date then
      pedeSenha;
  end;
end;

procedure TfrmInicial.verificaNFCesPendentes;
begin
  dm.qryGenerica.Close;
  dm.qryGenerica.SQL.Text := 'select count(nfce.codigo_pedido) qtd from nfce        '+
                             ' where not nfce.status in (''100'',''101'')           '+
                             '   and (select inu.codigo from notas_inutilizadas inu '+
                             '        where (inu.modelo = ''65'')and(nfce.nr_nota >= inu.inicio)and(nfce.nr_nota <= inu.fim)) is null';
  dm.qryGenerica.Open;

  lbPendentes.Caption := intToStr(dm.qryGenerica.FieldByName('qtd').AsInteger);
end;

procedure TfrmInicial.XMLsaocontador1Click(Sender: TObject);
begin
  self.AbreForm(TfrmEnviaXMLsContador);
end;

end.
