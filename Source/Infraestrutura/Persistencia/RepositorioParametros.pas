unit RepositorioParametros;

interface

uses DB, Repositorio;

type
  TRepositorioParametros = class(TRepositorio)

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

uses SysUtils, Parametros;

{ TRepositorioParametros }

function TRepositorioParametros.Get(Dataset: TDataSet): TObject;
var
  Parametros :TParametros;
begin
   Parametros:= TParametros.Create;
   Parametros.codigo                := self.FQuery.FieldByName('codigo').AsInteger;
   Parametros.versao_banco_de_dados := self.FQuery.FieldByName('versao_banco_de_dados').AsInteger;

   if self.FQuery.FieldByName('versao_banco_de_dados').AsInteger > 5 then
   begin
     Parametros.SetUsoInteger( self.FQuery.FieldByName('status_uso').AsInteger );
     Parametros.data_final            := self.FQuery.FieldByName('data_final').AsDateTime;
     Parametros.mensagem              := self.FQuery.FieldByName('mensagem').AsString;
     Parametros.ultima_conexao        := self.FQuery.FieldByName('ultima_conexao').AsDateTime;
     Parametros.data_senha            := self.FQuery.FieldByName('data_senha').AsString;
   end;

   result := Parametros;
end;

function TRepositorioParametros.GetIdentificador(Objeto: TObject): Variant;
begin
  result := TParametros(Objeto).Codigo;
end;

function TRepositorioParametros.GetNomeDaTabela: String;
begin
  result := 'PARAMETROS';
end;

function TRepositorioParametros.GetRepositorio: TRepositorio;
begin
  result := TRepositorioParametros.Create;
end;

function TRepositorioParametros.IsInsercao(Objeto: TObject): Boolean;
begin
  result := (TParametros(Objeto).Codigo <= 0);
end;

procedure TRepositorioParametros.SetIdentificador(Objeto: TObject; Identificador: Variant);
begin
  TParametros(Objeto).Codigo := Integer(Identificador);
end;
procedure TRepositorioParametros.SetParametros(Objeto: TObject);
var
  Parametros :TParametros;
begin
  Parametros := (Objeto as TParametros);

  self.FQuery.ParamByName('codigo').AsInteger                 := Parametros.codigo;
  self.FQuery.ParamByName('versao_banco_de_dados').AsInteger  := Parametros.versao_banco_de_dados;
  self.FQuery.ParamByName('status_uso').AsInteger             := Parametros.GetUsoInteger;
  self.FQuery.ParamByName('data_final').AsDateTime            := Parametros.data_final;
  self.FQuery.ParamByName('mensagem').AsString                := Parametros.mensagem;
  self.FQuery.ParamByName('ultima_conexao').AsDateTime        := Parametros.ultima_conexao;
  self.FQuery.ParamByName('data_senha').AsString              := Parametros.data_senha;
end;

function TRepositorioParametros.SQLGet: String;
begin
  result := 'select * from PARAMETROS where codigo = :ncod';
end;

function TRepositorioParametros.SQLGetAll: String;
begin
  result := 'select * from PARAMETROS';
end;

function TRepositorioParametros.SQLGetExiste(campo: String): String;
begin
  result := 'select '+ campo +' from PARAMETROS where '+ campo +' = :ncampo';
end;

function TRepositorioParametros.SQLRemover: String;
begin
  result := ' delete from PARAMETROS where codigo = :codigo ';
end;

function TRepositorioParametros.SQLSalvar: String;
begin
  result := 'update or insert into PARAMETROS (CODIGO ,VERSAO_BANCO_DE_DADOS ,STATUS_USO ,DATA_FINAL ,MENSAGEM ,ULTIMA_CONEXAO, DATA_SENHA) '+
           '                      values ( :CODIGO , :VERSAO_BANCO_DE_DADOS , :STATUS_USO , :DATA_FINAL , :MENSAGEM , :ULTIMA_CONEXAO, :DATA_SENHA) ';
end;

end.

