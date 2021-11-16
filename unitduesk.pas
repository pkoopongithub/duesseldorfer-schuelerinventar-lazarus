unit UnitDUESK;
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
  Classes, SysUtils, Crt;

(* benoetigte Datentypen *)
 VAR
   zaehler,zaehler2, UebereinstimmendeSEFE :integer;
   corr:real;
   Textdatei: Text;
   Zeile, Pfad, Zahl1,Zahl2: String;



(* Array Normtabelle *)
 SEnorm:  Array [1..6,1..7] of real;
 FEnorm:  Array [1..6,1..7] of real;

(* Array Selbsteinschaetzung *)
   SEchar : ARRAY [1..36,1..4] of char;
   SEint  : Array [1..36] of integer;

(* Array Profil Selbsteinschaetzung *)
   SEPint : Array [1..6] of integer;
   SEPmittel:real;

(* Array Fremdeinschaetzung *)
   FEchar : ARRAY [1..36,1..4] of char;
   FEint  : Array [1..36] of integer;

(* Array Profil Fremdeinschaetzung *)
   FEPint : Array [1..6] of integer;
   FEPmittel:real;


(* File of Normtabelle *)
(* File of Selbsteinschaetzung *)
(* File of Fremdeinschaetzung *)

implementation

end.

