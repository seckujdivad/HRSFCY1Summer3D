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
    renderForms: TList<TRenderForm>;

  public
    function GetToolWindow(index: integer; ftype: string): TForm;
    function MakeToolWindow(ftype: string): integer;
    procedure RemoveApp(index: integer; ftype: string);

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
var
  renderForm: TRenderForm;
begin
  for renderForm in renderForms do begin
    renderForm.SetScene(FileOpen1.Dialog.FileName);
  end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  renderForms := TList<TRenderForm>.Create;

  FileOpen1.Dialog.InitialDir := GetCurrentDir + '\scenes\';
end;

function TMainForm.GetToolWindow(index: integer; ftype: string): TForm;
begin
  if ftype = 'render' then
    result := renderForms[index];
end;

function TMainForm.MakeToolWindow(ftype: string): integer;
begin
  if ftype = 'render' then begin
    renderForms.Add(TRenderForm.Create(self));

    renderForms.Last.Parent := PnlParent;
    renderForms.Last.Show;
  end;
end;

procedure TMainForm.RemoveApp(index: integer; ftype: string);
begin
  if ftype = 'render' then begin
    renderForms[index].Hide;
    renderForms[index].Free;
  end;
end;

end.
