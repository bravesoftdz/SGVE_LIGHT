unit EspecificacaoNFCePorCodigoPedido;

interface

uses
  Especificacao, SysUtils;

type
  TEspecificacaoNFCePorCodigoPedido = class(TEspecificacao)

  private
    FCodigoPedido :integer;

  public
    constructor Create(codigoPedido :integer);

  public
    function SatisfeitoPor(Objeto :TObject): Boolean; override;
end;

implementation

uses NFCe;

{ TEspecificacaoNFCePorCodigoPedido }

constructor TEspecificacaoNFCePorCodigoPedido.Create(codigoPedido: integer);
begin
  self.FCodigoPedido := codigoPedido;
end;

function TEspecificacaoNFCePorCodigoPedido.SatisfeitoPor(Objeto: TObject): Boolean;
begin
  result := TNFCe(Objeto).codigo_pedido = self.FCodigoPedido;
end;

end.
