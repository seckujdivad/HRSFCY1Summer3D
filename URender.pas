unit URender;

interface
uses
  Vcl.Graphics, UScene;

type
  TRender = class
    private
      canvas: TCanvas;
      scene: TScene;
    public
      constructor Create(renderTo: TCanvas);

      procedure SetScene(newScene: TScene);
  end;

implementation

{ TRender }

constructor TRender.Create(renderTo: TCanvas);
begin
  self.canvas := renderTo;
end;

procedure TRender.SetScene(newScene: TScene);
begin
  self.scene := newScene;
end;

end.
