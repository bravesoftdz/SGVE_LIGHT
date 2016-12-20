unit RepositorioItem;

interface

uses DB, Repositorio, System.StrUtils;

type
  TRepositorioItem = class(TRepositorio)

  protected
    function Get             (Dataset :TDataSet) :TObject; overload; override;
    function GetNomeDaTabela                     :String;            override;
    function GetIdentificador(Objeto :TObject)   :Variant;           override;
    function GetRepositorio                     :TRepositorio;       override;

  protected
    function SQLGet                      :String;            override;
    function SQLSalvar                   :String;            override;
    function SQLGetAll                   :String;            override;
    function CondicaoSQLGetAll           :String;            override;
    function SQLRemover                  :String;            override;
    function SQLGetExiste(campo: String): String;            override;

  protected
    function IsInsercao(Objeto :TObject) :Boolean;           override;
  protected
    procedure SetParametros   (Objeto :TObject                        ); override;
    procedure SetIdentificador(Objeto :TObject; Identificador :Variant); override;
end;

implementation

uses SysUtils, Item;

{ TRepositorioItem }

function TRepositorioItem.CondicaoSQLGetAll: String;
begin
  result := ' WHERE '+FIdentificador;
end;

function TRepositorioItem.Get(Dataset: TDataSet): TObject;
var
  Item :TItem;
begin
   Item:= TItem.Create;
   Item.codigo         := self.FQuery.FieldByName('codigo').AsInteger;
   Item.codigo_pedido  := self.FQuery.FieldByName('codigo_pedido').AsInteger;
   Item.codigo_produto := self.FQuery.FieldByName('codigo_produto').AsInteger;
   Item.valor_unitario := self.FQuery.FieldByName('valor_unitario').AsFloat;
   Item.quantidade     := self.FQuery.FieldByName('quantidade').AsFloat;

   result := Item;
end;

function TRepositorioItem.GetIdentificador(Objeto: TObject): Variant;
begin
  result := TItem(Objeto).Codigo;
end;

function TRepositorioItem.GetNomeDaTabela: String;
begin
  result := 'ITENS';
end;

function TRepositorioItem.GetRepositorio: TRepositorio;
begin
  result := TRepositorioItem.Create;
end;

function TRepositorioItem.IsInsercao(Objeto: TObject): Boolean;
begin
  result := (TItem(Objeto).Codigo <= 0);
end;

procedure TRepositorioItem.SetIdentificador(Objeto: TObject; Identificador: Variant);
begin
  TItem(Objeto).Codigo := Integer(Identificador);
end;
procedure TRepositorioItem.SetParametros(Objeto: TObject);
var
  Item :TItem;
begin
  Item := (Objeto as TItem);

  self.FQuery.ParamByName('codigo').AsInteger         := Item.codigo;
  self.FQuery.ParamByName('codigo_pedido').AsInteger  := Item.codigo_pedido;
  self.FQuery.ParamByName('codigo_produto').AsInteger := Item.codigo_produto;
  self.FQuery.ParamByName('valor_unitario').AsFloat := Item.valor_unitario;
  self.FQuery.ParamByName('quantidade').AsFloat     := Item.quantidade;
end;

function TRepositorioItem.SQLGet: String;
begin
  result := 'select * from ITENS where codigo = :ncod';
end;

function TRepositorioItem.SQLGetAll: String;
begin
  result := 'select * from ITENS'+ IfThen(FIdentificador = '','', CondicaoSQLGetAll);
end;

function TRepositorioItem.SQLGetExiste(campo: String): String;
begin
  result := 'select '+ campo +' from ITENS where '+ campo +' = :ncampo';
end;

function TRepositorioItem.SQLRemover: String;
begin
  result := ' delete from ITENS where codigo = :codigo ';
end;

function TRepositorioItem.SQLSalvar: String;
begin
  result := 'update or insert into ITENS (CODIGO ,CODIGO_PEDIDO ,CODIGO_PRODUTO ,VALOR_UNITARIO , QUANTIDADE) '+
           '                      values ( :CODIGO , :CODIGO_PEDIDO , :CODIGO_PRODUTO , :VALOR_UNITARIO , :QUANTIDADE) ';
end;

end.


