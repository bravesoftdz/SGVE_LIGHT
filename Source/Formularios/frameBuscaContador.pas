unit frameBuscaContador;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Contador, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, RxToolEdit, RxCurrEdit;

type
  TBuscaContador = class(TFrame)
    StaticText2: TStaticText;
    StaticText1: TStaticText;
    edtCodigo: TCurrencyEdit;
    btnBusca: TBitBtn;
    edtNome: TEdit;
    edtEmail: TEdit;
    StaticText3: TStaticText;
    procedure edtCodigoChange(Sender: TObject);
    procedure edtCodigoEnter(Sender: TObject);
    procedure edtCodigoExit(Sender: TObject);
    procedure btnBuscaClick(Sender: TObject);
    procedure edtNomeEnter(Sender: TObject);
    procedure edtNomeExit(Sender: TObject);
  protected
    FCriou            :Boolean;
    FBuscando         :Boolean;
    FContador         :TContador;
    Fcodigo           :integer;

  private
    procedure SetCodigo         (const Value: integer);

  protected
    procedure Buscar     (const codigoPessoa :Integer); virtual;
    procedure SetContador(const Value      :TContador);

  public
    constructor Create(AOwner :TComponent); override;
    destructor  Destroy;                    override;

  public
    procedure Limpa;

  public
    property Contador  :TContador    read FContador         write SetContador;
    property codigo    :integer      read Fcodigo           write SetCodigo;
  end;

implementation

uses uPesquisaSimples, Repositorio, FabricaRepositorio, uCadastroContador;

{$R *.dfm}

{ TFrame1 }

procedure TBuscaContador.btnBuscaClick(Sender: TObject);
begin
    self.Buscar(0);
    keybd_event(VK_TAB, 0, 0, 0);
end;

procedure TBuscaContador.Buscar(const codigoPessoa: Integer);
var
  Repositorio :TRepositorio;
  Contador    :TContador;
begin
   Repositorio := nil;

   try
     Repositorio     := TFabricaRepositorio.GetRepositorio(TContador.ClassName);
     Contador        := TContador(Repositorio.Get(codigoPessoa));

     if not Assigned(Contador) then begin
       frmCadastroContador := nil;

       try
         frmCadastroContador := TfrmCadastroContador.CreateModoBusca(nil);
         frmCadastroContador.ShowModal;

         if (frmCadastroContador.ModalResult = mrOK) then begin
            Contador  := TContador(Repositorio.Get(frmCadastroContador.cdsCODIGO.AsInteger));

            if Assigned(Contador) then begin
              self.Contador := Contador;
              //self.Criou  := true;
              keybd_event(VK_TAB, 0, 0, 0);
            end;
         end
         else begin
           if edtNome.Text = '' then
             self.Limpa;
           edtCodigo.SetFocus;
         end;

       finally
         frmCadastroContador.Release;
         frmCadastroContador := nil;
       end;
     end
     else begin
       self.Contador := Contador;
       self.FCriou   := true;
     end;

   finally
     FreeAndNil(Repositorio);
   end;
end;

constructor TBuscaContador.Create(AOwner: TComponent);
begin
  inherited;
  self.FContador  := nil;
  self.FCriou     := false;
end;

destructor TBuscaContador.Destroy;
begin
  if self.FCriou and Assigned(self.FContador) then
    FreeAndNil(self.FContador);
  inherited;
end;

procedure TBuscaContador.edtCodigoChange(Sender: TObject);
begin
  Limpa;
end;

procedure TBuscaContador.edtCodigoEnter(Sender: TObject);
begin
  self.FBuscando := true;
end;

procedure TBuscaContador.edtCodigoExit(Sender: TObject);
begin
  self.FBuscando := false;
end;

procedure TBuscaContador.edtNomeEnter(Sender: TObject);
begin
  keybd_event(VK_TAB, 0,  0, 0);
end;

procedure TBuscaContador.edtNomeExit(Sender: TObject);
begin
   self.Buscar( edtCodigo.AsInteger );
end;

procedure TBuscaContador.Limpa;
begin
   if Self.FCriou and Assigned(self.FContador) then
      FreeAndNil(self.FContador);

   if not FBuscando then
   begin
     edtCodigo.OnChange := nil;
     self.edtCodigo.Clear;
     edtCodigo.OnChange := edtCodigoChange;
   end;

   self.edtNome.Clear;
end;

procedure TBuscaContador.SetCodigo(const Value: integer);
begin
  if value > 0 then
    self.Buscar( Value )
  else
    self.Limpa;
end;

procedure TBuscaContador.SetContador(const Value: TContador);
begin
   try
     if (Value = self.FContador) then
      exit;
   except
     on E: EAccessViolation do
   end;


   if self.FCriou and Assigned(self.FContador) then begin
      FreeAndNil(self.FContador);
      self.FCriou := false;
   end;

   FContador := Value;

  if Assigned(self.FContador) then begin
    self.edtCodigo.OnChange    := nil;
    self.edtCodigo.AsInteger   := self.FContador.codigo;
    self.edtNome.Text          := self.FContador.razao;
    self.edtEmail.Text         := self.FContador.email;
    self.edtCodigo.OnChange    := edtCodigoChange;
  end;
end;

end.
