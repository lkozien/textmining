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

### Funkcja wczytująca dane z pliku do macierzy term-dokument
```R
f_wczytaj_dane_do_macierzy_term_dokument <- function(sciezka_do_pliku = "")
```
* Przyjmuje sciezke do pliku
* Zwraca macierz Term-Dokument
* Domyslnie wczytuje 20 wierszy, szukajac tekstu w kolumnie 2
* Mozna przerobic, zeby zwracala wektor lub korpus, wystarczy od tylu usuwac przeksztalcenia
* Dziala na CSV ale takze na TXT jesli sa tam kolumny rozdzielone ;

### Funkcja wczytująca dane z pliku do wektora
```R
f_wczytaj_dane_do_wektora <- function(sciezka_do_pliku)
```
* Przyjmuje sciezke do pliku
* Zwraca pojedynczy wektor ze wszystkimi danymi

### Funkcja wczytująca z pliku txt do wektora
```R
f_wczytaj_dane_do_wektora_z_txt <- function(sciezka_do_pliku, separator=","){
```
* Przyjmuje sciezke do pliku i (opcjonalnie) separator
* Zwraca pojedynczy wektor ze wszystkimi danymi
