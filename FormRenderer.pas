unit FormRenderer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, URender, Vcl.StdCtrls,
  UScene;

type
  TRenderForm = class(TForm)
    RenderOutput: TPaintBox;
    BtnRender: TButton;
    LblStatus: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    renderer: TRender;
    scene: TScene;
  public
    procedure SetScene(path: string);
  end;

var
  RenderForm: TRenderForm;

implementation

{$R *.dfm}

procedure TRenderForm.FormCreate(Sender: TObject);
begin
  self.renderer := TRender.Create(RenderOutput.Canvas);
end;

procedure TRenderForm.SetScene(path: string);
begin
  self.scene := TScene.Create(path);

  LblStatus.Caption := path;
end;

end.
