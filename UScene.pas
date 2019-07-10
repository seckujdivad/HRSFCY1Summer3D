unit UScene;

interface
uses
  Generics.Collections, Data.FMTBcd, Data.DB, Data.SqlExpr, Vcl.Dialogs;

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

      dbConn: TSQLConnection;
      dbQuery: TSQLQuery;
      dbOngoingQuery: boolean;

      procedure LoadScene;
      procedure QueryDB(query: string); overload;
      procedure QueryDB(query: string; hasResult: boolean); overload;
      procedure ReleaseDB;
    public
      constructor Create(scenePath: string; conn: TSQLConnection; query: TSQLQuery);
  end;


implementation

{ TCamera }

procedure TCamera.SetAspectRatio(x, y: integer);
begin
  aspect := y / x;
end;

{ TScene }

constructor TScene.Create(scenePath: string; conn: TSQLConnection; query: TSQLQuery);
begin
  path := scenePath;

  dbConn := conn;
  dbQuery := query;
  dbOngoingQuery := False;

  dbConn.Params.Add('Database=' + path);

  try
    dbConn.Connected := True;
  except on E: EDatabaseError do
    ShowMessage('Exception while connecting to scene db: ' + E.Message);
  end;

  self.LoadScene;
end;

procedure TScene.LoadScene;
begin
  ShowMessage(QueryDB<array>()
end;

procedure TScene.QueryDB(query: string);
begin
  self.QueryDB<T>(query, False);
end;

procedure TScene.QueryDB(query: string; hasResult: boolean);
var
  output: TList<T>;
begin
  while dbOngoingQuery do
    SysUtils.Sleep(1);

  dbOngoingQuery := True;

  dbQuery.SQL.Text := query;
  dbQuery.Active := True;

  if not hasResult then
    dbOngoingQuery := False;
end;

procedure TScene.ReleaseDB;
begin
  dbOngoingQuery := False;
end;

end.
