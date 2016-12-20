unit Criptografia;

interface

uses
  SysUtils;

type
  TCriptografia = class

  public
    class function Encripta(Texto:String; const Chave :Integer = 10):String;
    class Function Desencripta(Texto:String; const Chave :integer = 10):string;
    class function codigoInteiroDaData(Texto:String) :String;
    class function AsciiToInt(Caracter: Char): Integer;

end;

implementation

class function TCriptografia.codigoInteiroDaData(Texto:String) :String;
var
  cont:integer;
  retorno:string;
begin
  if (trim(texto)=EmptyStr) then begin
    result:=texto;
  end else begin
    retorno:='';
    for cont:=1 to length(texto) do begin
      retorno:=retorno+inttostr(asciitoint(texto[cont]));
    end;
    result:=retorno;
  end;
end;

class function TCriptografia.AsciiToInt(Caracter: Char): Integer;
var
  i: Integer;
begin
  i := 32;
  while i < 255 do begin
    if Chr(i) = Caracter then
      Break;
    i := i + 1;
  end;
  Result := i;
end;

class function TCriptografia.Encripta(Texto:String; const Chave :integer):String;
var
  cont:integer;
  retorno:string;
begin
  if (trim(texto)=EmptyStr) or (chave=0) then begin
    result:=texto;
  end else begin
    retorno:='';
    for cont:=1 to length(texto) do begin
      retorno:=retorno+chr(asciitoint(texto[cont])+chave);
    end;
    result:=retorno;
  end;
end;

class function TCriptografia.Desencripta(Texto:String; const Chave :integer):string;
var
  cont:integer;
  retorno:string;
begin
  if (trim(texto)=EmptyStr) or (chave=0) then begin
    result:=texto;
  end else begin
    retorno:='';
    for cont:=1 to length(texto) do begin
      retorno:=retorno+chr(asciitoint(texto[cont])-chave);
    end;
    result:=retorno;
  end;
end;

end.

