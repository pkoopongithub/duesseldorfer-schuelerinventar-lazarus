program DUESK;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, tachartlazaruspkg, unitMain, unitDUESK;
  { you can add units after this }

{$R *.res}

begin
  Application.Title:='DUESK';
  RequireDerivedFormResource:=True;
  Application.Initialize;
  Application.CreateForm(TFormDUESK, FormDUESK);
  Application.Run;
end.

