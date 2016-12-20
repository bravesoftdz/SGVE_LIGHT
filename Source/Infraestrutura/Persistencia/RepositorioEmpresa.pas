unit RepositorioEmpresa;

interface

uses
  DB,
  Repositorio,
  RepositorioPessoa;

type
  TRepositorioEmpresa = class(TRepositorioPessoa)

  protected
    function Get             (Dataset :TDataSet) :TObject; overload; override;
    function GetNomeDaTabela                     :String;            override;
    function GetIdentificador(Objeto :TObject)   :Variant;           override;
    function GetRepositorio                      :TRepositorio;      override;

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

  protected
    procedure ExecutaDepoisDeSalvar (Objeto :TObject); override;

  //==============================================================================
  // Métodos de persistência no banco dados.
  //==============================================================================
  public
    function Salvar (Objeto              :TObject) :Boolean; override;
    function Remover(Objeto              :TObject) :Boolean; override;
end;

implementation

uses
  Empresa,
  Pessoa,
  TipoRegimeTributario,
  SysUtils, FabricaRepositorio, ConfiguracoesNF, ConfiguracoesNFEmail, ParametrosNFCe, Endereco;

{ TRepositorioEmpresa }

procedure TRepositorioEmpresa.ExecutaDepoisDeSalvar(Objeto: TObject);
var
  Empresa                       :TEmpresa;
  RepositorioConfiguracoes      :TRepositorio;
  RepositorioConfiguracoesEmail :TRepositorio;
  RepositorioParametrosNFCe     :TRepositorio;
  RepositorioEndereco           :TRepositorio;
begin
   inherited ExecutaDepoisDeSalvar(Objeto);

   RepositorioConfiguracoes       := nil;
   RepositorioConfiguracoesEmail  := nil;

   Empresa := (Objeto as TEmpresa);

   try
     if Assigned(Empresa.ConfiguracoesNF) then begin
       Empresa.ConfiguracoesNF.codigo_empresa := Empresa.CodigoEmpresa;
       RepositorioConfiguracoes := TFabricaRepositorio.GetRepositorio(TConfiguracoesNF.ClassName);
       RepositorioConfiguracoes.Remover(Empresa.ConfiguracoesNF);
       RepositorioConfiguracoes.Salvar(Empresa.ConfiguracoesNF);

       if Assigned(Empresa.ConfiguracoesNF.ParametrosNFCe) then begin
         Empresa.ConfiguracoesNF.ParametrosNFCe.codigo_empresa := Empresa.CodigoEmpresa;
         RepositorioParametrosNFCe := TFabricaRepositorio.GetRepositorio(TParametrosNFCe.ClassName);
         RepositorioParametrosNFCe.Remover(Empresa.ConfiguracoesNF.ParametrosNFCe);
         RepositorioParametrosNFCe.Salvar(Empresa.ConfiguracoesNF.ParametrosNFCe);
       end;
     end;

     if Assigned(Empresa.ConfiguracoesEmail) then begin
       Empresa.ConfiguracoesEmail.codigo_empresa := Empresa.CodigoEmpresa;
       RepositorioConfiguracoesEmail := TFabricaRepositorio.GetRepositorio(TConfiguracoesNFEmail.ClassName);
       RepositorioConfiguracoesEmail.Remover(Empresa.ConfiguracoesEmail);
       RepositorioConfiguracoesEmail.Salvar(Empresa.ConfiguracoesEmail);
     end;

     if Assigned(Empresa.Endereco) then begin
       Empresa.Endereco.codpessoa    := Empresa.CodigoEmpresa;
       RepositorioEndereco := TFabricaRepositorio.GetRepositorio(TEndereco.ClassName);
       RepositorioEndereco.Salvar(Empresa.Endereco);
     end;

   finally
     FreeAndNil(RepositorioConfiguracoes);
     FreeAndNil(RepositorioConfiguracoesEmail);
     FreeAndNil(RepositorioParametrosNFCe);
     FreeAndNil(RepositorioEndereco);
   end;
end;

function TRepositorioEmpresa.Get(Dataset: TDataSet): TObject;
var
  Pessoa           :TPessoa;
  Empresa          :TEmpresa;
begin
   Pessoa   := TPessoa(inherited Get(Dataset));

   result := nil;

   if not Assigned(Pessoa) then
     exit;

   Empresa                := TEmpresa.Create;
   Empresa.codigo         := Pessoa.Codigo;
   Empresa.CodigoEmpresa  := Pessoa.Codigo;
   Empresa.Razao          := Pessoa.Razao;
   Empresa.nome_fantasia  := Pessoa.nome_fantasia;
   Empresa.CPF_CNPJ       := Pessoa.CPF_CNPJ;
   Empresa.RG_IE          := Pessoa.RG_IE;
   Empresa.DtCadastro     := Pessoa.DtCadastro;
   Empresa.Fone1          := Pessoa.Fone1;
   Empresa.Fone2          := Pessoa.Fone2;
   Empresa.Email          := Pessoa.Email;

   result := Empresa;
   FreeAndNil(Pessoa);
end;

function TRepositorioEmpresa.GetIdentificador(Objeto: TObject): Variant;
begin
   result := TEmpresa(Objeto).CodigoEmpresa;
end;

function TRepositorioEmpresa.GetNomeDaTabela: String;
begin
   result := inherited GetNomeDaTabela;
end;

function TRepositorioEmpresa.GetRepositorio: TRepositorio;
begin
   result := TRepositorioEmpresa.Create;
end;

function TRepositorioEmpresa.IsInsercao(Objeto: TObject): Boolean;
begin
   result := (TEmpresa(Objeto).CodigoEmpresa <= 0);
end;

function TRepositorioEmpresa.Remover(Objeto: TObject): Boolean;
var
  RepositorioPessoa :TRepositorio;
begin
   RepositorioPessoa := TFabricaRepositorio.GetRepositorio(TPessoa.ClassName);

   try
     result := inherited Remover(Objeto);
   finally
     FreeAndNil(RepositorioPessoa);
   end;
end;

function TRepositorioEmpresa.Salvar(Objeto: TObject): Boolean;
begin
   Result := inherited Salvar(Objeto);
end;

procedure TRepositorioEmpresa.SetIdentificador(Objeto: TObject;
  Identificador: Variant);
begin
   TEmpresa(Objeto).codigo := Integer(Identificador);
end;

procedure TRepositorioEmpresa.SetParametros(Objeto: TObject);
var
  Empresa :TEmpresa;
begin
   inherited SetParametros(Objeto);

   Empresa := (Objeto as TEmpresa);
   inherited SetParametro('codigo', Empresa.CodigoEmpresa);
end;

function TRepositorioEmpresa.SQLGet: String;
begin
   result := inherited SQLGet;
end;

function TRepositorioEmpresa.SQLGetAll: String;
begin
   result := inherited SQLGetAll+ ' WHERE TIPO = ''E''  order by 1';
end;

function TRepositorioEmpresa.SQLGetExiste(campo: String): String;
begin
  result := inherited SQLGetExiste(campo);
end;

function TRepositorioEmpresa.SQLRemover: String;
begin
   result := inherited SQLRemover;
end;

function TRepositorioEmpresa.SQLSalvar: String;
begin
   result := inherited SQLSalvar;
end;

end.
