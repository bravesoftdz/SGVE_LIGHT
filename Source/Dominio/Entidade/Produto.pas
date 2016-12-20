unit Produto;

interface

uses SysUtils, Contnrs, NCMIbpt;

type
  TProduto = class

  private
    Fcodigo :Integer;
    Fdescricao :String;
    Fvalor :Real;
    Fcodigo_ibpt :Integer;
    Fcodigo_barras :String;
    FUnidade_medida: String;
    Finf_adicionais: String;

    FNCMIbpt :TNCMIbpt;
    function GetNCMIbpt: TNCMIbpt;

  public
    property codigo                :Integer read Fcodigo                write Fcodigo;
    property descricao             :String  read Fdescricao             write Fdescricao;
    property valor                 :Real    read Fvalor                 write Fvalor;
    property codigo_ibpt           :Integer read Fcodigo_ibpt           write Fcodigo_ibpt;
    property codigo_barras         :String  read Fcodigo_barras         write Fcodigo_barras;
    property unidade_medida        :String  read FUnidade_medida        write FUnidade_medida;
    property inf_adicionais        :String  read Finf_adicionais        write Finf_adicionais;

    property NCMIbpt               :TNCMIbpt read GetNCMIbpt;
end;

implementation

uses repositorio, fabricaRepositorio;

{ TProduto }

function TProduto.GetNCMIbpt: TNCMIbpt;
var repositorio :TRepositorio;
begin
  if not assigned(FNCMIbpt) then
  begin
    repositorio := TFabricaRepositorio.GetRepositorio(TNcmIBPT.ClassName);
    FNCMIbpt    := TNcmIBPT(repositorio.Get(self.Fcodigo_ibpt));
  end;

  result := FNCMIbpt;
end;

end.
