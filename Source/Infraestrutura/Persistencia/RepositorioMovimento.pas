unit RepositorioMovimento;

interface

uses DB, Repositorio, System.StrUtils;

type
  TRepositorioMovimento = class(TRepositorio)

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

uses SysUtils, Movimento, Funcoes;

{ TRepositorioMovimento }

function TRepositorioMovimento.CondicaoSQLGetAll: String;
begin
  result := ' WHERE '+FIdentificador;
end;

function TRepositorioMovimento.Get(Dataset: TDataSet): TObject;
var
  Movimento :TMovimento;
begin
   Movimento:= TMovimento.Create;
   Movimento.codigo        := self.FQuery.FieldByName('codigo').AsInteger;
   Movimento.tipo_moeda    := self.FQuery.FieldByName('tipo_moeda').AsInteger;
   Movimento.codigo_pedido := self.FQuery.FieldByName('codigo_pedido').AsInteger;
   Movimento.data          := self.FQuery.FieldByName('data').AsDateTime;
   Movimento.valor_pago    := self.FQuery.FieldByName('valor_pago').AsFloat;

   result := Movimento;
end;

function TRepositorioMovimento.GetIdentificador(Objeto: TObject): Variant;
begin
  result := TMovimento(Objeto).Codigo;
end;

function TRepositorioMovimento.GetNomeDaTabela: String;
begin
  result := 'MOVIMENTOS';
end;

function TRepositorioMovimento.GetRepositorio: TRepositorio;
begin
  result := TRepositorioMovimento.Create;
end;

function TRepositorioMovimento.IsInsercao(Objeto: TObject): Boolean;
begin
  result := (TMovimento(Objeto).Codigo <= 0);
end;

procedure TRepositorioMovimento.SetIdentificador(Objeto: TObject; Identificador: Variant);
begin
  TMovimento(Objeto).Codigo := Integer(Identificador);
end;
procedure TRepositorioMovimento.SetParametros(Objeto: TObject);
var
  Movimento :TMovimento;
begin
  Movimento := (Objeto as TMovimento);

  self.FQuery.ParamByName('codigo').AsInteger        := Movimento.codigo;
  self.FQuery.ParamByName('tipo_moeda').AsInteger    := Movimento.tipo_moeda;
  self.FQuery.ParamByName('codigo_pedido').AsInteger := Movimento.codigo_pedido;
  self.FQuery.ParamByName('data').AsDateTime         := Movimento.data;
  self.FQuery.ParamByName('valor_pago').AsFloat      := Movimento.valor_pago;
end;

function TRepositorioMovimento.SQLGet: String;
begin
  result := 'select * from MOVIMENTOS where codigo = :ncod';
end;

function TRepositorioMovimento.SQLGetAll: String;
begin
  result := 'select * from MOVIMENTOS ' + IfThen(FIdentificador = '','', CondicaoSQLGetAll);
end;

function TRepositorioMovimento.SQLGetExiste(campo: String): String;
begin
  result := 'select '+ campo +' from MOVIMENTOS where '+ campo +' = :ncampo';
end;

function TRepositorioMovimento.SQLRemover: String;
begin
  result := ' delete from MOVIMENTOS where codigo = :codigo ';
end;

function TRepositorioMovimento.SQLSalvar: String;
begin
  result := 'update or insert into MOVIMENTOS (CODIGO ,TIPO_MOEDA ,CODIGO_PEDIDO ,DATA, VALOR_PAGO) '+
           '                      values ( :CODIGO , :TIPO_MOEDA , :CODIGO_PEDIDO , :DATA, :VALOR_PAGO) ';
end;

end.

