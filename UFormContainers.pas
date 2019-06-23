unit UFormContainers;

interface
uses
  Generics.Collections;

type
  IForm = interface(IInterface)
    procedure Free;
  end;

  TFormContainer<T: IForm> = class(TList<T>)
    private
      active: TList<integer>;
    public
      constructor Create;
      destructor Destroy;

      function IsActive(index: integer): boolean; overload;
      function IsActive(form: T): boolean; overload;
      procedure DestroyForm(index: integer); overload;
      procedure DestroyForm(form: T); overload;
      procedure AddForm(form: T);
  end;

implementation

{ TFormContainer<T> }

procedure TFormContainer<T>.AddForm(form: T);
begin
  Add(form);
  active.Add(Count - 1);
end;

constructor TFormContainer<T>.Create;
begin
  inherited Create;
  active := TList<integer>.Create;
end;

destructor TFormContainer<T>.Destroy;
var
  index: integer;
begin
  active.Free;
end;

procedure TFormContainer<T>.DestroyForm(form: T);
begin
  active.Delete(IndexOf(form));
end;

function TFormContainer<T>.IsActive(form: T): boolean;
begin
  result := active.Contains(IndexOf(form));
end;

procedure TFormContainer<T>.DestroyForm(index: integer);
begin
  Delete(index);
end;

function TFormContainer<T>.IsActive(index: integer): boolean;
begin
  result := active.Contains(index);
end;

end.
