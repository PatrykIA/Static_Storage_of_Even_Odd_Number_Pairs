program Sprawozdanie2;
 // Program:Program zapisujący w tablicy zbiór par liczb parzysta-nieparzysta, AiSD7_Z2, ver.3.0, 19/01/2024
// Rogowski Patryk, Numer indeksu 162866, Rok 1,Wydział Techniki i Informatyki, grupa D2, Sem 1

uses CRT;
// Definicja rekordu tWezel reprezentującego węzeł listy jednokierunkowej

type
  wWezel = ^tWezel;
  tWezel = record
    Dana: integer;                           // Pole przechowujące wartość węzła
    Nastepny: wWezel;                       // Pole przechowujące wskaźnik do następnego węzła
  end;

 // Definicja rekordu tKolejka reprezentującego kolejkę

  tKolejka = record
    Pierwszy, Ostatni: wWezel;                  // Pola przechowujące wskaźniki na pierwszy i ostatni węzeł kolejki
  end;
 // Definicja rekordu tParaLiczb reprezentującego parę liczb całkowitych

  tParaLiczb = record
    L1, L2: integer;                            // Pola przechowujące dwie liczby całkowite
  end;
  // Definicja rekordu tCiagParLiczb reprezentującego ciąg par liczb

  tCiagParLiczb = record
    Elem: array[1..25] of tParaLiczb;    // Stała wielkość tablicy
    n: integer;                         // Pole przechowujące ilość par w ciągu
  end;

var
  Kolejka: tKolejka;                  // Struktura do obsługi kolejki
  StosNparz, StosParz: wWezel;       // Wskaźniki stosów parzystych i nieparzystych
  ParyLiczb: tCiagParLiczb;         // Struktura przechowująca ciąg par liczb

procedure wyswietlInfoOProgramie; forward;                                                     // Wyswietlanie informacji o programie w konsoli
procedure wyswietlListe(Lista: wWezel; X, Y: integer); forward;                               //Implementacja funkcji do wyświetlania listy jednokierunkowej.
procedure wyswietlCiagParLiczb(var Pary: tCiagParLiczb; X, Y: integer); forward;             // Implementacja funkcji do wyświetlania ciągu par liczb.
procedure DodajDoKolejki(var kolejka: tKolejka; L: integer); forward;                       // Implementacja funkcji dodającej element do kolejki.
function PobierzZKolejki(var kolejka: tKolejka): integer; forward;                         // Implementacja funkcji pobierającej element z kolejki.
procedure PolozNaStos(var stos: wWezel; L: integer); forward;                             // Implementacja funkcji kładącej element na stosie.
function ZdejmijZeStosu(var stos: wWezel): integer; forward;                             // Implementacja funkcji zdejmującej element ze stosu.
procedure LosujLiczbyDoKolejki(var kolejka: tKolejka); forward;                         // Implementacja funkcji losującej liczby i dodającej je do kolejki.
procedure RealizAlgCwicz(var kolejka: tKolejka; var pary: tCiagParLiczb); forward;     // Implementacja funkcji realizującej algorytm ćwiczeniowy.

procedure wyswietlInfoOProgramie;
begin
  writeln('Program:Program zapisujący w tablicy zbiór par liczb parzysta-nieparzysta, ver 3.0, _AiSD7_Z2');
  writeln('Autor: Rogowski Patryk, Numer indeksu 162866, Rok 1,Wydział Techniki i Informatyki, grupa D2, Sem 1');
end;

procedure wyswietlListe(Lista: wWezel; X, Y: integer);
var
  wsk: wWezel;                       // Wskaźnik na aktualny węzeł listy
  i: integer;                       // Licznik elementów listy
begin
  wsk := Lista;                       // Inicjalizacja wskaźnika na początek listy
  i := 1;                            // Inicjalizacja licznika
  while (wsk <> nil) do             // Iteracja przez listę jednokierunkową
  begin                            // Warunek dla przejścia do nowego wiersza, gdy osiągnięto 27 elementów w jednym wierszu
    if i = 27 then
    begin
      y := Y - 5;                  // Przesunięcie na nowy wiersz
      X := X + 11;                // Przesunięcie do nowej kolumny
    end;
    gotoXY(X, Y);                                           // Ustawienie kursora na pozycji (X, Y)
    writeln(i:2, ' : ', (wsk^.Dana):3, ' ');               // Wyświetlenie numeru i wartości elementu
    wsk := wsk^.Nastepny;                                 // Przejście do następnego węzła
    i := i + 1;                                          // Inkrementacja licznika
    Y := Y + 1;                                         // Przesunięcie na następną pozycję Y
  end; //while
end;

procedure wyswietlCiagParLiczb(var Pary: tCiagParLiczb; X, Y: integer);
var
  i: integer;                 // Licznik iteracji przez ciąg par liczb
begin
  for i := 1 to Pary.n do
  begin
    gotoXY(X, Y);                      // Ustawienie kursora na pozycji (X, Y)
    writeln(i:2, ' : ', (Pary.Elem[i].L1):3, ' - ', (Pary.Elem[i].L2):3, ' ');      // Wyświetlenie numeru i par liczb
    Y := Y + 1;                                                                    // Przesunięcie na następną pozycję Y
  end;
end;

procedure DodajDoKolejki(var kolejka: tKolejka; L: integer);
var
  wskNowy: wWezel;                                                        // Wskaźnik na nowy węzeł do dodania do kolejki
begin
  new(wskNowy);                                                         // Utworzenie nowego węzła
  wskNowy^.Dana := L;                                                  // Przypisanie wartości do pola Dana w nowym węźle
  wskNowy^.Nastepny := nil;
  if kolejka.Pierwszy = nil then
    kolejka.Pierwszy := wskNowy                                      // Jeśli kolejka jest pusta, nowy węzeł staje się pierwszym elementem
  else
    kolejka.Ostatni^.Nastepny := wskNowy;                          // W przeciwnym razie nowy węzeł zostaje dodany na koniec kolejki
  Kolejka.Ostatni := wskNowy;                                     // Aktualizacja wskaźnika Ostatni na nowy węzeł
end;

function PobierzZKolejki(var kolejka: tKolejka): integer;
var
  L: integer;                                                // Zmienna do przechowania pobranej wartości z kolejki
  wskUsuw: wWezel;                                          // Wskaźnik na węzeł do usunięcia z kolejki
begin
  if kolejka.Pierwszy = nil then
    PobierzZKolejki := 0                                // Jeśli kolejka jest pusta, zwróć zero
  else
  begin
    L := kolejka.Pierwszy^.Dana;                              // Pobierz wartość z pierwszego elementu kolejki
    wskUsuw := kolejka.Pierwszy;                             // Przypisz wskaźnik do pierwszego elementu kolejki do zmiennej tymczasowej
    kolejka.Pierwszy := kolejka.Pierwszy^.Nastepny;         // Aktualizuj wskaźnik Pierwszy na drugi element
    dispose(wskUsuw);                                      // Zwolnij pamięć za pomocą dispose
    if kolejka.Pierwszy = nil then                        // Jeśli kolejka stała się pusta, zaktualizuj wskaźnik Ostatni
      kolejka.Ostatni := nil;

    PobierzZKolejki := L;                              // Zwróć pobraną wartość z kolejki
  end;
end;

procedure PolozNaStos(var stos: wWezel; L: integer);
var
  wskNowy: wWezel;                                          // Wskaźnik na nowy węzeł do dodania na stos
begin
  new(wskNowy);                                           // Utworzenie nowego węzła
  wskNowy^.Dana := L;                                    // Przypisanie wartości do pola Dana w nowym węźle
  wskNowy^.Nastepny := stos;                            // Ustawienie wskaźnika Nastepny na poprzedni wierzchołek stosu
  stos := wskNowy;                                     // Aktualizacja wskaźnika stosu na nowy węzeł
end;

function ZdejmijZeStosu(var stos: wWezel): integer;
var
  L: integer;                                    // Zmienna do przechowania zdjętej wartości ze stosu
  wskUsuw: wWezel;                              // Wskaźnik na węzeł do usunięcia ze stosu
begin
  if stos = nil then
    ZdejmijZeStosu := 0                         // Jeśli stos jest pusty, zwróć zero
  else
  begin
    L := stos^.Dana;                                 // Pobierz wartość ze szczytu stosu
    wskUsuw := stos;                                // Przypisz wskaźnik na wierzchołek stosu do zmiennej tymczasowej
    stos := stos^.Nastepny;                        // Aktualizuj wskaźnik stosu na następny element
    dispose(wskUsuw);                             // Zwolnij pamięć za pomocą dispose

    ZdejmijZeStosu := L;                           // Zwróć zdjętą wartość ze stosu
  end;
end;

procedure LosujLiczbyDoKolejki(var kolejka: tKolejka);
var
  L: integer;                                      // Zmienna do przechowania losowej liczby
  i: integer;                                     // Licznik iteracji
begin
  while kolejka.Pierwszy <> nil do                    // Opróżnij kolejkę, usuwając wszystkie elementy
    L := PobierzZKolejki(kolejka);

  for i := 1 to 25 do                               // Losuj i dodaj 25 liczb do kolejki
  begin
    L := random(1000);                               // Wygeneruj losową liczbę całkowitą z przedziału [0, 999]
    DodajDoKolejki(kolejka, L);                     // Dodaj wylosowaną liczbę do kolejki
  end;
end;

procedure RealizAlgCwicz(var kolejka: tKolejka; var pary: tCiagParLiczb);
var
  L, LNparz, LParz: integer;                           // Zmienne do przechowywania aktualnej liczby oraz liczb z stosów
begin
  while StosNparz <> nil do                          // Opróżnij oba stosy, usuwając wszystkie elementy
    L := ZdejmijZeStosu(StosNparz);
  while StosParz <> nil do
    L := ZdejmijZeStosu(StosParz);

  while kolejka.Pierwszy <> nil do                   // Przeprowadź operacje na elementach kolejki
  begin
    L := PobierzZKolejki(kolejka);
    if L mod 2 <> 0 then                             // Jeśli liczba jest nieparzysta, umieść na stosie nieparzystych
      PolozNaStos(StosNparz, L)
    else
      PolozNaStos(StosParz, L);                     // W przeciwnym razie umieść na stosie parzystych
  end;

  pary.n := 0;                                                // Inicjalizuj licznik par w strukturze pary
  while (StosNparz <> nil) and (StosParz <> nil) do          // Dopóki oba stosy nie są puste, pobieraj liczby z obu stosów i twórz pary
  begin
    LNparz := ZdejmijZeStosu(StosNparz);
    LParz := ZdejmijZeStosu(StosParz);
    pary.n := pary.n + 1;                                   // Zwiększ licznik par i zapisz parę liczb w strukturze pary
    pary.Elem[pary.n].L1 := LNparz;
    pary.Elem[pary.n].L2 := LParz;
  end;
end;

begin
  Randomize;                                          // Inicjalizacja generatora liczb losowych
  Kolejka.Pierwszy := nil;                           // Inicjalizacja wskaźników struktury Kolejka
  Kolejka.Ostatni := nil;
  StosNparz := nil;                                    // Inicjalizacja wskaźników stosów StosNparz i StosParz
  StosParz := nil;
  ParyLiczb.N := 0;                                  // Inicjalizacja licznika par w strukturze ParyLiczb

  wyswietlInfoOProgramie;                          // Wyświetlenie informacji o programie
  writeln;
  writeln('Nacisnij <ENTER>... ');
  readln;

  ClrScr;                                             // Wyczyszczenie ekranu konsoli

  LosujLiczbyDoKolejki(Kolejka);                    // Wygenerowanie losowych liczb i dodanie ich do kolejki

  gotoXY(1, 1);
  writeln('- KOLEJKA -');
  wyswietlListe(Kolejka.Pierwszy, 2, 2);             // Wyświetlenie zawartości kolejki

  RealizAlgCwicz(Kolejka, ParyLiczb);              // Realizacja algorytmu ćwiczeniowego

  gotoXY(16, 1);
  writeln('- STOS NPARZ -');
  wyswietlListe(StosNparz, 18, 2);                 // Wyświetlenie zawartości stosu nieparzystych
  gotoXY(38, 1);
  writeln('- STOS PARZ -');
  wyswietlListe(StosParz, 40, 2);                 // Wyświetlenie zawartości stosu parzystych
  gotoXY(54, 1);
  writeln('- PARY LICZB -');
  wyswietlCiagParLiczb(ParyLiczb, 55, 2);          // Wyświetlenie zawartości ciągu par liczb

  gotoXY(1, 28);
  writeln('Aby zakonczyc, nacisnij <ENTER>');
  readln;
end.
