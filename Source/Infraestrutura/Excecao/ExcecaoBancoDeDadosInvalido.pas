unit ExcecaoBancoDeDadosInvalido;

interface

uses
  ExcecaoBancoInvalido;

type
  TExcecaoBancoDeDadosInvalido = class(TExcecaoBancoInvalido)

  public
    constructor Create;

end;

implementation

{ TExcecaoBancoDeDadosInvalido }

constructor TExcecaoBancoDeDadosInvalido.Create;
begin
   inherited Create;
end;

end.
