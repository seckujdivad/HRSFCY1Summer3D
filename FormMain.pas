unit FormMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, FormRenderer, FormDatabase,
  Vcl.ToolWin, Vcl.ActnMan, Vcl.ActnCtrls, System.Actions, Vcl.ActnList,
  Vcl.StdActns, Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnMenus,
  Generics.Collections, Vcl.ButtonGroup;

type
  TMainForm = class(TForm)
    PnlParent: TPanel;
    ActmgrMain: TActionManager;
    FileOpen1: TFileOpen;
    ActmenubrMain: TActionMainMenuBar;
    BtngrpTools: TButtonGroup;
    procedure FormCreate(Sender: TObject);
    procedure FileOpen1Accept(Sender: TObject);
    procedure ButtonGroup1Items0Click(Sender: TObject);

  private
    forms: TList<TForm>;

  public
    function GetToolWindow(index: integer): TForm;
    function MakeToolWindow(name: string): integer;
    procedure RemoveApp(index: integer);

  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.ButtonGroup1Items0Click(Sender: TObject);
begin
  MakeToolWindow('render');
end;

procedure TMainForm.FileOpen1Accept(Sender: TObject);
begin
  ShowMessage(FileOpen1.Dialog.FileName);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  forms := TList<TForm>.Create;

  FileOpen1.Dialog.InitialDir := GetCurrentDir + '\scenes\';
end;

function TMainForm.GetToolWindow(index: integer): TForm;
begin
  result := forms[index];
end;

function TMainForm.MakeToolWindow(name: string): integer;
begin
  if name = 'render' then
    forms.Add(TRenderForm.Create(self));

  forms.Last.Parent := PnlParent;
  forms.Last.Show;
end;

procedure TMainForm.RemoveApp(index: integer);
begin
  forms[index].Hide;
  forms[index].Destroy;
end;

end.
