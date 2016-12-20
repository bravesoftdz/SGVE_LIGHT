unit RepositorioNotaInutilizada;

interface

uses DB, Repositorio;

type
  TRepositorioNotaInutilizada = class(TRepositorio)

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

uses SysUtils, NotaInutilizada;

{ TRepositorioNotaInutilizada }

function TRepositorioNotaInutilizada.Get(Dataset: TDataSet): TObject;
var
  NotaInutilizada :TNotaInutilizada;
begin
   NotaInutilizada               := TNotaInutilizada.Create;
   NotaInutilizada.codigo        := self.FQuery.FieldByName('codigo').AsInteger;
   NotaInutilizada.modelo        := self.FQuery.FieldByName('modelo').AsString;
   NotaInutilizada.serie         := self.FQuery.FieldByName('serie').AsString;
   NotaInutilizada.inicio        := self.FQuery.FieldByName('inicio').AsInteger;
   NotaInutilizada.fim           := self.FQuery.FieldByName('fim').AsInteger;
   NotaInutilizada.justificativa := self.FQuery.FieldByName('justificativa').AsString;

   result := NotaInutilizada;
end;

function TRepositorioNotaInutilizada.GetIdentificador(Objeto: TObject): Variant;
begin
  result := TNotaInutilizada(Objeto).Codigo;
end;

function TRepositorioNotaInutilizada.GetNomeDaTabela: String;
begin
  result := 'NOTAS_INUTILIZADAS';
end;

function TRepositorioNotaInutilizada.GetRepositorio: TRepositorio;
begin
  result := TRepositorioNotaInutilizada.Create;
end;

function TRepositorioNotaInutilizada.IsInsercao(Objeto: TObject): Boolean;
begin
  result := (TNotaInutilizada(Objeto).Codigo <= 0);
end;

procedure TRepositorioNotaInutilizada.SetIdentificador(Objeto: TObject; Identificador: Variant);
begin
  TNotaInutilizada(Objeto).Codigo := Integer(Identificador);
end;
procedure TRepositorioNotaInutilizada.SetParametros(Objeto: TObject);
var
  NotaInutilizada :TNotaInutilizada;
begin
  NotaInutilizada := (Objeto as TNotaInutilizada);

  self.FQuery.ParamByName('codigo').AsInteger        := NotaInutilizada.codigo;
  self.FQuery.ParamByName('modelo').AsString        := NotaInutilizada.modelo;
  self.FQuery.ParamByName('serie').AsString         := NotaInutilizada.serie;
  self.FQuery.ParamByName('inicio').AsInteger        := NotaInutilizada.inicio;
  self.FQuery.ParamByName('fim').AsInteger           := NotaInutilizada.fim;
  self.FQuery.ParamByName('justificativa').AsString := NotaInutilizada.justificativa;
end;

function TRepositorioNotaInutilizada.SQLGet: String;
begin
  result := 'select * from NOTAS_INUTILIZADAS where codigo = :ncod';
end;

function TRepositorioNotaInutilizada.SQLGetAll: String;
begin
  result := 'select * from NOTAS_INUTILIZADAS';
end;

function TRepositorioNotaInutilizada.SQLGetExiste(campo: String): String;
begin
  result := 'select '+ campo +' from NOTAS_INUTILIZADAS where '+ campo +' = :ncampo';
end;

function TRepositorioNotaInutilizada.SQLRemover: String;
begin
  result := ' delete from NOTAS_INUTILIZADAS where codigo = :codigo ';
end;

function TRepositorioNotaInutilizada.SQLSalvar: String;
begin
  result := 'update or insert into NOTAS_INUTILIZADAS (CODIGO ,MODELO ,SERIE ,INICIO ,FIM ,JUSTIFICATIVA) '+
           '                      values ( :CODIGO , :MODELO , :SERIE , :INICIO , :FIM , :JUSTIFICATIVA) ';
end;

end.

