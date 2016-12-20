unit frameBuscaNcm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, Mask, RxToolEdit, RxCurrEdit, StdCtrls, Buttons;

type
  TBuscaNcm = class(TFrame)
    edtDescricao: TEdit;
    StaticText2: TStaticText;
    StaticText1: TStaticText;
    btnBusca: TBitBtn;
    edtCodigo: TCurrencyEdit;
    procedure edtDescricaoEnter(Sender: TObject);
    procedure btnBuscaClick(Sender: TObject);
    procedure edtCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodigoExit(Sender: TObject);
  private
    FcodNcm :String;
    FCodigo: Integer;

    procedure SetCodNcm(const value:String);

    procedure buscaNcm(codigo:String);
    procedure limpa;

  public

    property CodNcm :String  read FcodNcm write SetCodNcm;
    property Codigo :Integer read FCodigo;
  end;

implementation

uses uPesquisaSimples;

{$R *.dfm}

procedure TBuscaNcm.buscaNcm(codigo: String);
var campoRetorno :String;
begin
  campoRetorno := 'NCM'; //campo que deseja que retorne



end;

procedure TBuscaNcm.edtDescricaoEnter(Sender: TObject);
begin
  keybd_event(VK_RETURN, 0, 0, 0);
end;

procedure TBuscaNcm.btnBuscaClick(Sender: TObject);
var campoRetorno :String;
begin
  campoRetorno := 'NCM';
  
  frmPesquisaSimples := TFrmPesquisaSimples.Create(Self,'select ncm, descricao from classificacao_fiscal',
                                                         campoRetorno, 'Selecione codigo NCM desejado...');

  if frmPesquisaSimples.ShowModal = mrOk then
    buscaNcm(frmPesquisaSimples.cds_retorno.Fields[0].AsString);

  frmPesquisaSimples.Release;

  edtDescricao.SetFocus;
end;

procedure TBuscaNcm.SetCodNcm(const value: String);
begin
  buscaNcm(value);
end;

procedure TBuscaNcm.edtCodigoKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    if (edtCodigo.Value  = 0) then
      btnBusca.Click;
end;

procedure TBuscaNcm.edtCodigoExit(Sender: TObject);
begin
  if edtCodigo.Value > 0 then
    buscaNcm(edtCodigo.Text)
  else
    limpa;
end;

procedure TBuscaNcm.limpa;
begin
  edtCodigo.Clear;
  edtDescricao.Clear;
  FCodigo := 0;
end;

end.
