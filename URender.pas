unit URender;

interface
uses
  Vcl.Graphics, UScene, Generics.Collections, UPointUtils,
  System.Generics.Defaults, Vcl.Dialogs, SysUtils, System.Types, Vcl.ExtCtrls,
  System.Math;

type
  TRenderTri = class(TList<TPointList>)
    private
      tri_col: string;

      function GetZ: real;

      procedure MapCoords(var x, y: integer; canvas: TPaintBox);

    public
      property colour: string read tri_col write tri_col;
      property z: real read GetZ;

      constructor Create(triangle: TTriangle; parentObj: TSceneObj);

      procedure ApplyCamera(camera: TCamera);
      procedure Project(canvas: TPaintBox; mode: integer);
  end;

  TSimpleScene = TList<TRenderTri>;

  TRender = class
    private
      canvas: TPaintBox;
      scene: TScene;
      sceneTris: TSimpleScene;

      procedure ExtractSceneAsTris;
      procedure SceneSpaceToCameraSpace;
      procedure ZBuffer;
      function CompareTris(tri0, tri1: TRenderTri): integer;
    public
      constructor Create(renderTo: TPaintBox);

      procedure SetScene(newScene: TScene);
      procedure Render(mode: integer);
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

constructor TRender.Create(renderTo: TPaintBox);
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

procedure TRender.Render(mode: integer);
var
  triangle: TRenderTri;
begin
  for triangle in sceneTris do
    triangle.Free;
  sceneTris.Clear;

  self.ExtractSceneAsTris;
  self.SceneSpaceToCameraSpace;
  self.ZBuffer;

  for triangle in sceneTris do
    triangle.Project(self.canvas, mode);
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
    self[i].Transform(self[i].Multiply(camera.arrayPos, -1));
    self[i].Rotate(self[i].Multiply(camera.arrayRot, -1));
  end;
end;

constructor TRenderTri.Create(triangle: TTriangle; parentObj: TSceneObj);
var
 value: real;
 points: TPointList;
 i: integer;
begin
  inherited Create;

  for i := 0 to 2 do begin
    points := TPointList.Create;

    for value in triangle.arrayPoints[i] do
      points.Add(value);

    Add(points);
  end;

  for i := 0 to 2 do begin
    self[i].Scale(parentObj.arrayScale);
    self[i].Rotate(parentObj.arrayRot);
    self[i].Transform(parentObj.arrayPos);
  end;

  colour := triangle.mat_col;
end;

function TRenderTri.GetZ: real; //find the mean z coordinate (only relevant in cam space)
var
 point: TList<real>;
begin
  result := 0;

  for point in self do
    result := result + point[2];

  result := result / Count;
end;

procedure TRenderTri.MapCoords(var x, y: integer; canvas: TPaintBox);
begin
  x := x + (canvas.Width DIV 2);
  y := y + (canvas.Height DIV 2);
end;

procedure TRenderTri.Project(canvas: TPaintBox; mode: integer);
var
  arrayPoints: array[0..2] of TPoint;
  i: integer;
  pointList: TPointList;
  x, y: real;
  screen_x, screen_y: integer;
begin
  for i := 0 to 2 do begin
    //self[i].ShowPointsAsMessage;

    if mode = 0 then begin //ortho
      x := self[i][0] * 20;
      y := self[i][1] * 20;

    end else if mode = 1 then begin //proper perspective
      x := Tan(self[i][0] / self[i][2]);
      y := Tan(self[i][1] / self[i][2]);

      x := RadToDeg(x) / 45;
      y := RadToDeg(y) / 45;

      //ShowMessage('SCREEN X: ' + IntToStr(Trunc(x * 100)) + '% Y: ' + IntToStr(Trunc(y * 100)) + '%');

      x := x * canvas.Width * 0.5;
      y := y * canvas.Height * 0.5;

      x := (canvas.Width / 2) + x;
      y := (canvas.Height / 2) - y;

    end else if mode = 2 then begin //weak perspective
      x := self[i][0] * self[i][2];
      y := self[i][1] * self[i][2];
    end;

    screen_x := Trunc(x);
    screen_y := Trunc(y);

    if (mode = 0) or (mode = 2) then
       self.MapCoords(screen_x, screen_y, canvas);

    //ShowMessage('X: ' + IntToStr(screen_x) + ' Y: ' + IntToStr(screen_y));

    arrayPoints[i] := Point(screen_x, screen_y);
  end;

  canvas.Canvas.Pen.Color := StringToColor('$00' + colour);
  canvas.Canvas.Brush.Color := canvas.Canvas.Pen.Color;

  canvas.Canvas.Polygon(arrayPoints)
end;

end.
