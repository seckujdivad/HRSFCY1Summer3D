unit FormMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, FormRenderer, FormDatabase,
  Vcl.ToolWin, Vcl.ActnMan, Vcl.ActnCtrls;

type
  TMainForm = class(TForm)
    PnlParent: TPanel;
    ActionToolBar1: TActionToolBar;
    procedure RdoChoicesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    forms: array[0..1] of TForm;

    procedure OpenToolForm(index: integer);
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.OpenToolForm(index: integer);
begin
  forms[index].Parent := PnlParent;
  forms[index].Show;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  form: TForm;
begin
  forms[0] := TRenderForm.Create(self);
  forms[1] := TDatabaseForm.Create(self);
end;

end.
