unit RepositorioNcmIbpt;

interface

uses DB, Repositorio;

type
  TRepositorioNcmIbpt = class(TRepositorio)

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

uses SysUtils, NcmIbpt;

{ TRepositorioNcmIbpt }

function TRepositorioNcmIbpt.Get(Dataset: TDataSet): TObject;
var
  NcmIbpt :TNcmIbpt;
begin
   NcmIbpt:= TNcmIbpt.Create;
   NcmIbpt.codigo                 := self.FQuery.FieldByName('codigo').AsInteger;
   NcmIbpt.ncm_ibpt               := self.FQuery.FieldByName('ncm_ibpt').AsString;
   NcmIbpt.ex_ibpt                := self.FQuery.FieldByName('ex_ibpt').AsString;
   NcmIbpt.tabela_ibpt            := self.FQuery.FieldByName('tabela_ibpt').AsString;
   NcmIbpt.aliqnacional_ibpt      := self.FQuery.FieldByName('aliqnacional_ibpt').AsFloat;
   NcmIbpt.aliqinternacional_ibpt := self.FQuery.FieldByName('aliqinternacional_ibpt').AsFloat;
   NcmIbpt.cst                    := self.FQuery.FieldByName('cst').AsString;
   NcmIbpt.codigo_cfop            := self.FQuery.FieldByName('codigo_cfop').AsInteger;
   NcmIbpt.codigo_cfop_fora       := self.FQuery.FieldByName('codigo_cfop_fora').AsInteger;

   result := NcmIbpt;
end;

function TRepositorioNcmIbpt.GetIdentificador(Objeto: TObject): Variant;
begin
  result := TNcmIbpt(Objeto).Codigo;
end;

function TRepositorioNcmIbpt.GetNomeDaTabela: String;
begin
  result := 'IBPT';
end;

function TRepositorioNcmIbpt.GetRepositorio: TRepositorio;
begin
  result := TRepositorioNcmIbpt.Create;
end;

function TRepositorioNcmIbpt.IsInsercao(Objeto: TObject): Boolean;
begin
  result := (TNcmIbpt(Objeto).Codigo <= 0);
end;

procedure TRepositorioNcmIbpt.SetIdentificador(Objeto: TObject; Identificador: Variant);
begin
  TNcmIbpt(Objeto).Codigo := Integer(Identificador);
end;
procedure TRepositorioNcmIbpt.SetParametros(Objeto: TObject);
var
  NcmIbpt :TNcmIbpt;
begin
  NcmIbpt := (Objeto as TNcmIbpt);

  self.FQuery.ParamByName('codigo').AsInteger                := NcmIbpt.codigo;
  self.FQuery.ParamByName('ncm_ibpt').AsString               := NcmIbpt.ncm_ibpt;
  self.FQuery.ParamByName('ex_ibpt').AsString                := NcmIbpt.ex_ibpt;
  self.FQuery.ParamByName('tabela_ibpt').AsString            := NcmIbpt.tabela_ibpt;
  self.FQuery.ParamByName('aliqnacional_ibpt').AsFloat       := NcmIbpt.aliqnacional_ibpt;
  self.FQuery.ParamByName('aliqinternacional_ibpt').AsFloat  := NcmIbpt.aliqinternacional_ibpt;
  self.FQuery.ParamByName('cst').AsString                    := NcmIbpt.cst;
  self.FQuery.ParamByName('codigo_cfop').AsInteger           := NcmIbpt.codigo_cfop;
  self.FQuery.ParamByName('codigo_cfop_fora').AsInteger      := NcmIbpt.codigo_cfop_fora;
end;

function TRepositorioNcmIbpt.SQLGet: String;
begin
  result := 'select * from IBPT where codigo = :ncod';
end;

function TRepositorioNcmIbpt.SQLGetAll: String;
begin
  result := 'select * from IBPT';
end;

function TRepositorioNcmIbpt.SQLGetExiste(campo: String): String;
begin
  result := 'select '+ campo +' from IBPT where '+ campo +' = :ncampo';
end;

function TRepositorioNcmIbpt.SQLRemover: String;
begin
  result := ' delete from IBPT where codigo = :codigo ';
end;

function TRepositorioNcmIbpt.SQLSalvar: String;
begin
  result := 'update or insert into IBPT (CODIGO ,NCM_IBPT ,EX_IBPT ,TABELA_IBPT ,ALIQNACIONAL_IBPT ,ALIQINTERNACIONAL_IBPT ,CST ,CODIGO_CFOP, CODIGO_CFOP_FORA) '+
           '                      values ( :CODIGO , :NCM_IBPT , :EX_IBPT , :TABELA_IBPT , :ALIQNACIONAL_IBPT , :ALIQINTERNACIONAL_IBPT , :CST , :CODIGO_CFOP, :CODIGO_CFOP_FORA) ';
end;

end.

