
unit EspecificacaoEmpresaPorTag;

interface

uses
  Especificacao;

type
  TEspecificacaoEmpresaPorTag = class(TEspecificacao)

  private
    FTAGEmpresa :String;

  public
    constructor Create;

  public
    function SatisfeitoPor(Objeto :TObject): Boolean; override;
  end;

implementation

uses Empresa;

{ TEspecificacaoEmpresaPorTag }

constructor TEspecificacaoEmpresaPorTag.Create;
begin
  FTAGEmpresa := 'E';
end;

function TEspecificacaoEmpresaPorTag.SatisfeitoPor(Objeto: TObject): Boolean;
begin
  result := TEmpresa(Objeto).tipo = FTAGEmpresa;
end;

end.
