unit RepositorioPessoa;

interface

uses DB, Repositorio;

type
  TRepositorioPessoa = class(TRepositorio)

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
    procedure ExecutaDepoisDeSalvar (Objeto :TObject); override;

  protected
    procedure SetParametros   (Objeto :TObject                        ); override;
    procedure SetIdentificador(Objeto :TObject; Identificador :Variant); override;

end;

implementation

uses SysUtils, Pessoa, Endereco, fabricaRepositorio;

{ TRepositorioPessoa }

procedure TRepositorioPessoa.ExecutaDepoisDeSalvar(Objeto: TObject);
var
  Pessoa                        :TPessoa;
  RepositorioEndereco           :TRepositorio;
begin
   Pessoa := (Objeto as TPessoa);
   try

     if Assigned(Pessoa.Endereco) then begin
       Pessoa.Endereco.codpessoa    := Pessoa.codigo;
       RepositorioEndereco := TFabricaRepositorio.GetRepositorio(TEndereco.ClassName);
       RepositorioEndereco.Salvar(Pessoa.Endereco);
     end;

   finally
     FreeAndNil(RepositorioEndereco);
   end;
end;

function TRepositorioPessoa.Get(Dataset: TDataSet): TObject;
var
  Pessoa :TPessoa;
begin
   Pessoa:= TPessoa.Create;
   Pessoa.codigo        := Dataset.FieldByName('codigo').AsInteger;
   Pessoa.razao         := Dataset.FieldByName('razao').AsString;
   Pessoa.nome_fantasia := Dataset.FieldByName('nome_fantasia').AsString;
   Pessoa.pessoa        := Dataset.FieldByName('pessoa').AsString;
   Pessoa.tipo          := Dataset.FieldByName('tipo').AsString;
   Pessoa.cpf_cnpj      := Dataset.FieldByName('cpf_cnpj').AsString;
   Pessoa.rg_ie         := Dataset.FieldByName('rg_ie').AsString;
   Pessoa.dtcadastro    := Dataset.FieldByName('dtcadastro').AsDateTime;
   Pessoa.fone1         := Dataset.FieldByName('fone1').AsString;
   Pessoa.fone2         := Dataset.FieldByName('fone2').AsString;
   Pessoa.email         := Dataset.FieldByName('email').AsString;

   result := Pessoa;
end;

function TRepositorioPessoa.GetIdentificador(Objeto: TObject): Variant;
begin
  result := TPessoa(Objeto).Codigo;
end;

function TRepositorioPessoa.GetNomeDaTabela: String;
begin
  result := 'PESSOAS';
end;

function TRepositorioPessoa.GetRepositorio: TRepositorio;
begin
  result := TRepositorioPessoa.Create;
end;

function TRepositorioPessoa.IsInsercao(Objeto: TObject): Boolean;
begin
  result := (TPessoa(Objeto).Codigo <= 0);
end;

procedure TRepositorioPessoa.SetIdentificador(Objeto: TObject; Identificador: Variant);
begin
  TPessoa(Objeto).Codigo := Integer(Identificador);
end;
procedure TRepositorioPessoa.SetParametros(Objeto: TObject);
var
  Pessoa :TPessoa;
begin
  Pessoa := (Objeto as TPessoa);

  self.FQuery.ParamByName('codigo').AsInteger        := Pessoa.codigo;
  self.FQuery.ParamByName('razao').AsString         := Pessoa.razao;
  self.FQuery.ParamByName('nome_fantasia').AsString := Pessoa.nome_fantasia;
  self.FQuery.ParamByName('pessoa').AsString        := Pessoa.pessoa;
  self.FQuery.ParamByName('tipo').AsString          := Pessoa.tipo;
  self.FQuery.ParamByName('cpf_cnpj').AsString      := Pessoa.cpf_cnpj;
  self.FQuery.ParamByName('rg_ie').AsString         := Pessoa.rg_ie;
  self.FQuery.ParamByName('dtcadastro').AsDateTime    := Pessoa.dtcadastro;
  self.FQuery.ParamByName('fone1').AsString         := Pessoa.fone1;
  self.FQuery.ParamByName('fone2').AsString         := Pessoa.fone2;
  self.FQuery.ParamByName('email').AsString         := Pessoa.email;
end;

function TRepositorioPessoa.SQLGet: String;
begin
  result := 'select * from PESSOAS where codigo = :ncod';
end;

function TRepositorioPessoa.SQLGetAll: String;
begin
  result := 'select * from PESSOAS';
end;

function TRepositorioPessoa.SQLGetExiste(campo: String): String;
begin
  result := 'select '+ campo +' from PESSOAS where '+ campo +' = :ncampo';
end;

function TRepositorioPessoa.SQLRemover: String;
begin
  result := ' delete from PESSOAS where codigo = :codigo ';
end;

function TRepositorioPessoa.SQLSalvar: String;
begin
  result := 'update or insert into PESSOAS (CODIGO ,RAZAO ,PESSOA ,TIPO ,CPF_CNPJ ,RG_IE ,DTCADASTRO ,FONE1 ,FONE2,EMAIL, NOME_FANTASIA) '+
           '                      values ( :CODIGO , :RAZAO , :PESSOA , :TIPO , :CPF_CNPJ , :RG_IE , :DTCADASTRO , :FONE1 , :FONE2, :EMAIL , :NOME_FANTASIA) ';
end;

end.

