unit EspecificacaoEnderecoPorCodigoPessoa;

interface

uses
  Especificacao;

type
  TEspecificacaoEnderecoPorCodigoPessoa = class(TEspecificacao)

  private
    FCodigoPessoa :Integer;

  public
    constructor Create(pCodigoPessoa :Integer);

  public
    function SatisfeitoPor(Objeto :TObject): Boolean; override;
  end;

implementation

uses Endereco;

{ TEspecificacaoEnderecoPorCodigoPessoa }

constructor TEspecificacaoEnderecoPorCodigoPessoa.Create(pCodigoPessoa: Integer);
begin
  FCodigoPessoa := pCodigoPessoa;
end;

function TEspecificacaoEnderecoPorCodigoPessoa.SatisfeitoPor(Objeto: TObject): Boolean;
begin
  result := (Objeto as TEndereco).codpessoa = self.FCodigoPessoa;
end;

end.
