unit UPointUtils;

interface
uses
  UScene, Generics.Collections, System.Math;

function ArrToList(point: TPoint): TList<real>;
function ListToArr(point: TList<real>): TPoint;

function Transform(point, point2: TPoint): TPoint; overload;
function Transform(point, point2: TList<real>): TList<real>; overload;

function Rotate(point, rotate: TPoint): TPoint; overload;
function Rotate(point, rotate: TList<real>): TList<real>; overload;

function Scale(point, scale: TPoint): TPoint; overload;
function Scale(point, scale: TList<real>): TList<real>; overload;

implementation

{ type conversions }

function ArrToList(point: TPoint): TList<real>;
var
  value: real;
begin
  result := TList<real>;

  for value in point do
    result.Add;
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
begin
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

function Transform(point, point2: TPoint): TPoint;
begin
  result := ListToArr(Transform(ArrToList(point, point2)));
end;

function Rotate(point, rotate: TPoint): TPoint;
begin
  result := ListToArr(Rotate(ArrToList(point, rotate)));
end;

function Scale(point, scale: TPoint): TPoint;
begin
  result := ListToArr(Scale(ArrToList(point, scale)));
end;

end.
