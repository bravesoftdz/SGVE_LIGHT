unit Pessoa;

interface

uses SysUtils, Contnrs, Endereco;

type
  TPessoa = class

  private
    Fcodigo :Integer;
    Frazao :String;
    Fnome_fantasia :String;
    Fpessoa :String;
    Ftipo :String;
    Fcpf_cnpj :String;
    Frg_ie :String;
    Fdtcadastro :TDateTime;
    Ffone1 :String;
    Ffone2 :String;
    Femail :String;
    FEndereco :TEndereco;

  private
    function GetEndereco: TEndereco;

  public
    property codigo                :Integer read Fcodigo                write Fcodigo;
    property razao                 :String read Frazao                 write Frazao;
    property nome_fantasia         :String read Fnome_fantasia         write Fnome_fantasia;
    property pessoa                :String read Fpessoa                write Fpessoa;
    property tipo                  :String read Ftipo                  write Ftipo;
    property cpf_cnpj              :String read Fcpf_cnpj              write Fcpf_cnpj;
    property rg_ie                 :String read Frg_ie                 write Frg_ie;
    property dtcadastro            :TDateTime read Fdtcadastro            write Fdtcadastro;
    property fone1                 :String read Ffone1                 write Ffone1;
    property fone2                 :String read Ffone2                 write Ffone2;
    property email                 :String read Femail                 write Femail;

  public
    property Endereco              :TEndereco read GetEndereco;

    procedure adicionaEndereco(logradouro,
                               numero,
                               bairro,
                               cep,
                               complemento :String;
                               codigoCidade :integer;
                               const codigo :integer = 0);
  public
    destructor  Destroy; override;

end;

implementation

uses repositorio, fabricaRepositorio, EspecificacaoEnderecoPorCodigoPessoa;

{ TPessoa }

procedure TPessoa.adicionaEndereco(logradouro, numero, bairro, cep, complemento: String; codigoCidade: integer; const codigo :integer);
begin
  FEndereco := TEndereco.Create;

  FEndereco.codigo      := codigo;
  FEndereco.logradouro  := logradouro;
  FEndereco.numero      := numero;
  FEndereco.bairro      := bairro;
  FEndereco.cep         := cep;
  FEndereco.complemento := complemento;
  FEndereco.codcidade   := codigoCidade;
end;

destructor TPessoa.destroy;
begin
  if assigned(FEndereco) then
    freeAndNil(FEndereco);

  inherited;
end;

function TPessoa.GetEndereco: TEndereco;
var repositorio   :TRepositorio;
    especificacao :TEspecificacaoEnderecoPorCodigoPessoa;
begin

  if not assigned(FEndereco) then
  begin
    repositorio   := TFabricaRepositorio.GetRepositorio(TEndereco.ClassName);
    especificacao := TEspecificacaoEnderecoPorCodigoPessoa.Create(self.codigo);
    FEndereco     := TEndereco(repositorio.GetPorEspecificacao(especificacao));
  end;

  result := FEndereco;
end;

end.
