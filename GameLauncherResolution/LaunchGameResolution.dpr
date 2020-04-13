program LaunchGameResolution;

uses
  System.StartUpCopy,
  FMX.Forms,
  LauncherAoE2 in 'LauncherAoE2.pas' {Form7};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm7, Form7);
  Application.Run;
end.
