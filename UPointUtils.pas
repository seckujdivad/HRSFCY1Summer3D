unit UPointUtils;

interface
uses
  UScene, Generics.Collections, System.Math, Vcl.Dialogs, SysUtils;

function ArrToList(point: TPoint): TList<real>;
function ListToArr(point: TList<real>): TPoint;

type
  TPointList = class(TList<real>)
    private
    public
      constructor Create;

      procedure Transform(point: TPoint); overload;
      procedure Transform(point: TList<real>); overload;
      procedure Rotate(rotate: TPoint); overload;
      procedure Rotate(rotate: TList<real>); overload;
      procedure Scale(scale: TPoint); overload;
      procedure Scale(scale: TList<real>); overload;

      function Multiply(point: TList<real>; factor: real): TList<real>; overload;
      function Multiply(point: TPoint; factor: real): TPoint; overload;

      procedure ShowPointsAsMessage;
  end;

implementation

{ type conversions }

function ArrToList(point: TPoint): TList<real>;
var
  value: real;
begin
  result := TList<real>.Create;

  for value in point do
    result.Add(value);
end;

function ListToArr(point: TList<real>): TPoint;
var
  i: integer;
begin
  for i := 0 to 2 do
    result[i] := point[i];
end;

{ TPointList }

constructor TPointList.Create;
begin
  inherited Create;
end;

function TPointList.Multiply(point: TPoint; factor: real): TPoint;
begin
  result := ListToArr(self.Multiply(ArrToList(point), factor));
end;

function TPointList.Multiply(point: TList<real>; factor: real): TList<real>;
var
  value: real;
begin
  result := TList<real>.Create;

  for value in list do
    result.Add(value * factor);
end;

procedure TPointList.Rotate(rotate: TList<real>);
var
  theta: real;
  i: integer;
  old_values: TList<real>;
  result:  TList<real>;
begin
  result := TList<real>.Create;
  old_values := TList<real>.Create;

  for i := 0 to 2 do
    old_values.Add(self[i]);

  // x
  theta := DegToRad(rotate[0]);
  result.Add(old_values[0]);
  result.Add((Cos(theta) * old_values[1]) - (Sin(theta) * old_values[2]));
  result.Add((Sin(theta) * old_values[1]) + (Cos(theta) * old_values[2]));

  old_values.Free;
  old_values := result;
  result := TList<real>.Create;

  // y
  theta := DegToRad(rotate[1]);
  result.Add((Cos(theta) * old_values[0]) + (Sin(theta) * old_values[2]));
  result.Add(old_values[1]);
  result.Add((-1 * Sin(theta) * old_values[0]) + (Cos(theta) * old_values[2]));

  old_values.Free;
  old_values := result;
  result := TList<real>.Create;

  // z
  theta := DegToRad(rotate[2]);
  result.Add((Cos(theta) * old_values[0]) + (-1 * Sin(theta) * old_values[1]));
  result.Add((Sin(theta) * old_values[0]) + (Cos(theta) * old_values[1]));
  result.Add(old_values[2]);

  old_values.Free;

  for i := 0 to 2 do
    self[i] := result[i];
end;

procedure TPointList.Rotate(rotate: TPoint);
begin
  self.Rotate(ArrToList(rotate));
end;

procedure TPointList.Scale(scale: TPoint);
begin
  self.Scale(ArrToList(scale));
end;

procedure TPointList.Scale(scale: TList<real>);
var
  i: integer;
  result: TList<real>;
begin
  result := TList<real>.Create;

  for i := 0 to 2 do
    result.Add(Items[i] * scale[i]);

  for i := 0 to 2 do
    self[i] := result[i];
end;

procedure TPointList.ShowPointsAsMessage;
begin
  ShowMessage('X: ' + FloatToStrF(self[0], ffNumber, 4, 2) + 'Y: ' + FloatToStrF(self[1], ffNumber, 4, 2) + ' Z: ' + FloatToStrF(self[0], ffNumber, 4, 2));
end;

procedure TPointList.Transform(point: TList<real>);
var
  i: integer;
  result: TList<real>;
begin
  result := TList<real>.Create;

  for i := 0 to 2 do
    result.Add(self[i] + point[i]);

  for i := 0 to 2 do
    self[i] := result[i];
end;

procedure TPointList.Transform(point: TPoint);
begin
  self.Transform(ArrToList(point));
end;

end.
