unit FormaPagamentoParcelas;

interface

uses
  SysUtils,
  Contnrs;

type
  TFormaPagamentoParcelas = class

  private
    FCodigo        :Integer;
    FCodFormasPgto :Integer;
    FParcela       :Integer;
    FDiasParcela   :Integer;

    procedure SetCodigo       (const value :Integer);
    procedure SetCodFormasPgto(const value :Integer);
    procedure SetParcela      (const value :Integer);
    procedure SetDiasParcela  (const value :Integer);

  public

    property Codigo        :Integer   read FCodigo       write SetCodigo;
    property CodFormasPgto :Integer   read FCodFormasPgto write SetCodFormasPgto;
    property Parcela       :Integer   read FParcela       write SetParcela;
    property DiasParcela   :Integer   read FDiasParcela   write SetDiasParcela;
  end;

implementation

uses Repositorio, FabricaRepositorio;

{ TFormaPagamentoParcelas }

procedure TFormaPagamentoParcelas.SetCodFormasPgto(const value: Integer);
begin
  FCodFormasPgto := value;
end;

procedure TFormaPagamentoParcelas.SetCodigo(const value: Integer);
begin
  FCodigo := value;
end;

procedure TFormaPagamentoParcelas.SetDiasParcela(const value: Integer);
begin
  FDiasParcela := value;
end;

procedure TFormaPagamentoParcelas.SetParcela(const value: Integer);
begin
  FParcela := value;
end;

end.
