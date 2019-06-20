unit FormMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, FormRenderer, FormDatabase;

type
  TMainForm = class(TForm)
    RdoChoices: TRadioGroup;
    PnlParent: TPanel;
    procedure RdoChoicesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    forms: array[0..1] of TForm;
    currentFormIndex: integer;

    procedure ChoosePanel(index: integer);
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.ChoosePanel(index: integer);
begin
  currentFormIndex := index;
  forms[currentFormIndex].Parent := PnlParent;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  currentFormIndex := 0;
  forms[0] := TRenderForm.Create(self);
  forms[1] := TDatabaseForm.Create(self);

  ChoosePanel(currentFormIndex);
end;

procedure TMainForm.RdoChoicesClick(Sender: TObject);
begin
  ChoosePanel(RdoChoices.ItemIndex);
end;

end.
