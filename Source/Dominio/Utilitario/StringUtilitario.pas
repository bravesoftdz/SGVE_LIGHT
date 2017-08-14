unit StringUtilitario;

interface

type
  TStringUtilitario = class
  
  public
    class function ApenasNumeros    (const Texto :String)                      :String;
    class function EstaVazia        (Texto :String)                            :Boolean;
    class function FormataCEP       (const CEP   :String)                      :String; overload;
    class function FormataCEP       (const CEP   :String; UsaPonto :Boolean)   :String; overload;
    class function FormataDinheiro  (const Valor :Real)                        :String;          
    class function LetraPorSequencia(NumeroSequencia :Integer)                 :String;
    class function StringVazia                                                 :String;
    class function RemoveCaracter   (const Texto :String; const Caracter :String) :String;
    class function CaracterAEsquerda(Caracter :Char; Texto :String; tamanho_maximo :Integer) :String;
    class function MascaraCpfCnpj   (const CpfCnpj :String)                       :String;
    class function remove_quebras   (texto :String) :String;
    class function salvarTexto      (texto, caminho :String) :Boolean;
end;

implementation

uses
  SysUtils, StrUtils, Classes;

{ TStringUtilitario }

class function TStringUtilitario.ApenasNumeros(
  const Texto: String): String;
var nX: Integer;
begin
  result := '';

  for nX := 1 To Length(Texto) do begin
      if Texto[nX] in ['0'..'9'] Then
        result := result + Texto[nX];
  end;
end;

class function TStringUtilitario.CaracterAEsquerda(Caracter :Char; Texto: String;
  tamanho_maximo: Integer): String;
var vezes :Integer;
begin

  vezes := tamanho_maximo - Length(Texto);

  Result := StringOfChar(Caracter, vezes ) + Texto;

end;

class function TStringUtilitario.EstaVazia(Texto: String): Boolean;
begin
   result := (Trim(Texto) = self.StringVazia);
end;

class function TStringUtilitario.FormataCEP(const CEP: String; UsaPonto :Boolean): String;
var
  nX: Integer;
begin
  result := '';

  for nX := 1 to Length(CEP) do begin
      if CEP[nX] in ['0'..'9'] Then
        result := result + CEP[nX];
  end;

  if (Length(Result) <> 8) then
    exit;

   if UsaPonto then
     result := copy(Result,1,2) + '.' + copy(Result,3,3) + '-' + copy(Result,6,3)
   else
     result := copy(Result,1,2) +       copy(Result,3,3) + '-' + copy(Result,6,3);
end;

class function TStringUtilitario.FormataCEP(const CEP: String): String;
begin
   result := self.FormataCEP(CEP, true);
end;

class function TStringUtilitario.FormataDinheiro(
  const Valor: Real): String;
begin
   result := FormatFloat('R$ ,0.00; -,0.00;', Valor);
end;

class function TStringUtilitario.LetraPorSequencia(
  NumeroSequencia: Integer): String;
const
  ALFABETO = 'ABCDEFGHIJLMNOPQRSTUVXZ';
begin
   result := ALFABETO[NumeroSequencia];
end;

class function TStringUtilitario.MascaraCpfCnpj(const CpfCnpj :String): String;
begin
  result := '';

  result := IfThen(length(CpfCnpj) > 11,
                                        copy(CpfCnpj,1,2) +'.'+ copy(CpfCnpj,3,3) +'.'+ copy(CpfCnpj,6,3) +'/'+ copy(CpfCnpj,9,4) +'-'+ copy(CpfCnpj,13,2),
                                        copy(CpfCnpj,1,3) +'.'+ copy(CpfCnpj,4,3) +'.'+ copy(CpfCnpj,7,3) +'-'+ copy(CpfCnpj,10,2)
                                       );
end;

class function TStringUtilitario.RemoveCaracter(const Texto,
  Caracter: String): String;
begin
   result := StringReplace(Texto, Caracter, '', [rfReplaceAll]);
end;

class function TStringUtilitario.remove_quebras(texto: String): String;
begin
  result := StringReplace(texto, #13#10, ' ', [rfReplaceAll, rfIgnoreCase]);
end;

class function TStringUtilitario.salvarTexto(texto, caminho: String): Boolean;
var Arquivo: TStringList;
begin
  try
    Arquivo      := TStringList.Create;
    Arquivo.Text := texto;
    Arquivo.SaveToFile(caminho);
  finally
    FreeAndNil(Arquivo);
  end;
end;

class function TStringUtilitario.StringVazia: String;
begin
   result := '';
end;

end.
