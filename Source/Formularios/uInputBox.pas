unit uInputBox;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uPadrao, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls;

type
  TfrmInputBox = class(TfrmPadrao)
    panCorpo: TPanel;
    Shape1: TShape;
    Shape3: TShape;
    Shape2: TShape;
    lbTitulo: TLabel;
    memoMsg: TMemo;
    btnConfirmar: TBitBtn;
    btnCancelar: TBitBtn;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmInputBox: TfrmInputBox;

implementation

{$R *.dfm}

procedure TfrmInputBox.btnCancelarClick(Sender: TObject);
begin
  self.Close;
end;

procedure TfrmInputBox.btnConfirmarClick(Sender: TObject);
begin
  self.ModalResult := mrOk;
end;

procedure TfrmInputBox.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = vk_return then
  begin
    btnConfirmar.Click;
    key := 0;
  end;

  inherited;
end;

end.
