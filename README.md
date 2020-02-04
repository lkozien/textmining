# EGZAMIN 
Materiały na egzamin z Text Miningu

## Funkcje do wczytywania:

### Funkcja wczytująca dane z pliku do korpusu
```R
f_wczytaj_dane_do_korpusu <- function(sciezka_do_pliku = "")
```
* Przyjmuje sciezke do pliku
* Zwraca korpus
* Domyslnie wczytuje 20 wierszy, szukajac tekstu w kolumnie 2
* Mozna przerobic, zeby zwracala wektor
* Dziala na CSV ale takze na TXT jesli sa tam kolumny rozdzielone ;

#### Przykład użycia:
```R
korpus <- f_wczytaj_dane_do_korpusu("coffee_tweets.csv")
inspect(korpus)
```

### Funkcja wczytująca dane z pliku do macierzy term-dokument
```R
f_wczytaj_dane_do_macierzy_term_dokument <- function(sciezka_do_pliku = "")
```
* Przyjmuje sciezke do pliku
* Zwraca macierz Term-Dokument
* Domyslnie wczytuje 20 wierszy, szukajac tekstu w kolumnie 2
* Mozna przerobic, zeby zwracala wektor lub korpus, wystarczy od tylu usuwac przeksztalcenia
* Dziala na CSV ale takze na TXT jesli sa tam kolumny rozdzielone ;

#### Przykład użycia:
```R
korpus <- f_wczytaj_dane_do_korpusu("coffee_tweets.csv")
```

### Funkcja wczytująca dane z pliku do wektora
```R
f_wczytaj_dane_do_wektora <- function(sciezka_do_pliku)
```
* Przyjmuje sciezke do pliku
* Zwraca pojedynczy wektor ze wszystkimi danymi

#### Przykład użycia:
```R
wektor <- f_wczytaj_dane_do_wektora("coffee_tweets.csv")
```

## Funkcje do czyszczenia:

### Funkcja czyszcząca korpus
```R
f_czysc_korpus <- function(korpus, slowa = "")
```
* Przyjmuje korpus i (opcjonalnie) dodatkowe słowa do wyczyszczenia
* Zwraca wyczyszczony korpus

#### Przykład użycia:
```R
czysty_korpus <- f_czysc_korpus(korpus)
```

### Funkcja czyszcząca wektor
```R
f_czysc_wektor <- function(wektor, slowa="")
```
* Przyjmuje wektor i (opcjonalnie) dodatkowe słowa do wyczyszczenia
* Zwraca wyczyszczony wektor

#### Przykład użycia:
```R
wektor <- f_wczytaj_dane_do_wektora("coffee_tweets.csv")
czysty_wektor <- f_czysc_wektor(wektor)

wektor <- f_wczytaj_dane_do_wektora_z_txt("przyslowia.txt")
czysty_wektor <- f_czysc_wektor(wektor, slowa = c("czego", "czy", "i", "tego", "w", "z"))
```

### Funkcja usuwająca termy występujące rzadziej niż podana granica
```R
f_usun_rzadke_termy <- function(macierz_term_dokument, granica){
```
* Przyjmuje macierz Term-Dokument i granice występowania
* Zwraca macierz Term-Dokument
* Macierz Term-Dokument musi byc oczyszczona
* Im wieksza liczba tym rzadszy dokument. Np 10 dokumentow, "Jesien" 0.1, oznacza to, ze tylko w 1 na 10 pojawia sie to slowo

#### Przykład użycia:
```R
macierz_term_dokument_oczyszczona <- TermDocumentMatrix(korpus_oczyszczony, list(weighting = function(x) weightSMART(x, spec = "lnn")))
termy_najczestsze <- f_usun_rzadke_termy(macierz_term_dokument_oczyszczona, 0.95)
```

### Funkcja wykonująca stemming na korpusie 

> Stemming – w wyszukiwaniu informacji oraz w morfologii (w językoznawstwie) jest to proces usunięcia ze słowa końcówki fleksyjnej pozostawiając tylko temat wyrazu. Proces stemmingu może być przeprowadzany w celu zmierzenia popularności danego słowa. Końcówki fleksyjne zaniżają faktyczne dane. Algorytmy stemmingu są przedmiotem badań informatyki od lat 60. XX wieku. Pierwszy stemmer, czyli program do przeprowadzania procesu stemmingu, został napisany i opublikowany przez Julie Beth Lovins w 1968. W czerwcu 1980 Martin Porter opublikował swój algorytm stemmingu, zwany Algorytmem Portera. Np. angielskie słowa: „connection”, „connections”, „connective”, „connected”, „connecting” poddane stemmingowi dadzą ten sam wynik, czyli słowo „connect”


```R
f_steeming_korpusu <- function(korpus){
```
* Przyjmuje macierz Term-Dokument i granice występowania
* Zwraca macierz Term-Dokument
* Macierz Term-Dokument musi byc oczyszczona
* Im wieksza liczba tym rzadszy dokument. Np 10 dokumentow, "Jesien" 0.1, oznacza to, ze tylko w 1 na 10 pojawia sie to slowo

#### Przykład użycia:
```R
korpus_nieoczyszczony <- f_wczytaj_dane_do_korpusu("coffee_tweets.csv")
korpus_oczyszczony <- f_czysc_korpus(korpus_nieoczyszczony)
macierz_steeming <- f_steeming_korpusu(korpus_oczyszczony)
```

### Funkcja wykonująca lematyzacje na wektorze

> lematyzacja to sprowadzanie danego słowa do jego formy podstawowej (hasłowej), która reprezentuje dany wyraz, np. wiórkami → wiórek, jeżdżący → jeździć, uległa → ulec lub uległy; słowo specjalistyczne

```R
f_lematyzacja_wektora_zdan <- function(wektor_zdan, sciezka_do_slownika){
```
* Przyjmuje wektor z oryginalnymi slowami, slownik - 1 kolumna slowo podstawowe, 2 odmiana
* Zwraca wektor z lemami
* Wektor musi byc oczyszczony

#### Przykład użycia:
```R
wektor <- f_wczytaj_dane_do_wektora("coffee_tweets.csv")
wektor_czysty <- f_czysc_wektor(wektor)
wektor_lemy <- f_lematyzacja_wektora_zdan(wektor_czysty, "slownik2.txt")
```

