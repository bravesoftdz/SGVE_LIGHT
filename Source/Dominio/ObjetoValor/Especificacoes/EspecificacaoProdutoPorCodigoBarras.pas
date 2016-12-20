unit EspecificacaoProdutoPorCodigoBarras;

interface

uses
  Especificacao;

type
  TEspecificacaoProdutoPorCodigoBarras = class(TEspecificacao)

  private
    FCodigoBarras :String;

  public
    constructor Create(pCodigoBarras :String);

  public
    function SatisfeitoPor(Objeto :TObject): Boolean; override;
  end;

implementation

uses Produto;

{ TEspecificacaoProdutoPorCodigoBarras }

constructor TEspecificacaoProdutoPorCodigoBarras.Create(pCodigoBarras: String);
begin
  self.FCodigoBarras := pCodigoBarras;
end;

function TEspecificacaoProdutoPorCodigoBarras.SatisfeitoPor(Objeto: TObject): Boolean;
begin
  result := TProduto(Objeto).codigo_barras = self.FCodigoBarras;
end;

end.
