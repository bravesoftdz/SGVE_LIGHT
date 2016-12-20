unit EspecificacaoItensDoPedido;

interface

uses
  Especificacao;

type
  TEspecificacaoItensDoPedido = class(TEspecificacao)

  private
    FCodigoPedido :Integer;

  public
    constructor Create(CodigoPedido :Integer);

  public
    function SatisfeitoPor(Item :TObject) :Boolean; override;
end;

implementation

uses
  Item;

{ TEspecificacaoItensDoPedido }

constructor TEspecificacaoItensDoPedido.Create(CodigoPedido: Integer);
begin
  FCodigoPedido := CodigoPedido;
end;

function TEspecificacaoItensDoPedido.SatisfeitoPor(Item: TObject): Boolean;
begin
  result := TItem(Item).codigo_pedido = self.FCodigoPedido;
end;

end.
