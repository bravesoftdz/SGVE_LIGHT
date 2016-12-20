unit frameBuscaPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Pedido, System.StrUtils,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, RxToolEdit, RxCurrEdit;

type
  TBuscaPedido = class(TFrame)
    edtCodigo: TCurrencyEdit;
    btnBusca: TBitBtn;
    StaticText1: TStaticText;
    btnNovo: TBitBtn;
    btnCancelar: TSpeedButton;
    procedure btnNovoClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnBuscaClick(Sender: TObject);
  private
    FCriou            :Boolean;
    FPedidoCupomPendente :Boolean;
    FPedido           :TPedido;
    Fcodigo           :integer;

  private
    procedure SetCodigo         (const Value: integer);

  protected
    procedure Buscar    (const codigoPedido :Integer); virtual;
    procedure SetPedido (const Value      :TPedido);

  public
    constructor Create(AOwner :TComponent); override;
    destructor  Destroy;                    override;

  public
    procedure Limpa;
    procedure habilitado(boleana :Boolean);
  public
    property Pedido           :TPedido      read FPedido           write SetPedido;
    property codigo           :integer      read Fcodigo           write SetCodigo;
  end;

implementation

uses uModulo, repositorio, FabricaRepositorio, uPesquisaSimples;

{$R *.dfm}

procedure TBuscaPedido.btnBuscaClick(Sender: TObject);
begin
  Buscar(0);
end;

procedure TBuscaPedido.btnCancelarClick(Sender: TObject);
begin
  //self.habilitado(true);
  btnBusca.Enabled    := true;
end;

procedure TBuscaPedido.btnNovoClick(Sender: TObject);
begin
  self.edtCodigo.AsInteger := dm.GetValorGenerator('GEN_PEDIDOS_ID') + 1;
  //self.habilitado(false);
end;

procedure TBuscaPedido.Buscar(const codigoPedido: Integer);
var
  Repositorio :TRepositorio;
  Pedido      :TPedido;
  condicao    :String;
begin
   Repositorio := nil;

   try
     Repositorio     := TFabricaRepositorio.GetRepositorio(TPedido.ClassName);
     Pedido          := TPedido(Repositorio.Get(codigoPedido));

     if not Assigned(Pedido) then begin
       frmPesquisaSimples := nil;

       try
         condicao := IfThen(FPedidoCupomPendente,' where NFCE.CODIGO is null ', '');
         frmPesquisaSimples := TFrmPesquisaSimples.Create(Self,'Select ped.CODIGO, ped.VALOR_TOTAL, p.razao nome from Pedidos ped '+
                                                               'left join pessoas p on p.codigo = ped.codigo_cliente '+
                                                               'left join NFCE on NFCE.CODIGO_PEDIDO = ped.CODIGO '+ condicao,
                                                         'CODIGO', 'Selecione a Cor desejada...', 800, 700);

         if frmPesquisaSimples.ShowModal = mrOk then begin
            Pedido  := TPedido(Repositorio.Get(frmPesquisaSimples.cds_retorno.Fields[0].AsInteger));

            if Assigned(Pedido) then
              self.Pedido := Pedido;

           //self.habilitado(false);
          // keybd_event(VK_TAB, 0, 0, 0);
           btnCancelar.Enabled := true;
           btnBusca.Enabled    := false;
         end
         else begin
         // self.Limpa;
          //self.habilitado(true);
         end;
       finally
         frmPesquisaSimples.Release;
         frmPesquisaSimples := nil;
       end;
     end
     else begin
       self.Pedido  := Pedido;
       self.FCriou  := true;
     end;

   finally
     FreeAndNil(Repositorio);
   end;
end;

constructor TBuscaPedido.Create(AOwner: TComponent);
begin
  inherited;
  self.FPedido   := nil;
  self.FCriou    := false;
end;

destructor TBuscaPedido.Destroy;
begin
  if self.FCriou and Assigned(self.FPedido) then
    FreeAndNil(self.FPedido);
  inherited;
end;

procedure TBuscaPedido.habilitado(boleana :Boolean);
begin
  edtCodigo.Enabled   := boleana;
  btnBusca.Enabled    := boleana;
  btnNovo.Enabled     := boleana;
  //btnCancelar.Enabled := not boleana;
end;

procedure TBuscaPedido.Limpa;
begin
   if Self.FCriou and Assigned(self.FPedido) then
      FreeAndNil(self.FPedido);

   self.edtCodigo.Clear;
end;

procedure TBuscaPedido.SetCodigo(const Value: integer);
begin
  if value > 0 then
    self.Buscar( Value )
  else
    self.Limpa;
end;

procedure TBuscaPedido.SetPedido(const Value: TPedido);
begin
   try
     if (Value = self.FPedido) then
      exit;
   except
     on E: EAccessViolation do
   end;


   if self.FCriou and Assigned(self.FPedido) then begin
      FreeAndNil(self.FPedido);
      self.FCriou := false;
   end;

   FPedido := Value;

  if Assigned(self.FPedido) then
    self.edtCodigo.AsInteger   := self.FPedido.codigo;
end;

end.
