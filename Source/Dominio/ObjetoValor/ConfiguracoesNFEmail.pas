unit ConfiguracoesNFEmail;

interface

uses
  Classes{,
  MetodoDelegadoObtemCampoInteger};

type
  TConfiguracoesNFEmail = class

  private
    FCodigoEmpresa         :Integer;
 //   FBuscadorCodigoEmpresa :TMetodoDelegadoObtemCampoInteger;
    FSMTPHost                   :String;
    FSMTPPort                   :String;
    FSMTPUser                   :String;
    FSMTPPassword               :String;
    FAssunto                    :String;
    FMensagem                   :String;
    FMensagemList               :TStrings;
    FUsaSSL                     :Boolean;

  private
    function GetCodigoEmpresa         :Integer;
    function GetAssunto               :String;
    function GetMensagem              :TStrings;
    function GetSMTPHost              :String;
    function GetSMTPPassword          :String;
    function GetSMTPPort              :String;
    function GetSMTPUser              :String;
    function GetUsaSSL                :Boolean;

  public
    constructor Create({BuscadorCodigoEmpresa :TMetodoDelegadoObtemCampoInteger;}
                       SMTPHost,
                       SMTPPort,
                       SMTPUser,
                       SMTPPassword,
                       Assunto,
                       Mensagem :String;
                       UsaSSL :Boolean);

    constructor CriaParaRepositorio(CodigoEmpresa :Integer;
                                    SMTPHost,
                                    SMTPPort,
                                    SMTPUser,
                                    SMTPPassword,
                                    Assunto,
                                    Mensagem :String;
                                    UsaSSL :Boolean);


    destructor Destroy; override;

  public
    property CodigoEmpresa :Integer           read GetCodigoEmpresa;
    property SMTPHost              :String    read GetSMTPHost;
    property SMTPPort              :String    read GetSMTPPort;
    property SMTPUser              :String    read GetSMTPUser;
    property SMTPPassword          :String    read GetSMTPPassword;
    property Assunto               :String    read GetAssunto;
    property Mensagem              :TStrings  read GetMensagem;
    property UsaSSL                :Boolean   read GetUsaSSL;

end;

implementation

uses
  SysUtils, IniFiles;

{ TConfiguracoesNFEmail }

constructor TConfiguracoesNFEmail.Create({BuscadorCodigoEmpresa :TMetodoDelegadoObtemCampoInteger;}
  SMTPHost, SMTPPort, SMTPUser, SMTPPassword, Assunto, Mensagem: String;
  UsaSSL: Boolean);
begin
  // self.FBuscadorCodigoEmpresa := BuscadorCodigoEmpresa;
   self.FSMTPHost                   := SMTPHost;
   self.FSMTPPort                   := SMTPPort;
   self.FSMTPUser                   := SMTPUser;
   self.FSMTPPassword               := SMTPPassword;
   self.FAssunto                    := Assunto;
   self.FMensagem                   := Mensagem;
   self.FUsaSSL                     := UsaSSL;
   self.FMensagemList               := nil;
end;

constructor TConfiguracoesNFEmail.CriaParaRepositorio(CodigoEmpresa :Integer; SMTPHost, SMTPPort, SMTPUser,
  SMTPPassword, Assunto, Mensagem: String; UsaSSL: Boolean);
begin
   self.FCodigoEmpresa              := CodigoEmpresa;
   self.FSMTPHost                   := SMTPHost;
   self.FSMTPPort                   := SMTPPort;
   self.FSMTPUser                   := SMTPUser;
   self.FSMTPPassword               := SMTPPassword;
   self.FAssunto                    := Assunto;
   self.FMensagem                   := Mensagem;
   self.FUsaSSL                     := UsaSSL;
   self.FMensagemList               := nil;
end;

destructor TConfiguracoesNFEmail.Destroy;
begin
  FreeAndNil(self.FMensagemList);
  
  inherited;
end;

function TConfiguracoesNFEmail.GetAssunto: String;
begin
   result := Trim(self.FAssunto);
end;

function TConfiguracoesNFEmail.GetCodigoEmpresa: Integer;
begin
   result := self.FCodigoEmpresa;

   if (result <= 0) then
 //   result := self.FBuscadorCodigoEmpresa;
end;

function TConfiguracoesNFEmail.GetMensagem: TStrings;
begin
   if not Assigned(self.FMensagemList) then begin
      self.FMensagemList := TStringList.Create;
      self.FMensagemList.Add(self.FMensagem);
   end;

   result := self.FMensagemList;
end;

function TConfiguracoesNFEmail.GetSMTPHost: String;
begin
   result := Trim(self.FSMTPHost);
end;

function TConfiguracoesNFEmail.GetSMTPPassword: String;
begin
   result := Trim(self.FSMTPPassword);
end;

function TConfiguracoesNFEmail.GetSMTPPort: String;
begin
   result := Trim(self.FSMTPPort);
end;

function TConfiguracoesNFEmail.GetSMTPUser: String;
begin
   result := LowerCase(Trim(self.FSMTPUser));
end;

function TConfiguracoesNFEmail.GetUsaSSL: Boolean;
begin
   result := self.FUsaSSL;
end;

end.
