unit Empresa;

interface

uses
  Pessoa,
  ConfiguracoesNF,
  ConfiguracoesNFEmail;

type
  TEmpresa = class(TPessoa)

  private
    FCodigoEmpresa      :Integer;
    FConfiguracoesNF    :TConfiguracoesNF;
    FConfiguracoesEmail :TConfiguracoesNFEmail;

  private
    procedure SetCodigoEmpresa          (const Value: Integer);

  private
    function GetCodigoEmpresa           :Integer;
    function GetConfiguracoesEmail      :TConfiguracoesNFEmail;
    function GetConfiguracoesNF         :TConfiguracoesNF;

  public
    constructor Create;
    destructor  Destroy; override;

  public
    property CodigoEmpresa            :Integer               read GetCodigoEmpresa            write SetCodigoEmpresa;
    property ConfiguracoesNF          :TConfiguracoesNF      read GetConfiguracoesNF          write FConfiguracoesNF;
    property ConfiguracoesEmail       :TConfiguracoesNFEmail read GetConfiguracoesEmail;

  public
    procedure AdicionarConfiguracoesNFe(
                                     AliquotaCreditoSN :Real;
                                     AliquotaICMS      :Real;
                                     AliquotaPIS       :Real;
                                     AliquotaCOFINS    :Real;
                                     NumeroCertificado :String;
                                     AmbienteNFe       :String;
                                     SenhaCertificado  :String;
                                     TipoEmissao       :integer;
                                     CRT               :integer;
                                     obsGeradaSistema  :string
                                    );

                                    
    procedure AdicionarConfiguracoesEmail(SMTPHost,
                                          SMTPPort,
                                          SMTPUser,
                                          SMTPPassword,
                                          Assunto,
                                          Mensagem :String);

end;

implementation

uses
  SysUtils,
  Repositorio,
  FabricaRepositorio,
  Funcoes,
  ExcecaoParametroInvalido;

{ TEmpresa }

procedure TEmpresa.AdicionarConfiguracoesNFe(AliquotaCreditoSN, AliquotaICMS,
  AliquotaPIS, AliquotaCOFINS: Real; NumeroCertificado, AmbienteNFe,
  SenhaCertificado: String; TipoEmissao, CRT :integer; obsGeradaSistema :string);
begin
   if stringVazia(AmbienteNFe) then
    raise TExcecaoParametroInvalido.Create(self.ClassName, 'AdicionarConfiguracoes(AliquotaCreditoSN, AliquotaICMS, AliquotaPIS, '+
                                                           ' AliquotaCOFINS: Real; NumeroCertificado, AmbienteNFe, '+
                                                           '  SenhaCertificado: String)', 'AmbienteNFe' );

   self.FConfiguracoesNF                      := TConfiguracoesNF.Create;
   self.FConfiguracoesNF.codigo_empresa       := self.CodigoEmpresa;
   self.FConfiguracoesNF.aliq_cred_sn         := AliquotaCreditoSN;
   self.FConfiguracoesNF.aliq_icms            := AliquotaICMS;
   self.FConfiguracoesNF.aliq_pis             := AliquotaPIS;
   self.FConfiguracoesNF.aliq_cofins          := AliquotaCOFINS;
   self.FConfiguracoesNF.num_certificado      := NumeroCertificado;
   self.FConfiguracoesNF.senha_certificado    := SenhaCertificado;
   self.FConfiguracoesNF.ambiente_nfe         := AmbienteNFe;
   self.FConfiguracoesNF.CRT                  := CRT;
   self.FConfiguracoesNF.ObsGeradaPeloSistema := obsGeradaSistema;

   {7 = SVCRS}
   if (tipoEmissao = 7) then
     self.FConfiguracoesNF.Dt_contingencia := now;

   self.FConfiguracoesNF.Tipo_emissao        := TipoEmissao;
end;

procedure TEmpresa.AdicionarConfiguracoesEmail(SMTPHost, SMTPPort,
  SMTPUser, SMTPPassword, Assunto, Mensagem: String);
const
  NOME_METODO = ' AdicionarConfiguracoesEmail(SMTPHost, SMTPPort, SMTPUser, SMTPPassword, Assunto, Mensagem: String; UsaSSL: Boolean) ';
begin
   if stringVazia(SMTPHost) and stringVazia(SMTPPort) and stringVazia(SMTPUser) and stringVazia(SMTPPassword) and
      stringVazia(Assunto)  and stringVazia(Mensagem) then
   begin
     exit;
   end;

   self.FConfiguracoesEmail := TConfiguracoesNFEmail.Create(self.CodigoEmpresa,
                                                            SMTPHost,
                                                            SMTPPort,
                                                            SMTPUser,
                                                            SMTPPassword,
                                                            Assunto,
                                                            Mensagem);
end;

constructor TEmpresa.Create;
begin
   inherited Pessoa       := 'J';
   inherited Tipo         := 'E';
   inherited DtCadastro   := Date;

   self.FConfiguracoesNF    := nil;
   self.FConfiguracoesEmail := nil;
end;

destructor TEmpresa.Destroy;
begin
   if assigned(self.FConfiguracoesNF) then
     FreeAndNil(self.FConfiguracoesNF);

   if assigned(self.FConfiguracoesEmail) then
     FreeAndNil(self.FConfiguracoesEmail);

  inherited;
end;

function TEmpresa.GetCodigoEmpresa: Integer;
begin
   if FCodigoEmpresa <= 0 then
     FCodigoEmpresa := inherited codigo;
   result := FCodigoEmpresa;
end;

function TEmpresa.GetConfiguracoesEmail: TConfiguracoesNFEmail;
var
  Repositorio :TRepositorio;
begin
   if not Assigned(self.FConfiguracoesEmail) then begin
     Repositorio := nil;
     try
       Repositorio              := TFabricaRepositorio.GetRepositorio(TConfiguracoesNFEmail.ClassName);
       self.FConfiguracoesEmail := (Repositorio.Get(self.FCodigoEmpresa) as TConfiguracoesNFEmail);
     finally
       FreeAndNil(Repositorio);
     end;
   end;

   result := self.FConfiguracoesEmail;
end;

function TEmpresa.GetConfiguracoesNF: TConfiguracoesNF;
var
  Repositorio :TRepositorio;
begin
   if not Assigned(self.FConfiguracoesNF) then begin
     Repositorio := nil;
     try
       Repositorio              := TFabricaRepositorio.GetRepositorio(TConfiguracoesNF.ClassName);
       self.FConfiguracoesNF := (Repositorio.Get(self.FCodigoEmpresa) as TConfiguracoesNF);
     finally
       FreeAndNil(Repositorio);
     end;
   end;

   result := self.FConfiguracoesNF;
end;

procedure TEmpresa.SetCodigoEmpresa(const Value: Integer);
begin
  FCodigoEmpresa := Value;
end;

end.
