unit uTelaDesbloqueio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, uPadrao;

type
  TfrmTelaDesbloqueio = class(TFrmPadrao)
    edtSenha: TEdit;
    Shape2: TShape;
    Shape1: TShape;
    btnConfirma: TBitBtn;
    memMsg: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    btnCancela: TBitBtn;
    procedure edtSenhaEnter(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    FTentativas :integer;

    function geraSenha2(dData :TDate; tHora: TTime): String;
    function geraSenha(dData :TDate): String;
    function Val(S:String): Integer;
    function StrZero(nNumero,Qt: Int64): String;
    function Replicate(S: String; qt: Integer): String;
    function Right(s : string; k : integer): string;
    function Arredonda(Valor:Extended;Decimais:Integer):Extended;
    function TimeStr(tHora: TTime; cSep: String = ':'): String;
    function DateStr(dData: TDateTime; cSep: String = '/'; nQtAno: Integer = 4; nTip: Integer = 1):String;
    function DLeft(S: String; qt: Integer): String;
  public
    constructor Create         (AOwner :TComponent; Mensagem :String); overload;
  end;

var
  frmTelaDesbloqueio: TfrmTelaDesbloqueio;

implementation

uses Criptografia;

{$R *.dfm}

{ TfrmTelaDesbloqueio }

procedure TfrmTelaDesbloqueio.btnCancelaClick(Sender: TObject);
begin
  self.ModalResult := mrCancel;
end;

procedure TfrmTelaDesbloqueio.btnConfirmaClick(Sender: TObject);
begin
  if edtSenha.Text = geraSenha(Date) then
  begin
    self.ModalResult := mrOk;
    exit;
  end
  else
  begin
    inc(FTentativas);
    avisar(1,'Senha incorreta!',2);
    edtSenha.SetFocus;
    if FTentativas < 3 then
      exit;
  end;

  self.ModalResult := mrCancel;
end;

constructor TfrmTelaDesbloqueio.Create(AOwner: TComponent; Mensagem: String);
begin
  inherited Create(AOwner);
  memMsg.Lines.Add( Mensagem );
  memMsg.Lines.Add( #13#10'FONE: (43)3534-2350' );
  FTentativas := 0;
end;

procedure TfrmTelaDesbloqueio.edtSenhaEnter(Sender: TObject);
begin
  edtSenha.SelectAll;
end;

procedure TfrmTelaDesbloqueio.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = vk_return then
    btnConfirma.Click;
  inherited;
end;

function TfrmTelaDesbloqueio.geraSenha(dData: TDate): String;
var encripted :Extended;
    encriptedStr, dataint   :String;
begin
  dataint      := StringReplace( DateToStr(dData),'/','',[rfReplaceAll, rfIgnoreCase]);
  encripted    := StrToFloat(TCriptografia.codigoInteiroDaData(dataint));
  encripted    := encripted/99;
  encriptedStr := FloatToStr(encripted);
  result       := copy(encriptedStr,length(encriptedStr)-6,5);
end;

function TfrmTelaDesbloqueio.geraSenha2(dData :TDate; tHora: TTime): String;
var cSenha,cData,cHora: String;
begin
  cHora  := TimeStr(tHora);
  cData  := DateStr(dData);

  cHora  := DLeft(cHora,5);

  cSenha := '';

  cSenha := cSenha + StrZero(Val(FloatToStr((Val(DLeft(cHora,2)) / 3))),1);

  cSenha := cSenha + Right(cHora,1);
  cSenha := cSenha + StrZero(Val(FloatToStr(Int(Val(DLeft(cHora,2)) / 4))) ,1);
  cSenha := cSenha + StrZero(Val(FloatToStr(Int(Val(Copy(cData,4,2)) / 2))),1);

  Result := cSenha;
end;


function TfrmTelaDesbloqueio.Val(S:String): Integer;
var Ver: Boolean;
    nX : Integer;
    Resultado: String;
begin
  Ver := True;
  nX  := 1;
  Resultado := '';
  While Ver Do
    begin
      If S[nX] in ['0'..'9','.',','] Then
        Resultado := Resultado + S[nX]
      Else
        Ver := False;
      Inc(nX);
    end;
  If Resultado = '' Then
    Result := 0
  Else
    begin
      Result := StrToInt(FloatToStr(Arredonda(StrToFloat(Resultado),0)));
    end;
end;

function TfrmTelaDesbloqueio.StrZero(nNumero,Qt: Int64): String;
var cNumero: String;
begin
  cNumero := IntToStr(nNumero);
  If Length(cNumero) > Qt Then
    cNumero := Replicate('*',QT)
  Else If Length(cNumero) < Qt Then
    begin
      While Length(cNumero) < Qt Do
        cNumero := '0' + cNumero;
    end;
  Result := cNumero
end;

function TfrmTelaDesbloqueio.Replicate(S: String; qt: Integer): String;
var n: Integer;
Var c: String;
begin
  c := '';
  C := S;
  For n := 1 To Qt - 1 Do
    S := S + C;

  Result := S;
end;

function TfrmTelaDesbloqueio.Right(s : string; k : integer): string;
var temp : integer;
begin
  temp := Length(s);
  Result := Copy(s, temp - k + 1, k);
end;

function TfrmTelaDesbloqueio.Arredonda(Valor:Extended;Decimais:Integer):Extended;
var
  I:Integer;
  Multiplicador:Integer;
begin
  if Decimais > 15 then
     begin
     Decimais := 15;
     end
  else if Decimais < 0 then
          begin
          Decimais := 0;
          end;
  Multiplicador := 1;
  for I:=1 to Decimais do
      begin
      Multiplicador := Multiplicador*10;
      end;
  Result := round(Valor*Multiplicador)/Multiplicador;
end;

function TfrmTelaDesbloqueio.TimeStr(tHora: TTime; cSep: String = ':'): String;
var
  Hora,Min,Sec,mSec: Word;
begin
  DecodeTime(tHora,Hora,Min,Sec,mSec);
  Result := StrZero(Hora,2) + cSep + StrZero(Min,2) + cSep + StrZero(Sec,2);
end;

function TfrmTelaDesbloqueio.DateStr(dData: TDateTime; cSep: String = '/'; nQtAno: Integer = 4; nTip: Integer = 1):String;
var Dia,Mes,Ano: Word;
begin
  DecodeDate(dData,Ano,Mes,Dia);

  If nTip = 1 Then
    begin
      If nQtAno = 4 Then
        Result := StrZero(Dia,2) + cSep + StrZero(Mes,2) + cSep + StrZero(Ano,4)
      Else If nQtAno = 2 Then
        Result := StrZero(Dia,2) + cSep + StrZero(Mes,2) + cSep + StrZero(StrToInt(Right(StrZero(Ano,4),2)),2)
      Else
        Result := StrZero(Dia,2) + cSep + StrZero(Mes,2) + cSep + StrZero(Ano,4);
    end
  Else
    begin
      If nQtAno = 4 Then
        Result := StrZero(Ano,4) + cSep + StrZero(Mes,2) + cSep + StrZero(Dia,2)
      Else If nQtAno = 2 Then
        Result := StrZero(StrToInt(Right(StrZero(Ano,4),2)),2) + cSep + StrZero(Mes,2) + cSep + StrZero(Dia,2)
      Else
        Result := StrZero(Ano,4) + cSep + StrZero(Mes,2) + cSep + StrZero(Dia,2)
    end;
end;

function TfrmTelaDesbloqueio.DLeft(S: String; qt: Integer): String;
begin
  Result := Copy(S,1,qt);
end;

end.
