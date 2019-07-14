unit FormRenderer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, URender, Vcl.StdCtrls,
  UScene, Data.FMTBcd, Data.DB, Data.SqlExpr, Data.DbxSqlite, Vcl.ComCtrls;

type
  TRenderForm = class(TForm)
    RenderOutput: TPaintBox;
    BtnRender: TButton;
    LblStatus: TLabel;
    SQLConnScene: TSQLConnection;
    SQLQueryScene: TSQLQuery;
    RdoMethod: TRadioGroup;
    TrkX: TTrackBar;
    TrkY: TTrackBar;
    TrkZ: TTrackBar;
    Label1: TLabel;
    LblY: TLabel;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure BtnRenderClick(Sender: TObject);
    procedure TrkXChange(Sender: TObject);
    procedure TrkYChange(Sender: TObject);
    procedure TrkZChange(Sender: TObject);
  private
    renderer: TRender;
    scene: TScene;

    procedure ClearCanvas;
    procedure RenderScene;
  public
    procedure SetScene(path: string);
  end;

var
  RenderForm: TRenderForm;

implementation

{$R *.dfm}

procedure TRenderForm.BtnRenderClick(Sender: TObject);
begin
  self.RenderScene;
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

procedure TRenderForm.RenderScene;
begin
  ClearCanvas;
  self.renderer.Render(RdoMethod.ItemIndex);
end;

procedure TRenderForm.SetScene(path: string);
begin
  self.scene := TScene.Create(path, SQLConnScene, SQLQueryScene);
  self.renderer.SetScene(self.scene);

  self.RenderScene;
end;

procedure TRenderForm.TrkXChange(Sender: TObject);
begin
  self.scene[0].rot[0] := TrkX.Position;
  self.RenderScene;
end;

procedure TRenderForm.TrkYChange(Sender: TObject);
begin
  self.scene[0].rot[1] := TrkY.Position;
  self.RenderScene;
end;

procedure TRenderForm.TrkZChange(Sender: TObject);
begin
  self.scene[0].rot[2] := TrkZ.Position;
  self.RenderScene;
end;

end.
