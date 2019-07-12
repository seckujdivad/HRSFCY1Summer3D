unit URender;

interface
uses
  Vcl.Graphics, UScene, Generics.Collections, UPointUtils;

type
  TRenderTri = class(TList<TList<real>>)
    private
      tri_col: string;
    public
      property colour: string read tri_col write tri_col;

      constructor Create(triangle: TTriangle; parentObj: TSceneObj);

      procedure ApplyCamera(camera: TCamera);
  end;

  TSimpleScene = TList<TRenderTri>;

  TRender = class
    private
      canvas: TCanvas;
      scene: TScene;

      sceneTris: TSimpleScene;
    public
      constructor Create(renderTo: TCanvas);

      procedure SetScene(newScene: TScene);
      procedure Render;

      procedure ExtractSceneAsTris;
      procedure SceneSpaceToCameraSpace;
  end;

implementation

{ TRender }

constructor TRender.Create(renderTo: TCanvas);
begin
  self.canvas := renderTo;

  self.sceneTris := TSimpleScene.Create;
end;

procedure TRender.ExtractSceneAsTris;
var
  sceneObj: TSceneObj;
  tri: TTriangle;
  render_tri: TRenderTri;
begin
  self.sceneTris.Clear;

  for sceneObj in self.scene do
    for tri in sceneObj do begin
      render_tri := TRenderTri.Create(tri, sceneObj);
      sceneTris.Add(render_tri);
    end;
end;

procedure TRender.Render;
begin
  self.ExtractSceneAsTris;
  self.SceneSpaceToCameraSpace;
end;

procedure TRender.SceneSpaceToCameraSpace;
var
  triangle: TRenderTri;
begin
  for triangle in sceneTris do
    triangle.ApplyCamera(self.scene.camera);
end;

procedure TRender.SetScene(newScene: TScene);
begin
  self.scene := newScene;
end;

{ TRenderTri }

procedure TRenderTri.ApplyCamera(camera: TCamera);
var
  points: TList<real>;
  i: integer;
begin
  for i := 0 to 2 do begin
    self[i] := Transform(self[i], ArrToList(camera.arrayPos));
    self[i] := Rotate(self[i], ArrToList(camera.arrayRot));
  end;
end;

constructor TRenderTri.Create(triangle: TTriangle; parentObj: TSceneObj);
var
 point: TPoint;
 value: real;
 points: TList<real>;
 i: integer;
begin
  inherited Create;

  for point in triangle do begin
    points := TList<integer>.Create;

    for value in point do
      points.Add(value);

    Add(points);
  end;

  for i := 0 to self.Count - 1 do begin
    self[i] := Scale(self[i], ArrToList(parentObj.arrayScale));
    self[i] := Rotate(self[i], ArrToList(parentObj.arrayRot));
    self[i] := Transform(self[i], ArrToList(parentObj.arrayPos));
  end;

end;

end.
