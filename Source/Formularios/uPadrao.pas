unit uPadrao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, TipoMensagem,
  Dialogs, uModulo, stdCtrls, DBCtrls, Mask, RxCurrEdit{, PermissoesAcesso};

type
  TfrmPadrao = class(TForm)

    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    
  private
    FFecharComEsc: Boolean;
    FaguardaAtivo :Boolean;

  private
    procedure SetFecharComEsc(const Value: Boolean);
    procedure padraoConfiguraGrid;

  protected
    procedure KeyDownPadrao(Sender: TObject; var Key: Word; Shift: TShiftState);

  public
    function confirma(mensagem:String) :Boolean;

  public
    procedure AbreForm(frm: TFormClass);
    procedure AbrirArquivo(const CaminhoCompletoDoArquivo :String);
    procedure avisar(tipoMsg :Integer; mensagem:String; const tempoEspera :integer = 0; const semAtalho :String = '');
    function  inputBox(titulo :String) :String;
    procedure Aguarda(mensagem :String);
    procedure FimAguarda(const mensagem :String = '');

  public
    constructor Create(AOwner :TComponent); override;

  protected
    Fdm :Tdm;

    property FecharComEsc :Boolean read FFecharComEsc write SetFecharComEsc;
end;

var
  frmPadrao: TfrmPadrao;

implementation

uses
  uAvisar,
  uAguarde,
  uInputBox,
  uConfirmacaoUsuario,
  DBGridCBN,
  ConfigCores,
  Masks,
  ShellApi;

{$R *.dfm}

{ TfrmPadrao }

procedure TfrmPadrao.avisar(tipoMsg :Integer; mensagem: String; const tempoEspera: integer; const semAtalho :String);
begin
  frmAvisar := TfrmAvisar.Create(self, tipoMsg, mensagem, tempoEspera, semAtalho);
  frmAvisar.ShowModal;
  frmAvisar.Release;
  frmAvisar := nil;
end;

procedure TfrmPadrao.AbreForm(frm: TFormClass);
var lFrm : TForm;
begin
   lFrm := frm.Create(nil);
   lFrm.ShowModal;

   if Assigned( lFrm ) then
    begin
       lFrm.Release;
       lFrm := nil;
    end;
end;

procedure TfrmPadrao.FormCreate(Sender: TObject);
begin
  Fdm := dm;
  self.FaguardaAtivo := false;
  padraoConfiguraGrid;
end;

procedure TfrmPadrao.FormDestroy(Sender: TObject);
begin
  if self.FaguardaAtivo then
    self.FimAguarda();
end;

procedure TfrmPadrao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if not (ssCtrl in Shift) and (Key = VK_RETURN) then
    begin
       Shift := [];
       Key   := 0;
       keybd_event(VK_TAB, 0, 0, 0);
    end
   else if (Key = VK_ESCAPE) and self.FFecharComEsc then
    begin
       Shift := [];
       Key   := 0;
       self.Close();
    end
   else if(ssCtrl in Shift) and (ssShift in Shift) then
     if key = 67 then
      // buscaTelaAtalhos;

end;

function TfrmPadrao.inputBox(titulo: String): String;
begin
  result := '';
  frmInputBox := TfrmInputBox.Create(nil);
  frmInputBox.lbTitulo.Caption := titulo;

  if frmInputBox.ShowModal = mrOk then
    result := TRIM(frmInputBox.memoMsg.Text);

  frmInputBox.Release;
  frmInputBox := nil;
end;

function TfrmPadrao.confirma(mensagem: String): Boolean;
begin
  Result := false;
  
  frmConfirmacaoUsuario := TfrmConfirmacaoUsuario.Create(self);
  frmConfirmacaoUsuario.memMsg.Text := mensagem;

  if frmConfirmacaoUsuario.ShowModal = mrOk then
    result := true;

  frmConfirmacaoUsuario.Release;
  frmConfirmacaoUsuario := nil;
end;

procedure TfrmPadrao.padraoConfiguraGrid;
var i :integer;
begin
  for i := 0 to ComponentCount-1 do begin
    if Components[I] is TDBGridCBN then begin
      TDBGridCBN(Components[i]).ConfCores.Destacado.CorFonte := clwhite;
      TDBGridCBN(Components[i]).ConfCores.Destacado.CorFundo := $00538C60;//$00917E6F;
      TDBGridCBN(Components[i]).ConfCores.Selecao.CorFonte   := clBlack;
      TDBGridCBN(Components[i]).ConfCores.Selecao.CorFundo   := $0098E0B7;
      TDBGridCBN(Components[i]).ConfCores.Normal.CorFonte    := clBlack;
      TDBGridCBN(Components[i]).ConfCores.Normal.CorFundo    := $00E1E1E1;
      TDBGridCBN(Components[i]).ConfCores.Zebrada.CorFonte   := clBlack;
      TDBGridCBN(Components[i]).ConfCores.Zebrada.CorFundo   := clWhite;
    end;
  end;
end;

procedure TfrmPadrao.KeyDownPadrao(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   self.FormKeyDown(Sender, Key, Shift);
end;

procedure TfrmPadrao.AbrirArquivo(const CaminhoCompletoDoArquivo:String);
begin
    ShellExecute(handle, 'open', PChar(CaminhoCompletoDoArquivo), '','',SW_SHOWNORMAL);
end;

procedure TfrmPadrao.SetFecharComEsc(const Value: Boolean);
begin
  FFecharComEsc := Value;
end;

constructor TfrmPadrao.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);

   self.FFecharComEsc := true;
end;

procedure TfrmPadrao.Aguarda(mensagem: String);
begin

  if frmAguarde = nil then begin
    frmAguarde := TfrmAguarde.Create(nil, mensagem);
    frmAguarde.Show;
    self.FaguardaAtivo := true;
  end
  else
    frmAguarde.memoAguarde.Text := mensagem;

end;

procedure TfrmPadrao.FimAguarda(const mensagem :String);
begin
  if self.FaguardaAtivo then begin
    frmAguarde.memoAguarde.Text := mensagem;

    Application.ProcessMessages;

    if mensagem <> '' then
      sleep(3000);

    self.FaguardaAtivo := false;
    frmAguarde.Release;
    frmAguarde := nil;
  end;

end;

end.
