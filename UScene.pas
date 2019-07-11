unit UScene;

interface
uses
  Generics.Collections, Data.FMTBcd, Data.DB, Data.SqlExpr, Vcl.Dialogs, SysUtils;

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
      cam_rot: TPoint;
      cam_name: string;
      cam_fov: real;

      procedure SetPos(index: integer; value: real);
      procedure SetRot(index: integer; value: real);
      function GetPos(index: integer): real;
      function GetRot(index: integer): real;
    public
      property pos[index: integer]: real read GetPos write SetPos;
      property aspect: real read cam_aspect write cam_aspect;
      property rot[index: integer]: real read GetRot write SetRot;
      property name: string read cam_name write cam_name;
      property fov: real read cam_fov write cam_fov;

      procedure SetAspectRatio(x, y: integer);
      procedure Interpret(query: TSQLQuery);
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

function TCamera.GetPos(index: integer): real;
begin
  result := cam_pos[index];
end;

function TCamera.GetRot(index: integer): real;
begin
  result := cam_rot[index];
end;

procedure TCamera.Interpret(query: TSQLQuery);
begin
  pos[0] := query.FieldByName('pos x').AsFloat;
  pos[1] := query.FieldByName('pos y').AsFloat;
  pos[2] := query.FieldByName('pos z').AsFloat;

  rot[0] := query.FieldByName('rot x').AsFloat;
  rot[1] := query.FieldByName('rot y').AsFloat;
  rot[2] := query.FieldByName('rot z').AsFloat;

  fov := query.FieldByName('fov').AsFloat;
  name := query.FieldByName('name').AsString;
end;

procedure TCamera.SetAspectRatio(x, y: integer);
begin
  aspect := y / x;
end;

procedure TCamera.SetPos(index: integer; value: real);
begin
  cam_pos[index] := value;
end;

procedure TCamera.SetRot(index: integer; value: real);
begin
  cam_rot[index] := value;
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
  //get default camera and load into memory
  self.QueryDB('SELECT * FROM cams WHERE isdefault = 1;');

  //assume there is one default camera
  scene_cam := TCamera.Create();
  scene_cam.Interpret(self.dbQuery);

  while not dbQuery.Eof do begin
    ShowMessage(dbQuery.FieldByName('name').AsString);
    dbQuery.Next;
  end;
end;

procedure TScene.QueryDB(query: string);
begin
  self.QueryDB(query, False);
end;

procedure TScene.QueryDB(query: string; hasResult: boolean);
begin
  while dbOngoingQuery do begin end;

  dbOngoingQuery := True;

  try
    dbQuery.SQL.Text := query;
    dbQuery.Active := True;
  except on E: Exception do
    ShowMessage('Error while executing statement "' + query + '": ' + E.Message);
  end;

  if not hasResult then
    dbOngoingQuery := False;
end;

procedure TScene.ReleaseDB;
begin
  dbOngoingQuery := False;
end;

end.
