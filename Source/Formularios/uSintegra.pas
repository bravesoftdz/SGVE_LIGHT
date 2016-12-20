unit uSintegra;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uPadrao, StdCtrls, ComCtrls, filectrl, Buttons, ExtCtrls, GeradorSintegra,
  frameBuscaEmpresa, DateUtils;

type
  TfrmSintegra = class(TfrmPadrao)
    GroupBox1: TGroupBox;
    rgFinArq: TRadioGroup;
    btnGerar: TBitBtn;
    GroupBox2: TGroupBox;
    edtCaminho: TEdit;
    StaticText1: TStaticText;
    btnSeleciona: TBitBtn;
    BitBtn2: TBitBtn;
    Label4: TLabel;
    BuscaEmpresa1: TBuscaEmpresa;
    edtAno: TEdit;
    UpDown1: TUpDown;
    cbMes: TComboBox;
    Label6: TLabel;
    Label1: TLabel;
    procedure btnSelecionaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnGerarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    function verifica_obrigatorios :Boolean;
  public
    { Public declarations }
  end;

var
  frmSintegra: TfrmSintegra;

implementation

{$R *.dfm}

procedure TfrmSintegra.btnSelecionaClick(Sender: TObject);
var caminho :String;
begin
  SelectDirectory('Selecione a pasta destino','', caminho);

  if caminho <> '' then
    edtCaminho.Text := caminho;

end;

procedure TfrmSintegra.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = VK_F3 then
    btnGerar.Click;
end;

procedure TfrmSintegra.btnGerarClick(Sender: TObject);
var gerador :TGeradorSintegra;
    nome_arq, resposta :String;
    data_i, data_f :TDateTime;
begin
  try
  try
   if not verifica_obrigatorios then Exit;

   if not confirma('Deseja gerar o arquivo Sintegra?') then exit;

   data_i := strToDate( '01/'+intToStr(cbMes.ItemIndex)+'/'+edtAno.Text );
   data_f := strToDateTime( intToStr(DaysInMonth(data_i) )+ '/' + formatDateTime('mm/yyyy 23:59:59', data_i) );

   self.Aguarda('Gerando arquivo, favor aguarde');

   nome_arq := copy(dateToStr(data_i),4,2)+copy(dateToStr(data_f),7,4)+'_Sintegra.txt';


   Application.ProcessMessages;
   gerador := TGeradorSintegra.create( data_i,
                                       data_f,
                                       (edtCaminho.Text + '\' + nome_arq),
                                       intToStr(rgFinArq.itemIndex + 1){,
                                       BuscaEmpresa1.Empresa});

   gerador.gerarSintegra;
   
   resposta := 'Arquivo gerado com sucesso!';

  except
    on e : Exception do
      begin
        resposta := 'Erro ao gerar arquivo. | '+e.Message;
      end;
   end;

  finally
    self.FimAguarda( resposta );
  end;
end;

function TfrmSintegra.verifica_obrigatorios: Boolean;
begin
  Result := false;

  if not assigned(BuscaEmpresa1.Empresa) then
    Avisar('Selecione a empresa para o filtro dos arquivos')
  else if cbMes.ItemIndex < 1 then
    avisar('Selecione o mês desejado')  
  else
    Result := True;
end;

procedure TfrmSintegra.FormShow(Sender: TObject);
begin
  if not FileExists( ExtractFilePath( Application.ExeName ) + 'sintegra') then
    CreateDir( ExtractFilePath( Application.ExeName ) + 'sintegra' );

  edtCaminho.Text := ExtractFilePath( Application.ExeName ) + 'sintegra';

end;

end.
