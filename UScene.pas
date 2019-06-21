unit UScene;

interface
uses
  Generics.Collections;

type
  TPoint = array[0..2] of real;
  TTriPoints = array[0..2] of TPoint;

  TTriangle = class
    private
      tri_points: TTriPoints;
    public
      property points: TTriPoints read tri_points write tri_points;
  end;

  TSceneObj = class(TList<TTriangle>)
    private
      o_pos, o_rot, o_scale: TPoint;
    public
      property pos: TPoint read o_pos write o_pos;
      property rot: TPoint read o_rot write o_rot;
      property scale: TPoint read o_scale write o_scale;
  end;

  TCamera = class
    private
      cam_pos: TPoint;
      cam_aspect: real;
    public
      property pos: TPoint read cam_pos write cam_pos;
      property aspect: real read cam_aspect write cam_aspect;

      procedure SetAspectRatio(x, y: integer);
  end;

  TScene = class(TList<TSceneObj>)
    private
      scene_cam: TCamera;
      path: string;
    public
      constructor Create(scenePath: string);
  end;


implementation

{ TCamera }

procedure TCamera.SetAspectRatio(x, y: integer);
begin
  aspect := y / x;
end;

{ TScene }

constructor TScene.Create(scenePath: string);
begin
  path := scenePath;
end;

end.
