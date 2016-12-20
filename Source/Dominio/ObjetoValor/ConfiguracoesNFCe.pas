unit ConfiguracoesNFCe;

interface

uses
  ParametrosNFCe{,
  Empresa};

type
  TConfiguracoesNFCe = class

  private
    FNFCe :TParametrosNFCe;
 //   FEmpresa: TEmpresa;
 //   function GetEmpresa: TEmpresa;
    function GetNFCe: TParametrosNFCe;

  private
  //  procedure SetEmpresa(const Value: TEmpresa);
    procedure SetNFCe(const Value: TParametrosNFCe);

  public
    property NFCe :TParametrosNFCe read GetNFCe;
   // property Empresa :TEmpresa read GetEmpresa;

  public
    constructor Create;
    destructor Destroy; override;
end;

implementation

uses
  SysUtils, repositorio, fabricaRepositorio;

{ TParametros }

constructor TConfiguracoesNFCe.Create;
begin
   FNFCe := TParametrosNFCe.Create;
  // FEmpresa := TEmpresa.Create;
end;

destructor TConfiguracoesNFCe.Destroy;
begin
   FreeAndNil(FNFCe);
  // FreeAndNil(FEmpresa);

   inherited;
end;
                      {
function TConfiguracoesNFCe.GetEmpresa: TEmpresa;
var repositorio :TRepositorio;
begin

  if not assigned(FEmpresa) then begin
     repositorio  := TFabricaRepositorio.GetRepositorio(TEmpresa.ClassName);
     Fempresa    := TEmpresa(repositorio.Get(3));
  end;

  result := FEmpresa;
end; }

function TConfiguracoesNFCe.GetNFCe: TParametrosNFCe;
var repositorio :TRepositorio;
begin

  if not assigned(FNFCe) then begin
     repositorio  := TFabricaRepositorio.GetRepositorio(TParametrosNFCe.ClassName);
     FNFCe        := TParametrosNFCe(repositorio.Get(1));
  end;

  result := FNFCe;
end;
        {
procedure TConfiguracoesNFCe.SetEmpresa(const Value: TEmpresa);
begin
  FEmpresa := Value;
end;        }

procedure TConfiguracoesNFCe.SetNFCe(const Value: TParametrosNFCe);
begin
  FNFCe := Value;
end;

end.
