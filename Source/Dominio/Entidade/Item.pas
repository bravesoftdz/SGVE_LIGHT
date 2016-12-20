unit Item;

interface

uses SysUtils, Contnrs, Produto;

type
  TItem = class

  private
    Fcodigo :Integer;
    Fcodigo_pedido :Integer;
    Fcodigo_produto :Integer;
    Fvalor_unitario :Real;
    Fquantidade :Real;

  private
    FProduto :TProduto;

    function GetProduto: TProduto;

  public
    property codigo                :Integer read Fcodigo                write Fcodigo;
    property codigo_pedido         :Integer read Fcodigo_pedido         write Fcodigo_pedido;
    property codigo_produto        :Integer read Fcodigo_produto        write Fcodigo_produto;
    property valor_unitario        :Real read Fvalor_unitario        write Fvalor_unitario;
    property quantidade            :Real read Fquantidade            write Fquantidade;

    property Produto               :TProduto read GetProduto;
end;

implementation

uses repositorio, FabricaRepositorio;
{ TItem }

function TItem.GetProduto: TProduto;
var repositorio :TRepositorio;
begin
  if not assigned(FProduto) then
  begin
    repositorio := TFabricaRepositorio.GetRepositorio(TProduto.ClassName);
    FProduto    := TProduto(repositorio.Get(self.Fcodigo_produto));
  end;

  result := FProduto;
end;

end.
