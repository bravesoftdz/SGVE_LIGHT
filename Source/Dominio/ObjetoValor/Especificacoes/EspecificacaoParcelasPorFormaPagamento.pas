unit EspecificacaoParcelasPorFormaPagamento;

interface

uses
  Especificacao;

type
  TEspecificacaoParcelasPorFormaPagamento = class (TEspecificacao)

  private
    FCodigoFpagto :Integer;

  public
    constructor Create(const CodigoFPagto :Integer);

  public
    function SatisfeitoPor(Objeto :TObject) :Boolean; override;
end;

implementation

uses FormaPagamentoParcelas;

{ TEspecificacaoParcelasPorFormaPagamento }

constructor TEspecificacaoParcelasPorFormaPagamento.Create(
  const CodigoFPagto: Integer);
begin
   self.FCodigoFpagto := CodigoFPagto;
end;

function TEspecificacaoParcelasPorFormaPagamento.SatisfeitoPor(
  Objeto: TObject): Boolean;
var
  Parc :TFormaPagamentoParcelas;
begin
   Parc := (Objeto as TFormaPagamentoParcelas);

   result := (self.FCodigoFpagto = Parc.CodFormasPgto);
end;

end.
