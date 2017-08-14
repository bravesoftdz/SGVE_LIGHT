unit Pedido;

interface

uses SysUtils, Contnrs, Item, Generics.Collections, Cliente, NFCe, SAT;

type
  TPedido = class

  private
    Fcodigo :Integer;
    Fcodigo_cliente :Integer;
    Fdt_cadastro :TDateTime;
    Fsituacao :String;
    Facrescimo :Real;
    Fdesconto :Real;
    Fdesconto_fpgto :Real;
    Fvalor_total :Real;
    Fcpf_cliente :String;
    FItens  :TObjectList<TItem>;
    FCliente :TCliente;
    FNFCe :TNFCe;
    FSAT :TSAT;

  private
    function GetItens: TObjectList<TItem>;
    function GetCliente: TCliente;
    function GetNFCe: TNFCe;
    function GetSAT: TSAT;

  public
    property codigo           :Integer read Fcodigo             write Fcodigo;
    property codigo_cliente   :Integer read Fcodigo_cliente     write Fcodigo_cliente;
    property dt_cadastro      :TDateTime read Fdt_cadastro      write Fdt_cadastro;
    property situacao         :String read Fsituacao            write Fsituacao;
    property acrescimo        :Real read Facrescimo             write Facrescimo;
    property desconto         :Real read Fdesconto              write Fdesconto;
    property desconto_fpgto   :Real read Fdesconto_fpgto        write Fdesconto_fpgto;
    property valor_total      :Real read Fvalor_total           write Fvalor_total;
    property cpf_cliente      :String read Fcpf_cliente         write Fcpf_cliente;

    property Cliente          :TCliente           read GetCliente;
    property Itens            :TObjectList<TItem> read GetItens;
    property NFCe             :TNFCe              read GetNFCe;
    property SAT              :TSAT               read GetSAT;

  public
    destructor destroy;
    procedure adicionaItem(item :TItem);
end;

implementation

uses repositorio, fabricaRepositorio, EspecificacaoItensDoPedido, EspecificacaoNFCePorCodigoPedido, Funcoes, EspecificacaoSATPorCodigoPedido;

{ TPedido }

procedure TPedido.adicionaItem(item: TItem);
begin
  self.GetItens;
  if not assigned(FItens) then
    FItens := TObjectList<TItem>.Create(true);

  FItens.Add(item);
end;

destructor TPedido.destroy;
begin
  if assigned(FItens) then
    FreeAndNil(FItens);
  if assigned(FNFCe) then
    FreeAndNil(FNFCe);
  if assigned(FSAT) then
    FreeAndNil(FSAT);

  inherited;
end;

function TPedido.GetCliente: TCliente;
var repositorio :TRepositorio;
begin
  if not assigned(FCliente) then
  begin
    repositorio := TFabricaRepositorio.GetRepositorio(TCliente.ClassName);
    FCliente    := TCliente(repositorio.Get(self.Fcodigo_cliente));
  end;

  result := FCliente;
end;

function TPedido.GetItens: TObjectList<TItem>;
var repositorio :TRepositorio;
    especificacao :TEspecificacaoItensDoPedido;
begin
  if not assigned(FItens) then
  begin
    repositorio   := TFabricaRepositorio.GetRepositorio(TItem.ClassName);
    especificacao := TEspecificacaoItensDoPedido.Create(self.codigo);
    FItens        := repositorio.GetListaPorEspecificacao<TItem>(especificacao, 'CODIGO_PEDIDO = '+IntToStr(self.Fcodigo));
  end;

  result := FItens;
end;

function TPedido.GetNFCe: TNFCe;
var especificacao :TEspecificacaoNFCePorCodigoPedido;
    repositorio :TRepositorio;
begin
  if not assigned(FNFCe) then
  begin
    especificacao := TEspecificacaoNFCePorCodigoPedido.Create(self.Fcodigo);
    repositorio   := TFabricaRepositorio.GetRepositorio(TNFCe.ClassName);
    FNFCe         := TNFCe( repositorio.GetPorEspecificacao(especificacao));
  end;

  result := FNFCe;
end;

function TPedido.GetSAT: TSAT;
var especificacao :TEspecificacaoSATPorCodigoPedido;
    repositorio :TRepositorio;
begin
  if not assigned(FNFCe) then
  begin
    especificacao := TEspecificacaoSATPorCodigoPedido.Create(self.Fcodigo);
    repositorio   := TFabricaRepositorio.GetRepositorio(TNFCe.ClassName);
    FSAT         := TSAT( repositorio.GetPorEspecificacao(especificacao));
  end;

  result := FSAT;
end;

end.
