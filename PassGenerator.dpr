program PassGenerator;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {PasswordGenerator},
  Unit2 in 'Unit2.pas' {About};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TPasswordGenerator, PasswordGenerator);
  Application.CreateForm(TAbout, About);
  Application.Run;
end.
