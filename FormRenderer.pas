unit FormRenderer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, URender, Vcl.Graphics;

type
  TForm1 = class(TForm)
    RenderOutput: TPaintBox;
    procedure FormCreate(Sender: TObject);
  private
    renderer: TRender;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  self.renderer := TRender.Create(RenderOutput.Canvas);
end;

end.
