unit Contador;

interface

uses SysUtils, Contnrs, Pessoa;

type
  TContador = class(TPessoa)

  private
    Fcodigo_pessoa :Integer;
    Fcnpj :String;
    Fcrc :String;

  public
    property codigo_pessoa         :Integer read Fcodigo_pessoa         write Fcodigo_pessoa;
    property cnpj                  :String read Fcnpj                  write Fcnpj;
    property crc                   :String read Fcrc                   write Fcrc;

  public
    constructor Create;
end;

implementation

{ TContador }

{ TContador }

constructor TContador.Create;
begin
  self.tipo := 'O';
end;

end.
