
unit frameBuscaCidade;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask, RxToolEdit, RxCurrEdit, Cidade;

type
  TBuscaCidade = class(TFrame)
    StaticText1: TStaticText;
    edtCidade: TEdit;
    btnBusca: TBitBtn;
    StaticText2: TStaticText;
    edtUF: TEdit;
    StaticText3: TStaticText;
    edtCodCid: TCurrencyEdit;
    procedure edtCodCidChange(Sender: TObject);
    procedure edtCodCidEnter(Sender: TObject);
    procedure edtCodCidExit(Sender: TObject);
    procedure btnBuscaClick(Sender: TObject);
    procedure edtCidadeEnter(Sender: TObject);
    procedure edtCidadeExit(Sender: TObject);

  private
    FCriou            :Boolean;
    FBuscando         :Boolean;
    FCidade           :TCidade;
    Fcodigo           :integer;

  private
    procedure SetCodigo         (const Value: integer);

  private
    procedure Buscar    (const CodigoCidade :Integer);
    procedure SetCidade (const Value      :TCidade);

    function buscaPorEspecificacao(codigoIBGE: Integer) :Integer;
    function EstadoCodSigla(C_S: String): String;

  public
    constructor Create(AOwner :TComponent); override;
    destructor  Destroy;                    override;

  public
    procedure Limpa;

  public
    property Cidade           :TCidade      read FCidade           write SetCidade;
    property codigo           :integer      read Fcodigo           write SetCodigo;
  end;

implementation

uses DB, Repositorio, fabricaRepositorio, uCadastroCidade, EspecificacaoCidadePorCodigoIBGE;

{$R *.dfm}

procedure TBuscaCidade.btnBuscaClick(Sender: TObject);
begin
    self.Buscar(StrToIntDef(self.edtCodCid.Text, 0));

end;

function TBuscaCidade.buscaPorEspecificacao(codigoIBGE: Integer): Integer;
var especificao :TEspecificacaoCidadePorCodigoIBGE;
    repositorio :TRepositorio;
begin
  try
  result := 0;
  repositorio := TFabricaRepositorio.GetRepositorio(TCidade.ClassName);
  especificao := TEspecificacaoCidadePorCodigoIBGE.Create(codigoIBGE);

  try
    result      := TCidade(repositorio.GetPorEspecificacao(especificao)).codigo;
  Except
  end;
  finally
    FreeAndNil(repositorio);
    FreeAndNil(especificao);
  end;
end;

procedure TBuscaCidade.Buscar(const CodigoCidade: Integer);
var
  Repositorio :TRepositorio;
  Cidade      :TCidade;
begin
   Repositorio := nil;

   try
     Repositorio     := TFabricaRepositorio.GetRepositorio(TCidade.ClassName);
     Cidade         := TCidade(Repositorio.Get(CodigoCidade));

     if not Assigned(Cidade) then begin
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
     end;

   finally
     FreeAndNil(Repositorio);
   end;
end;

constructor TBuscaCidade.Create(AOwner: TComponent);
begin
  inherited;
  self.FCidade   := nil;
  self.FCriou    := false;
end;

destructor TBuscaCidade.Destroy;
begin
  if self.FCriou and Assigned(self.FCidade) then
    FreeAndNil(self.FCidade);

  inherited;
end;

procedure TBuscaCidade.edtCidadeEnter(Sender: TObject);
begin
  keybd_event(VK_TAB, 0,  0, 0);
end;

procedure TBuscaCidade.edtCidadeExit(Sender: TObject);
begin
   self.Buscar( buscaPorEspecificacao(edtCodCid.AsInteger) );
end;

procedure TBuscaCidade.edtCodCidChange(Sender: TObject);
begin
  Limpa;
end;

procedure TBuscaCidade.edtCodCidEnter(Sender: TObject);
begin
  self.FBuscando := true;
end;

procedure TBuscaCidade.edtCodCidExit(Sender: TObject);
begin
  self.FBuscando := false;
end;

function TBuscaCidade.EstadoCodSigla(C_S: String): String;
var num :Integer;
begin
  num := StrToIntDef(C_S,0);

  if num = 0 then begin
    if C_S = 'AC' then result := '1'
    else if C_S = 'AL' then result := '2'
    else if C_S = 'AM' then result := '4'
    else if C_S = 'BA' then result := '5'
    else if C_S = 'CE' then result := '6'
    else if C_S = 'DF' then result := '7'
    else if C_S = 'ES' then result := '8'
    else if C_S = 'RR' then result := '9'
    else if C_S = 'GO' then result := '10'
    else if C_S = 'MA' then result := '11'
    else if C_S = 'MT' then result := '12'
    else if C_S = 'MS' then result := '13'
    else if C_S = 'MG' then result := '14'
    else if C_S = 'PA' then result := '15'
    else if C_S = 'PB' then result := '16'
    else if C_S = 'PR' then result := '17'
    else if C_S = 'PE' then result := '18'
    else if C_S = 'PI' then result := '19'
    else if C_S = 'RJ' then result := '20'
    else if C_S = 'RN' then result := '21'
    else if C_S = 'RS' then result := '22'
    else if C_S = 'RO' then result := '23'
    else if C_S = 'TO' then result := '24'
    else if C_S = 'SC' then result := '25'
    else if C_S = 'SP' then result := '26'
    else if C_S = 'SE' then result := '27';

  end
  else begin
          if C_S = '1' then result := 'AC'
    else if C_S = '2'  then result := 'AL'
    else if C_S = '3'  then result := 'AP'
    else if C_S = '4'  then result := 'AM'
    else if C_S = '5'  then result := 'BA'
    else if C_S = '6'  then result := 'CE'
    else if C_S = '7'  then result := 'DF'
    else if C_S = '8'  then result := 'ES'
    else if C_S = '9'  then result := 'RR'
    else if C_S = '10' then result := 'GO'
    else if C_S = '11' then result := 'MA'
    else if C_S = '12' then result := 'MT'
    else if C_S = '13' then result := 'MS'
    else if C_S = '14' then result := 'MG'
    else if C_S = '15' then result := 'PA'
    else if C_S = '16' then result := 'PB'
    else if C_S = '17' then result := 'PR'
    else if C_S = '18' then result := 'PE'
    else if C_S = '19' then result := 'PI'
    else if C_S = '20' then result := 'RJ'
    else if C_S = '21' then result := 'RN'
    else if C_S = '22' then result := 'RS'
    else if C_S = '23' then result := 'RO'
    else if C_S = '24' then result := 'TO'
    else if C_S = '25' then result := 'SC'
    else if C_S = '26' then result := 'SP'
    else if C_S = '27' then result := 'SE';

  end;
end;

procedure TBuscaCidade.Limpa;
begin
   if Self.FCriou and Assigned(self.FCidade) then
      FreeAndNil(self.FCidade);

   if not FBuscando then
   begin
     edtCodCid.OnChange := nil;
     self.edtCodCid.Clear;
     edtCodCid.OnChange := edtCodCidChange;
   end;

   self.edtCidade.Clear;
   self.edtUF.Clear;
end;

procedure TBuscaCidade.SetCidade(const Value: TCidade);
begin
   try
     if (Value = self.FCidade) then
      exit;
   except
     on E: EAccessViolation do
   end;


   if self.FCriou and Assigned(self.FCidade) then begin
      FreeAndNil(self.FCidade);
      self.FCriou := false;
   end;

   FCidade := Value;

  if Assigned(self.FCidade) then begin
    self.edtCodCid.OnChange  := nil;
    self.edtCodCid.AsInteger := self.FCidade.codibge;
    self.edtCidade.Text      := self.FCidade.nome;
    self.edtUF.Text          := self.FCidade.Estado.sigla;
    self.edtCodCid.OnChange  := edtCodCidChange;
  end;
end;

procedure TBuscaCidade.SetCodigo(const Value: integer);
begin
  if value > 0 then
    self.Buscar( self.buscaPorEspecificacao(Value) )
  else
    self.Limpa;
end;

end.




