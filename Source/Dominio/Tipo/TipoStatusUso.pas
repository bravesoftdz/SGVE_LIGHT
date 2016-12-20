unit TipoStatusUso;

interface

type TTipoStatusUso = (tsuLiberado=1, tsuLimitado=2, tsuBloqueado=3);

type
  TTipoStatusUsoUtilitario = class

  public
    class function DeEnumeradoParaInteger(Tipo :TTipoStatusUso) :Integer;
    class function DeIntegerParaEnumerado(Tipo :Integer)        :TTipoStatusUso;
end;

implementation

uses
  ExcecaoParametroInvalido;

{ TTipoRegimeTributarioUtilitario }

class function TTipoStatusUsoUtilitario.DeEnumeradoParaInteger(Tipo: TTipoStatusUso): Integer;
begin
   case Tipo of
    tsuLiberado  : result := 1;
    tsuLimitado  : result := 2;
    tsuBloqueado : result := 3

   else
     raise TExcecaoParametroInvalido.Create(self.ClassName,
                                            'DeEnumeradoParaInteger(Tipo: TTipoStatusUso): Integer;',
                                            'Tipo');
   end;
end;

class function TTipoStatusUsoUtilitario.DeIntegerParaEnumerado(Tipo: Integer): TTipoStatusUso;
begin
   case Tipo of
    1: result := tsuLiberado;
    2: result := tsuLimitado;
    3: result := tsuBloqueado;

   else
     raise TExcecaoParametroInvalido.Create(self.ClassName,
                                            'DeIntegerParaEnumerado(Tipo: Integer): Integer;',
                                            'Tipo');
   end;
end;

end.
