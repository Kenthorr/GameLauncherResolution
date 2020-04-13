unit LauncherAoE2;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Edit,
  FMX.Controls.Presentation, FMX.StdCtrls, System.IOUtils, System.Win.Devices,
  Windows, Messages, shellApi, FMX.Layouts, FMX.ScrollBox, FMX.Memo;

type
  TForm7 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    OpenDialog1: TOpenDialog;
    Button2: TButton;
    Edit2: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    Button3: TButton;
    ScaledLayout1: TScaledLayout;
    StyleBook1: TStyleBook;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Edit1Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }

    function ChangeResolution(Width, Height: integer): Longint;
    function LanceAppliAttenteFin(NomFichier:string):boolean;

  end;

var
  Form7: TForm7;
  MemWidth, MemHeight: integer; //Ancienne tailel d'écran

implementation

{$R *.fmx}







procedure TForm7.Button1Click(Sender: TObject);
var
  OleStr  : PWideChar ;
  OleStr2 : PWideChar ;
begin
  if Edit1.Text = '' then begin
    ShowMessage('Select Launcher Game');
    Exit;
  end;

  if (Edit2.Text = '') or (Edit3.Text = '') then begin
    ShowMessage('Enter Resolution');
    Exit;
  end;

  Button2.Enabled := True ;
  MemWidth := GetSystemMetrics(SM_CXSCREEN);//Memorise la resolutio actuelle
  MemHeight := GetSystemMetrics(SM_CYSCREEN);
  ChangeResolution(strtoint(Edit2.Text),strtoint(Edit3.Text));

  GetMem(OleStr, (Length(TPath.GetFileName(OpenDialog1.FileName))+1) * SizeOf(WideChar));
  GetMem(OleStr2, (Length(TPath.GetDirectoryName(OpenDialog1.FileName))+1) * SizeOf(WideChar));

  StringToWideChar(TPath.GetFileName(OpenDialog1.FileName), OleStr, Length(TPath.GetFileName(OpenDialog1.FileName))+1);
  StringToWideChar(TPath.GetDirectoryName(OpenDialog1.FileName), OleStr2, Length(TPath.GetDirectoryName(OpenDialog1.FileName))+1);

  ShellExecute(0, Nil, OleStr, '', OleStr2, SW_NORMAL);
  //LanceAppliAttenteFin(Edit1.Text);

  FreeMem(OleStr);
  FreeMem(OleStr2);
end;

procedure TForm7.Button2Click(Sender: TObject);
begin
  ChangeResolution(MemWidth,MemHeight);
end;

function TForm7.LanceAppliAttenteFin(NomFichier:string):boolean;
{permet de lancer un exécutable. NomFichier est le nom avec chemin     }
{de cet exécutable ou d'un raccourci qui pointe vers cet exécutable. }
{ notre programme est arrété tant que l'exécutable n'est pas fini      }
{tout est arrété on ne peut donc même plus déplacer sa fenêtre.        }
{ il est donc préférable de la rendre invisible avant le lancement     }
{de cette fonction.                                                    }
{ LanceAppliAttenteFin renvoie true si le lancement s'est bien passé   }
var
  StartInfo : TStartupInfo;
  ProcessInformation : TProcessInformation;
  n:longint;
begin
  n:=Length(NomFichier);
  NomFichier:=Lowercase(NomFichier);
  //if ( n > 3 ) then
  //  if not ( ( NomFichier[n-2] = 'e' ) and ( NomFichier[n-1] = 'x' ) and ( NomFichier[n] = 'e' ) ) then
  //    NomFichier:='C:\WINDOWS\RUNDLL32.EXE amovie.ocx,RunDll /play /close '+NomFichier;
  result:=true;
  ZeroMemory(@StartInfo, sizeof(StartInfo)); // rempli de 0 StartInfo
  StartInfo.cb:=sizeof(StartInfo);
  {if CreateProcess(nil,PChar(NomFichier),nil,nil,true,0,nil,nil,StartInfo,ProcessInformation) then
    begin
      Form7.FormStyle:= TFormStyle.Normal;
      Form7.Hide;
      //WaitForSingleObject(ProcessInformation.hProcess, INFINITE)// attend que l'application désignée par le handle ProcessInformation.hProcess soit terminée
    end
  else result:=false;  }
end;







procedure TForm7.Button3Click(Sender: TObject);
begin
  if OpenDialog1.Execute then begin

    Edit1.Text := OpenDialog1.FileName ;

  end;
end;

procedure TForm7.Edit1Click(Sender: TObject);
begin

  ShowMessage(TPath.GetDirectoryName(OpenDialog1.FileName));
  ShowMessage(TPath.GetFileName(OpenDialog1.FileName));

end;

function TForm7.ChangeResolution(Width, Height: integer): Longint;
var
  Affich: TDeviceMode;
begin
  Affich.dmSize := SizeOf(TDeviceMode);//Paramètres
  Affich.dmPelsWidth := Width;
  Affich.dmPelsHeight := Height;
  Affich.dmFields := DM_PELSWIDTH or DM_PELSHEIGHT;
  Result := ChangeDisplaySettings(Affich, CDS_UPDATEREGISTRY);//Applique avec l'Api windows
end;




end.
