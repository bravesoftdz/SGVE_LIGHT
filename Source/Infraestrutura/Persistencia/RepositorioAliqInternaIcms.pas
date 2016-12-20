unit RepositorioAliqInternaIcms;

interface

uses DB, Repositorio;

type
  TRepositorioAliqInternaIcms = class(TRepositorio)

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

uses SysUtils, AliqInternaIcms;

{ TRepositorioAliqInternaIcms }

function TRepositorioAliqInternaIcms.Get(Dataset: TDataSet): TObject;
var
  AliqInternaIcms :TAliqInternaIcms;
begin
   AliqInternaIcms:= TAliqInternaIcms.Create;
   AliqInternaIcms.codigo        := self.FQuery.FieldByName('codigo').AsInteger;
   AliqInternaIcms.codigo_estado := self.FQuery.FieldByName('codigo_estado').AsInteger;
   AliqInternaIcms.aliquota      := self.FQuery.FieldByName('aliquota').AsFloat;

   result := AliqInternaIcms;
end;

function TRepositorioAliqInternaIcms.GetIdentificador(Objeto: TObject): Variant;
begin
  result := TAliqInternaIcms(Objeto).Codigo;
end;

function TRepositorioAliqInternaIcms.GetNomeDaTabela: String;
begin
  result := 'ALIQ_INTERNA_ICMS';
end;

function TRepositorioAliqInternaIcms.GetRepositorio: TRepositorio;
begin
  result := TRepositorioAliqInternaIcms.Create;
end;

function TRepositorioAliqInternaIcms.IsInsercao(Objeto: TObject): Boolean;
begin
  result := (TAliqInternaIcms(Objeto).Codigo <= 0);
end;

procedure TRepositorioAliqInternaIcms.SetIdentificador(Objeto: TObject; Identificador: Variant);
begin
  TAliqInternaIcms(Objeto).Codigo := Integer(Identificador);
end;
procedure TRepositorioAliqInternaIcms.SetParametros(Objeto: TObject);
var
  AliqInternaIcms :TAliqInternaIcms;
begin
  AliqInternaIcms := (Objeto as TAliqInternaIcms);

  self.FQuery.ParamByName('codigo').AsInteger        := AliqInternaIcms.codigo;
  self.FQuery.ParamByName('codigo_estado').AsInteger := AliqInternaIcms.codigo_estado;
  self.FQuery.ParamByName('aliquota').AsFloat      := AliqInternaIcms.aliquota;
end;

function TRepositorioAliqInternaIcms.SQLGet: String;
begin
  result := 'select * from ALIQ_INTERNA_ICMS where codigo = :ncod';
end;

function TRepositorioAliqInternaIcms.SQLGetAll: String;
begin
  result := 'select * from ALIQ_INTERNA_ICMS';
end;

function TRepositorioAliqInternaIcms.SQLGetExiste(campo: String): String;
begin
  result := 'select '+ campo +' from ALIQ_INTERNA_ICMS where '+ campo +' = :ncampo';
end;

function TRepositorioAliqInternaIcms.SQLRemover: String;
begin
  result := ' delete from ALIQ_INTERNA_ICMS where codigo = :codigo ';
end;

function TRepositorioAliqInternaIcms.SQLSalvar: String;
begin
  result := 'update or insert into ALIQ_INTERNA_ICMS (CODIGO ,CODIGO_ESTADO ,ALIQUOTA) '+
           '                      values ( :CODIGO , :CODIGO_ESTADO , :ALIQUOTA) ';
end;

end.



























