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
    procedure FormCreate(Sender: TObject);
    procedure BtnRenderClick(Sender: TObject);
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

procedure TRenderForm.BtnRenderClick(Sender: TObject);
begin
  self.renderer.Render;
end;

procedure TRenderForm.FormCreate(Sender: TObject);
begin
  self.renderer := TRender.Create(RenderOutput.Canvas);
end;

procedure TRenderForm.SetScene(path: string);
begin
  self.scene := TScene.Create(path, SQLConnScene, SQLQueryScene);
  self.renderer.SetScene(self.scene);

  LblStatus.Caption := path;
end;

end.
