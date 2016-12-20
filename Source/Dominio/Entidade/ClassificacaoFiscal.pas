unit ClassificacaoFiscal;

interface

uses SysUtils, Contnrs;

type
  TClassificacaoFiscal = class

  private
    Fund_medida :String;
    Fncm :Integer;
    Fcodigo :Integer;
    Fdescricao :String;

  public
    property und_medida            :String read Fund_medida            write Fund_medida;
    property ncm                   :Integer read Fncm                   write Fncm;
    property codigo                :Integer read Fcodigo                write Fcodigo;
    property descricao             :String read Fdescricao             write Fdescricao;
end;

implementation

{ TClassificacaoFiscal }

end.
