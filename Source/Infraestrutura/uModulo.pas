unit uModulo;

interface

uses
  SysUtils,
  Classes,
  ArquivoConfiguracao,
  LogErros,
  DB,
  Windows,
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Parametros,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Phys.FB, FireDAC.Phys.FBDef, Empresa, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef;

type
  Tdm = class(TDataModule)
    FDConnection: TFDConnection;
    qryGenerica: TFDQuery;
    qryGenerica2: TFDQuery;
    FDTransaction1: TFDTransaction;
    FDConnectionServidor: TFDConnection;

  // Eventos
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure FDConnectionError(ASender, AInitiator: TObject; var AException: Exception);

  private
    FArquivoConfiguracao      :TArquivoConfiguracao;
    FLogErros                 :TLogErros;
    FNomeDoExecutavel         :String;
    FConexaoBancoDeDados      :TFDConnection;
    FParametros               :TParametros;
    FVersao_BD                :Integer;
    FVersao_sistema           :Integer;
    FEmpresa                  :TEmpresa;

    function GetParametros    :TParametros;
    function GetConexao       :TFDConnection;
    function GetLogo: String;
    function GetEmpresa: TEmpresa;

  private
    function GetDiretorioSistema        :String;
    function GetIsConectadoBancoDeDados :Boolean;
    function GetNomeDoTerminal          :String;
    function GetVersaoBD                :integer;

  private
    procedure SetArquivoConfiguracao(const Value: TArquivoConfiguracao);
    procedure SetLogErros           (const Value: TLogErros);
    procedure SetParametros         (const Value: TParametros);

    procedure PreencheDadosConexaoBancoDeDados(Sender: TObject);
    procedure verificaVersaoSistema;

  public
    constructor Create(AOwner :TComponent); override;

  public
    cancelaInicializacao :Boolean;

  // Propriedades
  public
     property LogErros              :TLogErros            read FLogErros            write SetLogErros;
     property ArquivoConfiguracao   :TArquivoConfiguracao read FArquivoConfiguracao write SetArquivoConfiguracao;
     property Parametros            :TParametros          read GetParametros        write SetParametros;

     // Apenas leitura
     property DiretorioSistema          :String       read GetDiretorioSistema;
     property NomeDoTerminal            :String       read GetNomeDoTerminal;
     property IsConectadoBancoDeDados   :Boolean      read GetIsConectadoBancoDeDados;
     property conexao                   :TFDConnection read GetConexao;
     property Logo                      :String       read GetLogo;
     property versao_bd                 :integer      read GetVersaoBD;
     property Empresa                   :TEmpresa     read GetEmpresa   write FEmpresa;

  public
     procedure AbreConexaoBancoDeDados;
     procedure FechaConexaoBancoDeDados;

     function GetConsulta                            :TFDQuery; overload;
     function GetConsulta(const SQL         :String) :TFDQuery; overload;
     function GetValorGenerator(const NomeDoGenerator :String; const op :integer = 0) :Integer;
end;



var
  dm: Tdm;

implementation

uses
  FabricaRepositorio,
  Forms, Funcoes,
  ExcecaoBancoDeDadosInvalido,
  uScript,
  Repositorio,
  ZDbcIntfs, uPadrao, EspecificacaoEmpresaPorTag;

{$R *.dfm}

{ Tdm }

procedure Tdm.SetArquivoConfiguracao(const Value: TArquivoConfiguracao);
begin
  FArquivoConfiguracao := Value;
end;

procedure Tdm.SetLogErros(const Value: TLogErros);
begin
  FLogErros := Value;
end;

procedure Tdm.DataModuleCreate(Sender: TObject);
var
  Aplicacao :TApplication;
begin
  Aplicacao                            := (self.Owner as TApplication);
  self.FNomeDoExecutavel               := ExtractFilePath(Aplicacao.ExeName);
  self.FLogErros                       := TLogErros.Create(self.DiretorioSistema);
  self.FArquivoConfiguracao            := TArquivoConfiguracao.Create(self.DiretorioSistema);
  self.AbreConexaoBancoDeDados;

  FParametros                          := nil;

  self.verificaVersaoSistema;

  qryGenerica.Connection := self.FConexaoBancoDeDados;
end;

function Tdm.GetDiretorioSistema: String;
begin
   result := ExtractFilePath(self.FNomeDoExecutavel); 
end;

function Tdm.GetEmpresa: TEmpresa;
var repositorio :TRepositorio;
    especificacao :TEspecificacaoEmpresaPorTag;
begin
  if not assigned(FEmpresa) then
  begin
    especificacao := nil;
    repositorio   := nil;

    try
      especificacao := TEspecificacaoEmpresaPorTag.Create;
      repositorio   := TFabricaRepositorio.GetRepositorio(TEmpresa.ClassName);
      FEmpresa      := TEmpresa(repositorio.GetPorEspecificacao(especificacao));
    finally
      FreeAndNil(repositorio);
      FreeAndNil(especificacao);
    end;
  end;

  result := FEmpresa;
end;

procedure Tdm.DataModuleDestroy(Sender: TObject);
begin
   FreeAndNil(self.FArquivoConfiguracao);
   FreeAndNil(self.FLogErros);
   FreeAndNil(self.FConexaoBancoDeDados);
   FreeAndNil(self.FParametros);
end;

procedure Tdm.PreencheDadosConexaoBancoDeDados(Sender: TObject);
begin
    self.FConexaoBancoDeDados.Connected := False;

    self.FConexaoBancoDeDados.Params.Clear;
    self.FConexaoBancoDeDados.Params.Add('server='+ self.FArquivoConfiguracao.NomeServidorBancoDeDados);
    self.FConexaoBancoDeDados.Params.Add('user_name='+ self.FArquivoConfiguracao.UsuarioBancoDeDados);
    self.FConexaoBancoDeDados.Params.Add('password='+ self.FArquivoConfiguracao.SenhaBancoDeDados);
    self.FConexaoBancoDeDados.Params.Add('port='+ IntToStr(self.FArquivoConfiguracao.PortaBancoDeDados));
    self.FConexaoBancoDeDados.Params.Add('Database='+ self.FArquivoConfiguracao.CaminhoBancoDeDados);
    self.FConexaoBancoDeDados.Params.Add('Protocol='+ self.FArquivoConfiguracao.ProtocoloBancoDeDados);
    self.FConexaoBancoDeDados.Params.Add('DriverID='+ 'FB');

    self.FDConnection.Connected         := False;

    self.FDConnection.Params.Clear;
    self.FDConnection.Params.Add('server='+ self.FArquivoConfiguracao.NomeServidorBancoDeDados);
    self.FDConnection.Params.Add('user_name='+ self.FArquivoConfiguracao.UsuarioBancoDeDados);
    self.FDConnection.Params.Add('password='+ self.FArquivoConfiguracao.SenhaBancoDeDados);
    self.FDConnection.Params.Add('port='+ IntToStr(self.FArquivoConfiguracao.PortaBancoDeDados));
    self.FDConnection.Params.Add('Database='+ self.FArquivoConfiguracao.CaminhoBancoDeDados);
    self.FDConnection.Params.Add('Protocol='+ self.FArquivoConfiguracao.ProtocoloBancoDeDados);
    self.FDConnection.Params.Add('DriverID='+ 'FB');
end;

constructor Tdm.Create(AOwner: TComponent);
begin
  inherited;

  self.FConexaoBancoDeDados               := TFDConnection.Create(nil);
  self.FConexaoBancoDeDados.BeforeConnect := self.PreencheDadosConexaoBancoDeDados;
end;

procedure Tdm.AbreConexaoBancoDeDados;
begin
   try


       self.FConexaoBancoDeDados.TxOptions.Isolation := xiReadCommitted;

       self.FConexaoBancoDeDados.TxOptions.AutoCommit   := true;
       try
       self.FConexaoBancoDeDados.Connected              := true;

       except

       end;
       FDConnection.Connected  := true;


   except
     on E: TExcecaoBancoDeDadosInvalido do
        self.FLogErros.AdicionaErro('uModulo', 'TExcecaoBancoDeDadosInvalido', E.Message);
   end;
end;

function Tdm.GetIsConectadoBancoDeDados: Boolean;
begin
   result := self.FConexaoBancoDeDados.Connected;
end;

procedure Tdm.FDConnectionError(ASender, AInitiator: TObject; var AException: Exception);
var x :integer;
begin
  abort;
end;

procedure Tdm.FechaConexaoBancoDeDados;
begin
   self.FConexaoBancoDeDados.Connected := false;
   self.FDConnection.Connected         := false;
end;

function Tdm.GetConsulta: TFDQuery;
begin
   result               := TFDQuery.Create(nil);
   result.Connection    := self.FConexaoBancoDeDados;
   result.CachedUpdates := true;
   result.SQL.Clear;
end;

function Tdm.GetConsulta(const SQL: String): TFDQuery;
begin
   result := self.GetConsulta;
   result.SQL.Add(SQL);
end;

function Tdm.GetValorGenerator(const NomeDoGenerator: String; const op :integer): Integer;
begin
   try
     qryGenerica.sql.Text := 'select gen_id(' + NomeDoGenerator + ', '+intToStr(op)+' ) from rdb$database';
     qryGenerica.Open;

     result := qryGenerica.Fields[0].AsInteger;
   finally
     qryGenerica.Close;
   end;
end;

function Tdm.GetVersaoBD: integer;
var repositorio :TRepositorio;
    Versao      :TParametros;
begin
  Result := 0;

  if not self.FVersao_BD <= 0 then begin
    repositorio  := TFabricaRepositorio.GetRepositorio(TParametros.ClassName);
    Versao       := TParametros( repositorio.Get(1) );

    if assigned( Versao ) then
      self.FVersao_BD := Versao.versao_banco_de_dados;
  end;

  Result := self.FVersao_BD;
end;

function Tdm.GetNomeDoTerminal: String;
var
  Buffer       :Array [0 .. 255] of Char;
  Size         :DWORD;
  ComputerName :String;
begin
  Size := MAX_COMPUTERNAME_LENGTH + 1;
  GetComputerName(Buffer, Size);
  ComputerName := Buffer;
  Result := ComputerName;
end;

procedure Tdm.SetParametros(const Value: TParametros);
begin
  FParametros := Value;
end;

procedure Tdm.verificaVersaoSistema;
begin
  frmScript := TfrmScript.Create(nil);
  frmPadrao := TfrmPadrao.Create(nil);

  self.FVersao_Sistema := UltimaVersaoSistema;

  try
  if getVersaoBD = 0 then   frmScript.ExecutaAtualizacoesBanco;

  if UltimaVersaoSistema > self.getVersaoBD then
    begin

    if frmPadrao.confirma( '>>> Atenção <<<' + #13#10 +
                           'As atualizações que serão realizadas a seguir são irreverssíveis!' + #13#10 +
                           'Você ja fez um backup do sistema antes de atualizar?') then
      begin

          if not frmScript.ExecutaAtualizacoesBanco then
            begin
              frmPadrao.avisar(1,'Não foi possível atualizar o banco de dados!',2);
              cancelaInicializacao := true;
              exit;
            end;

        end
      else
        begin
          cancelaInicializacao := true;
          exit;
        end;
    end;

  if UltimaVersaoSistema < self.FVersao_BD then
    begin
      frmPadrao.Avisar(1,'O seu sistema encontra-se desatualizado!' + #13 + 'Favor atualizar antes de continuar!');
      cancelaInicializacao := true;
    end;

  finally
    frmPadrao.Release;
    frmPadrao := nil;
    frmScript.Release;
    frmScript := nil;
  end;
end;

function Tdm.GetParametros: TParametros;
var
  Repositorio :TRepositorio;
begin
   if not Assigned(self.FParametros) then begin
      Repositorio := TFabricaRepositorio.GetRepositorio(TParametros.ClassName);

      try
        self.FParametros := TParametros(Repositorio.Get(1));
      finally
        FreeAndNil(Repositorio);
      end;
   end;

   if not Assigned(self.FParametros) then
    raise Exception.Create('ATENÇÃO!'+#13+'Não foi possível encontrar o registro de parâmetros no banco de dados. Informe o suporte!');

   result := self.FParametros;
end;

function Tdm.GetConexao: TFDConnection;
begin
  Result := FConexaoBancoDeDados;
end;

function Tdm.GetLogo: String;
begin
   result := self.DiretorioSistema + 'logo.png';
end;

end.
