unit frameBuscaNotaFiscal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, NotaFiscal,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, RxToolEdit, RxCurrEdit;

type
  TBuscaNotaFiscal = class(TFrame)
    StaticText1: TStaticText;
    edtNrNota: TCurrencyEdit;
    btnBusca: TBitBtn;
    StaticText2: TStaticText;
    edtID: TEdit;
    procedure edtNrNotaChange(Sender: TObject);
    procedure edtNrNotaEnter(Sender: TObject);
    procedure edtNrNotaExit(Sender: TObject);
    procedure btnBuscaClick(Sender: TObject);
    procedure edtIDEnter(Sender: TObject);
    procedure edtIDExit(Sender: TObject);
  private
    FCriou            :Boolean;
    FBuscando         :Boolean;
    FNotaFiscal       :TNotaFiscal;
    Fcodigo           :integer;

  private
    procedure SetCodigo         (const Value: integer);

  private
    procedure Buscar       (const CodigoNF  :Integer);
    procedure SetNotaFiscal(const Value     :TNotaFiscal);

    function buscaPorEspecificacao(NrNota: Integer) :Integer;

  public
    constructor Create(AOwner :TComponent); override;
    destructor  Destroy;                    override;

  public
    procedure Limpa;

  public
    property NotaFiscal   :TNotaFiscal  read FNotaFiscal  write SetNotaFiscal;
    property codigo       :integer      read Fcodigo      write SetCodigo;
  end;

implementation

uses Repositorio, FabricaRepositorio, EspecificacaoNFePorNrNota;

{$R *.dfm}

{ TBuscaNotaFiscal }

procedure TBuscaNotaFiscal.btnBuscaClick(Sender: TObject);
begin
    self.Buscar(StrToIntDef(self.edtNrNota.Text, 0));
end;

function TBuscaNotaFiscal.buscaPorEspecificacao(NrNota: Integer): Integer;
var especificao :TEspecificacaoNFePorNrNota;
    repositorio :TRepositorio;
begin
  try
  result := 0;
  repositorio := TFabricaRepositorio.GetRepositorio(TNotaFiscal.ClassName);
  especificao := TEspecificacaoNFePorNrNota.Create(NrNota);

  try
    result      := TNotaFiscal(repositorio.GetPorEspecificacao(especificao)).CodigoNotaFiscal;
  Except
  end;
  finally
    FreeAndNil(repositorio);
    FreeAndNil(especificao);
  end;
end;

procedure TBuscaNotaFiscal.Buscar(const CodigoNF: Integer);
var
  Repositorio :TRepositorio;
  NotaFiscal  :TNotaFiscal;
begin
   Repositorio := nil;

   try
     Repositorio     := TFabricaRepositorio.GetRepositorio(TNotaFiscal.ClassName);
     NotaFiscal      := TNotaFiscal(Repositorio.Get(CodigoNF));

   {  if not Assigned(NotaFiscal) then begin
       frmCadastroCidade := nil;

       try
         frmCadastroCidade := TfrmCadastroCidade.CreateModoBusca(nil);
         frmCadastroCidade.ShowModal;

         if (frmCadastroCidade.ModalResult = mrOK) then begin
            Cidade          := TCidade(Repositorio.Get(frmCadastroCidade.cdsCODIGO.AsInteger));

            if Assigned(Cidade) then begin
              self.Cidade  := Cidade;
              self.FCriou  := true;
              keybd_event(VK_TAB, 0, 0, 0);
            end;
         end
         else begin
           if edtCidade.Text = '' then
             self.Limpa;
           edtCodCid.SetFocus;
         end;
       finally
         frmCadastroCidade.Release;
         frmCadastroCidade := nil;
       end;
     end
     else begin
       self.Cidade  := Cidade;
       self.FCriou  := true;
     end;                        }

   finally
     FreeAndNil(Repositorio);
   end;
end;

constructor TBuscaNotaFiscal.Create(AOwner: TComponent);
begin
  inherited;
  self.FNotaFiscal := nil;
  self.FCriou      := false;
end;

destructor TBuscaNotaFiscal.Destroy;
begin
  if self.FCriou and Assigned(self.FNotaFiscal) then
    FreeAndNil(self.FNotaFiscal);

  inherited;
end;

procedure TBuscaNotaFiscal.edtIDEnter(Sender: TObject);
begin
  keybd_event(VK_TAB, 0,  0, 0);
end;

procedure TBuscaNotaFiscal.edtIDExit(Sender: TObject);
begin
   self.Buscar( buscaPorEspecificacao(edtNrNota.AsInteger) );
end;

procedure TBuscaNotaFiscal.edtNrNotaChange(Sender: TObject);
begin
  Limpa;
end;

procedure TBuscaNotaFiscal.edtNrNotaEnter(Sender: TObject);
begin
  self.FBuscando := true;
end;

procedure TBuscaNotaFiscal.edtNrNotaExit(Sender: TObject);
begin
  self.FBuscando := false;
end;

procedure TBuscaNotaFiscal.Limpa;
begin
   if Self.FCriou and Assigned(self.FNotaFiscal) then
      FreeAndNil(self.FNotaFiscal);

   if not FBuscando then
   begin
     edtNrNota.OnChange := nil;
     self.edtNrNota.Clear;
     edtNrNota.OnChange := edtNrNotaChange;
   end;

   self.edtID.Clear;
end;

procedure TBuscaNotaFiscal.SetCodigo(const Value: integer);
begin
  if value > 0 then
    self.Buscar( self.buscaPorEspecificacao(Value) )
  else
    self.Limpa;
end;

procedure TBuscaNotaFiscal.SetNotaFiscal(const Value: TNotaFiscal);
begin
   try
     if (Value = self.FNotaFiscal) then
      exit;
   except
     on E: EAccessViolation do
   end;


   if self.FCriou and Assigned(self.FNotaFiscal) then begin
      FreeAndNil(self.FNotaFiscal);
      self.FCriou := false;
   end;

   FNotaFiscal := Value;

  if Assigned(self.FNotaFiscal) then begin
    self.edtNrNota.OnChange  := nil;
    self.edtNrNota.AsInteger := self.FNotaFiscal.NumeroNotaFiscal;
    self.edtID.Text          := self.FNotaFiscal.ChaveAcesso;
    self.edtNrNota.OnChange  := edtNrNotaChange;
  end;
end;

end.
