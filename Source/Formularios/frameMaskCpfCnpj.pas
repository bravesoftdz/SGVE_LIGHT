unit frameMaskCpfCnpj;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, Mask;

type
  TMaskCpfCnpj = class(TFrame)
    edtCpf: TMaskEdit;
    comPessoa: TComboBox;
    StaticText1: TStaticText;
    stxTitulo: TStaticText;
    Label19: TLabel;
    procedure comPessoaChange(Sender: TObject);
  private
    Fpessoa: String;
    procedure Setpessoa(const Value: String);
    { Private declarations }
  public
    procedure setPadrao;
    
    property pessoa :String read Fpessoa write Setpessoa;
  end;

implementation

{$R *.dfm}

{ TFrame1 }

procedure TMaskCpfCnpj.Setpessoa(const Value: String);
begin
  Fpessoa := Value;
  if FPessoa = 'F' then
    comPessoa.ItemIndex := 0
  else if Pessoa = 'J' then
    comPessoa.ItemIndex := 1;

  comPessoaChange(nil);
end;

procedure TMaskCpfCnpj.comPessoaChange(Sender: TObject);
begin
  if comPessoa.ItemIndex = 0 then begin

    if length(edtCpf.Text) > 11 then   edtCpf.Text := copy(edtCpf.Text,1,11);
    self.Fpessoa      := 'F';
    edtCpf.EditMask   := '999\.999\.999\-99;0; ';
    stxTitulo.Caption := 'CPF';
  end
  else if comPessoa.ItemIndex = 1 then
  begin
    self.Fpessoa      := 'J';
    edtCpf.EditMask := '99\.999\.999/9999\-99;0; ';
    stxTitulo.Caption := 'CNPJ';
  end;

end;

procedure TMaskCpfCnpj.setPadrao;
begin
  comPessoa.ItemIndex := 0;
  comPessoaChange(nil);
  edtCpf.Clear;
end;

end.
