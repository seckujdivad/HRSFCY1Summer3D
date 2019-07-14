unit FormRenderer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, URender, Vcl.StdCtrls,
  UScene, Data.FMTBcd, Data.DB, Data.SqlExpr, Data.DbxSqlite;

type
  TRenderForm = class(TForm)
    RenderOutput: TPaintBox;
    BtnRender: TButton;
    LblStatus: TLabel;
    SQLConnScene: TSQLConnection;
    SQLQueryScene: TSQLQuery;
    RdoMethod: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure BtnRenderClick(Sender: TObject);
  private
    renderer: TRender;
    scene: TScene;

    procedure ClearCanvas;
  public
    procedure SetScene(path: string);
  end;

var
  RenderForm: TRenderForm;

implementation

{$R *.dfm}

procedure TRenderForm.BtnRenderClick(Sender: TObject);
begin
  ClearCanvas;
  self.renderer.Render(RdoMethod.ItemIndex);
  self.scene.camera.rot[0] := self.scene.camera.rot[0] + 1;
  //ShowMessage(IntToStr(Trunc(self.scene.camera.rot[0])));
end;

procedure TRenderForm.ClearCanvas;
begin
  RenderOutput.Canvas.Brush.Color := clWhite;
  RenderOutput.Canvas.Pen.Color := clWhite;
  RenderOutput.Canvas.Rectangle(0, 0, RenderOutput.Width - 1, RenderOutput.Height - 1);
end;

procedure TRenderForm.FormCreate(Sender: TObject);
begin
  self.renderer := TRender.Create(RenderOutput);
end;

procedure TRenderForm.SetScene(path: string);
begin
  self.scene := TScene.Create(path, SQLConnScene, SQLQueryScene);
  self.renderer.SetScene(self.scene);
end;

end.
