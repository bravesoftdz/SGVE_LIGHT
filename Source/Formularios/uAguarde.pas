unit uAguarde;

interface
                                                  
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, ACBrGIF;

type
  TfrmAguarde = class(TForm)
    memoAguarde: TMemo;
    gifAguarde: TACBrGIF;
    Shape1: TShape;
    lbAviso: TLabel;
    Shape2: TShape;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    constructor Create(AOwner: TComponent; mensagem: String); overload;
  end;

var
  frmAguarde: TfrmAguarde;

implementation

{$R *.dfm}

{ TfrmAguarde }

constructor TfrmAguarde.Create(AOwner: TComponent; mensagem: String);
begin
  self.Create(aOwner);
  Self.memoAguarde.Text := mensagem;
  self.DoubleBuffered := true;
end;

procedure TfrmAguarde.FormShow(Sender: TObject);
begin
  Application.ProcessMessages;
  frmAguarde.gifAguarde.Filename := ExtractFilePath( Application.ExeName )+'\Imagens\Aguarda.gif';
  frmAguarde.gifAguarde.Active   := true;
  Application.ProcessMessages;
end;

end.
