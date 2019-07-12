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
      tri_mat_name, tri_mat_col: string;

      procedure SetPoints(index, index2: integer; value: real);

      function GetPoints(index, index2: integer): real;
    public
      property points[index, index2: integer]: real read GetPoints write SetPoints;

      property mat_name: string read tri_mat_name write tri_mat_name;
      property mat_col: string read tri_mat_col write tri_mat_col;
  end;

  TSceneObj = class(TList<TTriangle>)
    private
      o_pos, o_rot, o_scale: TPoint;
      o_uid: integer;

      procedure SetPos(index: integer; value: real);
      procedure SetRot(index: integer; value: real);
      procedure SetScale(index: integer; value: real);

      function GetPos(index: integer): real;
      function GetRot(index: integer): real;
      function GetScale(index: integer): real;
    public
      property pos[index: integer]: real read GetPos write SetPos;
      property rot[index: integer]: real read GetRot write SetRot;
      property scale[index: integer]: real read GetScale write SetScale;
      property uid: integer read o_uid;

      constructor Create(identifier: integer);

      procedure Interpret(query: TSQLQuery);
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
  inherited Create;

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
var
  sceneObj: TSceneObj;
  tri: TTriangle;
begin
  //get default camera and load into memory
  self.QueryDB('SELECT * FROM cams WHERE isdefault = 1');

  //assume there is one default camera
  scene_cam := TCamera.Create();
  scene_cam.Interpret(self.dbQuery);

  self.ReleaseDB;

  //get model information
  self.QueryDB('SELECT * FROM scene WHERE vis = 1');

  while not dbQuery.Eof do begin
    sceneObj := TSceneObj.Create(dbQuery.FieldByName('modelID').AsInteger);
    sceneObj.Interpret(dbQuery);
    Add(sceneObj);
    dbQuery.Next;
  end;


end;

procedure TScene.QueryDB(query: string);
begin
  self.QueryDB(query, False);
end;

procedure TScene.QueryDB(query: string; hasResult: boolean);
begin
  while dbOngoingQuery do
    SysUtils.Sleep(1);

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

{ TSceneObj }

constructor TSceneObj.Create(identifier: integer);
begin
  inherited Create;

  o_uid := identifier;
end;

function TSceneObj.GetPos(index: integer): real;
begin
  result := o_pos[index];
end;

function TSceneObj.GetRot(index: integer): real;
begin
  result := o_rot[index];
end;

function TSceneObj.GetScale(index: integer): real;
begin
  result := o_scale[index];
end;

procedure TSceneObj.Interpret(query: TSQLQuery);
begin
  //pos
  o_pos[0] := query.FieldByName('pos x').AsFloat;
  o_pos[1] := query.FieldByName('pos y').AsFloat;
  o_pos[2] := query.FieldByName('pos z').AsFloat;

  //rot
  o_rot[0] := query.FieldByName('rot x').AsFloat;
  o_rot[1] := query.FieldByName('rot y').AsFloat;
  o_rot[2] := query.FieldByName('rot z').AsFloat;

  //scale
  o_scale[0] := query.FieldByName('scale x').AsFloat;
  o_scale[1] := query.FieldByName('scale y').AsFloat;
  o_scale[2] := query.FieldByName('scale z').AsFloat;
end;

procedure TSceneObj.SetPos(index: integer; value: real);
begin
  o_pos[index] := value;
end;

procedure TSceneObj.SetRot(index: integer; value: real);
begin
  o_rot[index] := value;
end;

procedure TSceneObj.SetScale(index: integer; value: real);
begin
  o_scale[index] := value;
end;

{ TTriangle }

function TTriangle.GetPoints(index, index2: integer): real;
begin
  result := tri_points[index][index2];
end;

procedure TTriangle.SetPoints(index, index2: integer; value: real);
begin
  tri_points[index][index2] := value;
end;

end.
