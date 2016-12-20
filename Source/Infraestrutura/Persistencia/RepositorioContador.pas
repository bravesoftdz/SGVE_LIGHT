unit RepositorioContador;

interface

uses DB, Repositorio, RepositorioPessoa;

type
  TRepositorioContador = class(TRepositorioPessoa)

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
    function IsComponente                :Boolean;           override;

  public
    function Salvar (Objeto              :TObject) :Boolean; override;
    function Remover(Objeto              :TObject) :Boolean; override;

end;

implementation

uses SysUtils, Contador, FabricaRepositorio, Pessoa;

{ TRepositorioContador }

function TRepositorioContador.Get(Dataset: TDataSet): TObject;
var
  Pessoa :TPessoa;
  Contador :TContador;
begin
   Pessoa:= TPessoa(inherited Get(Dataset));

   result := nil;

   if not assigned(Pessoa) then
     exit;

   Contador               := TContador.Create;
   Contador.Codigo        := Pessoa.Codigo;
   Contador.Razao         := Pessoa.Razao;
   Contador.CPF_CNPJ      := Pessoa.CPF_CNPJ;
   Contador.RG_IE         := Pessoa.RG_IE;
   Contador.DtCadastro    := Pessoa.DtCadastro;
   Contador.Fone1         := Pessoa.Fone1;
   Contador.Fone2         := Pessoa.Fone2;
   Contador.Email         := Pessoa.Email;
   Contador.codigo_pessoa := Pessoa.Codigo;
   Contador.cnpj          := self.FQuery.FieldByName('cnpj').AsString;
   Contador.crc           := self.FQuery.FieldByName('crc').AsString;

   result := Contador;
   FreeAndNil(Pessoa);
end;

function TRepositorioContador.GetIdentificador(Objeto: TObject): Variant;
begin
  result := TContador(Objeto).codigo;
end;

function TRepositorioContador.GetNomeDaTabela: String;
begin
  result := 'CONTADOR';
end;

function TRepositorioContador.GetRepositorio: TRepositorio;
begin
  result := TRepositorioContador.Create;
end;

function TRepositorioContador.IsComponente: Boolean;
begin
  result := true;
end;

function TRepositorioContador.IsInsercao(Objeto: TObject): Boolean;
begin
  result := true;
end;

function TRepositorioContador.Remover(Objeto: TObject): Boolean;
var
  RepositorioPessoa :TRepositorio;
begin
   RepositorioPessoa := TFabricaRepositorio.GetRepositorio(TPessoa.ClassName);

   try
     result := inherited Remover(Objeto);
     RepositorioPessoa.Remover(Objeto);
   finally
     FreeAndNil(RepositorioPessoa);
   end;
end;

function TRepositorioContador.Salvar(Objeto: TObject): Boolean;
var
  RepositorioPessoa :TRepositorio;
begin
   RepositorioPessoa := TFabricaRepositorio.GetRepositorio(TPessoa.ClassName);

   try
     RepositorioPessoa.Salvar(Objeto);

     Result := inherited Salvar(Objeto);
   finally
     FreeAndNil(RepositorioPessoa);
   end;
end;

procedure TRepositorioContador.SetParametros(Objeto: TObject);
var
  Contador :TContador;
begin
  Contador := (Objeto as TContador);

//  inherited SetParametro('codigo', Contador.codigo);

  self.FQuery.ParamByName('codigo_pessoa').AsInteger := Contador.codigo;
  self.FQuery.ParamByName('cnpj').AsString           := Contador.cnpj;
  self.FQuery.ParamByName('crc').AsString            := Contador.crc;
end;

function TRepositorioContador.SQLGet: String;
begin
  result := ' select p.*, C.CNPJ, C.CRC                            '+
            ' from CONTADOR C                                      '+
            ' inner join pessoas p on (C.codigo_pessoa = p.codigo) '+
            ' where C.codigo_PESSOA = :nCodigo                     ';
end;

function TRepositorioContador.SQLGetAll: String;
begin
  result := 'select p.*, C.CNPJ, C.CRC from CONTADOR C inner join pessoas p on (C.codigo_pessoa = p.codigo) order by CODIGO';
end;

function TRepositorioContador.SQLGetExiste(campo: String): String;
begin
  result := 'select '+ campo +' from CONTADOR where '+ campo +' = :ncampo';
end;

function TRepositorioContador.SQLRemover: String;
begin
  result := ' delete from CONTADOR where codigo_pessoa = :codigo ';
end;

function TRepositorioContador.SQLSalvar: String;
begin
  result := 'update or insert into CONTADOR (CODIGO_PESSOA ,CNPJ ,CRC) '+
           '                      values ( :CODIGO_PESSOA , :CNPJ , :CRC) ';
end;

end.

