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



