unit IcmsEstado;

interface

uses SysUtils, Contnrs;

type
  TIcmsEstado = class

  private
    Fcodigo :Integer;
    Fcodigo_estado :Integer;
    Fperc_reducao_bc :Real;

  public
    property codigo                :Integer read Fcodigo                write Fcodigo;
    property codigo_estado         :Integer read Fcodigo_estado         write Fcodigo_estado;
    property perc_reducao_bc       :Real    read Fperc_reducao_bc       write Fperc_reducao_bc;

  public
    constructor CreatePorEstado(codigo_estado: integer);    
end;

implementation

uses EspecificacaoIcmsEstadoPorCodigoEstado, repositorio, fabricaRepositorio, umodulo;

{ TIcmsEstado }

constructor TIcmsEstado.CreatePorEstado(codigo_estado: integer);
var especificacao :TEspecificacaoIcmsEstadoPorCodigoEstado;
    repositorio   :TRepositorio;
begin
  especificacao := nil;
  repositorio   := nil;
  try

    repositorio     := TFabricaRepositorio.GetRepositorio(self.ClassName);

    especificacao   := TEspecificacaoIcmsEstadoPorCodigoEstado.Create(codigo_estado);

    self            := TIcmsEstado( repositorio.GetPorEspecificacao(especificacao) );

  finally
    FreeAndNil(especificacao);
    FreeAndNil(repositorio);
  end;
end;
end.
