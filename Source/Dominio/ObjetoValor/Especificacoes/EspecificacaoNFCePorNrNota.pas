unit EspecificacaoNFCePorNrNota;

interface

uses
  Especificacao, SysUtils;

type
  TEspecificacaoNFCePorNrNota = class(TEspecificacao)

  private
    FNrNota :integer;

  public
    constructor Create(nrNota :integer);

  public
    function SatisfeitoPor(Objeto :TObject): Boolean; override;
end;

implementation

uses NFCe;

{ TEspecificacaoNFCePorNrNota }

constructor TEspecificacaoNFCePorNrNota.Create(nrNota: integer);
begin
  self.FNrNota := nrNota;
end;

function TEspecificacaoNFCePorNrNota.SatisfeitoPor(Objeto: TObject): Boolean;
begin
  result := TNFCe(Objeto).nr_nota = FNrNota;
end;

end.
