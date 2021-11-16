unit unitMain;
(**************************************************************************)
(* DUESK Düsseldorfer Schuelerinventar                                    *)
(* Paul Koop (c) 2012                                                     *)
(* Anwendung darf mit Quellcode und Handbuch und SPSS dateien             *)
(* zum Weiterentwickeln fuer nicht gewerbliche Zwecke weitergegeben werden*)
(* Ich freue mich ueber Info zur Veroeffentlichung auf dem DUESK Portal   *)
(**************************************************************************)

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, TASources, TATransformations, TATools, TAGraph,
  TASeries, Forms, Controls, Graphics, Dialogs, ComCtrls, Menus, Grids,
  StdCtrls, CRT, UnitDUESK, Types, Math;

type

  { TFormDUESK }

  TFormDUESK = class(TForm)
    Button1: TButton;
    UebereinstimmungSEFE: TEdit;
    Korrelation: TEdit;
    KorrelationLabel: TLabel;
    Label1: TLabel;
    MainMenu1: TMainMenu;
    Profil: TMenuItem;
    Info: TMenuItem;
    Normtabelle: TMenuItem;
    Neu: TMenuItem;
    Profiloeffnen: TMenuItem;
    Profilspeichern: TMenuItem;
    Normtabelleeinlesen: TMenuItem;
    Sprache: TMenuItem;
    ItemDeutsch: TMenuItem;
    ProfilDeutsch: TMenuItem;
    OpenDialog1: TOpenDialog;
    PageControlDuesk: TPageControl;
    SaveDialog1: TSaveDialog;
    StringGridNFE: TStringGrid;
    StringGridPSE: TStringGrid;
    StringGridPFE: TStringGrid;
    StringGridNSE: TStringGrid;
    StringGridPSEFE: TStringGrid;
    StringGridSE: TStringGrid;
    StringGridFE: TStringGrid;
    TabSheetNorm: TTabSheet;
    TabSheetProfil: TTabSheet;
    TabSheetFE: TTabSheet;
    TabSheetSE: TTabSheet;
    procedure FormActivate(Sender: TObject);
    procedure InfoClick(Sender: TObject);
    procedure NeuClick(Sender: TObject);
    procedure ProfiloeffnenClick(Sender: TObject);
    procedure ProfilspeichernClick(Sender: TObject);
    procedure NormtabelleeinlesenClick(Sender: TObject);
    procedure ItemDeutschClick(Sender: TObject);
    procedure ProfilDeutschClick(Sender: TObject);
    procedure StringGridFESelectCell(Sender: TObject; aCol, aRow: Integer;
      var CanSelect: Boolean);
    procedure StringGridSESelectCell(Sender: TObject; aCol, aRow: Integer;
      var CanSelect: Boolean);
    procedure TabSheetProfilEnter(Sender: TObject);


  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FormDUESK: TFormDUESK;

implementation

{$R *.lfm}

{ TFormDUESK }





procedure TFormDUESK.ItemDeutschClick(Sender: TObject);
begin
    if OpenDialog1.Execute then
   begin
     Pfad := OpenDialog1.Filename;
     Assignfile (Textdatei,Pfad);
     Reset (Textdatei);
     zaehler:=1;
     REPEAT
      Readln (Textdatei,Zeile);
      StringGridSE.Cells[1,zaehler]:=Zeile;
      StringGridFE.Cells[1,zaehler]:=Zeile;
      StringGridPSEFE.Cells[1,zaehler]:=Zeile;
      zaehler:=zaehler+1;
     UNTIL EOF (Textdatei);
   end;
end;

procedure TFormDUESK.NormtabelleeinlesenClick(Sender: TObject);
begin
   if OpenDialog1.Execute then
   begin
     Pfad := OpenDialog1.Filename;
     Assignfile (Textdatei,Pfad);
     Reset (Textdatei);
     zaehler:=1;
     REPEAT
      Readln(Textdatei,Zahl1);
      Readln(Textdatei,Zahl2);
      IF zaehler <7
       THEN
        BEGIN
          SEnorm[zaehler,6]:=StrToFloat(Zahl1);
          SEnorm[zaehler,7]:=StrToFloat(Zahl2);
        END
       ELSE
        BEGIN
          FEnorm[zaehler-6,6]:=StrToFloat(Zahl1);
          FEnorm[zaehler-6,7]:=StrToFloat(Zahl2);
        END;
      zaehler:=zaehler+1;
     UNTIL EOF (Textdatei);
   FOR zaehler:=1 TO 6
   DO
   BEGIN
    SEnorm[zaehler,1]:=SEnorm[zaehler,6]-2*SEnorm[zaehler,7];
    SEnorm[zaehler,2]:=SEnorm[zaehler,6]-SEnorm[zaehler,7];
    SEnorm[zaehler,3]:=SEnorm[zaehler,6];
    SEnorm[zaehler,4]:=SEnorm[zaehler,6]+SEnorm[zaehler,7];
    SEnorm[zaehler,5]:=SEnorm[zaehler,6]+2*SEnorm[zaehler,7];
    StringGridNSE.Cells[1,zaehler]:=FloatToStr(SEnorm[zaehler,1]);
    StringGridNSE.Cells[2,zaehler]:=FloatToStr(SEnorm[zaehler,2]);
    StringGridNSE.Cells[3,zaehler]:=FloatToStr(SEnorm[zaehler,3]);
    StringGridNSE.Cells[4,zaehler]:=FloatToStr(SEnorm[zaehler,4]);
    StringGridNSE.Cells[5,zaehler]:=FloatToStr(SEnorm[zaehler,5]);
    StringGridNSE.Cells[6,zaehler]:=FloatToStr(SEnorm[zaehler,6]);
    StringGridNSE.Cells[7,zaehler]:=FloatToStr(SEnorm[zaehler,7]);
   END;
      FOR zaehler:=1 TO 6
   DO
   BEGIN
    FEnorm[zaehler,1]:=FEnorm[zaehler,6]-2*FEnorm[zaehler,7];
    FEnorm[zaehler,2]:=FEnorm[zaehler,6]-FEnorm[zaehler,7];
    FEnorm[zaehler,3]:=FEnorm[zaehler,6];
    FEnorm[zaehler,4]:=FEnorm[zaehler,6]+FEnorm[zaehler,7];
    FEnorm[zaehler,5]:=FEnorm[zaehler,6]+2*FEnorm[zaehler,7];
    StringGridNFE.Cells[1,zaehler]:=FloatToStr(FEnorm[zaehler,1]);
    StringGridNFE.Cells[2,zaehler]:=FloatToStr(FEnorm[zaehler,2]);
    StringGridNFE.Cells[3,zaehler]:=FloatToStr(FEnorm[zaehler,3]);
    StringGridNFE.Cells[4,zaehler]:=FloatToStr(FEnorm[zaehler,4]);
    StringGridNFE.Cells[5,zaehler]:=FloatToStr(FEnorm[zaehler,5]);
    StringGridNFE.Cells[6,zaehler]:=FloatToStr(FEnorm[zaehler,6]);
    StringGridNFE.Cells[7,zaehler]:=FloatToStr(FEnorm[zaehler,7]);
   END;
  end;
end;

procedure TFormDUESK.FormActivate(Sender: TObject);
begin
         FillChar(SEint,SizeOf(SEint),2);
         FillChar(FEint,SizeOf(FEint),2);
end;

procedure TFormDUESK.InfoClick(Sender: TObject);
begin
  showmessage('DÜSK' + #13#10 +
              'Duesseldorfer Schuelerinventar' + #13#10 +
              'zur Selbstbeschreibung berufsbezogener Kompetenzen' + #13#10 +
              'Paul Koop (c)');
end;



procedure TFormDUESK.NeuClick(Sender: TObject);
begin
    For zaehler := 1 TO 36
     DO
     BEGIN
      SEint[zaehler]:=2;
      SEchar[zaehler,1]:=' ';
      SEchar[zaehler,2]:=' ';
      SEchar[zaehler,3]:=' ';
      SEchar[zaehler,4]:=' ';
      SEchar[zaehler,5-SEint[zaehler]]:='X';
      FOR zaehler2 :=1 To 4 DO
       BEGIN
        StringGridSE.Cells[zaehler2+1,zaehler]:=SEchar[zaehler,zaehler2]
       END;
     END;
     zaehler:=1;
     For zaehler := 1 TO 36
     DO
     BEGIN
      FEint[zaehler]:=2;
      FEchar[zaehler,1]:=' ';
      FEchar[zaehler,2]:=' ';
      FEchar[zaehler,3]:=' ';
      FEchar[zaehler,4]:=' ';
      FEchar[zaehler,5-FEint[zaehler]]:='X';
      FOR zaehler2 :=1 To 4 DO
       BEGIN
        StringGridFE.Cells[zaehler2+1,zaehler]:=FEchar[zaehler,zaehler2]
       END;
     END;
     showmessage('Neues Profil im Arbeitsspeicher angelegt'+ #13#10 +
                 'mit Vorbelegung - Trifft teilweise zu- ');
end;

procedure TFormDUESK.ProfiloeffnenClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
   begin
     Pfad := OpenDialog1.Filename;
     Assignfile (Textdatei,Pfad);
     Reset (Textdatei);
     zaehler:=1;
     For zaehler := 1 TO 36
     DO
     BEGIN
      Readln (Textdatei,Zeile);
      SEint[zaehler]:=StrToInt(Zeile);
      SEchar[zaehler,1]:=' ';
      SEchar[zaehler,2]:=' ';
      SEchar[zaehler,3]:=' ';
      SEchar[zaehler,4]:=' ';
      SEchar[zaehler,5-SEint[zaehler]]:='X';
      FOR zaehler2 :=1 To 4 DO
       BEGIN
        StringGridSE.Cells[zaehler2+1,zaehler]:=SEchar[zaehler,zaehler2]
       END;
     END;
     zaehler:=1;
     For zaehler := 1 TO 36
     DO
     BEGIN
      Readln (Textdatei,Zeile);
      FEint[zaehler]:=StrToInt(Zeile);
      FEchar[zaehler,1]:=' ';
      FEchar[zaehler,2]:=' ';
      FEchar[zaehler,3]:=' ';
      FEchar[zaehler,4]:=' ';
      FEchar[zaehler,5-FEint[zaehler]]:='X';
      FOR zaehler2 :=1 To 4 DO
       BEGIN
        StringGridFE.Cells[zaehler2+1,zaehler]:=FEchar[zaehler,zaehler2]
       END;
     END;
   end;
end;

procedure TFormDUESK.ProfilspeichernClick(Sender: TObject);
begin
  if SaveDialog1.Execute then
  begin
     Pfad := SaveDialog1.Filename;
     Assignfile (Textdatei,Pfad);
     ReWrite(Textdatei);
     zaehler:=1;
     For zaehler := 1 TO 36
     DO
     BEGIN
      writeln(Textdatei,IntToStr(SEint[zaehler]));
     END;
     zaehler:=1;
     For zaehler := 1 TO 36
     DO
     BEGIN
      writeln(Textdatei,IntToStr(FEint[zaehler]));
     END;
     Closefile (Textdatei);
   end;
end;


procedure TFormDUESK.ProfilDeutschClick(Sender: TObject);
begin
    if OpenDialog1.Execute then
   begin
     Pfad := OpenDialog1.Filename;
     Assignfile (Textdatei,Pfad);
     Reset (Textdatei);
     zaehler:=1;
     REPEAT
      Readln (Textdatei,Zeile);
      StringGridPSE.Cells[0,zaehler]:=Zeile;
      StringGridPFE.Cells[0,zaehler]:=Zeile;
      StringGridNSE.Cells[0,zaehler]:=Zeile;
      StringGridNFE.Cells[0,zaehler]:=Zeile;
      zaehler:=zaehler+1;
     UNTIL EOF (Textdatei);
   end;
end;



procedure TFormDUESK.StringGridSESelectCell(Sender: TObject; aCol,
  aRow: Integer; var CanSelect: Boolean);
begin
  IF (aRow>=1)  and (aCol>=2)
  THEN
  BEGIN
     SEchar[aRow,1]:=' ';
     SEchar[aRow,2]:=' ';
     SEchar[aRow,3]:=' ';
     SEchar[aRow,4]:=' ';
     SEchar[aRow,aCol-1]:='X';
     SEint[aRow]:= 5-(aCol-1);

  FOR zaehler :=1 To 4 DO
    BEGIN
     StringGridSE.Cells[zaehler+1,aRow]:=SEchar[aRow,zaehler]
    END;
  END;
end;


procedure TFormDUESK.StringGridFESelectCell(Sender: TObject; aCol,
  aRow: Integer; var Canselect: Boolean);
begin
  IF (aRow>=1)  and (aCol>=2)
  THEN
  BEGIN
     FEchar[aRow,1]:=' ';
     FEchar[aRow,2]:=' ';
     FEchar[aRow,3]:=' ';
     FEchar[aRow,4]:=' ';
     FEchar[aRow,aCol-1]:='X';
     FEint[aRow]:= 5-(aCol-1);

    FOR zaehler :=1 To 4 DO
    BEGIN
     StringGridFE.Cells[zaehler+1,aRow]:=FEchar[aRow,zaehler]
    END;
  END;
end;





procedure TFormDUESK.TabSheetProfilEnter(Sender: TObject);
begin


       FillChar(SEPint,SizeOf(SEPint),0);

       For zaehler := 1 TO 36
       DO
       BEGIN
        For zaehler2:= 1 TO 4
        DO
        BEGIN
         IF SEchar[zaehler,zaehler2]='X' THEN
          BEGIN
            SEint[zaehler]:=5-zaehler2;
            StringGridPSEFE.Cells[2,zaehler]:=IntToStr(SEint[zaehler]);
          END;
        END;
       END;
       SEPint[1]:=SEint[1]+ SEint[2]+ SEint[3]+ SEint[4]+ SEint[5]+
                  SEint[6]+ SEint[7]+ SEint[8]+ SEint[9]+ SEint[10];
       SEPint[2]:=SEint[11]+ SEint[12]+ SEint[13]+ SEint[14]+ SEint[15]+
                  SEint[16]+ SEint[17]+ SEint[18]+ SEint[19]+ SEint[20];
       SEPint[3]:=SEint[21]+ SEint[22]+ SEint[23]+ SEint[24]+ SEint[25]+
                  SEint[26]+ SEint[27]+ SEint[28]+ SEint[9]+ SEint[10];
       SEPint[4]:=SEint[29]+ SEint[30]+ SEint[31]+ SEint[32]+ SEint[33]+
                  SEint[34]+ SEint[35]+ SEint[36];
       SEPint[5]:=SEint[1]+ SEint[2]+
                  SEint[6]+ SEint[7]+ SEint[8]+ SEint[9]+ SEint[10]+
                  SEint[12]+SEint[13]+ SEint[14]+ SEint[15];
       SEPint[6]:=SEint[3]+ SEint[4]+ SEint[5]+
                  SEint[9]+ SEint[10]+ SEint[11]+
                  SEint[17]+ SEint[18];


       FOR zaehler:=1 TO 6
       DO
       BEGIN
       zaehler2:=1;
       REPEAT
        StringGridPSE.Cells[1,zaehler]:=' ';
        StringGridPSE.Cells[2,zaehler]:=' ';
        StringGridPSE.Cells[3,zaehler]:=' ';
        StringGridPSE.Cells[4,zaehler]:=' ';
        StringGridPSE.Cells[5,zaehler]:=' ';
        IF (SEPint[zaehler]<SEnorm[zaehler,zaehler2])
            OR
            (zaehler2=5)
            THEN
             BEGIN
               StringGridPSE.Cells[zaehler2,zaehler]:='X';
               zaehler2:=6
             END;
        zaehler2:=zaehler2+1;
       UNTIL zaehler2>=6;
       END;




       FillChar(FEPint,SizeOf(FEPint),0);

       For zaehler := 1 TO 36
       DO
       BEGIN
        For zaehler2:= 1 TO 4
        DO
        BEGIN
         IF FEchar[zaehler,zaehler2]='X' THEN
          BEGIN
            FEint[zaehler]:=5-zaehler2;
            StringGridPSEFE.Cells[3,zaehler]:=IntToStr(FEint[zaehler]);
          END;
        END;
       END;
       FEPint[1]:=FEint[1]+ FEint[2]+ FEint[3]+ FEint[4]+ FEint[5]+
                  FEint[6]+ FEint[7]+ FEint[8]+ FEint[9]+ FEint[10];
       FEPint[2]:=FEint[11]+ FEint[12]+ FEint[13]+ FEint[14]+ FEint[15]+
                  FEint[16]+ FEint[17]+ FEint[18]+ FEint[19]+ FEint[20];
       FEPint[3]:=FEint[21]+ FEint[22]+ FEint[23]+ FEint[24]+ FEint[25]+
                  FEint[26]+ FEint[27]+ FEint[28]+ FEint[9]+ FEint[10];
       FEPint[4]:=FEint[29]+ FEint[30]+ FEint[31]+ FEint[32]+ FEint[33]+
                  FEint[34]+ FEint[35]+ FEint[36];
       FEPint[5]:=FEint[1]+ FEint[2]+
                  FEint[6]+ FEint[7]+ FEint[8]+ FEint[9]+ FEint[10]+
                  FEint[12]+FEint[13]+ FEint[14]+ FEint[15];
       FEPint[6]:=FEint[3]+ FEint[4]+ FEint[5]+
                  FEint[9]+ FEint[10]+ FEint[11]+
                  FEint[17]+ FEint[18];

       FOR zaehler:=1 TO 6
       DO
       BEGIN
       zaehler2:=1;
       REPEAT
        StringGridPFE.Cells[1,zaehler]:=' ';
        StringGridPFE.Cells[2,zaehler]:=' ';
        StringGridPFE.Cells[3,zaehler]:=' ';
        StringGridPFE.Cells[4,zaehler]:=' ';
        StringGridPFE.Cells[5,zaehler]:=' ';
        IF (FEPint[zaehler]<FEnorm[zaehler,zaehler2])
            OR
            (zaehler2=5)
            THEN
             BEGIN
               StringGridPFE.Cells[zaehler2,zaehler]:='X';
               zaehler2:=6
             END;
        zaehler2:=zaehler2+1;
       UNTIL zaehler2>=6;
       END;

       SEPmittel:=(SEPint[1]+SEPint[2]+SEPint[3]+SEPint[4]+SEPint[5]+SEPint[6]) / 6;
       FEPmittel:=(FEPint[1]+FEPint[2]+FEPint[3]+FEPint[4]+FEPint[5]+FEPint[6]) / 6;

       corr:=
       (
        ((SEPmittel-SEPint[1])*(FEPmittel-FEPint[1]))+
        ((SEPmittel-SEPint[2])*(FEPmittel-FEPint[2]))+
        ((SEPmittel-SEPint[3])*(FEPmittel-FEPint[3]))+
        ((SEPmittel-SEPint[4])*(FEPmittel-FEPint[4]))+
        ((SEPmittel-SEPint[5])*(FEPmittel-FEPint[5]))+
        ((SEPmittel-SEPint[6])*(FEPmittel-FEPint[6]))
       )
       /
       sqrt
       (
        (
         sqr(SEPmittel-SEPint[1])+
         sqr(SEPmittel-SEPint[2])+
         sqr(SEPmittel-SEPint[3])+
         sqr(SEPmittel-SEPint[4])+
         sqr(SEPmittel-SEPint[5])+
         sqr(SEPmittel-SEPint[6])
        )
        *
        (
         sqr(FEPmittel-FEPint[1])+
         sqr(FEPmittel-FEPint[2])+
         sqr(FEPmittel-FEPint[3])+
         sqr(FEPmittel-FEPint[4])+
         sqr(FEPmittel-FEPint[5])+
         sqr(FEPmittel-FEPint[6])
        )
       );


       writestr(Zeile,corr :1:2);
       Korrelation.Text:=Zeile;

       zaehler2:=0;
       FOR zaehler :=1 TO 36
        DO
        IF SEint[zaehler]= FEint[zaehler] THEN zaehler2:=zaehler2+1;

       UebereinstimmendeSEFE:=round((zaehler2 / 36)*100);
       writestr(Zeile,UebereinstimmendeSEFE );
       UebereinstimmungSEFE.Text:=Zeile;


end;



end.

