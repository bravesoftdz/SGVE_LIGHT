unit RepositorioClassificacaoFiscal;

interface

uses DB, Repositorio;

type
  TRepositorioClassificacaoFiscal = class(TRepositorio)

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

uses SysUtils, ClassificacaoFiscal;

{ TRepositorioClassificacaoFiscal }

function TRepositorioClassificacaoFiscal.Get(Dataset: TDataSet): TObject;
var
  ClassificacaoFiscal :TClassificacaoFiscal;
begin
   ClassificacaoFiscal:= TClassificacaoFiscal.Create;
   ClassificacaoFiscal.und_medida := self.FQuery.FieldByName('und_medida').AsString;
   ClassificacaoFiscal.ncm        := self.FQuery.FieldByName('ncm').AsInteger;
   ClassificacaoFiscal.codigo     := self.FQuery.FieldByName('codigo').AsInteger;
   ClassificacaoFiscal.descricao  := self.FQuery.FieldByName('descricao').AsString;

   result := ClassificacaoFiscal;
end;

function TRepositorioClassificacaoFiscal.GetIdentificador(Objeto: TObject): Variant;
begin
  result := TClassificacaoFiscal(Objeto).Codigo;
end;

function TRepositorioClassificacaoFiscal.GetNomeDaTabela: String;
begin
  result := 'CLASSIFICACAO_FISCAL';
end;

function TRepositorioClassificacaoFiscal.GetRepositorio: TRepositorio;
begin
  result := TRepositorioClassificacaoFiscal.Create;
end;

function TRepositorioClassificacaoFiscal.IsInsercao(Objeto: TObject): Boolean;
begin
  result := (TClassificacaoFiscal(Objeto).Codigo <= 0);
end;

procedure TRepositorioClassificacaoFiscal.SetIdentificador(Objeto: TObject; Identificador: Variant);
begin
  TClassificacaoFiscal(Objeto).Codigo := Integer(Identificador);
end;
procedure TRepositorioClassificacaoFiscal.SetParametros(Objeto: TObject);
var
  ClassificacaoFiscal :TClassificacaoFiscal;
begin
  ClassificacaoFiscal := (Objeto as TClassificacaoFiscal);

  self.FQuery.ParamByName('und_medida').AsString := ClassificacaoFiscal.und_medida;
  self.FQuery.ParamByName('ncm').AsInteger        := ClassificacaoFiscal.ncm;
  self.FQuery.ParamByName('codigo').AsInteger     := ClassificacaoFiscal.codigo;
  self.FQuery.ParamByName('descricao').AsString  := ClassificacaoFiscal.descricao;
end;

function TRepositorioClassificacaoFiscal.SQLGet: String;
begin
  result := 'select * from CLASSIFICACAO_FISCAL where codigo = :ncod';
end;

function TRepositorioClassificacaoFiscal.SQLGetAll: String;
begin
  result := 'select * from CLASSIFICACAO_FISCAL';
end;

function TRepositorioClassificacaoFiscal.SQLGetExiste(campo: String): String;
begin
  result := 'select '+ campo +' from CLASSIFICACAO_FISCAL where '+ campo +' = :ncampo';
end;

function TRepositorioClassificacaoFiscal.SQLRemover: String;
begin
  result := ' delete from CLASSIFICACAO_FISCAL where codigo = :codigo ';
end;

function TRepositorioClassificacaoFiscal.SQLSalvar: String;
begin
  result := 'update or insert into CLASSIFICACAO_FISCAL (UND_MEDIDA ,NCM ,CODIGO ,DESCRICAO) '+
           '                      values ( :UND_MEDIDA , :NCM , :CODIGO , :DESCRICAO) ';
end;

end.

