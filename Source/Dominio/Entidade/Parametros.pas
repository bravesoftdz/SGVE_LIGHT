unit Parametros;

interface

uses TipoStatusUso;

type
  TParametros = class

  private
    FVersaoBancoDeDados :Integer;
    FCodigo             :Integer;
    FStatus_uso: TTipoStatusUso;
    FUltima_conexao: TDate;
    FData_final: TDate;
    FMensagem: String;
    FData_senha: String;

  private
    procedure SetCodigo             (const Value: Integer);
    procedure SetVersaoBancoDeDados (const Value: Integer);

  public
    procedure SetUsoInteger(value :integer);
    function  GetUsoInteger :integer;

    property Codigo                 :Integer        read FCodigo              write SetCodigo;
    property versao_banco_de_dados  :Integer        read FVersaoBancoDeDados  write SetVersaoBancoDeDados;
    property status_uso             :TTipoStatusUso read FStatus_uso          write FStatus_uso;
    property data_final             :TDate          read FData_final          write FData_final;
    property mensagem               :String         read FMensagem            write FMensagem;
    property ultima_conexao         :TDate          read FUltima_conexao      write FUltima_conexao;
    property data_senha             :String         read FData_senha          write FData_senha;
end;

implementation

{ TParametros }

function TParametros.GetUsoInteger: integer;
begin
  result := TTipoStatusUsoUtilitario.DeEnumeradoParaInteger(self.FStatus_uso);
end;

procedure TParametros.SetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TParametros.SetUsoInteger(value: integer);
begin
  FStatus_uso := TTipoStatusUsoUtilitario.DeIntegerParaEnumerado(value);
end;

procedure TParametros.SetVersaoBancoDeDados(const Value: Integer);
begin
  FVersaoBancoDeDados := Value;
end;

end.
