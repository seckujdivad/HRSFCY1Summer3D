unit UPointUtils;

interface
uses
  UScene, Generics.Collections;

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

end.
