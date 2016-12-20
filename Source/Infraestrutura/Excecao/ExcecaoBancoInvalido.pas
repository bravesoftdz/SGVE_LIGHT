unit ExcecaoBancoInvalido;

interface

uses
  SysUtils;

type
  TExcecaoBancoInvalido = class(Exception)

  public
    constructor Create;
end;

implementation

{ TExcecaoBancoInvalido }

constructor TExcecaoBancoInvalido.Create;
const
  CORPO = 'Não foi possível conectar ao banco ';
var
  Mensagem :String;
begin
   Mensagem := CORPO + 'de dados';


   inherited Create(Mensagem);
end;

end.
