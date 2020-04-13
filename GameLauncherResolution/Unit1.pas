unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  MemWidth, MemHeight: integer; //Ancienne tailel d'écran

  
implementation

{$R *.dfm}
function ChangeResolution(Width, Height: integer): Longint;
  var
    Affich: TDeviceMode;
  begin
      Affich.dmSize := SizeOf(TDeviceMode);//Paramètres
      Affich.dmPelsWidth := Width;
      Affich.dmPelsHeight := Height;
      Affich.dmFields := DM_PELSWIDTH or DM_PELSHEIGHT;
  Result := ChangeDisplaySettings(Affich, CDS_UPDATEREGISTRY);//Applique avec l'Api windows
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
MemWidth := GetSystemMetrics(SM_CXSCREEN);//Memorise la resolutio nactuelle
MemHeight := GetSystemMetrics(SM_CYSCREEN);
ChangeResolution(800,600);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
ChangeResolution(Memwidth, MemHeight);
end;

end.
