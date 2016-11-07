program FireMonkeyPaintDemo;

uses
  System.StartUpCopy,
  FMX.Forms,
  MyPaintBox in 'MyPaintBox.pas',
  uMain in 'uMain.pas' {MainForm},
  frmfilebrowseopen in 'frmfilebrowseopen.pas' {filebrowseopenfrm},
  frmSelectBmp in 'frmSelectBmp.pas' {SelectBmpfrm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TSelectBmpfrm, SelectBmpfrm);
  Application.CreateForm(Tfilebrowseopenfrm, filebrowseopenfrm);
  Application.Run;
end.
