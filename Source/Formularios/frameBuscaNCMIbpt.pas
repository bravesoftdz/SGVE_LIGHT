unit frameBuscaNCMIbpt;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, NcmIBPT, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.Mask, RxToolEdit, RxCurrEdit, funcoes, System.StrUtils;

type
  TBuscaNCMIbpt = class(TFrame)
    StaticText2: TStaticText;
    StaticText1: TStaticText;
    edtCodigo: TCurrencyEdit;
    btnBusca: TBitBtn;
    edtNCM: TEdit;
    edtAliquota: TCurrencyEdit;
    edtCFOP: TEdit;
    StaticText3: TStaticText;
    edtCST: TEdit;
    StaticText4: TStaticText;
    BitBtn1: TBitBtn;
    procedure btnBuscaClick(Sender: TObject);
    procedure edtNCMKeyPress(Sender: TObject; var Key: Char);
    procedure edtNCMChange(Sender: TObject);
    procedure edtNCMEnter(Sender: TObject);
    procedure edtNCMExit(Sender: TObject);
    procedure edtAliquotaExit(Sender: TObject);
    procedure edtAliquotaEnter(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    FCriou            :Boolean;
    FBuscando         :Boolean;
    FNcmIBPT          :TNcmIBPT;
    Fcodigo           :integer;

  private
    procedure SetCodigo         (const Value: integer);

  private
    procedure Buscar    (const CodigoNcmIBPT :Integer);
    procedure SetNcmIBPT(const Value         :TNcmIBPT);

    function buscaPorEspecificacao(codigoNcm :String) :Integer;

  public
    constructor Create(AOwner :TComponent); override;
    destructor  Destroy;                    override;

  public
    procedure Limpa;

  public
    property NcmIBPT          :TNcmIBPT     read FNcmIBPT          write SetNcmIBPT;
    property codigo           :integer      read Fcodigo           write SetCodigo;
  end;

implementation

uses uPesquisaSimples, Repositorio, FabricaRepositorio, EspecificacaoNCMPorCodigoNcm, uCadastroNcmIBPT;

{$R *.dfm}

{ TBuscaNCMIbpt }

procedure TBuscaNCMIbpt.BitBtn1Click(Sender: TObject);
begin
  frmCadastroNcmIBPT            := TfrmCadastroNcmIBPT.Create(nil);
  frmCadastroNcmIBPT.codigoNCM  := edtCodigo.AsInteger;
  frmCadastroNcmIBPT.ShowModal;
  frmCadastroNcmIBPT.Release;
  frmCadastroNcmIBPT := nil;

  self.Buscar(self.edtCodigo.AsInteger);
end;

procedure TBuscaNCMIbpt.btnBuscaClick(Sender: TObject);
begin
    self.Buscar(StrToIntDef(self.edtCodigo.Text, 0));
    keybd_event(VK_TAB, 0, 0, 0);
end;

function TBuscaNCMIbpt.buscaPorEspecificacao(codigoNcm: String): Integer;
var especificao :TEspecificacaoNCMPorCodigoNcm;
    repositorio :TRepositorio;
begin
  try
  result := 0;
  repositorio := TFabricaRepositorio.GetRepositorio(TNcmIBPT.ClassName);
  especificao := TEspecificacaoNCMPorCodigoNcm.Create(codigoNcm);

  try
    result      := TNcmIbpt(repositorio.GetPorEspecificacao(especificao)).codigo;
  Except
  end;
  finally
    FreeAndNil(repositorio);
    FreeAndNil(especificao);
  end;
end;

procedure TBuscaNCMIbpt.Buscar(const CodigoNcmIBPT: Integer);
var
  Repositorio :TRepositorio;
  NcmIBPT     :TNcmIBPT;
begin
   Repositorio := nil;

   try
     Repositorio     := TFabricaRepositorio.GetRepositorio(TNcmIBPT.ClassName);
     NcmIBPT         := TNcmIBPT(Repositorio.Get(CodigoNcmIBPT));

     if not Assigned(NcmIBPT) then begin
       frmCadastroNcmIBPT := nil;

       try
         frmCadastroNcmIBPT := TfrmCadastroNcmIBPT.CreateModoBusca(nil);
         frmCadastroNcmIBPT.ShowModal;

         if (frmCadastroNcmIBPT.ModalResult = mrOK) then begin
            NcmIBPT          := TNcmIBPT(Repositorio.Get(frmCadastroNcmIBPT.cdsCODIGO.AsInteger));

            if Assigned(NcmIBPT) then begin
              self.NcmIBPT := NcmIBPT;
              self.FCriou  := true;
            end;
         end
         else
          self.Limpa;
       finally
         frmCadastroNcmIBPT.Release;
         frmCadastroNcmIBPT := nil;
       end;
     end
     else begin
       self.NcmIBPT := NcmIBPT;
       self.FCriou  := true;
     end;

   finally
     FreeAndNil(Repositorio);
   end;
end;

constructor TBuscaNCMIbpt.Create(AOwner: TComponent);
begin
  inherited;
  self.FNcmIBPT  := nil;
  self.FCriou    := false;
end;

destructor TBuscaNCMIbpt.Destroy;
begin
  if self.FCriou and Assigned(self.FNcmIBPT) then
    FreeAndNil(self.FNcmIBPT);

  inherited;
end;

procedure TBuscaNCMIbpt.edtAliquotaEnter(Sender: TObject);
begin
  keybd_event(VK_TAB, 0,  0, 0);
end;

procedure TBuscaNCMIbpt.edtAliquotaExit(Sender: TObject);
begin
   self.Buscar( buscaPorEspecificacao(edtNCM.Text) );
end;

procedure TBuscaNCMIbpt.edtNCMChange(Sender: TObject);
begin
  Limpa;
end;

procedure TBuscaNCMIbpt.edtNCMEnter(Sender: TObject);
begin
  self.FBuscando := true;
end;

procedure TBuscaNCMIbpt.edtNCMExit(Sender: TObject);
begin
  self.FBuscando := false;
end;

procedure TBuscaNCMIbpt.edtNCMKeyPress(Sender: TObject; var Key: Char);
begin
  If not( key in['0'..'9',#08] ) then
    key:=#0;
end;

procedure TBuscaNCMIbpt.Limpa;
begin
   if Self.FCriou and Assigned(self.FNcmIBPT) then
      FreeAndNil(self.FNcmIBPT);

   self.edtCodigo.Clear;
   if not FBuscando then
   begin
     edtNCM.OnChange := nil;
     self.edtNCM.Clear;
     edtNCM.OnChange := edtNCMChange;
   end;

   self.edtAliquota.Clear;
   self.edtCFOP.Clear;
   self.edtCST.Clear;
   self.FCriou := false;
end;

procedure TBuscaNCMIbpt.SetCodigo(const Value: integer);
begin
  if value > 0 then
    self.Buscar( Value )
  else
    self.Limpa;
end;

procedure TBuscaNCMIbpt.SetNcmIBPT(const Value: TNcmIBPT);
begin
   try
     if (Value = self.FNcmIBPT) then
      exit;
   except
     on E: EAccessViolation do
   end;


   if self.FCriou and Assigned(self.FNcmIBPT) then begin
      FreeAndNil(self.FNcmIBPT);
      self.FCriou := false;
   end;

   FNcmIBPT := Value;

  if Assigned(self.FNcmIBPT) then begin
    self.edtNCM.OnChange    := nil;
    self.edtCodigo.Text     := IntToStr(self.FNcmIBPT.codigo);
    self.edtNCM.Text        := self.FNcmIBPT.ncm_ibpt;
    self.edtAliquota.Value  := self.FNcmIBPT.aliqnacional_ibpt;
    self.edtCST.Text        := self.FNcmIBPT.cst;
    self.edtCFOP.Text       := self.FNcmIBPT.cfop.cfop;
    self.edtNCM.OnChange    := edtNCMChange;
  end;
end;

end.
