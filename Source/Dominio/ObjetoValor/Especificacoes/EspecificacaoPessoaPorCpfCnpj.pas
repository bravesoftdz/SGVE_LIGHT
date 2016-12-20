unit EspecificacaoPessoaPorCpfCnpj;

interface

uses
  Especificacao;

type
  TEspecificacaoPessoaPorCpfCnpj = class(TEspecificacao)

  private
    FCpfCnpj :String;

  public
    constructor Create(cpfCnpj :String);

  public
    function SatisfeitoPor(Objeto :TObject): Boolean; override;
end;

implementation

uses Pessoa;

{ TEspecificacaoPessoaPorCpfCnpj }

constructor TEspecificacaoPessoaPorCpfCnpj.Create(cpfCnpj: String);
begin
  self.FCpfCnpj := cpfCnpj;
end;

function TEspecificacaoPessoaPorCpfCnpj.SatisfeitoPor(Objeto: TObject): Boolean;
begin
  result := (TPessoa(Objeto).CPF_CNPJ = self.FCpfCnpj);
end;

end.
