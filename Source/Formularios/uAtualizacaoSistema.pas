unit uAtualizacaoSistema;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uPadrao, IdException, IniFiles, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdExplicitTLSClientServerBase, IdFTP, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons, ShellAPI, Vcl.ExtCtrls, Vcl.Mask, RxToolEdit, RxCurrEdit;

type
  TfrmAtualizacaoSistema = class(TfrmPadrao)
    IdFTP1: TIdFTP;
    Shape1: TShape;
    Label2: TLabel;
    Shape2: TShape;
    btnCancela: TBitBtn;
    btnConfirma: TBitBtn;
    Label3: TLabel;
    Label4: TLabel;
    pnlProgresso: TPanel;
    ProgressBar1: TProgressBar;
    Label1: TLabel;
    Shape3: TShape;
    edtVersaoLocal: TCurrencyEdit;
    edtUltimaVersao: TCurrencyEdit;
    Label5: TLabel;
    lbSituacao: TLabel;
    procedure IdFTP1WorkBegin(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
    procedure IdFTP1Work(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCancelaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FnTamanhoTotal: integer;

    function ConectarAoServidorFTP: boolean;
    function ObterNumeroVersaoLocal: smallint;
    function ObterNumeroVersaoFTP: smallint;
    procedure BaixarAtualizacao;
    procedure DescompactarAtualizacao;
    procedure AtualizarNumeroVersao;
    procedure atualizaStatus;
  public
    { Public declarations }
  end;

var
  frmAtualizacaoSistema: TfrmAtualizacaoSistema;

implementation

uses Funcoes, repositorio, fabricarepositorio;

{$R *.dfm}

{ TfrmAtualizacaoSistema }

procedure TfrmAtualizacaoSistema.AtualizarNumeroVersao;
var
  oArquivoLocal, oArquivoFTP: TIniFile;
  sNumeroNovaVersao: string;
  repositorio :TRepositorio;
begin
  // abre os dois arquivos INI
  oArquivoFTP := TIniFile.Create(diretorioExecutavel + 'VersaoFTP.ini');

  try
    // obtém o número da nova versão no arquivo "VersaoFTP.ini"...
    sNumeroNovaVersao := oArquivoFTP.ReadString('VersaoFTP', 'Numero', EmptyStr);

    repositorio := nil;
    repositorio := TFabricaRepositorio.GetRepositorio(fdm.Parametros.ClassName);

    fdm.Parametros.versao_excutavel := strToIntDef(sNumeroNovaVersao,0);
    repositorio.Salvar(fdm.Parametros);
    
    edtVersaoLocal.Text := sNumeroNovaVersao;
  finally
    FreeAndNil(oArquivoFTP);
    FreeAndNil(repositorio);
  end;
end;

procedure TfrmAtualizacaoSistema.atualizaStatus;
begin
  if edtVersaoLocal.AsInteger < edtUltimaVersao.AsInteger then
  begin
    lbSituacao.Caption    := 'Atualização pendente';
    lbSituacao.Font.Color := $00FF8000;
    btnConfirma.Enabled   := true;
  end
  else
  begin
    lbSituacao.Caption    := 'Atualizado';
    lbSituacao.Font.Color := clGreen;
    btnConfirma.Enabled   := false;
  end;
end;

procedure TfrmAtualizacaoSistema.BaixarAtualizacao;
begin
  try
    // deleta o arquivo "Atualizacao.rar", caso exista,
    // evitando erro de arquivo já existente
    if FileExists(diretorioExecutavel + 'SGVE_LIGHT.rar') then
      DeleteFile(diretorioExecutavel + 'SGVE_LIGHT.rar');

    // obtém o tamanho da atualização e preenche a variável "FnTamanhoTotal"
    FnTamanhoTotal := IdFTP1.Size('atualizacao/SGVE_LIGHT.rar');

    pnlProgresso.Visible := true;

    Application.ProcessMessages;

    // faz o download do arquivo "Atualizacao.rar"
    IdFTP1.Get('atualizacao/SGVE_LIGHT.rar',
    diretorioExecutavel + 'SGVE_LIGHT.rar', True, True);

  except
    On E:Exception do
    begin
      // ignora a exceção "Connection Closed Gracefully"
      if E is EIdConnClosedGracefully then
        Exit;

      avisar(0,'Erro ao baixar a atualização: ' + E.Message);

      // interrompe a atualização
      Abort;
    end;
  end;
end;

procedure TfrmAtualizacaoSistema.btnCancelaClick(Sender: TObject);
begin
  self.Close;
end;

procedure TfrmAtualizacaoSistema.btnConfirmaClick(Sender: TObject);
begin
  try
    if edtVersaoLocal.AsInteger < edtUltimaVersao.AsInteger then
    begin
      BaixarAtualizacao;
      DescompactarAtualizacao;
      AtualizarNumeroVersao;

      avisar(1,'Atualização realizada com sucesso!'+#13#10+
               'O sistema será reiniciado.',5);

      ShellExecute(Handle, nil, PWideChar(Application.ExeName) , nil, nil, SW_SHOWNORMAL); //para qq extensao
      Application.Terminate;
    end
    else
      avisar(1,'O sistema já está atualizado.',2);

  finally
     pnlProgresso.Visible := false;
  end;
end;

function TfrmAtualizacaoSistema.ConectarAoServidorFTP: boolean;
begin
  // desconecta, caso tenha sido conectado anteriormente
  if IdFTP1.Connected then
    IdFTP1.Disconnect;
  try
    IdFTP1.Connect;
    result := True;
  except
    On E:Exception do
    begin
      avisar(0,'Erro ao acessar o servidor de atualização: ' + E.Message);
      result := False;
    end;
  end;
end;

procedure TfrmAtualizacaoSistema.DescompactarAtualizacao;
var
  sNomeArquivoAtualizacao, comando, caminhoWinRAR: string;
begin
  // deleta o backup anterior, ou melhor, da versão anterior,
  // evitando erro de arquivo já existente
  if FileExists(diretorioExecutavel + 'SGVE_LIGHT_Backup.exe') then
    DeleteFile(diretorioExecutavel + 'SGVE_LIGHT_Backup.exe');

  // Renomeia o executável atual (desatualizado) para "Sistema_Backup.exe"
  RenameFile(diretorioExecutavel + 'SGVE_LIGHT.exe',
    diretorioExecutavel + 'SGVE_LIGHT_Backup.exe');

  // armazena o nome do arquivo de atualização em uma variável
  sNomeArquivoAtualizacao := diretorioExecutavel + 'SGVE_LIGHT.rar';

  if FileExists(diretorioExecutavel+'WinRAR.exe') then
    caminhoWinRAR := diretorioExecutavel+'WinRAR.exe'
  else if FileExists('C:\Program Files\WinRAR\WinRAR.exe') then
    caminhoWinRAR := 'C:\Program Files\WinRAR\WinRAR.exe';

  // executa a linha de comando do 7-Zip para descompactar o arquivo baixado
  comando := ' x ' + sNomeArquivoAtualizacao + ' ' + '*.exe' + ' ' + diretorioExecutavel;

  ShellExecute(0, 'open', PChar(caminhoWinRAR), PChar(comando), '', SW_HIDE);
end;

procedure TfrmAtualizacaoSistema.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (key = VK_F4) and (btnConfirma.Enabled) then
    btnConfirma.Click;
end;

procedure TfrmAtualizacaoSistema.FormShow(Sender: TObject);
begin
  try
    Aguarda('Realizando conexão com o servidor');
    Application.ProcessMessages;

    if not ConectarAoServidorFTP then
      Exit;

    edtVersaoLocal.AsInteger  := ObterNumeroVersaoLocal;
    edtUltimaVersao.AsInteger := ObterNumeroVersaoFTP;

    atualizaStatus;

  finally
    FimAguarda();
  end;
end;

procedure TfrmAtualizacaoSistema.IdFTP1Work(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
var
  nTamanhoTotal, nTransmitidos, nPorcentagem: real;
begin
  if FnTamanhoTotal = 0 then
    Exit;

  Application.ProcessMessages;

  // obtém o tamanho total do arquivo em bytes
  nTamanhoTotal := FnTamanhoTotal div 1024;

  // obtém a quantidade de bytes já baixados
  nTransmitidos := AWorkCount div 1024;

  // calcula a porcentagem de download
  nPorcentagem := (nTransmitidos * 100) / nTamanhoTotal;

  // atualiza o componente TLabel com a porcentagem
  Label1.Caption := 'Baixando última versão do sistema - '+Format('%s%%', [FormatFloat('##0', nPorcentagem)]);

  // atualiza a barra de preenchimento do componente TProgressBar
  ProgressBar1.Position := AWorkCount div 1024;
end;

procedure TfrmAtualizacaoSistema.IdFTP1WorkBegin(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
begin
  ProgressBar1.Max := FnTamanhoTotal div 1024;
end;

function TfrmAtualizacaoSistema.ObterNumeroVersaoFTP: smallint;
var
  sNumeroVersao: string;
  oArquivoINI: TIniFile;
begin
  // deleta o arquivo "VersaoFTP.ini" do computador, caso exista,
  // evitando erro de arquivo já existente
  if FileExists(diretorioExecutavel + 'VersaoFTP.ini') then
    DeleteFile(diretorioExecutavel + 'VersaoFTP.ini');

  // baixa o arquivo "VersaoFTP.ini" para o computador
  IdFTP1.Get('atualizacao/VersaoFTP.ini', diretorioExecutavel + 'VersaoFTP.ini', True, True);

  // abre o arquivo "VersaoFTP.ini"
  oArquivoINI := TIniFile.Create(diretorioExecutavel + 'VersaoFTP.ini');
  try
    // lê o número da versão
    sNumeroVersao := oArquivoINI.ReadString('VersaoFTP', 'Numero', EmptyStr);

    // retira os pontos (exemplo: de "1.0.1" para "101")
    sNumeroVersao := StringReplace(sNumeroVersao, '.', EmptyStr, [rfReplaceAll]);

    // converte o número da versão para número
    result := StrToIntDef(sNumeroVersao, 0);
  finally
    FreeAndNil(oArquivoINI);
  end;
end;

function TfrmAtualizacaoSistema.ObterNumeroVersaoLocal: smallint;
begin
  result := fdm.Parametros.versao_excutavel;
end;

end.
