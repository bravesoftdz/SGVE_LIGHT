unit uPesquisaSimples;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uPadrao, StdCtrls, Buttons, ExtCtrls, Grids, DBGrids, DBGridCBN,
  Provider, DB, DBClient;

type
  TfrmPesquisaSimples = class(TfrmPadrao)
    Panel1: TPanel;
    btnSeleciona: TBitBtn;
    btnCancela: TBitBtn;
    ds: TDataSource;
    DBGrid1: TDBGridCBN;
    Label1: TLabel;
    Shape1: TShape;
    lbQtdRegistros: TLabel;
    cds: TClientDataSet;
    dsp: TDataSetProvider;
    Timer1: TTimer;
    procedure btnCancelaClick(Sender: TObject);
    procedure btnSelecionaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    Campo :String;
    Fcds_retorno :TClientDataSet;

    procedure adiciona_remove(valor :String);

  public
    constructor Create(AOwner: TComponent; SQL, campoRetorno :String; const titulo :String = '';
                       const largura_form :Integer = 670; const altura_form :Integer = 330); overload; virtual;
    destructor Destroy; override;

    property cds_retorno :TClientDataSet read Fcds_retorno;

  end;

var
  frmPesquisaSimples: TfrmPesquisaSimples;

implementation

{$R *.dfm}

{ TfrmPadrao1 }

constructor TfrmPesquisaSimples.Create(AOwner: TComponent; SQL, campoRetorno :String; const titulo :String;
             const largura_form :Integer; const altura_form :Integer);
var i :integer;
begin
  self.Create(AOwner);
  Campo := CampoRetorno;

  if titulo <> '' then   self.Caption := titulo;

  self.Width  := largura_form;
  self.Height := altura_form;

  Fcds_retorno := TClientDataSet.Create(nil);

  Fcds_retorno.Close;
  Fcds_retorno.FieldDefs.Clear;
  Fcds_retorno.FieldDefs.add(Campo, ftString, 100, false);
  Fcds_retorno.CreateDataSet;
  Fcds_retorno.Open;

  dsp.DataSet := FDM.GetConsulta(SQL);
  cds.Open;

  for i:= 0 to cds.Fields.Count -1 do
  begin
    if cds.Fields[i].DataType in [ftFloat, ftBCD] then
      TNumericField(cds.Fields[i]).DisplayFormat := ' ,0.00; -,0.00';
    if cds.Fields[i].FieldName = 'ATIVO' then
      cds.Fields[i].Visible:= False;
  end;


  for i := 0 to DBGrid1.Columns.Count -1 do
    if DBGrid1.Columns[i].Title.Caption = 'DESCRICAO' then
       DBGrid1.Columns[i].Width := 470;


 // cds.RecNo      := 1;

  lbQtdRegistros.Caption := IntToStr( cds.RecordCount )+' registros foram encontrados.';

end;

procedure TfrmPesquisaSimples.btnCancelaClick(Sender: TObject);
begin
  inherited;
  self.ModalResult := mrCancel;
end;

procedure TfrmPesquisaSimples.btnSelecionaClick(Sender: TObject);
begin
  inherited;

  if cds.IsEmpty then
  begin
     self.ModalResult := mrCancel;
     exit;
  end;

  if Fcds_retorno.IsEmpty then
     adiciona_remove( cds.FieldByName(campo).AsString );

  Fcds_retorno.First;   

  self.ModalResult := mrOk;
end;

procedure TfrmPesquisaSimples.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = vk_return then begin
    key := 0;
    btnSeleciona.Click;
  end
  else if key = vk_escape then begin
    key := 0;
    btnCancela.Click;
  end;  

  inherited;

end;

procedure TfrmPesquisaSimples.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  try
    if cds.FieldByName('ATIVO').AsString = 'N' then
    begin
      TDBgridCBN(Sender).Canvas.Font.Color := clRed;
      TDBgridCBN(Sender).Canvas.Font.Style  := [fsBold];
      TDBGridCBN(Sender).Canvas.FillRect(Rect);
      TDBGridCBN(Sender).DefaultDrawDataCell(Rect,Column.Field,State);
    end;
  except
  end;

  if Fcds_retorno.Locate(campo, cds.FieldByName(campo).AsString, []) then begin
    TDBgridCBN(Sender).Canvas.Brush.Color := clSkyBlue;
    TDBgridCBN(Sender).Canvas.FillRect(Rect);
    TDBgridCBN(Sender).Canvas.TextOut(Rect.Left+2,Rect.Top,Column.Field.AsString);
  end;

end;

destructor TfrmPesquisaSimples.Destroy;
var
  Dataset :TDataset;
begin
  Dataset := dsp.DataSet;

  if Assigned(Dataset) then
    FreeAndNil(Dataset);

  inherited;
end;

procedure TfrmPesquisaSimples.adiciona_remove(valor: String);
begin
  if Fcds_retorno.Locate(campo, valor, []) then
    Fcds_retorno.Delete
  else begin
    Fcds_retorno.Append;
    Fcds_retorno.FieldByName(campo).AsString := valor;
    Fcds_retorno.Post;
  end;
end;

procedure TfrmPesquisaSimples.DBGrid1DblClick(Sender: TObject);
begin
  adiciona_remove( cds.FieldByName(campo).AsString );
  dbgrid1.Repaint;
end;

procedure TfrmPesquisaSimples.FormShow(Sender: TObject);
begin
{  btnCancela.SetFocus;
  Dbgrid1.SelectedIndex := 0; // Primeiro indique qual coluna do grid voce quer se posicionar.
  Dbgrid1.SetFocus;

  cds.FieldByName(DBGrid1.Columns[DBGrid1.Columns.Count-1].FieldName).focusControl;}
end;

procedure TfrmPesquisaSimples.Timer1Timer(Sender: TObject);
begin
  Dbgrid1.SelectedIndex := 0;
  Timer1.Enabled := false;
end;

end.
