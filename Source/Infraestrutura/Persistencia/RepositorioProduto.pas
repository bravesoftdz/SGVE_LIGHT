unit RepositorioProduto;

interface

uses DB, Repositorio;

type
  TRepositorioProduto = class(TRepositorio)

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

end;

implementation

uses SysUtils, Produto;

{ TRepositorioProduto }

function TRepositorioProduto.Get(Dataset: TDataSet): TObject;
var
  Produto :TProduto;
begin
   Produto:= TProduto.Create;
   Produto.codigo         := self.FQuery.FieldByName('codigo').AsInteger;
   Produto.descricao      := self.FQuery.FieldByName('descricao').AsString;
   Produto.valor          := self.FQuery.FieldByName('valor').AsFloat;
   Produto.codigo_ibpt    := self.FQuery.FieldByName('codigo_ibpt').AsInteger;
   Produto.codigo_barras  := self.FQuery.FieldByName('codigo_barras').AsString;
   Produto.unidade_medida := self.FQuery.FieldByName('unidade_medida').AsString;
   Produto.inf_adicionais := self.FQuery.FieldByName('inf_adicionais').AsString;

   result := Produto;
end;

function TRepositorioProduto.GetIdentificador(Objeto: TObject): Variant;
begin
  result := TProduto(Objeto).Codigo;
end;

function TRepositorioProduto.GetNomeDaTabela: String;
begin
  result := 'PRODUTOS';
end;

function TRepositorioProduto.GetRepositorio: TRepositorio;
begin
  result := TRepositorioProduto.Create;
end;

function TRepositorioProduto.IsInsercao(Objeto: TObject): Boolean;
begin
  result := (TProduto(Objeto).Codigo <= 0);
end;

procedure TRepositorioProduto.SetIdentificador(Objeto: TObject; Identificador: Variant);
begin
  TProduto(Objeto).Codigo := Integer(Identificador);
end;

procedure TRepositorioProduto.SetParametros(Objeto: TObject);
var
  Produto :TProduto;
begin
  Produto := (Objeto as TProduto);

  self.FQuery.ParamByName('codigo').AsInteger         := Produto.codigo;
  self.FQuery.ParamByName('descricao').AsString       := Produto.descricao;
  self.FQuery.ParamByName('valor').AsFloat            := Produto.valor;
  self.FQuery.ParamByName('codigo_ibpt').AsInteger    := Produto.codigo_ibpt;
  self.FQuery.ParamByName('codigo_barras').AsString   := Produto.codigo_barras;
  self.FQuery.ParamByName('unidade_medida').AsString  := Produto.unidade_medida;
  self.FQuery.ParamByName('inf_adicionais').AsString     := Produto.inf_adicionais;
end;

function TRepositorioProduto.SQLGet: String;
begin
  result := 'select * from PRODUTOS where codigo = :ncod';
end;

function TRepositorioProduto.SQLGetAll: String;
begin
  result := 'select * from PRODUTOS';
end;

function TRepositorioProduto.SQLGetExiste(campo: String): String;
begin
  result := 'select '+ campo +' from PRODUTOS where '+ campo +' = :ncampo';
end;

function TRepositorioProduto.SQLRemover: String;
begin
  result := ' delete from PRODUTOS where codigo = :codigo ';
end;

function TRepositorioProduto.SQLSalvar: String;
begin
  result := 'update or insert into PRODUTOS (CODIGO ,DESCRICAO ,VALOR ,CODIGO_IBPT ,CODIGO_BARRAS, UNIDADE_MEDIDA, INF_ADICIONAIS) '+
            '                      values ( :CODIGO , :DESCRICAO , :VALOR , :CODIGO_IBPT , :CODIGO_BARRAS, :UNIDADE_MEDIDA, :INF_ADICIONAIS) ';
end;

end.




