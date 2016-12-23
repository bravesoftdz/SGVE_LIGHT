unit EspecificacaoItemNfCfopAliq;

interface

uses Especificacao, TipoRegimeTributario;

type
  TEspecificacaoItemNfCfopAliq = class(TEspecificacao)

  private
    FCfop     :String;
    FAliquota :Real;
    FRegime   :TTipoRegimeTributario;

  public
    constructor Create(CFOP :String; Aliquota :Real; regime :TTipoRegimeTributario);

  public
    function SatisfeitoPor(ItemNotaFiscal :TObject) :Boolean; override;  

end;

implementation

uses ItemNotaFiscal;

{ TEspecificacaoItemNfCfopAliq }

constructor TEspecificacaoItemNfCfopAliq.Create(CFOP : String; Aliquota: Real; regime :TTipoRegimeTributario);
begin
  self.FCfop     := CFOP;
  self.FAliquota := Aliquota;
  self.FRegime   := regime;
end;

function TEspecificacaoItemNfCfopAliq.SatisfeitoPor( ItemNotaFiscal: TObject): Boolean;
var ItemNota :TItemNotaFiscal;
begin
  Result := false;
   
  ItemNota := (ItemNotaFiscal as TItemNotaFiscal);

  if (ItemNota.NaturezaOperacao.CFOP = self.FCfop) then
  begin
     if TTipoRegimeTributarioUtilitario.DeEnumeradoParaInteger(self.FRegime) = 1 then //lucro presumido
     begin
        if (ItemNota.Icms00.Aliquota = self.FAliquota) then
          result := true;
     end
     else if TTipoRegimeTributarioUtilitario.DeEnumeradoParaInteger(self.FRegime) = 0 then //simples nacional
     begin
        if (ItemNota.IcmsSn101.AliquotaCreditoSN = self.FAliquota) then
        result := true;
     end;
  end;

end;

end.

