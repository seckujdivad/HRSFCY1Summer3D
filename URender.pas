unit URender;

interface
uses
  Vcl.Graphics, UScene, Generics.Collections, UPointUtils,
  System.Generics.Defaults;

type
  TRenderTri = class(TList<TList<real>>)
    private
      tri_col: string;

      function GetZ: real;
    public
      property colour: string read tri_col write tri_col;
      property z: real read GetZ;

      constructor Create(triangle: TTriangle; parentObj: TSceneObj);

      procedure ApplyCamera(camera: TCamera);
  end;

  TSimpleScene = TList<TRenderTri>;

  TRender = class
    private
      canvas: TCanvas;
      scene: TScene;
      sceneTris: TSimpleScene;

      procedure ExtractSceneAsTris;
      procedure SceneSpaceToCameraSpace;
      procedure ZBuffer;
      function CompareTris(tri0, tri1: TRenderTri): integer;
    public
      constructor Create(renderTo: TCanvas);

      procedure SetScene(newScene: TScene);
      procedure Render;
  end;

implementation

{ TRender }

function TRender.CompareTris(tri0, tri1: TRenderTri): integer;
var
  z0, z1: real;
begin
  z0 := tri0.z;
  z1 := tri1.z;

  if z0 < z1 then
    result := 1
  else if z0 > z1 then
    result := -1
  else
    result := 0;
end;

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
  self.ZBuffer;
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

procedure TRender.ZBuffer;
begin
  sceneTris.Sort(TComparer<TRenderTri>.Construct(function(const tri0, tri1: TRenderTri): integer
    var
      z0, z1: real;
    begin
    z0 := tri0.z;
    z1 := tri1.z;

    if z0 < z1 then
      result := 1
    else if z0 > z1 then
      result := -1
    else
      result := 0;
  end));
end;

{ TRenderTri }

procedure TRenderTri.ApplyCamera(camera: TCamera);
var
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
 i, j: integer;
begin
  inherited Create;

  for i := 0 to 2 do begin
    points := TList<real>.Create;

    for value in triangle.arrayPoints[i] do
      points.Add(value);

    Add(points);
  end;

  for i := 0 to 2 do begin
    Items[i] := Scale(Items[i], ArrToList(parentObj.arrayScale));
    Items[i] := Rotate(Items[i], ArrToList(parentObj.arrayRot));
    Items[i] := Transform(Items[i], ArrToList(parentObj.arrayPos));
  end;

end;

function TRenderTri.GetZ: real;
var
 point: TList<real>;
begin
  result := 0;

  for point in self do
    result := result + point[2];

  result := result / Count;
end;

end.
