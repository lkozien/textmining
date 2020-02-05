# EGZAMIN 
Materiały na egzamin z Text Miningu

## Ważne
Dla termow trzeba pamietac, zeby macierz Term-Dokument miala parametr control.

* Macierz binarna             control = list(weighting = weightBin)
* Macierz liczebnosciowa      control = list(weighting = weightTf)
* Macierz TfIdf -             control = list(weighting = weightTfIdf)
* Macierz logarytmiczna -     control = list(weighting = function(x) weightSMART(x, spec = "lnn"))

## TODO
- [ ] Konwerter korpus -> wektor
- [ ] Konwerter korpus -> data.frame
- [ ] Konwerter macierz dokument-term -> data.frame
- [ ] Konwerter macierz term-dokument -> data.frame
- [X] Laborki 5 - Łukasz
- [ ] Laborki 6
- [ ] Funkcje do wykresów, które można wymyślić

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

### Funkcja normalizująca wektor min-max
```R
f_normalizuj <- function(x)
```
* Przyjmuje wektor
* Zwraca znormalizowany data.frame

#### Przykład użycia:
```R
znormalizowane_dane <- f_normalizuj(c(10000,13121,512,100,511,2220,511,20,11,311))
```

### Funkcja normalizująca data.frame bez kolumny z klasą

```R
f_normalizuj_dane <- function(x, column)
```
* Przyjmuje data.frame i kolumne z wynikiem
* Zwraca znormalizowany data.frame

#### Przykład użycia:
```R
nieznormalizowane_dane <- data.frame(hello = c(10,1,213,1231,511,123,161,271,1123,351),
                   business = c(0,1,3,0,1,2,0,1,2,3),
                   replica = c(3,2,1,0,0,0,1,0,3,0),
                   mail = c("spam","spam","ham","ham","ham","ham","spam","ham","spam","ham"))

znormalizowany_data_frame = f_normalizuj_dane(nieznormalizowane_dane, "mail")
```

## Funkcje rysujące:

### Funkcja rysujaca barplot z 10 najczestszymi termami
```R
f_rysuj_najczestsze_termy <- function(macierz_term_dokument)
```
* Przyjmuje macierz Term-Dokument
* Rysuje wykres liczebosci danych termow
* Macierz term-dokument musi byc oczyszczona przed uzyciem. Domyslnie wybiera z posortowanej tabeli 10 termow

#### Przykład użycia:
```R
korpus_nieoczyszczony <- f_wczytaj_dane_do_korpusu("coffee_tweets.csv")
korpus_oczyszczony <- f_czysc_korpus(korpus_nieoczyszczony)
macierz_term_dokument_oczyszczona <- TermDocumentMatrix(korpus_oczyszczony)
f_rysuj_najczestsze_termy(macierz_term_dokument_oczyszczona)
```

### Funkcja rysująca dendrogram
```R
f_rysuj_dendrogram <- function(matrix, metoda)
```
* Przyjmuje macierz i metode odległości (euclidean, manhattan, cosine, jaccard)
* Macierz musi byc oczyszczona

#### Przykład użycia:
```R
wektor_nieoczyszczony <- f_wczytaj_dane_do_wektora("coffee_tweets.csv")
wektor_oczyszczony <- f_czysc_wektor(wektor_nieoczyszczony)
macierz_term_dokument_oczyszczona <- f_przeksztalc_wektor_na_macierz_term_dokument(wektor_oczyszczony)
f_rysuj_dendrogram(matrix, "euclidean") # euclidean, manhattan, cosine, jaccard
```

## Funkcje do analizy:

### Funkcja wykonująca analizę korespondencji
```R
f_analiza_korespondencji<- function(macierz_dokument_term)
```
* Przyjmuje macierz dokument-term
* Zwraca korpus z informacjami?
* Macierz musi byc oczyszczona

#### Przykład użycia:
```R
przyslowia_wektor <- f_wczytaj_dane_do_wektora_z_txt("przyslowia.txt")
czyste_przyslowia <- f_czysc_wektor(przyslowia_wektor, c("czego", "czy", "i", "tego", "w", "z"))
przyslowia_lemy <- f_lematyzacja_wektora_zdan(czyste_przyslowia, "slownik.txt")
przyslowia_dokument_term <- f_przeksztalc_wektor_na_macierz_dokument_term(przyslowia_lemy)
wynik <- f_analiza_korespondencji(przyslowia_dokument_term)
```


### Funkcja obliczająca rzadkość termów w macierzy Term-Dokument
```R
f_rzadkosc_termow <- function(macierz_term_dokument)
```
* Przyjmuje macierz Term-Dokument
* Zwraca matryce
* Macierz Term-Dokument musi byc oczyszczona
* Im wieksza liczba tym rzadszy dokument. Np 10 dokumentow, "Jesien" 0.1, oznacza to, ze tylko w 1 na 10 pojawia sie to slowo. 
* Non-/sparse entries: X/Y - X termow ma wartosc niezerowa, Y zerowa we wszystkich dokumentach.
* Sparsity - np 95% - 95% procent komorek w tej matrycy ma wartosc 0


#### Przykład użycia:
```R
macierz_term_dokument_oczyszczona <- TermDocumentMatrix(korpus_oczyszczony, control = list(weighting = function(x) weightSMART(x, spec = "lnn")))
rzadkosc_termow <- f_rzadkosc_termow(macierz_term_dokument_oczyszczona)
```


### Funkcja do grupowania hierarchicznego
```R
f_oblicz_odleglosci_miedzy_dokumentami<- function(macierz_dokument_term)
```
* Przyjmuje macierz dokument-term
* Zwraca korpus z informacjami?
* Macierz musi byc oczyszczona


#### Przykład użycia:
```R
wektor <- f_wczytaj_dane_do_wektora("coffee_tweets.csv")
wektor_czysty <- f_czysc_wektor(wektor)
wektor_lemy <- f_lematyzacja_wektora_zdan(wektor_czysty, "slownik2.txt")
macierz_dokument_term <- f_przeksztalc_wektor_na_macierz_dokument_term(wektor_lemy)
odleglosc <- f_oblicz_odleglosci_miedzy_dokumentami(macierz_dokument_term)
odleglosc

# Grupowanie hierarchiczne
hg <- hclust(odleglosc)
plot(hg)
```


### Funkcja do grupowania niehierarchicznego
```R
f_normalizuj_i_grupuj_wektory_dokumentow<- function(macierz_dokument_term, ilosc_klastrow)
```
* Przyjmuje macierz dokument-term i ilosc klastrow
* Zwraca korpus z informacjami?
* Macierz musi byc oczyszczona


#### Przykład użycia:
```R
wektor_nieoczyszczony <- f_wczytaj_dane_do_wektora("coffee_tweets.csv")
wektor_oczyszczony <- f_czysc_wektor(wektor_nieoczyszczony)
wektor_lemy <- f_lematyzacja_wektora_zdan(wektor_oczyszczony, "slownik2.txt")
macierz_dokument_term <- f_przeksztalc_wektor_na_macierz_dokument_term(wektor_lemy)

# Grupowanie niehierarchiczne do podanej ilosci klastrow
wynik <- f_normalizuj_i_grupuj_wektory_dokumentow(macierz_dokument_term, 3)
wynik
```



## Konwertery:

### Funkcja przeksztalcajaca wektor na macierz Term-Dokument
```R
f_przeksztalc_wektor_na_macierz_term_dokument <- function(wektor)
```
* Przyjmuje wektor
* Zwraca macierz Term-Dokument
* Wektor musi byc oczyszczony przed uzyciem

#### Przykład użycia:
```R
wektor_nieoczyszczony <- f_wczytaj_dane_do_wektora("coffee_tweets.csv")
wektor_oczyszczony <- f_czysc_wektor(wektor_nieoczyszczony)
macierz_term_dokument_oczyszczona <- f_przeksztalc_wektor_na_macierz_term_dokument(wektor_oczyszczony)
```

### Funkcja przeksztalcajaca wektor na macierz Dokument-Term
```R
f_przeksztalc_wektor_na_macierz_dokument_term <- function(wektor)
```
* Przyjmuje wektor
* Zwraca macierz Dokument-Term
* Wektor musi byc oczyszczony przed uzyciem

#### Przykład użycia:
```R
przyslowia_wektor <- f_wczytaj_dane_do_wektora_z_txt("przyslowia.txt")
czyste_przyslowia <- f_czysc_wektor(przyslowia_wektor, c("czego", "czy", "i", "tego", "w", "z"))
przyslowia_lemy <- f_lematyzacja_wektora_zdan(czyste_przyslowia, "slownik.txt")
przyslowia_dokument_term <- f_przeksztalc_wektor_na_macierz_dokument_term(przyslowia_lemy)
```

## Funkcje klasyfikujące:

### Funkcja klasyfikująca KNN
```R
f_klasyfikuj_knn <- function(data, k, result_column_name, columns)
```
* Przyjmuje data.frame, ilość grup na którą powinno podzielić, kolumnę z wynikami i liczbę kolumn
* Zwraca macierz błędów 
* Macierz musi byc oczyszczona

#### Przykład użycia:
```R
dane <- data.frame(hello = c(1,1,2,1,1,0,1,2,1,3),
                   business = c(0,1,3,0,1,2,0,1,2,3),
                   replica = c(3,2,1,0,0,0,1,0,3,0),
                   mail = c("spam","spam","ham","ham","ham","ham","spam","ham","spam","ham"))

data_norm = f_normalizuj_dane(dane, "mail")
knn_k1 = f_klasyfikuj_knn(data_norm, 1, "mail", 4)
```


### Funkcja klasyfikująca Bayes
Ważne - zmienić wywołanie naiveBayes nazwa kolumny z klasą zamiast mail

```R
f_klasyfikuj_knn <- function(data, k, result_column_name, columns)
```
* Przyjmuje data.frame, kolumnę z wynikami i liczbę kolumn
* Zwraca macierz błędów 
* Macierz musi byc oczyszczona

#### Przykład użycia:
```R
dane <- data.frame(hello = c(1,1,2,1,1,0,1,2,1,3),
                   business = c(0,1,3,0,1,2,0,1,2,3),
                   replica = c(3,2,1,0,0,0,1,0,3,0),
                   mail = c("spam","spam","ham","ham","ham","ham","spam","ham","spam","ham"))

data_norm = f_normalizuj_dane(dane, "mail")
bayes_k1 = f_klasyfikuj_bayes(data_norm, "mail", 4)
```
