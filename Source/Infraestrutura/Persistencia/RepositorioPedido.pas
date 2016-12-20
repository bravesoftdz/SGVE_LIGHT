unit RepositorioPedido;

interface

uses DB, Repositorio;

type
  TRepositorioPedido = class(TRepositorio)

  protected
    function Get             (Dataset :TDataSet) :TObject; overload; override;
    function GetNomeDaTabela                     :String;            override;
    function GetIdentificador(Objeto :TObject)   :Variant;           override;
    function GetRepositorio                     :TRepositorio;       override;

  protected
    function SQLGet                      :String;            override;
    function SQLSalvar                   :String;            override;
    function SQLGetAll                   :String;            override;
    function SQLRemover                  :String;            override;
    function SQLGetExiste(campo: String): String;            override;

  protected
    function IsInsercao(Objeto :TObject) :Boolean;           override;
  protected
    procedure SetParametros   (Objeto :TObject                        ); override;
    procedure SetIdentificador(Objeto :TObject; Identificador :Variant); override;
    procedure ExecutaDepoisDeSalvar (Objeto :TObject); override;
end;

implementation

uses SysUtils, Pedido, RepositorioItem, Item;

{ TRepositorioPedido }

procedure TRepositorioPedido.ExecutaDepoisDeSalvar(Objeto: TObject);
var repositorio :TRepositorioItem;
    item :TItem;
begin
  try
    repositorio := TRepositorioItem.Create;

    for Item in TPedido(Objeto).Itens do
    begin
      Item.codigo_pedido := TPedido(Objeto).codigo;
      repositorio.Salvar(Item);
    end;
  finally
    FreeAndNil(repositorio);
  end;
end;

function TRepositorioPedido.Get(Dataset: TDataSet): TObject;
var
  Pedido :TPedido;
begin
   Pedido:= TPedido.Create;
   Pedido.codigo         := self.FQuery.FieldByName('codigo').AsInteger;
   Pedido.codigo_cliente := self.FQuery.FieldByName('codigo_cliente').AsInteger;
   Pedido.dt_cadastro    := self.FQuery.FieldByName('dt_cadastro').AsDateTime;
   Pedido.situacao       := self.FQuery.FieldByName('situacao').AsString;
   Pedido.acrescimo      := self.FQuery.FieldByName('acrescimo').AsFloat;
   Pedido.desconto       := self.FQuery.FieldByName('desconto').AsFloat;
   Pedido.desconto_fpgto := self.FQuery.FieldByName('desconto_fpgto').AsFloat;
   Pedido.valor_total    := self.FQuery.FieldByName('valor_total').AsFloat;
   Pedido.cpf_cliente    := self.FQuery.FieldByName('cpf_cliente').AsString;

   result := Pedido;
end;

function TRepositorioPedido.GetIdentificador(Objeto: TObject): Variant;
begin
  result := TPedido(Objeto).Codigo;
end;

function TRepositorioPedido.GetNomeDaTabela: String;
begin
  result := 'PEDIDOS';
end;

function TRepositorioPedido.GetRepositorio: TRepositorio;
begin
  result := TRepositorioPedido.Create;
end;

function TRepositorioPedido.IsInsercao(Objeto: TObject): Boolean;
begin
  result := (TPedido(Objeto).Codigo <= 0);
end;

procedure TRepositorioPedido.SetIdentificador(Objeto: TObject; Identificador: Variant);
begin
  TPedido(Objeto).Codigo := Integer(Identificador);
end;
procedure TRepositorioPedido.SetParametros(Objeto: TObject);
var
  Pedido :TPedido;
begin
  Pedido := (Objeto as TPedido);

  self.FQuery.ParamByName('codigo').AsInteger         := Pedido.codigo;
  self.FQuery.ParamByName('codigo_cliente').AsInteger := Pedido.codigo_cliente;
  self.FQuery.ParamByName('dt_cadastro').AsDateTime    := Pedido.dt_cadastro;
  self.FQuery.ParamByName('situacao').AsString       := Pedido.situacao;
  self.FQuery.ParamByName('acrescimo').AsFloat      := Pedido.acrescimo;
  self.FQuery.ParamByName('desconto').AsFloat       := Pedido.desconto;
  self.FQuery.ParamByName('desconto_fpgto').AsFloat := Pedido.desconto_fpgto;
  self.FQuery.ParamByName('valor_total').AsFloat    := Pedido.valor_total;
  self.FQuery.ParamByName('cpf_cliente').AsString    := Pedido.cpf_cliente;
end;

function TRepositorioPedido.SQLGet: String;
begin
  result := 'select * from PEDIDOS where codigo = :ncod';
end;

function TRepositorioPedido.SQLGetAll: String;
begin
  result := 'select * from PEDIDOS';
end;

function TRepositorioPedido.SQLGetExiste(campo: String): String;
begin
  result := 'select '+ campo +' from PEDIDOS where '+ campo +' = :ncampo';
end;

function TRepositorioPedido.SQLRemover: String;
begin
  result := ' delete from PEDIDOS where codigo = :codigo ';
end;

function TRepositorioPedido.SQLSalvar: String;
begin
  result := 'update or insert into PEDIDOS (CODIGO ,CODIGO_CLIENTE ,DT_CADASTRO ,SITUACAO ,ACRESCIMO ,DESCONTO ,DESCONTO_FPGTO ,VALOR_TOTAL ,CPF_CLIENTE) '+
           '                      values ( :CODIGO , :CODIGO_CLIENTE , :DT_CADASTRO , :SITUACAO , :ACRESCIMO , :DESCONTO , :DESCONTO_FPGTO , :VALOR_TOTAL , :CPF_CLIENTE) ';
end;

end.

