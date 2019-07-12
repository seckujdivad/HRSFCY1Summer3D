unit URender;

interface
uses
  Vcl.Graphics, UScene, Generics.Collections;

type
  TRenderTri = class(TList<TList<real>>)
    private
      tri_col: string;
    public
      property colour: string read tri_col write tri_col;
  end;

  TSimpleScene = TList<TRenderTri>;

  TRender = class
    private
      canvas: TCanvas;
      scene: TScene;
    public
      constructor Create(renderTo: TCanvas);

      procedure SetScene(newScene: TScene);
      procedure Render;
  end;

implementation

{ TRender }

constructor TRender.Create(renderTo: TCanvas);
begin
  self.canvas := renderTo;
end;

procedure TRender.Render;
begin

end;

procedure TRender.SetScene(newScene: TScene);
begin
  self.scene := newScene;
end;

end.
