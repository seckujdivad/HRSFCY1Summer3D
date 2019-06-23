program Summer3D;

uses
  Vcl.Forms,
  FormRenderer in 'FormRenderer.pas' {RenderForm},
  URender in 'URender.pas',
  UScene in 'UScene.pas',
  FormDatabase in 'FormDatabase.pas' {DatabaseForm},
  FormMain in 'FormMain.pas' {MainForm},
  UFormContainers in 'UFormContainers.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TRenderForm, RenderForm);
  Application.CreateForm(TDatabaseForm, DatabaseForm);
  Application.Run;
end.
