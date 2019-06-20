unit FormMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, FormRenderer, FormDatabase,
  Vcl.ToolWin, Vcl.ActnMan, Vcl.ActnCtrls, System.Actions, Vcl.ActnList,
  Vcl.StdActns, Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnMenus,
  Generics.Collections;

type
  TMainForm = class(TForm)
    PnlParent: TPanel;
    ActmgrMain: TActionManager;
    FileOpen1: TFileOpen;
    ActmenubrMain: TActionMainMenuBar;
    procedure FormCreate(Sender: TObject);
    procedure FileOpen1BeforeExecute(Sender: TObject);
    procedure FileOpen1Accept(Sender: TObject);
  private
    formRender: TRenderForm;

  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.FileOpen1Accept(Sender: TObject);
begin
  ShowMessage(FileOpen1.Dialog.FileName);
end;

procedure TMainForm.FileOpen1BeforeExecute(Sender: TObject);
begin
  formRender.Show;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  formRender := TRenderForm.Create(self);
  formRender.Parent := PnlParent;

  FileOpen1.Dialog.InitialDir := GetCurrentDir + '\scenes\';
end;

end.
