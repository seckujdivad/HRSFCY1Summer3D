unit UPointUtils;

interface
uses
  UScene, Generics.Collections, System.Math;

function ArrToList(point: TPoint): TList<real>;
function ListToArr(point: TList<real>): TPoint;

//function Transform(point, point2: TPoint): TPoint; overload;
function Transform(point, point2: TList<real>): TList<real>; overload;

//function Rotate(point, rotate: TPoint): TPoint; overload;
function Rotate(point, rotate: TList<real>): TList<real>; overload;

//function Scale(point, scale: TPoint): TPoint; overload;
function Scale(point, scale: TList<real>): TList<real>; overload;

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

{ list methods }

function Transform(point, point2: TList<real>): TList<real>;
var
  i: integer;
begin
  result := TList<real>.Create;

  for i := 0 to 2 do
    result.Add(point[i] + point2[i]);
end;

function Rotate(point, rotate: TList<real>): TList<real>;
var
  value, theta: real;
  i: integer;
  old_values: TList<real>;
begin
  result := TList<real>.Create;
  old_values := TList<real>.Create;

  for i := 0 to 2 do
    old_values[i] := point[i];

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
end;

function Scale(point, scale: TList<real>): TList<real>;
var
  i: integer;
begin
  result := TList<real>.Create;

  for i := 0 to 2 do
    result.Add(point[i] * scale[i]);
end;

{ array methods }

{function Transform(point, point2: TPoint): TPoint;
begin
  result := ListToArr(Transform(ArrToList(point), ArrToList(point2)));
end;

function Rotate(point, rotate: TPoint): TPoint;
begin
  result := ListToArr(Rotate(ArrToList(point), ArrToList(rotate)));
end;

function Scale(point, scale: TPoint): TPoint;
begin
  result := ListToArr(Scale(ArrToList(point), ArrToList(scale)));
end;}

end.
