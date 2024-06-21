uses CRT;

type
  wWezel = ^tWezel;
  tWezel = record
    Dana: integer;                           
    Nastepny: wWezel;                       
  end;

  tKolejka = record
    Pierwszy, Ostatni: wWezel;                 
  end;

  tParaLiczb = record
    L1, L2: integer;                            
  end;

  tCiagParLiczb = record
    Elem: array[1..25] of tParaLiczb;    
    n: integer;                         
  end;

var
  Kolejka: tKolejka;
  StosNparz, StosParz: wWezel;
  ParyLiczb: tCiagParLiczb;

procedure wyswietlInfoOProgramie; forward;
procedure wyswietlListe(Lista: wWezel; X, Y: integer); forward;
procedure wyswietlCiagParLiczb(var Pary: tCiagParLiczb; X, Y: integer); forward;
procedure DodajDoKolejki(var kolejka: tKolejka; L: integer); forward;
function PobierzZKolejki(var kolejka: tKolejka): integer; forward;
procedure PolozNaStos(var stos: wWezel; L: integer); forward;
function ZdejmijZeStosu(var stos: wWezel): integer; forward;
procedure LosujLiczbyDoKolejki(var kolejka: tKolejka); forward;
procedure RealizAlgCwicz(var kolejka: tKolejka; var pary: tCiagParLiczb); forward;

procedure wyswietlInfoOProgramie;
begin
  writeln('Program:Program zapisujący w tablicy zbiór par liczb parzysta-nieparzysta, ver 3.0, _AiSD7_Z2');
  writeln('Autor: Rogowski Patryk, Numer indeksu 162866, Rok 1,Wydział Techniki i Informatyki, grupa D2, Sem 1');
end;

procedure wyswietlListe(Lista: wWezel; X, Y: integer);
var
  wsk: wWezel;
  i: integer;
begin
  wsk := Lista;
  i := 1;
  while (wsk <> nil) do
  begin
    if i = 27 then
    begin
      y := Y - 5;
      X := X + 11;
    end;
    gotoXY(X, Y);
    writeln(i:2, ' : ', (wsk^.Dana):3, ' ');
    wsk := wsk^.Nastepny;
    i := i + 1;
    Y := Y + 1;
  end;
end;

procedure wyswietlCiagParLiczb(var Pary: tCiagParLiczb; X, Y: integer);
var
  i: integer;
begin
  for i := 1 to Pary.n do
  begin
    gotoXY(X, Y);
    writeln(i:2, ' : ', (Pary.Elem[i].L1):3, ' - ', (Pary.Elem[i].L2):3, ' ');
    Y := Y + 1;
  end;
end;

procedure DodajDoKolejki(var kolejka: tKolejka; L: integer);
var
  wskNowy: wWezel;
begin
  new(wskNowy);
  wskNowy^.Dana := L;
  wskNowy^.Nastepny := nil;
  if kolejka.Pierwszy = nil then
    kolejka.Pierwszy := wskNowy
  else
    kolejka.Ostatni^.Nastepny := wskNowy;
  Kolejka.Ostatni := wskNowy;
end;

function PobierzZKolejki(var kolejka: tKolejka): integer;
var
  L: integer;
  wskUsuw: wWezel;
begin
  if kolejka.Pierwszy = nil then
    PobierzZKolejki := 0
  else
  begin
    L := kolejka.Pierwszy^.Dana;
    wskUsuw := kolejka.Pierwszy;
    kolejka.Pierwszy := kolejka.Pierwszy^.Nastepny;
    dispose(wskUsuw);
    if kolejka.Pierwszy = nil then
      kolejka.Ostatni := nil;
    PobierzZKolejki := L;
  end;
end;

procedure PolozNaStos(var stos: wWezel; L: integer);
var
  wskNowy: wWezel;
begin
  new(wskNowy);
  wskNowy^.Dana := L;
  wskNowy^.Nastepny := stos;
  stos := wskNowy;
end;

function ZdejmijZeStosu(var stos: wWezel): integer;
var
  L: integer;
  wskUsuw: wWezel;
begin
  if stos = nil then
    ZdejmijZeStosu := 0
  else
  begin
    L := stos^.Dana;
    wskUsuw := stos;
    stos := stos^.Nastepny;
    dispose(wskUsuw);
    ZdejmijZeStosu := L;
  end;
end;

procedure LosujLiczbyDoKolejki(var kolejka: tKolejka);
var
  L: integer;
  i: integer;
begin
  while kolejka.Pierwszy <> nil do
    L := PobierzZKolejki(kolejka);
  for i := 1 to 25 do
  begin
    L := random(1000);
    DodajDoKolejki(kolejka, L);
  end;
end;

procedure RealizAlgCwicz(var kolejka: tKolejka; var pary: tCiagParLiczb);
var
  L, LNparz, LParz: integer;
begin
  while StosNparz <> nil do
    L := ZdejmijZeStosu(StosNparz);
  while StosParz <> nil do
    L := ZdejmijZeStosu(StosParz);
  while kolejka.Pierwszy <> nil do
  begin
    L := PobierzZKolejki(kolejka);
    if L mod 2 <> 0 then
      PolozNaStos(StosNparz, L)
    else
      PolozNaStos(StosParz, L);
  end;
  pary.n := 0;
  while (StosNparz <> nil) and (StosParz <> nil) do
  begin
    LNparz := ZdejmijZeStosu(StosNparz);
    LParz := ZdejmijZeStosu(StosParz);
    pary.n := pary.n + 1;
    pary.Elem[pary.n].L1 := LNparz;
    pary.Elem[pary.n].L2 := LParz;
  end;
end;

begin
  Randomize;
  Kolejka.Pierwszy := nil;
  Kolejka.Ostatni := nil;
  StosNparz := nil;
  StosParz := nil;
  ParyLiczb.N := 0;

  wyswietlInfoOProgramie;
  writeln;
  writeln('Nacisnij <ENTER>... ');
  readln;

  ClrScr;

  LosujLiczbyDoKolejki(Kolejka);

  gotoXY(1, 1);
  writeln('- KOLEJKA -');
  wyswietlListe(Kolejka.Pierwszy, 2, 2);

  RealizAlgCwicz(Kolejka, ParyLiczb);

  gotoXY(16, 1);
  writeln('- STOS NPARZ -');
  wyswietlListe(StosNparz, 18, 2);
  gotoXY(38, 1);
  writeln('- STOS PARZ -');
  wyswietlListe(StosParz, 40, 2);
  gotoXY(54, 1);
  writeln('- PARY LICZB -');
  wyswietlCiagParLiczb(ParyLiczb, 55, 2);

  gotoXY(1, 28);
  writeln('Aby zakonczyc, nacisnij <ENTER>');
  readln;
end.