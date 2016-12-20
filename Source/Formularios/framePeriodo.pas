unit framePeriodo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls;

type
  TPeriodo = class(TFrame)
    dtpInicio: TDateTimePicker;
    dtpFim: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    procedure dtpInicioChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TPeriodo.dtpInicioChange(Sender: TObject);
begin
  if dtpFim.DateTime < dtpInicio.DateTime then
    dtpFim.DateTime := dtpInicio.DateTime;
end;

end.
