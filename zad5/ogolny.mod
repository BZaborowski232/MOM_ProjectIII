# Plik optymalizacji produkcji z uwzględnieniem składników, przychodów, kosztów i zanieczyszczeń
set PRODUKTY;
set SKLADNIKI;
set CELE;
set CELE_MAKSYMALIZACJA;
set CELE_MINIMALIZACJA;

# Parametry modelu
param PRODUKT_PRZYCHOD{p in PRODUKTY}; # Przychód z produkcji danego produktu
param POZIOM_ZANIECZYSZCZEN_PRODUKT{p in PRODUKTY};	 # Poziom zanieczyszczeń generowany przez dany produkt
param KOSZT_PRODUKCJA{p in PRODUKTY};	 # Koszt produkcji danego produktu
param PRODUKT_SKLADNIK{p in PRODUKTY, c in SKLADNIKI};	 # Ilość składnika c potrzebna do produkcji produktu p

param SKLADNIKI_UZYCIE_MAX{c in SKLADNIKI};	 # Maksymalne zużycie składnika c
param PRODUKCJA_MIN{p in PRODUKTY};	 # Minimalna produkcja produktu p

param PRZYCHOD_MIN;	 # Minimalny przychód, który musi zostać osiągnięty
param EMISJA_ZANIECZYSZCZEN_MAX;	 # Maksymalna emisja zanieczyszczeń, która może zostać wygenerowana
param KOSZT_MAX;	 # Maksymalny koszt produkcji, który może zostać poniesiony

param ZAMIERZENIA{o in CELE};	 # Wartości docelowe dla celów


# Zmienne modelu
var produkcja{p in PRODUKTY} >= 0;	 # Ilość produkcji dla każdego produktu, musi być nieujemna

var skladniki_uzycie{c in SKLADNIKI};	 # Ilość składników użytych w produkcji, może być zerowa

var przychod;	 # Całkowity przychód z produkcji

var zanieczyszczenia;	 # Całkowita emisja zanieczyszczeń

var koszt;	 # Całkowity koszt produkcji

# Cele optymalizacji
var cele{o in CELE};
s.t. cele_1: cele['S1'] = skladniki_uzycie['S1'];
s.t. cele_2: cele['S2'] = skladniki_uzycie['S2'];
s.t. cele_3: cele['przychod'] = przychod;
s.t. cele_4: cele['zanieczyszczenia'] = zanieczyszczenia;
s.t. cele_5: cele['koszt'] = koszt;

# Cele krytyczne, które muszą być spełnione
var limity_krytyczne{o in CELE};
s.t. limity_krytyczne_1: limity_krytyczne['S1'] = SKLADNIKI_UZYCIE_MAX['S1'];
s.t. limity_krytyczne_2: limity_krytyczne['S2'] = SKLADNIKI_UZYCIE_MAX['S2'];
s.t. limity_krytyczne_3: limity_krytyczne['przychod'] = PRZYCHOD_MIN;
s.t. limity_krytyczne_4: limity_krytyczne['zanieczyszczenia'] = EMISJA_ZANIECZYSZCZEN_MAX;
s.t. limity_krytyczne_5: limity_krytyczne['koszt'] = KOSZT_MAX;

# Ograniczenia modelu
subject to skladniki_uzycie_constraint{c in SKLADNIKI}:
	skladniki_uzycie[c] = sum{p in PRODUKTY} PRODUKT_SKLADNIK[p, c] * produkcja[p];

subject to przychod_constraint:
	przychod = (sum{p in PRODUKTY} PRODUKT_PRZYCHOD[p] * produkcja[p]) - koszt;

subject to zanieczyszczenia_constraint:
	zanieczyszczenia = sum{p in PRODUKTY} POZIOM_ZANIECZYSZCZEN_PRODUKT[p] * produkcja[p];
	
subject to koszt_constraint:
	koszt = sum{p in PRODUKTY} KOSZT_PRODUKCJA[p] * produkcja[p];


subject to skladniki_uzycie_max_constraint{c in SKLADNIKI}:
	skladniki_uzycie[c] <= SKLADNIKI_UZYCIE_MAX[c];
	
subject to produkcja_min_constraint{p in PRODUKTY}:
	produkcja[p] >= PRODUKCJA_MIN[p];


subject to przychod_min_constraint:
	przychod >= PRZYCHOD_MIN;

subject to emisja_zanieczyszczen_max_constraint:
	zanieczyszczenia <= EMISJA_ZANIECZYSZCZEN_MAX;

subject to koszt_max_constraint:
	koszt <= KOSZT_MAX;
