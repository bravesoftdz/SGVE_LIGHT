unit RepositorioEndereco;

interface

uses DB, Repositorio;

type
  TRepositorioEndereco = class(TRepositorio)

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

uses SysUtils, Endereco;

{ TRepositorioEndereco }

function TRepositorioEndereco.Get(Dataset: TDataSet): TObject;
var
  Endereco :TEndereco;
begin
   Endereco:= TEndereco.Create;
   Endereco.codigo      := self.FQuery.FieldByName('codigo').AsInteger;
   Endereco.codpessoa   := self.FQuery.FieldByName('codpessoa').AsInteger;
   Endereco.logradouro  := self.FQuery.FieldByName('logradouro').AsString;
   Endereco.numero      := self.FQuery.FieldByName('numero').AsString;
   Endereco.bairro      := self.FQuery.FieldByName('bairro').AsString;
   Endereco.codcidade   := self.FQuery.FieldByName('codcidade').AsInteger;
   Endereco.cep         := self.FQuery.FieldByName('cep').AsString;
   Endereco.complemento := self.FQuery.FieldByName('complemento').AsString;

   result := Endereco;
end;

function TRepositorioEndereco.GetIdentificador(Objeto: TObject): Variant;
begin
  result := TEndereco(Objeto).Codigo;
end;

function TRepositorioEndereco.GetNomeDaTabela: String;
begin
  result := 'ENDERECOS';
end;

function TRepositorioEndereco.GetRepositorio: TRepositorio;
begin
  result := TRepositorioEndereco.Create;
end;

function TRepositorioEndereco.IsInsercao(Objeto: TObject): Boolean;
begin
  result := (TEndereco(Objeto).Codigo <= 0);
end;

procedure TRepositorioEndereco.SetIdentificador(Objeto: TObject; Identificador: Variant);
begin
  TEndereco(Objeto).Codigo := Integer(Identificador);
end;
procedure TRepositorioEndereco.SetParametros(Objeto: TObject);
var
  Endereco :TEndereco;
begin
  Endereco := (Objeto as TEndereco);

  self.FQuery.ParamByName('codigo').AsInteger      := Endereco.codigo;
  self.FQuery.ParamByName('codpessoa').AsInteger   := Endereco.codpessoa;
  self.FQuery.ParamByName('logradouro').AsString  := Endereco.logradouro;
  self.FQuery.ParamByName('numero').AsString      := Endereco.numero;
  self.FQuery.ParamByName('bairro').AsString      := Endereco.bairro;
  self.FQuery.ParamByName('codcidade').AsInteger   := Endereco.codcidade;
  self.FQuery.ParamByName('cep').AsString         := Endereco.cep;
  self.FQuery.ParamByName('complemento').AsString := Endereco.complemento;
end;

function TRepositorioEndereco.SQLGet: String;
begin
  result := 'select * from ENDERECOS where codigo = :ncod';
end;

function TRepositorioEndereco.SQLGetAll: String;
begin
  result := 'select * from ENDERECOS';
end;

function TRepositorioEndereco.SQLGetExiste(campo: String): String;
begin
  result := 'select '+ campo +' from ENDERECOS where '+ campo +' = :ncampo';
end;

function TRepositorioEndereco.SQLRemover: String;
begin
  result := ' delete from ENDERECOS where codigo = :codigo ';
end;

function TRepositorioEndereco.SQLSalvar: String;
begin
  result := 'update or insert into ENDERECOS (CODIGO ,CODPESSOA ,LOGRADOURO ,NUMERO ,BAIRRO ,CODCIDADE ,CEP ,COMPLEMENTO) '+
           '                      values ( :CODIGO , :CODPESSOA , :LOGRADOURO , :NUMERO , :BAIRRO , :CODCIDADE , :CEP , :COMPLEMENTO) ';
end;

end.

