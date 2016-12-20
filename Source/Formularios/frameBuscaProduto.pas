unit frameBuscaProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Produto,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Mask, RxToolEdit, RxCurrEdit, Vcl.StdCtrls, Vcl.Buttons;

type
  TBuscaProduto = class(TFrame)
    StaticText2: TStaticText;
    StaticText1: TStaticText;
    edtProduto: TEdit;
    btnBusca: TBitBtn;
    edtCodigo: TEdit;
    procedure edtCodigoChange(Sender: TObject);
    procedure edtCodigoEnter(Sender: TObject);
    procedure edtCodigoExit(Sender: TObject);
    procedure edtProdutoEnter(Sender: TObject);
    procedure edtProdutoExit(Sender: TObject);
    procedure btnBuscaClick(Sender: TObject);
    procedure edtCodigoKeyPress(Sender: TObject; var Key: Char);
  private
    FCriou            :Boolean;
    FBuscando         :Boolean;
    FProduto          :TProduto;
    Fcodigo           :integer;

  private
    procedure SetCodigo         (const Value: integer);

  private
    procedure Buscar     (const codigoProduto :Integer);
    procedure SetProduto (const Value         :TProduto);

    function buscaPorEspecificacao(codigoBarras :String) :Integer;

  public
    constructor Create(AOwner :TComponent); override;
    destructor  Destroy;                    override;

  public
    procedure Limpa;

  public
    property Produto           :TProduto      read FProduto           write SetProduto;
    property codigo            :integer       read Fcodigo            write SetCodigo;
  end;

implementation

uses repositorio, fabricaREpositorio, uCadastroProduto, EspecificacaoProdutoPorCodigoBarras;

{$R *.dfm}

{ TBuscaProduto }

procedure TBuscaProduto.btnBuscaClick(Sender: TObject);
begin
  self.Buscar(0);
end;

function TBuscaProduto.buscaPorEspecificacao(codigoBarras: String): Integer;
var especificao :TEspecificacaoProdutoPorCodigoBarras;
    repositorio :TRepositorio;
begin
  try
  result := 0;
  repositorio := TFabricaRepositorio.GetRepositorio(TProduto.ClassName);
  especificao := TEspecificacaoProdutoPorCodigoBarras.Create(codigoBarras);

  try
    result      := TProduto(repositorio.GetPorEspecificacao(especificao)).codigo;
  Except
  end;
  finally
    FreeAndNil(repositorio);
    FreeAndNil(especificao);
  end;
end;

procedure TBuscaProduto.Buscar(const codigoProduto: Integer);
var
  Repositorio :TRepositorio;
  Produto     :TProduto;
begin
   Repositorio := nil;

   try
     Repositorio     := TFabricaRepositorio.GetRepositorio(TProduto.ClassName);
     Produto         := TProduto(Repositorio.Get(codigoProduto));

     if not Assigned(Produto) then begin
       frmCadastroProduto := nil;

       try
         frmCadastroProduto := TfrmCadastroProduto.CreateModoBusca(nil);
         frmCadastroProduto.ShowModal;

         if (frmCadastroProduto.ModalResult = mrOK) then begin
            Produto          := TProduto(Repositorio.Get(frmCadastroProduto.cdsCODIGO.AsInteger));

            if Assigned(Produto) then begin
              self.Produto := Produto;
              self.FCriou  := true;
              //keybd_event(VK_TAB, 0, 0, 0);
            end;
         end
         else begin
          if edtProduto.Text = '' then
            self.Limpa;
          edtCodigo.SetFocus;
         end;
       finally
         frmCadastroProduto.Release;
         frmCadastroProduto := nil;
       end;
     end
     else begin
       self.Produto  := Produto;
       self.FCriou   := true;
     end;

   finally
     FreeAndNil(Repositorio);
   end;
end;

constructor TBuscaProduto.Create(AOwner: TComponent);
begin
  inherited;
  self.FProduto  := nil;
  self.FCriou    := false;
end;

destructor TBuscaProduto.Destroy;
begin
  if self.FCriou and Assigned(self.FProduto) then
    FreeAndNil(self.FProduto);
  inherited;
end;

procedure TBuscaProduto.edtCodigoChange(Sender: TObject);
begin
  Limpa;
end;

procedure TBuscaProduto.edtCodigoEnter(Sender: TObject);
begin
  self.FBuscando := true;
end;

procedure TBuscaProduto.edtCodigoExit(Sender: TObject);
begin
  self.FBuscando := false;
end;

procedure TBuscaProduto.edtCodigoKeyPress(Sender: TObject; var Key: Char);
begin
  If not( key in['0'..'9',#08] ) then
    key:=#0;
end;

procedure TBuscaProduto.edtProdutoEnter(Sender: TObject);
begin
  keybd_event(VK_TAB, 0,  0, 0);
end;

procedure TBuscaProduto.edtProdutoExit(Sender: TObject);
var codigoProduto :integer;
begin
   if length(edtCodigo.Text) > 10 then
     codigoProduto := self.buscaPorEspecificacao(edtCodigo.Text)
   else
     codigoProduto := StrToIntDef(edtCodigo.Text,0);

   self.Buscar( codigoProduto );
end;

procedure TBuscaProduto.Limpa;
begin
   if Self.FCriou and Assigned(self.FProduto) then
      FreeAndNil(self.FProduto);

   if not FBuscando then
   begin
     edtCodigo.OnChange := nil;
     self.edtCodigo.Clear;
     edtCodigo.OnChange := edtCodigoChange;
   end;

   self.edtProduto.Clear;
end;

procedure TBuscaProduto.SetCodigo(const Value: integer);
begin
  if value > 0 then
    self.Buscar( Value )
  else
    self.Limpa;
end;

procedure TBuscaProduto.SetProduto(const Value: TProduto);
begin
   try
     if (Value = self.FProduto) then
      exit;
   except
     on E: EAccessViolation do
   end;


   if self.FCriou and Assigned(self.FProduto) then begin
      FreeAndNil(self.FProduto);
      self.FCriou := false;
   end;

   FProduto := Value;

  if Assigned(self.FProduto) then begin
    self.edtCodigo.OnChange    := nil;
    self.edtCodigo.Text        := IntToStr(self.FProduto.codigo);
    self.edtProduto.Text       := self.FProduto.descricao;
    self.edtCodigo.OnChange    := edtCodigoChange;
  end;
end;

end.
