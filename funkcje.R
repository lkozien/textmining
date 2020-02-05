# Przestrze? robocza
install.packages(c("stringr", "stringi", "tm", "dplyr", "SnowballC", "dendextend", "ca", "factoextra","tidyr", "ggplot2", "kernlab", "caret", "class", "e1071"))
library("stringr")
library("stringi")
library("tm")
library("dplyr")
library("SnowballC")
library("dendextend")
library("ca")
library("factoextra")
library("tidyr")
library("ggplot2")
library("kernlab")
library("caret")
library("class")
library("e1071")

setwd("C:/Users/gryff/Documents/R")

# ------------------------------------------------------------------------------------------------------------------
# Funkcja wczytujaca dane z pliku do macierzy Term-Dokument
# --- Zwraca macierz Term-Dokument
# --- Domyslnie wczytuje 20 wierszy, szukajac tekstu w kolumnie 2
# --- Mozna przerobic, zeby zwracala wektor lub korpus, wystarczy od tylu usuwac przeksztalcenia
# --- Dziala na CSV ale takze na TXT jesli sa tam kolumny rozdzielone ;
# ------------------------------------------------------------------------------------------------------------------
f_wczytaj_dane_do_macierzy_term_dokument <- function(sciezka_do_pliku = ""){

  # Wczytanie pliku, pierwszych 20 wierszy
  n_wierszy_wszystkie_kolumny <- read.csv2(sciezka_do_pliku, nrows = 20, stringsAsFactors = FALSE)
  
  # Wyciagniecie tylko kolumny z tekstem, tutaj kolumna nr 2
  n_wierszy_z_kolumny_x = n_wierszy_wszystkie_kolumny[,2]
  
  # Zmiana kodowania
  n_wierszy_z_kolumny_x_UTF_8 <- stri_encode(n_wierszy_z_kolumny_x, to = "UTF-8")
  
  # Utworzenie Wektora tekstowego
  dane_w_postaci_wektora <- VectorSource(n_wierszy_z_kolumny_x_UTF_8)
  
  # Utworzenie Korpusu wektora
  dane_w_postaci_korpusu <- VCorpus(dane_w_postaci_wektora)
  
  # ---Sprawdzanie zawartosci---
  # dane_w_postaci_korpusu[[1]]$content
  # dane_w_postaci_korpusu
  # inspect(dane_w_postaci_korpusu)
  
  # Utworzenie macierzy Term-Document
  dane_w_postaci_macierzy_term_dokument <- TermDocumentMatrix(dane_w_postaci_korpusu)
  
  # ---Sprawdzenie zawartosci---
  # inspect(dane_w_postaci_macierzy_term_dokument)
}

macierz <- f_wczytaj_dane_do_macierzy_term_dokument("coffee_tweets.csv")
inspect(macierz)







# ------------------------------------------------------------------------------------------------------------------
# Funkcja wczytujaca dane z pliku do Korpusu
# --- Zwraca korpus
# --- Domyslnie wczytuje 20 wierszy, szukajac tekstu w kolumnie 2
# --- Mozna przerobic, zeby zwracala wektor
# --- Dziala na CSV ale takze na TXT jesli sa tam kolumny rozdzielone ;
# ------------------------------------------------------------------------------------------------------------------
f_wczytaj_dane_do_korpusu <- function(sciezka_do_pliku = ""){

  # Wczytanie pliku, pierwszych 20 wierszy
  n_wierszy_wszystkie_kolumny <- read.csv2(sciezka_do_pliku, nrows = 20, stringsAsFactors = FALSE)
  
  # Wyciagniecie tylko kolumny z tekstem, tutaj kolumna nr 2
  n_wierszy_z_kolumny_x = n_wierszy_wszystkie_kolumny[,2]
  
  # Zmiana kodowania
  n_wierszy_z_kolumny_x_UTF_8 <- stri_encode(n_wierszy_z_kolumny_x, to = "UTF-8")
  
  # Utworzenie Wektora tekstowego
  dane_w_postaci_wektora <- VectorSource(n_wierszy_z_kolumny_x_UTF_8)
  
  # Utworzenie Korpusu wektora
  dane_w_postaci_korpusu <- VCorpus(dane_w_postaci_wektora)
  
  # ---Sprawdzanie zawartosci---
  # dane_w_postaci_korpusu[[1]]$content
  # dane_w_postaci_korpusu
  # inspect(dane_w_postaci_korpusu)
}

korpus <- f_wczytaj_dane_do_korpusu("coffee_tweets.csv")
inspect(korpus)







# ------------------------------------------------------------------------------------------------------------------
# Funkcja zmienia oczyszczony korpus na pojedynczy wektor
# --- Przyjmuje sciezke do pliku
# --- Zwraca pojedynczy wektor ze wszystkimi danymi
# ------------------------------------------------------------------------------------------------------------------
f_wczytaj_dane_do_wektora <- function(sciezka_do_pliku){
  
  n_wierszy_wszystkie_kolumny <- read.csv2(sciezka_do_pliku, nrows = 20, stringsAsFactors = FALSE)
  
  # Wyciagniecie tylko kolumny z tekstem, tutaj kolumna nr 2
  n_wierszy_z_kolumny_x = n_wierszy_wszystkie_kolumny[,2]
  
  # Zmiana kodowania
  n_wierszy_z_kolumny_x_UTF_8 <- stri_encode(n_wierszy_z_kolumny_x, to = "UTF-8")
  
  # Utworzenie wektora tekstowego
  dane_korpus <- Corpus(VectorSource(n_wierszy_z_kolumny_x_UTF_8))
  dataframe <- data.frame(text=sapply(dane_korpus, identity),stringsAsFactors=F)
  wektor <- dataframe[,1]
}

wektor <- f_wczytaj_dane_do_wektora("coffee_tweets.csv")







# ------------------------------------------------------------------------------------------------------------------
# Funkcja wczytuje dane z jednego pliku do wektora, rozdziela podanym separatorem
# --- Przyjmuje sciezke do pliku
# --- Zwraca pojedynczy wektor ze wszystkimi danymi
# ------------------------------------------------------------------------------------------------------------------
f_wczytaj_dane_do_wektora_z_txt <- function(sciezka_do_pliku, separator=","){
  
  wektor <- scan(sciezka_do_pliku, what="character", sep=separator, encoding = "UTF-8")
}

wektor <- f_wczytaj_dane_do_wektora_z_txt("przyslowia.txt")







# ------------------------------------------------------------------------------------------------------------------
# Funkcja czyszczaca korpus
# --- Przyjmuje korpus
# --- Zwraca korpus
# ------------------------------------------------------------------------------------------------------------------
f_czysc_korpus <- function(korpus, slowa = ""){
  # korpus <- tm_map(korpus, removeWords, "@") mozna dodac swoje znaki konkretne
  # korpus <- tm_map(korpus, content_transformer(function(x) str_replace_all(x, "-", ""))) #mozliwe, ze trzeba usunac jakies znaki specjalne
  
  # Zamiane duzych znakow na male
  korpus <- tm_map(korpus, content_transformer(tolower))
  
  # Usuniecie znakow przestankowych
  korpus <- tm_map(korpus, removePunctuation)
  
  # Usuniecie numerow
  korpus <- tm_map(korpus, removeNumbers)
  
  # Usuniecie swojego slowa
  korpus <- tm_map(korpus, removeWords, slowa)
  
  # Usuniecie stopwords
  korpus <- tm_map(korpus, removeWords, stopwords("en"))
  
  # Usuniecie bialych znakow
  korpus <- tm_map(korpus, stripWhitespace)
  
  # Czyszczenie bialych znakow z poczatku i konca <- tutaj NIE WOLNO tego uzywac, moze dla wektora to dziala, ale tutaj rozpierdala wszystko w drobny mak
  #korpus <- tm_map(korpus, str_trim)
}

korpus <- f_wczytaj_dane_do_korpusu("coffee_tweets.csv")

# Zeby usunac kilka dodatkowych slow jednoczesnia, po korpus uzyc c("slowo1", "slowo2", ...)
czysty_korpus <- f_czysc_korpus(korpus)
inspect(czysty_korpus)
warnings()
czysty_korpus[[20]]







# ------------------------------------------------------------------------------------------------------------------
# Funkcja czyszczaca wektor
# --- Przyjmuje wektor
# --- Zwraca wektor
# ------------------------------------------------------------------------------------------------------------------
f_czysc_wektor <- function(wektor, slowa=""){
  # wektor <- removeWords(wektor, "@") #mozna dodac swoje znaki konkretne
  wektor <- str_replace(wektor, "?", "") #mozliwe, ze trzeba usunac jakies znaki specjalne
  
  # Zamiane duzych znakow na male
  wektor <- tolower(wektor)
  
  # Usuniecie swojego slowa
  wektor <- removeWords(wektor, slowa)
  
  # Usuniecie stopwords
  wektor <- removeWords(wektor, stopwords("en"))
  
  # Usuniecie numerow
  wektor <- removeNumbers(wektor)
  
  # Usuniecie znakow przestankowych
  wektor <- removePunctuation(wektor)
  
  # Usuniecie bialych znakow
  wektor <- stripWhitespace(wektor)
  
  # Przyciecie bialych znakow z poczatku i konca
  wektor <- str_trim(wektor)
}

wektor <- f_wczytaj_dane_do_wektora("coffee_tweets.csv")
czysty_wektor <- f_czysc_wektor(wektor)

wektor <- f_wczytaj_dane_do_wektora_z_txt("przyslowia.txt")
czysty_wektor <- f_czysc_wektor(wektor, slowa = c("czego", "czy", "i", "tego", "w", "z"))






# ------------------------------------------------------------------------------------------------------------------
# Funkcja przeksztalcajaca wektor na macierz Dokument-Term
# --- Przyjmuje wektor
# --- Zwraca macierz Dokument-Term
# --- Wektor musi byc oczyszczony przed uzyciem
# ------------------------------------------------------------------------------------------------------------------
f_przeksztalc_wektor_na_macierz_dokument_term <- function(wektor){
  
  wektor_zrodlo <- VectorSource(wektor)
  
  wektor_korpus <- VCorpus(wektor_zrodlo)
  
  macierz_dokument_term <- DocumentTermMatrix(wektor_korpus)
}

wektor_nieoczyszczony <- f_wczytaj_dane_do_wektora("coffee_tweets.csv")
wektor_oczyszczony <- f_czysc_wektor(wektor_nieoczyszczony)
macierz_dokument_term_oczyszczona <- f_przeksztalc_wektor_na_macierz_dokument_term(wektor_oczyszczony)
inspect(macierz_dokument_term_oczyszczona)







# ------------------------------------------------------------------------------------------------------------------
# Funkcja przeksztalcajaca wektor na macierz Term-Dokument
# --- Przyjmuje wektor
# --- Zwraca macierz Term-Dokument
# --- Wektor musi byc oczyszczony przed uzyciem
# ------------------------------------------------------------------------------------------------------------------
f_przeksztalc_wektor_na_macierz_term_dokument <- function(wektor){
  
  wektor_zrodlo <- VectorSource(wektor)
  
  wektor_korpus <- VCorpus(wektor_zrodlo)
  
  macierz_term_dokument <- TermDocumentMatrix(wektor_korpus)
}

wektor_nieoczyszczony <- f_wczytaj_dane_do_wektora("coffee_tweets.csv")
wektor_oczyszczony <- f_czysc_wektor(wektor_nieoczyszczony)
macierz_term_dokument_oczyszczona <- f_przeksztalc_wektor_na_macierz_term_dokument(wektor_oczyszczony)
inspect(macierz_term_dokument_oczyszczona)










# ------------------------------------------------------------------------------------------------------------------
# Funkcja rysujaca 10 najczestszych termow
# --- Przyjmuje macierz Term-Dokument
# --- Rysuje wykres liczebosci danych termow
# --- Macierz term-dokument musi byc oczyszczona przed uzyciem. Domyslnie wybiera z posortowanej tabeli 10 termow
# ------------------------------------------------------------------------------------------------------------------
f_rysuj_najczestsze_termy <- function(macierz_term_dokument){

  # Konwersja do macierzy
  matryca <- as.matrix(macierz_term_dokument)
  
  # Obliczanie liczebno?ci term?w
  ilosc_termow <- rowSums(matryca)
  
  # Sortowanie wed?ug liczebno?ci
  ilosc_termow <- sort(ilosc_termow, decreasing = TRUE)
  
  # Generowanie wykresu
  barplot(ilosc_termow[1:10], col = "tan", las = 2)
}

korpus_nieoczyszczony <- f_wczytaj_dane_do_korpusu("coffee_tweets.csv")
korpus_oczyszczony <- f_czysc_korpus(korpus_nieoczyszczony)
macierz_term_dokument_oczyszczona <- TermDocumentMatrix(korpus_oczyszczony)
f_rysuj_najczestsze_termy(macierz_term_dokument_oczyszczona)





# ------------------------------------------------------------------------------------------------------------------
# Funkcja rysuje dendrogram
# --- Przyjmuje macierz i metode
# --- Macierz musi byc oczyszczona
# ------------------------------------------------------------------------------------------------------------------
f_rysuj_dendrogram <- function(matrix, metoda){
  odl <- dist(matrix, method = metoda)
  hg <- hclust(odl, method = "ward.D")
  hg_ladne <- as.dendrogram(hg)
  hg_ladne <- color_labels(hg_ladne,3, col = c("royalblue", "orangered", "seagreen"))
  hg_ladne <- color_branches(hg_ladne,3, col = c("royalblue", "orangered", "seagreen"))
  plot(hg_ladne, main = paste("Dendogram na podstawie miary:\n", metoda))
  rect.dendrogram(hg_ladne, k = 3, border = "grey20", lty = 2)
}

wektor_nieoczyszczony <- f_wczytaj_dane_do_wektora("coffee_tweets.csv")
wektor_oczyszczony <- f_czysc_wektor(wektor_nieoczyszczony)
macierz_term_dokument_oczyszczona <- f_przeksztalc_wektor_na_macierz_term_dokument(wektor_oczyszczony)
matrix <- as.matrix(macierz_term_dokument_oczyszczona)
f_rysuj_dendrogram(matrix, "euclidean") # euclidean, manhattan, cosine, jaccard







# ------------------------------------------------------------------------------------------------------------------
# Funkcja steeming dla korpusu
# --- Przyjmuje korpus
# --- Zwraca macierz Term-Dokument
# --- Korpus musi byc oczyszczony
# ------------------------------------------------------------------------------------------------------------------
f_steeming_korpusu <- function(korpus){
  
  # Steeming - wyszukiwanie rdzenia slow dla korpusu
  korpus <- tm_map(korpus, stemDocument)
  
  # Konwersja na macierz Term-Dokument
  macierz_term_dokument <- TermDocumentMatrix(korpus)
}

korpus_nieoczyszczony <- f_wczytaj_dane_do_korpusu("coffee_tweets.csv")
korpus_oczyszczony <- f_czysc_korpus(korpus_nieoczyszczony)
macierz_steeming <- f_steeming_korpusu(korpus_oczyszczony)








# ------------------------------------------------------------------------------------------------------------------
# Funkcja obliczajaca rzadkosc termow w macierzy Term-Dokument
# --- Przyjmuje macierz Term-Dokument
# --- Zwraca matryce
# --- Macierz Term-Dokument musi byc oczyszczona
# --- Im wieksza liczba tym rzadszy dokument. Np 10 dokumentow, "Jesien" 0.1, oznacza to, ze tylko w 1 na 10 pojawia
# --- sie to slowo. 
# --- Non-/sparse entries: X/Y - X termow ma wartosc niezerowa, Y zerowa we wszystkich dokumentach.
# --- Sparsity - np 95% - 95% procent komorek w tej matrycy ma wartosc 0
# ------------------------------------------------------------------------------------------------------------------
f_rzadkosc_termow <- function(macierz_term_dokument){

  matryca <- as.matrix(macierz_term_dokument)
  rzadkoscTermow <- sort(1-rowSums(matryca)/nDocs(macierz_term_dokument))
}

korpus_nieoczyszczony <- f_wczytaj_dane_do_korpusu("coffee_tweets.csv")
korpus_oczyszczony <- f_czysc_korpus(korpus_nieoczyszczony)

# Dla termow trzeba pamietac, zeby macierz Term-Dokument miala parametr control.
# Macierz binarna             control = list(weighting = weightBin)
# Macierz liczebnosciowa      control = list(weighting = weightTf)
# Macierz TfIdf -             control = list(weighting = weightTfIdf)
# Macierz logarytmiczna -     control = list(weighting = function(x) weightSMART(x, spec = "lnn"))
macierz_term_dokument_oczyszczona <- TermDocumentMatrix(korpus_oczyszczony, control = list(weighting = function(x) weightSMART(x, spec = "lnn")))
rzadkosc_termow <- f_rzadkosc_termow(macierz_term_dokument_oczyszczona)

rzadkosc_termow






# ------------------------------------------------------------------------------------------------------------------
# Funkcja usuwajaca termy powyzej okreslonej granicy - czyli usuwamy te, ktore wystepuja najrzadziej
# --- Przyjmuje macierz Term-Dokument
# --- Zwraca macierz Term-Dokument
# --- Macierz Term-Dokument musi byc oczyszczona
# --- Im wieksza liczba tym rzadszy dokument. Np 10 dokumentow, "Jesien" 0.1, oznacza to, ze tylko w 1 na 10 pojawia
# --- sie to slowo
# ------------------------------------------------------------------------------------------------------------------
f_usun_rzadke_termy <- function(macierz_term_dokument, granica){

  removeSparseTerms(macierz_term_dokument, granica)
}

korpus_nieoczyszczony <- f_wczytaj_dane_do_korpusu("coffee_tweets.csv")
korpus_oczyszczony <- f_czysc_korpus(korpus_nieoczyszczony)

# Dla termow trzeba pamietac, zeby macierz Term-Dokument miala parametr control.
# Macierz binarna             control = list(weighting = weightBin)
# Macierz liczebnosciowa      control = list(weighting = weightTf)
# Macierz TfIdf -             control = list(weighting = weightTfIdf)
# Macierz logarytmiczna -     control = list(weighting = function(x) weightSMART(x, spec = "lnn"))
macierz_term_dokument_oczyszczona <- TermDocumentMatrix(korpus_oczyszczony, list(weighting = function(x) weightSMART(x, spec = "lnn")))
termy_najczestsze <- f_usun_rzadke_termy(macierz_term_dokument_oczyszczona, 0.95)

termy_najczestsze

f_rysuj_najczestsze_termy(termy_najczestsze)






# ------------------------------------------------------------------------------------------------------------------
# Funkcja lematyzacji wektora zdan - czyli zamiana slow na formy podstawowe
# --- Przyjmuje wektor z oryginalnymi slowami, slownik - 1 kolumna slowo podstawowe, 2 odmiana
# --- Zwraca wektor z lemami
# --- Wektor musi byc oczyszczony
# ------------------------------------------------------------------------------------------------------------------
f_lematyzacja_wektora_zdan <- function(wektor_zdan, sciezka_do_slownika){
  
  # Wczytanie slownika ze slowami podstawowymi i odmianami
  slownik <- read.csv2(sciezka_do_slownika, header=F, stringsAsFactors=FALSE)
  
  # W 1 kolumnie sa formy podstawowe
  formy_podstawowe<-slownik[,1]
  
  # W 2 kolumnie sa formy odmienione
  names(formy_podstawowe)<-slownik[,2] # chyba mozna tez napisac formy_odmienione <- slownik[,2]
  
  # Zamiana odmian na formy podstawowe
  lemy <- str_replace_all(wektor_zdan, formy_podstawowe)
}

wektor <- f_wczytaj_dane_do_wektora("coffee_tweets.csv")
wektor_czysty <- f_czysc_wektor(wektor)
wektor_lemy <- f_lematyzacja_wektora_zdan(wektor_czysty, "slownik2.txt")






# ------------------------------------------------------------------------------------------------------------------
# Funkcja oblicza odelosci miedzy dokumentami - do grupowania hierarchicznego
# --- Przyjmuje macierz dokument-term
# --- Zwraca wektor(?) odleglosci
# ------------------------------------------------------------------------------------------------------------------
f_oblicz_odleglosci_miedzy_dokumentami<- function(macierz_dokument_term){

  # Obliczenie odleg?o?ci pomi?dzy dokumentami
  
  dokumenty_data_matrix <- as.matrix(macierz_dokument_term)
  odl <- dist(dokumenty_data_matrix) # domyslnie uzyta jest miara euklidesowa (method = "euclidean")
}

wektor <- f_wczytaj_dane_do_wektora("coffee_tweets.csv")
wektor_czysty <- f_czysc_wektor(wektor)
wektor_lemy <- f_lematyzacja_wektora_zdan(wektor_czysty, "slownik2.txt")
macierz_dokument_term <- f_przeksztalc_wektor_na_macierz_dokument_term(wektor_lemy)
odleglosc <- f_oblicz_odleglosci_miedzy_dokumentami(macierz_dokument_term)
odleglosc

# Grupowanie hierarchiczne
hg <- hclust(odleglosc)
plot(hg)


# ------------------------------------------------------------------------------------------------------------------
# Funkcja normalizacji wektorow dokumentow i grupowanie - do grupowania niehierarchicznego
# --- Przyjmuje macierz dokument-term
# --- Zwraca korpus z informacjami?
# ------------------------------------------------------------------------------------------------------------------
f_normalizuj_i_grupuj_wektory_dokumentow<- function(macierz_dokument_term, ilosc_klastrow){
  
  # Konwersja na macierz
  matrix <- as.matrix(macierz_dokument_term)
  
  # Obliczenia
  matrix_scale <- t(scale(t(matrix), center=FALSE, scale=sqrt(rowSums(matrix^2))))
  
  km <- kmeans(matrix_scale, ilosc_klastrow)
}

wektor_nieoczyszczony <- f_wczytaj_dane_do_wektora("coffee_tweets.csv")
wektor_oczyszczony <- f_czysc_wektor(wektor_nieoczyszczony)
wektor_lemy <- f_lematyzacja_wektora_zdan(wektor_oczyszczony, "slownik2.txt")
macierz_dokument_term <- f_przeksztalc_wektor_na_macierz_dokument_term(wektor_lemy)

# Grupowanie niehierarchiczne do podanej ilosci klastrow
wynik <- f_normalizuj_i_grupuj_wektory_dokumentow(macierz_dokument_term, 3)
wynik

# dzia?ania

# Sortowanie kolumn
sort(wynik$centers[1,], decreasing = T)
sort(wynik$centers[2,], decreasing = T)
sort(wynik$centers[3,], decreasing = T)

# Wywalenie lemow, ktore wystepuja najrzadziej
colnames(wynik$centers)[wynik$centers[1,] != 0]
colnames(wynik$centers)[wynik$centers[2,] != 0]
colnames(wynik$centers)[wynik$centers[3,] != 0]

# Ktory dokument nalezy do ktorego klastra
wynik$cluster == 1
Docs(macierz_dokument_term[wynik$cluster == 1,])

# Najszczestsze termy dla danego klastra
findFreqTerms(macierz_dokument_term[wynik$cluster == 1,], 2)
findFreqTerms(macierz_dokument_term[wynik$cluster == 2,], 2)
findFreqTerms(macierz_dokument_term[wynik$cluster == 3,], 2)








# ------------------------------------------------------------------------------------------------------------------
# Funkcja przeprowadza analize korespondencji
# --- Przyjmuje macierz dokument-term
# --- Zwraca korpus z informacjami?
# --- Macierz musi byc oczyszczona
# ------------------------------------------------------------------------------------------------------------------
f_analiza_korespondencji<- function(macierz_dokument_term){
  
  # Konwersja na macierz
  przyslowia_matrix <- as.matrix(macierz_dokument_term)
  
  # Obliczenia
  wynik <- ca(przyslowia_matrix)
}

przyslowia_wektor <- f_wczytaj_dane_do_wektora_z_txt("przyslowia.txt")
czyste_przyslowia <- f_czysc_wektor(przyslowia_wektor, c("czego", "czy", "i", "tego", "w", "z"))
przyslowia_lemy <- f_lematyzacja_wektora_zdan(czyste_przyslowia, "slownik.txt")
przyslowia_dokument_term <- f_przeksztalc_wektor_na_macierz_dokument_term(przyslowia_lemy)
wynik <- f_analiza_korespondencji(przyslowia_dokument_term)

# Np dla pierwszego wymiaru, jesli chcemy wszystko zapisac za pomoca jednego wymiaru, to wyjasnimy okolo 22% zmiennosci danych
summary(wynik)
plot(wynik)
fviz_ca(wynik, repel = TRUE)
fviz_ca(wynik, axes = c(1, 4), repel = TRUE)



# Tutaj przyklad z analiza korespondencji dla dokumentow
korpus_nieoczyszczony <- f_wczytaj_dane_do_korpusu("coffee_tweets.csv")
korpus_oczyszczony <- f_czysc_korpus(korpus_nieoczyszczony)
korpus_steem <- tm_map(korpus_oczyszczony, stemDocument)
macierz_dokument_term <- TermDocumentMatrix(korpus_steem)
wynik <- f_analiza_korespondencji(macierz_dokument_term)
summary(wynik)
plot(wynik)
fviz_ca(wynik, repel = TRUE)
fviz_ca(wynik, axes = c(1, 4), repel = TRUE)


# ------------------------------------------------------------------------------------------------------------------
# Funkcja przeprowadza normalizacje (min-max ?)
# --- Przyjmuje wektor
# --- Zwraca znormalizowany data.frame
# ------------------------------------------------------------------------------------------------------------------
f_normalizuj <- function(x){
  (x-min(x))/(max(x)-min(x))
}

znormalizowane_dane <- f_normalizuj(c(10000,13121,512,100,511,2220,511,20,11,311))

# ------------------------------------------------------------------------------------------------------------------
# Funkcja przeprowadza normalizacje (min-max ?) bez kolumny okreslajacej klase
# --- Przyjmuje data.frame i kolumne z wynikiem
# --- Zwraca znormalizowany data.frame
# ------------------------------------------------------------------------------------------------------------------
f_normalizuj_dane <- function(x, column){
  
  #chcemy normalizowac (wartosci 0-1) wartosci wszystkie oprocz kolumny wynikowej, 
  #wiec tworzymy data.frame bez kolumny wynikowej i normalizujemy kazda z nich
  tmp <- x
  result_column <- x[,column]
  data_norm <- tmp %>% 
    select(-column) %>% 
    mutate_all(funs(f_normalizuj(.)))
  
  data_norm[column] <- result_column
  #zwracamy data.frame zawierajacy kolumny znormalizowane wraz z kolumna wynikowa
  return (data_norm)

}

nieznormalizowane_dane <- data.frame(hello = c(10,1,213,1231,511,123,161,271,1123,351),
                   business = c(0,1,3,0,1,2,0,1,2,3),
                   replica = c(3,2,1,0,0,0,1,0,3,0),
                   mail = c("spam","spam","ham","ham","ham","ham","spam","ham","spam","ham"))

znormalizowany_data_frame = f_normalizuj_dane(nieznormalizowane_dane, "mail")


# ------------------------------------------------------------------------------------------------------------------
# Funkcja przeprowadza klasyfikację metodą KNN
# --- Przyjmuje data.frame, ilość grup na którą powinno podzielić, kolumnę z wynikami i liczbę kolumn
# --- Zwraca macierz błędów 
# --- Macierz musi byc oczyszczona
# ------------------------------------------------------------------------------------------------------------------
f_klasyfikuj_knn <- function(data, k, result_column_name, columns){
  # Podzielenie na zbior testowy i uczacy, 
  # Pierwszy argument to kolumna po której ma dzielic (aby bylo proporcjonalnie wszystkich klas)
  # p - podzial uczacy/testowy, tutaj 0,7 zbioru uczacy, 0,3 testowy
  wUczacym <- createDataPartition(data[,result_column_name], p = 0.7, list = FALSE)
  Uczacy <- data[wUczacym,]
  Testowy <- data[-wUczacym,]
  
  # Utworzenie modelu
  modelSpamKnn <- knn(train = Uczacy[,-columns],
                      test = Testowy[,-columns],
                      cl = Uczacy[,columns],
                      k = k) 
  
  # Utworzenie macierzy błędów knn
  return (confusionMatrix(modelSpamKnn, Testowy[,result_column_name]))
}

dane <- data.frame(hello = c(1,1,2,1,1,0,1,2,1,3),
                   business = c(0,1,3,0,1,2,0,1,2,3),
                   replica = c(3,2,1,0,0,0,1,0,3,0),
                   mail = c("spam","spam","ham","ham","ham","ham","spam","ham","spam","ham"))

data_norm = f_normalizuj_dane(dane, "mail")
knn_k1 = f_klasyfikuj_knn(data_norm, 1, "mail", 4)


# ------------------------------------------------------------------------------------------------------------------
# Funkcja przeprowadza klasyfikację metodą Bayes
# --- Przyjmuje data.frame, kolumnę z wynikami i liczbę kolumn
# --- Zwraca macierz błędów 
# --- Macierz musi byc oczyszczona
# ------------------------------------------------------------------------------------------------------------------
f_klasyfikuj_bayes <- function(data, result_column_name, columns){
  # Podzielenie na zbior testowy i uczacy, 
  # Pierwszy argument to kolumna po której ma dzielic (aby bylo proporcjonalnie wszystkich klas)
  # p - podzial uczacy/testowy, tutaj 0,7 zbioru uczacy, 0,3 testowy
  wUczacym <- createDataPartition(data[,result_column_name], p = 0.7, list = FALSE)
  Uczacy <- data[wUczacym,]
  Testowy <- data[-wUczacym,]
  
  #tworzenie modelu -> zamiast mail powinna być nazwa kolumny zawierająca klase
  #nie umiałem tego ogarnąc z parametru result_column_name, ale przekazuje sie to samo tylko nie jako string
  model <- naiveBayes(mail ~ ., data = Uczacy)
  
  przewidywanie <- predict(model, Testowy[, -columns])
  
  return (confusionMatrix(przewidywanie, Testowy[,result_column_name]))
}


dane <- data.frame(hello = c(1,1,2,1,1,0,1,2,1,3),
                   business = c(0,1,3,0,1,2,0,1,2,3),
                   replica = c(3,2,1,0,0,0,1,0,3,0),
                   mail = c("spam","spam","ham","ham","ham","ham","spam","ham","spam","ham"))

data_norm = f_normalizuj_dane(dane, "mail")
bayes_k1 = f_klasyfikuj_bayes(data_norm, "mail", 4)


