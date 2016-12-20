unit frameBuscaNaturezaOperacao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, NaturezaOperacao, Especificacao;

type
  TBuscaNaturezaOperacao = class(TFrame)
    lblCFOP: TStaticText;
    lblRazao: TStaticText;
    edtCFOP: TEdit;
    btnBusca: TBitBtn;
    edtDescricao: TEdit;
    procedure edtCFOPChange(Sender: TObject);
    procedure edtCFOPEnter(Sender: TObject);
    procedure edtCFOPExit(Sender: TObject);
    procedure btnBuscaClick(Sender: TObject);
    procedure edtDescricaoEnter(Sender: TObject);
    procedure edtDescricaoExit(Sender: TObject);

  private
    FCriou            :Boolean;
    FBuscando         :Boolean;
    FNaturezaOperacao :TNaturezaOperacao;
    Fcodigo           :integer;

  private
    procedure SetCodigo         (const Value: integer);

  private
    procedure Buscar    (const CodigoNatOp :Integer);
    procedure SetNaturezaOperacao (const Value      :TNaturezaOperacao);

    function buscaPorEspecificacao(CFOP: String) :Integer;

  public
    constructor Create(AOwner :TComponent); override;
    destructor  Destroy;                    override;

  public
    procedure Limpa;

  public
    property NaturezaOperacao :TNaturezaOperacao  read FNaturezaOperacao write SetNaturezaOperacao;
    property codigo           :integer            read Fcodigo           write SetCodigo;
  end;

implementation

uses
  Repositorio,
  FabricaRepositorio,
  EspecificacaoNaturezaComCFOPIgualA;//,
 // uCadastroNaturezaOperacao;

{$R *.dfm}

{ TBuscaNaturezaOperacao }

procedure TBuscaNaturezaOperacao.btnBuscaClick(Sender: TObject);
begin
    self.Buscar( self.buscaPorEspecificacao(self.edtCFOP.Text));
end;

function TBuscaNaturezaOperacao.buscaPorEspecificacao(CFOP: String): Integer;
var especificao :TEspecificacaoNaturezaComCFOPIgualA;
    repositorio :TRepositorio;
begin
  try
  result := 0;
  repositorio := TFabricaRepositorio.GetRepositorio(TNaturezaOperacao.ClassName);
  especificao := TEspecificacaoNaturezaComCFOPIgualA.Create(CFOP);

  try
    result      := TNaturezaOperacao(repositorio.GetPorEspecificacao(especificao)).codigo;
  Except
  end;
  finally
    FreeAndNil(repositorio);
    FreeAndNil(especificao);
  end;
end;

procedure TBuscaNaturezaOperacao.Buscar(const CodigoNatOp :Integer);
var
  Repositorio :TRepositorio;
  NatOp       :TNaturezaOperacao;
begin
   Repositorio := nil;

   try
     Repositorio     := TFabricaRepositorio.GetRepositorio(TNaturezaOperacao.ClassName);
     NatOp         := TNaturezaOperacao(Repositorio.Get(CodigoNatOp));

     if not Assigned(NatOp) then begin
       frmCadastroCidade := nil;

       try
         frmCadastroCidade := TfrmCadastroCidade.CreateModoBusca(nil);
         frmCadastroCidade.ShowModal;

         if (frmCadastroCidade.ModalResult = mrOK) then begin
            NatOp          := TNaturezaOperacao(Repositorio.Get(frmCadastroCidade.cdsCODIGO.AsInteger));

            if Assigned(NatOp) then begin
              self.NaturezaOperacao  := NatOp;
              self.FCriou  := true;
              keybd_event(VK_TAB, 0, 0, 0);
            end;
         end
         else begin
           if edtDescricao.Text = '' then
             self.Limpa;
           edtCFOP.SetFocus;
         end;
       finally
         frmCadastroCidade.Release;
         frmCadastroCidade := nil;
       end;
     end
     else begin
       self.NaturezaOperacao  := NatOp;
       self.FCriou  := true;
     end;

   finally
     FreeAndNil(Repositorio);
   end;
end;

constructor TBuscaNaturezaOperacao.Create(AOwner: TComponent);
begin
  inherited;
  self.FCidade   := nil;
  self.FCriou    := false;
end;

destructor TBuscaNaturezaOperacao.Destroy;
begin
  if self.FCriou and Assigned(self.FNaturezaOperacao) then
    FreeAndNil(self.FNaturezaOperacao);

  inherited;
end;

procedure TBuscaNaturezaOperacao.edtCFOPChange(Sender: TObject);
begin
  Limpa;
end;

procedure TBuscaNaturezaOperacao.edtCFOPEnter(Sender: TObject);
begin
  self.FBuscando := true;
end;

procedure TBuscaNaturezaOperacao.edtCFOPExit(Sender: TObject);
begin
  self.FBuscando := false;
end;

procedure TBuscaNaturezaOperacao.edtDescricaoEnter(Sender: TObject);
begin
  keybd_event(VK_TAB, 0,  0, 0);
end;

procedure TBuscaNaturezaOperacao.edtDescricaoExit(Sender: TObject);
begin
   self.Buscar( buscaPorEspecificacao(edtCFOP.Text) );
end;

procedure TBuscaNaturezaOperacao.Limpa;
begin
   if Self.FCriou and Assigned(self.FNaturezaOperacao) then
      FreeAndNil(self.FNaturezaOperacao);

   if not FBuscando then
   begin
     edtCFOP.OnChange := nil;
     self.edtCFOP.Clear;
     edtCFOP.OnChange := edtCFOPChange;
   end;

   self.edtDescricao.Clear;
end;

procedure TBuscaNaturezaOperacao.SetCodigo(const Value: integer);
begin
  if value > 0 then
    self.Buscar( self.buscaPorEspecificacao(Value) )
  else
    self.Limpa;
end;

procedure TBuscaNaturezaOperacao.SetNaturezaOperacao(const Value: TNaturezaOperacao);
begin
   try
     if (Value = self.FNaturezaOperacao) then
      exit;
   except
     on E: EAccessViolation do
   end;


   if self.FCriou and Assigned(self.FNaturezaOperacao) then begin
      FreeAndNil(self.FNaturezaOperacao);
      self.FCriou := false;
   end;

   FNaturezaOperacao := Value;

  if Assigned(self.FNaturezaOperacao) then begin
    self.edtCFOP.OnChange  := nil;
    self.edtCFOP.Text      := self.FNaturezaOperacao.CFOP;
    self.edtDescricao.Text := self.FNaturezaOperacao.Descricao;
    self.edtCFOP.OnChange  := edtCFOPChange;
  end;
end;

end.
