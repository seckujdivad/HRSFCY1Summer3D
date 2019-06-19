unit FormDatabase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Data.SqlExpr;

type
  TDatabaseForm = class(TForm)
    SQLConnection1: TSQLConnection;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DatabaseForm: TDatabaseForm;

implementation

{$R *.dfm}

end.
