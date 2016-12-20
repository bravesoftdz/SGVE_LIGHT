unit Endereco;

interface

uses SysUtils, Contnrs, Cidade;

type
  TEndereco = class

  private
    Fcodigo :Integer;
    Fcodpessoa :Integer;
    Flogradouro :String;
    Fnumero :String;
    Fbairro :String;
    Fcodcidade :Integer;
    Fcep :String;
    Fcomplemento :String;
    FCidade :TCidade;

  private
    function GetCidade: TCidade;

  public
    property codigo                :Integer read Fcodigo                write Fcodigo;
    property codpessoa             :Integer read Fcodpessoa             write Fcodpessoa;
    property logradouro            :String read Flogradouro            write Flogradouro;
    property numero                :String read Fnumero                write Fnumero;
    property bairro                :String read Fbairro                write Fbairro;
    property codcidade             :Integer read Fcodcidade             write Fcodcidade;
    property cep                   :String read Fcep                   write Fcep;
    property complemento           :String read Fcomplemento           write Fcomplemento;

  public
    property Cidade                :TCidade read GetCidade;
end;

implementation

uses repositorio, fabricaRepositorio, EspecificacaoCidadePorCodigoIBGE;

{ TEndereco }

function TEndereco.GetCidade: TCidade;
var repositorio   :TRepositorio;
    especificacao :TEspecificacaoCidadePorCodigoIBGE;
begin

  if not assigned(FCidade) then
  begin
    repositorio   := TFabricaRepositorio.GetRepositorio(TCidade.ClassName);
    especificacao := TEspecificacaoCidadePorCodigoIBGE.Create(self.codcidade);
    FCidade     := TCidade(repositorio.GetPorEspecificacao(especificacao));
  end;

  result := FCidade;
end;

end.
