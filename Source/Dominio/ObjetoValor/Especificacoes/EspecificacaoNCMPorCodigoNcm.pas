unit EspecificacaoNCMPorCodigoNcm;

interface

uses
  Especificacao;

type
  TEspecificacaoNCMPorCodigoNcm = class(TEspecificacao)

  private
    FCodigoNcm :String;

  public
    constructor Create(pCodigoNcm :String);

  public
    function SatisfeitoPor(Objeto :TObject): Boolean; override;
  end;

implementation

uses NcmIBPT;

{ TEspecificacaoNCMPorCodigoNcm }

constructor TEspecificacaoNCMPorCodigoNcm.Create(pCodigoNcm: String);
begin
  FCodigoNcm := pCodigoNcm;
end;

function TEspecificacaoNCMPorCodigoNcm.SatisfeitoPor(Objeto: TObject): Boolean;
begin
  result := (TNcmIBPT(Objeto).ncm_ibpt = FCodigoNcm);
end;

end.
