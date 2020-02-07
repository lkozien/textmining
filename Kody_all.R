###### Pierwsze zajêcia ######

  ### Pierwszy plik ###
  
    # instalacja potrzebnych pakietów
    install.packages("stringr")
    library("stringr")
    
    # ustalenie przestrzeni roboczej
    setwd("H:/R/Workbench")
    
    # Zadanie 1
    
    tekst1 <- "Dzisiaj mamy 10 dzieñ miesi¹ca 03 roku 2011"
    wynik_zad_1 <- gregexpr('[0-9]', tekst1)
    print(wynik_zad_1)
    
    # Zadanie 2
    
    wynik_zad_2 <- str_extract_all(tekst1, '\\b\\w{3,}\\b')
    print(wynik_zad_2)
    
    # Zadanie 3
    
    kod <- '<p>linia tekstu <b>pogrubienie</b> kolejny tekst <em>wyróznienie</em>.</p>'
    wynik_zad_3 <- str_split(kod, "<[/?[:alnum:]]+>")
    print(wynik_zad_3)
    
    # Zadanie 4
    
    tweet <- "To jest #przyklad #tweeta od @Maciej #niewiemjaktagowac #1991"
    
    tweethash <- function(tweet){
      print(str_extract_all(tweet, '#(\\w*[0-9a-zA-Z]+\\w*[0-9a-zA-Z])'))
    }
    
    tweethash(tweet)
    
    # Zadanie 5
    
    tweet <- "To jest #przyklad #tweeta od @Maciej #niewiemjaktagowac #1991"
    
    tweettext <- function(tweet){
      print(str_replace_all(tweet, '#(\\w*[0-9a-zA-Z]+\\w*[0-9a-zA-Z])', ""))
    }
    
    tweettext(tweet)
    
    # Zadanie 6
    
    # ".*p.t.*" LUB "^\w?.*p[a-z ?]t\w?.*$"

###### Drugie zajêcia TEORIA ######

    # Ustawianie przestrzeni roboczej (skrypt lub rêcznie)
    
    getwd() # Sprawdza katalog w którym dzia³amy
    dir.create("Cwiczenia 1 20171014") # Tworzenie katalogu
    setwd("~/Cwiczenia 1 20171014") # Ustawiam katalog jako przestrzeñ robocz¹
    
    # Instalacja i ³adowanie bilbiotek (skrypt lub rêcznie)
    
    # dplyr - manipulowanie tabelami (³atwiejszy bo przypomina SQL)
    install.packages("dplyr")
    library("dplyr", lib.loc="~/R/win-library/3.4")
    
    # tm - do tworzenia macierzy term-dokument i Text Mining
    install.packages("tm")
    library("tm", lib.loc="~/R/win-library/3.4")
    
    # Wczytanie danych (skrypt lub rêcznie)
    
    dane <- read.csv2("coffee_tweets.csv") #2 bo rozdzielany ; read.csv w przypadku ,
    View(dane) # podgl¹d, mo¿na te¿ rêcznie
    
    # wydzielanie kolumn
    
    dane$text # biorê tylko kolumne text
    dane[ , 1 ] # tylko kolumna z indexem 1 czyli text w inny sposob
    dane[ , "text" ] # to samo tylko nazwa kolumny zamiast indexu
    
    # dplyr
    
    select(dane, "text") # wybiera kolumne (Ÿród³o danych, index lub nazwa)
    
    # praca na plikach 
    
    tekst_dir <- paste0(getwd(), "/Teksty") # tworzy zmienn¹ która przechowuje œcie¿kê paste0 ³¹czy stringi i nie dodaje spacji
    zrodlo_dir <- DirSource(tekst_dir) # tworzy zmienn¹ która przechowuje info o tym co tam jest (?)
    
    # tworzenie korpusu w zale¿noœci od typu zaczytanych danych
    
    # zgodnie z cheeat sheet z moodle
    
###### Drugie zajêcia ZADANIA ######

    # Ustawianie przestrzeni roboczej (skrypt lub rêcznie)
    
    getwd()
    dir.create("Cwiczenia 1 20171014")
    setwd("~/Cwiczenia 1 20171014")
    
    # Instalacja i ³adowanie bilbiotek
    
    # dplyr - manipulowanie tabelami
    install.packages("dplyr")
    library("dplyr", lib.loc="~/R/win-library/3.4")
    
    # tm - do tworzenia macierzy term-dokument i Text Mining
    install.packages("tm")
    library("tm", lib.loc="~/R/win-library/3.4")
    
    # Wczytanie danych
    
    dane <- read.csv2("coffee_tweets.csv")
    
    # Zadanie 1
    
    k1 <- select(dane, "text") # wybiera kolumne
    t20 <- DataframeSource(data.frame(k1[ 1:20, 1 ])) # tworzê dataframe z 20 pierwszych tweetów
    
    korpus_df<-VCorpus(t20) # tworzenie korpusu
    inspect(korpus_df) # wyœwietlanie korpusu
    
    # Zadanie 2
    
    t20 <- VectorSource(dane[1:20, 1])
    korpus_vec <- VCorpus(t20)
    inspect(korpus_vec)
    
    # Zadanie 3
    
    dir.create("cwierki") # Tworzenie katalogu
    setwd("~/Cwiczenia 1 20171014/cwierki") # Ustawiam katalog jako przestrzeñ robocz¹
    
    k1 <- select(dane, "text") # wybiera kolumne
    t20 <- dane[1:20, 1]
    cnt=1
    
    #Tworzenie plików
    for (i in t20)
    {
      write(i, file=paste0("cwierk", cnt, ".txt"))
      cnt = cnt +1
    }
    
    zrodlo_dir <- DirSource("~/Cwiczenia 1 20171014/cwierki")
    korpus_dir <- VCorpus(zrodlo_dir)
    inspect(korpus_dir)

###### Trzecie zajêcia TEORIA ######
    
    # Ustawianie przestrzeni roboczej (skrypt lub rêcznie)
    
    getwd() # Sprawdza katalog w którym dzia³amy
    dir.create("Cwiczenia 1 20171022") # Tworzenie katalogu
    setwd("~/Cwiczenia 1 20171022") # Ustawiam katalog jako przestrzeñ robocz¹
    
    # Instalacja i ³adowanie bilbiotek (skrypt lub rêcznie)
    
    install.packages(c("stringr", "tm", "SnowballC", "wordcloud"))
    library("stringr")
    library("tm")
    library("SnowballC")
    library("wordcloud")
    
    # Czyszczenie tekstu http://web.ae.katowice.pl/elearning/moodle/file.php/1349/NLPiTM_cw2_nst1718m.html
    
    (tekstANG <- "<b>She</b> woke up at       6 A.M. It\'s so early!  She was only 10% awake and began drinking coffee in front of her computer.")
    (tekstPOL <- "To jest 4. przys³owie:      \"œw. Bart³omiej pogodny, jesieñ pogodna\" ")
    
    # zmiana znaków na ma³e
    
    tolower(tekstANG)
    tolower(tekstPOL)
    
    # usuwanie interpunkcji (jak chcê uwzglêdniæ emocje to warto rozwa¿yæ zostawienie emotek albo !)
    
    removePunctuation(tekstANG)
    removePunctuation(tekstPOL)
    
    # usuwanie cyfr
    
    removeNumbers(tekstANG)
    removeNumbers(tekstPOL)
    
    # usuwanie "bia³ych znaków"
    
    stripWhitespace(tekstANG)
    stripWhitespace(tekstPOL)
    
    # usuwanie stopword (s³owa, które nic nie wnosz¹)
    
    removeWords(tekstANG, stopwords("en")) # stopwords("en") <- wbudowane stopwordsy dla Angielskiego
    
    new_stops <- c("coffee", "she", stopwords("en")) # mogê dodaæ nowe s³owa wed³ug uznania
    
    removeWords(tekstANG, new_stops)
    
    stopWordsPL <- c("œw.", "To", "jesieñ") # robocza wersja 
    
    removeWords(tekstPOL, stopWordsPL)
    
    str_replace_all(tekstPOL, "œw.", "")
    
    
    # æwiczenie - czyszczenie korpusu
    
    # wczytanie i utworzenie korpusu
    
    przyslowia <- scan("przyslowia.txt", what="character", sep=",")
    przyslowia_zr_vec <- VectorSource(przyslowia)
    przyslowia_korp <- VCorpus(przyslowia_zr_vec)
    przyslowia_korp[[1]]$content
    
    # Czyszczenie korpusu
    
    # ma³e litery
    przyslowia_czyste <- tm_map(przyslowia_korp, content_transformer(tolower))
    przyslowia_czyste[[10]]$content
    
    # zmiana na ma³e litery
    przyslowia_czyste <- tm_map(przyslowia_czyste, removePunctuation)
    przyslowia_czyste[[3]]$content
    
    # stopwords
    stopWordsPL <- c("tak", "to", "tego", "czego", "jaka", "taka","i", "czy", "w", "z", "nim", "jakiej", "tak¹", "jaki", "tak¹æ", "tak¹¿", "taki")
    przyslowia_czyste <- tm_map(przyslowia_czyste, removeWords, stopWordsPL)
    przyslowia_czyste[[3]]$content
    
    # usuwanie œ
    przyslowia_czyste <- tm_map(przyslowia_czyste, content_transformer(function(x) str_replace_all(x, "œ", "")))
    przyslowia_czyste[[3]]$content
    
    # æwiczenie - tweety o kawie
    
    # Tworzenie korpusu
    
    kawa <- read.csv2("coffee_tweets.csv")
    kawa_zr_vec <- VectorSource(kawa$text)
    kawa_korp <- VCorpus(kawa_zr_vec)
    kawa_korp[[1]]$content
    
    
    # podwójne wordcloudy 
    
    kawaTekst <- paste(kawa$text, collapse = " ")
    herbataTekst <- paste(herbata$text, collapse = " ")
    
    razemTekst <- c(kawaTekst, herbataTekst)
    
    razem_source <- VectorSource(razemTekst)
    razem_korp <- VCorpus(razem_source)
    
    razem_czysty <- czysc_korpus(razem_korp, c("coffee", "teatime", "tea"))
    
    razem_tdm <- TermDocumentMatrix(razem_czysty)
    
    razem_m <- as.matrix(razem_tdm)
    
    # wordcloud razem 
    commonality.cloud(razem_m, max.words = 50, colors = "steelblue4")
    
    # wordcloud ró¿nice
    
    # nale¿y wprowadziæ nazwy okreœlaj¹ce poszczególne dokumenty
    razem_tdm_nazwy <- razem_tdm
    colnames(razem_tdm_nazwy) <- c("kawa", "herbata")
    
    # a nastêpnie wyœwietliæ chmurê
    razem_m_nazwy <- as.matrix(razem_tdm_nazwy)
    comparison.cloud(razem_m_nazwy, max.words = 50, colors = c("orangered3", "darkolivegreen3")) 
    
###### Trzecie zajêcia ZADANIA ######
    
    # Ustawianie przestrzeni roboczej (skrypt lub rêcznie)
    
    getwd() # Sprawdza katalog w którym dzia³amy
    dir.create("Cwiczenia 1 20171022") # Tworzenie katalogu
    setwd("~/Cwiczenia 1 20171022") # Ustawiam katalog jako przestrzeñ robocz¹
    
    # Instalacja i ³adowanie bilbiotek (skrypt lub rêcznie)
    
    install.packages(c("stringr", "tm", "SnowballC", "wordcloud"))
    library("stringr")
    library("tm")
    library("SnowballC")
    library("wordcloud")
    
    # Zadanie 1
    
    # Tworzenie korpusu
    
    kawa <- read.csv2("coffee_tweets.csv")
    kawa_zr_vec <- VectorSource(kawa$text)
    kawa_korp <- VCorpus(kawa_zr_vec)
    kawa_korp[[1]]$content
    
    # definiowanie funkcji
    
    czysc_korpus <- function(korpus, slowa = ""){
      # ma³e litery
      korpus <- tm_map(korpus, content_transformer(tolower))
      # usuwanie interpunkcji
      korpus <- tm_map(korpus, removePunctuation)
      # definiowanie nowych stopwords
      new_stops <- c(slowa, stopwords("en"))
      # usuwanie stopwords
      korpus <- tm_map(korpus, removeWords, new_stops)
      # usuwanie bia³ych znaków
      korpus <- tm_map(korpus, stripWhitespace)
      return (korpus)
    }
    
    # testowanie 
    kawa_czysty <- czysc_korpus(kawa_korp)
    kawa_czysty[[1]]$content
    
    # testowanie z usuwaniem dodatkowych slow angielskich
    kawa_czysty <- czysc_korpus(kawa_korp, c("true", "lots"))
    
    # Zadanie 2
    
    # Tworzenie korpusu
    
    kawa <- read.csv2("coffee_tweets.csv")
    kawa_zr_vec <- VectorSource(kawa$text)
    kawa_korp <- VCorpus(kawa_zr_vec)
    
    
    # Czyszczenie korpusu ³¹cznie z s³owem coffee
    kawa_czysty <- czysc_korpus(kawa_korp, c("coffee"))
    
    # Tworzenie term-document
    kawa_tdm <- TermDocumentMatrix(kawa_czysty)
    
    # Konwersja do macierzy
    kawa_m <- as.matrix(kawa_tdm)
    
    # Obliczanie liczebnoœci termów
    kawa_term <- rowSums(kawa_m)
    
    # Sortowanie wed³ug liczebnoœci
    kawa_term <- sort(kawa_term, decreasing = TRUE)
    
    # Generowanie wykresu
    barplot(kawa_term[1:10], col = "tan", las = 2)
    
    # Zadanie 3
    
    herbata <- read.csv2("tea_tweets.csv")
    herbata_zr_vec <- VectorSource(herbata$text)
    herbata_korp <- VCorpus(herbata_zr_vec)
    
    # opcja bez czyszczenia
    
    #czyszczenie korpusu kawy
    herbata_czysty <- czysc_korpus(herbata_korp)
    
    # Tworzenie term-document
    herbata_tdm <- TermDocumentMatrix(herbata_czysty)
    
    # Konwersja do macierzy
    herbata_m <- as.matrix(herbata_tdm)
    
    # Obliczanie liczebnoœci termów
    herbata_term <- rowSums(herbata_m)
    
    # Sortowanie wed³ug liczebnoœci
    herbata_term <- sort(herbata_term, decreasing = TRUE)
    
    # generowanie wordcloudów
    
    # Podstawowy wordloud
    wordcloud(names(herbata_term), herbata_term, max.words = 50, colors = "steelblue4")
    
    # Z u¿yciem kolorów w zale¿noœci od wystêpowania
    wordcloud(names(herbata_term), herbata_term, max.words = 50, colors = c("grey80", "tan", "darkorange4"))
    
    # opcja z usuniêcie tea i teatime
    
    #czyszczenie korpusu kawy
    herbata_czysty <- czysc_korpus(herbata_korp, c("tea", "teatime"))
    
    # Tworzenie term-document
    herbata_tdm <- TermDocumentMatrix(herbata_czysty)
    
    # Konwersja do macierzy
    herbata_m <- as.matrix(herbata_tdm)
    
    # Obliczanie liczebnoœci termów
    herbata_term <- rowSums(herbata_m)
    
    # Sortowanie wed³ug liczebnoœci
    herbata_term <- sort(herbata_term, decreasing = TRUE)
    
    # generowanie wordcloudów
    
    # Podstawowy wordloud
    wordcloud(names(herbata_term), herbata_term, max.words = 50, colors = "steelblue4")
    
    # Z u¿yciem kolorów w zale¿noœci od wystêpowania
    wordcloud(names(herbata_term), herbata_term, max.words = 50, colors = c("grey80", "tan", "darkorange4"))
    
###### Czwarte zajêcia TEORIA ######    
    
    # http://web.ae.katowice.pl/elearning/moodle/file.php/1349/NLPiTM_cw3stem_nst1718.html
    # Pakiety które mog¹ siê przydaæ
    
    install.packages(c("stringr", "tm", "SnowballC", "wordcloud"))
    library("stringr")
    library("tm")
    library("SnowballC")
    library("wordcloud")
    
    
    # Funkcja czyszcz¹ca korpus
    
    czysc_korpus <- function(corpus, slowa = ""){
      corpus <- tm_map(corpus, stripWhitespace)
      corpus <- tm_map(corpus, removePunctuation)
      corpus <- tm_map(corpus, content_transformer(tolower))
      corpus <- tm_map(corpus, removeNumbers)
      corpus <- tm_map(corpus, removeWords, c(stopwords("en"), slowa))
      return(corpus)
    }
    
    # Przestrzeñ robocza
    
    setwd("~/Wyklad i cwiczenia 20171104")
    
    # zaczytanie tekstu i tworzenie korpusu
    
    kawa <- read.csv2("coffee_tweets.csv")
    kawa_zrodlo <- VectorSource(kawa$text)
    kawa_korp <- VCorpus(kawa_zrodlo)
    
    # obróbka
    
    kawa_czysty <- czysc_korpus(kawa_korp, "coffee")
    
    kawa_tdm <- TermDocumentMatrix(kawa_czysty)
    kawa_m <- as.matrix(kawa_tdm)
    
    kawa_term <- rowSums(kawa_m)
    kawa_term <- sort(kawa_term, decreasing = TRUE)
    
    # Wizualizacja 10 najczêstszych termów
    
    barplot(kawa_term[1:10], col = "tan", las = 2)
    
    # Stemming - wyci¹ganie rdzenia s³owa
    
    # Stemming dla wektora wyrazów
    
    slowa<-c( "argue", "argued", "argues", "arguing")
    
    rdzen <- stemDocument(slowa)
    rdzen
    
    # s³ownik uzupe³nieñ
    
    slownik <- c("argue")
    
    kompletne_slowa <- stemCompletion(rdzen, slownik)
    kompletne_slowa
    
    # Stemming dla zdania
    
    stemDocument("John is argumentative. He argues about everything, yesterday was arguing for one penny")
    
    tekst <- "John is argumentative. He argues about everything, yesterday was arguing for one penny"
    
    # przygotowanie tekstu
    tekst_punc <- removePunctuation(tekst)
    
    # tokenizacja
    slowa <- str_split(tekst_punc, ' ')
    
    # wyszukanie rdzenia 
    rdzenie <- stemDocument(slowa[[1]])
    
    # lub
    rdzenie <- stemDocument(unlist(slowa))
    
    rdzenie
    
    # s³ownik uzupe³nieñ
    slownik <- c("argue", "everything", "penny")
    
    kompletne_slowa <- stemCompletion(rdzenie, slownik)
    
    kompletne_slowa <- stemCompletion(rdzenie, unlist(slowa), type = "prevalent")
    
    kompletne_slowa
    
    # Zadanie domowe spróbowaæ na innym przyk³adzie
    
    # Stemming dla korpusu
    
    kawa_stem <- tm_map(kawa_czysty, stemDocument)
    
    kawa_stem_tdm <- TermDocumentMatrix(kawa_stem)
    kawa_stem_m <- as.matrix(kawa_stem_tdm)
    
    kawa_stem_term <- rowSums(kawa_stem_m)
    kawa_stem_term <- sort(kawa_stem_term, decreasing = TRUE)
    
    # Wizualizacja 10 najczêstszych termów po stemmingu
    barplot(kawa_stem_term[1:10], col = "tan", las = 2)
    
    # ró¿nica miêdzy 1 a 2 podejœciem do kawy
    cat("Liczba wyodrêbnionych termów z korpusu tweetów o kawie, po dokonaniu stemmingu spad³a o", dim(kawa_m)[1]-dim(kawa_stem_m)[1], "termy" )
    
    # Lematyzacja ze s³ownikiem
    
    # zaczytanie danych
    przyslowia <- scan("przyslowia.txt", encoding = "UTF-8", what="character", sep=",")
    
    przyslowia_czyste <- removePunctuation(przyslowia)
    przyslowia_czyste <- str_replace(przyslowia_czyste, "–", "")
    
    przyslowia_czyste <- tolower(przyslowia_czyste)
    
    stopWords <- c("czego", "czy", "i", "tego", "w", "z")
    przyslowia_czyste <- removeWords(przyslowia_czyste, stopWords)
    
    przyslowia_czyste <- stripWhitespace(przyslowia_czyste)
    przyslowia_czyste <- str_trim(przyslowia_czyste)
    
    # wczytanie s³ownika https://github.com/morfologik/polimorfologik/releases/tag/2.1
    
    slownik <- read.csv2("polimorfologik-2.1.txt", encoding = "UTF-8", header=F, stringsAsFactors=FALSE)
    
    # sprawdzanie czy zaczytane ok
    
    dim(slownik) # 3 kolumny i brdzo du¿o wierszy: 4 811 854
    
    slownik[3604764,]
    slownik[1007902,]
    slownik[2581393,]
    slownik[700:710,]
    
    
    # usuwanie duplikatów ¿eby poprawiæ wydajnoœæ
    
    slownik <- slownik[!duplicated(slownik[,2]),1:2]
    
    
    
    
    # Lematyzacja bez s³ownika (chodzi o wydajnoœæ)
    
    # Zamiana dla jednego wzorca formy odmienionej i formy podstawowej
    str_replace_all(c("Dzisiaj, Bart³omieja nie bêdzie", "Bartek, dzisiaj siê nie pojawi³"),
                    "Bartek",
                    "Bart³omiej")
    # Gdy wzorce znajduj¹ siê w tabeli
    slownikBart<-data.frame(podst=c("Bart³omiej", "Bart³omiej"), odmiana=c("Bart³omieja", "Bartek"), stringsAsFactors = FALSE)
    
    str_replace_all(c("Dzisiaj, Bart³omieja nie bêdzie", "Bartek, dzisiaj siê nie pojawi³"),
                    slownikBart[2,2],
                    slownikBart[2,1])
    
    # Zamiana dla kilku wzorców formy odmienionej i formy podstawowej
    str_replace_all(c("Dzisiaj, Bart³omieja nie bêdzie", "Bartek, dzisiaj siê nie pojawi³"),
                    c("Bartek", "Bart³omieja", "bêdzie"),
                    c("Bart³omiej", "Bart³omiej", "byæ"))
    
    # Gdy wzorce znajduj¹ siê w tabeli
    slownikBart<-data.frame(podst=c("Bart³omiej", "Bart³omiej", "byæ"), odmiana=c("Bart³omieja", "Bartek", "bêdzie"), stringsAsFactors = FALSE)
    
    str_replace_all(c("Dzisiaj, Bart³omieja nie bêdzie", "Bartek, dzisiaj siê nie pojawi³"),
                    slownikBart[,2],
                    slownikBart[,1])
    
    # Stworzenie wektora z wyrazów w formie podstawowej (1. kolumna s³ownika)
    podstawaBart<-slownikBart[,1]
    
    # Nadanie nazw elementom wektora w postaci wyrazów w formie odmienionej (2. kolumna s³ownika)
    names(podstawaBart)<-slownikBart[,2]
    podstawaBart
    
    # Zamiana wyrazów z formy odmienionej na formê podstawow¹
    str_replace_all(c("Dzisiaj, Bart³omieja nie bêdzie", "Bartek, dzisiaj siê nie pojawi³"),
                    podstawaBart)
    
    # Lematyzacji wszystkich przys³ów, mo¿na dokonaæ z wykorzystaniem s³ownika polimorfigik:    
    podstawa<-slownik[,1]
    names(podstawa)<-slownik[,2]
    przyslowia_lemmy <- str_replace_all(przyslowia_czyste, podstawa)
    
    # Uproszczona wersja (za dlugo by to trwa³o)
    slownikMaly <- read.csv2("slownik.txt", header=F, stringsAsFactors=FALSE)
    podstawaMaly<-slownikMaly[,1]
    names(podstawaMaly)<-slownikMaly[,2]
    przyslowia_lemmy <- str_replace_all(przyslowia_czyste, podstawaMaly)
    przyslowia_lemmy
    
    # Po lematyzacji mo¿na stworzyæ macierz term-dokument i przyst¹piæ do jej analizy:
    
    przyslowia_zrodlo <- VectorSource(przyslowia_lemmy)
    przyslowia_korp <- VCorpus(przyslowia_zrodlo)
    
    przyslowia_tdm <- TermDocumentMatrix(przyslowia_korp)
    inspect(przyslowia_tdm)
    
    # Liczba s³ów
    
    nTerms(przyslowia_tdm)
    
    Terms(przyslowia_tdm)
    
    findFreqTerms(przyslowia_tdm, 4)
    
    
    # Konwersja term-document na klasyczn¹ macierz
    
    przyslowia_m <- as.matrix(przyslowia_tdm)
    przyslowia_term <- rowSums(przyslowia_m)
    przyslowia_term <- sort(przyslowia_term, decreasing = TRUE)
    
    # Wizualizacja 10 najczêstszych termów
    barplot(przyslowia_term[1:10], col = "forestgreen", las = 2)
    

###### Czwarte zajêcia ZADANIA 1/2 ######      
    
    # http://web.ae.katowice.pl/elearning/moodle/file.php/1349/NLPiTM_cw3stem_nst1718.html
    # Pakiety które mog¹ siê przydaæ
    
    install.packages(c("stringr", "tm", "SnowballC", "wordcloud"))
    library("stringr")
    library("tm")
    library("SnowballC")
    library("wordcloud")
    
    
    # Funkcja czyszcz¹ca korpus
    
    czysc_korpus <- function(corpus, slowa = ""){
      corpus <- tm_map(corpus, stripWhitespace)
      corpus <- tm_map(corpus, removePunctuation)
      corpus <- tm_map(corpus, content_transformer(tolower))
      corpus <- tm_map(corpus, removeNumbers)
      corpus <- tm_map(corpus, removeWords, c(stopwords("en"), slowa))
      return(corpus)
    }
    
    # Przestrzeñ robocza
    
    setwd("~/Wyklad i cwiczenia 20171104")
    
    
    herbata <- read.csv2("tea_tweets.csv")
    herbata_zrodlo <- VectorSource(herbata$text)
    herbata_korp <- VCorpus(herbata_zrodlo)
    
    # obróbka
    
    herbata_czysty <- czysc_korpus(herbata_korp, "tea")
    
    herbata_tdm <- TermDocumentMatrix(herbata_czysty)
    herbata_m <- as.matrix(herbata_tdm)
    herbata_term <- rowSums(herbata_m)
    herbata_term <- sort(herbata_term, decreasing = TRUE)
    
    # chmura bez stemmingu
    
    wordcloud(names(herbata_term), herbata_term, max.words = 50, colors = "steelblue4")
    
    # stemming
    
    herbata_stem <- tm_map(herbata_czysty, stemDocument)
    
    herbata_stem_tdm <- TermDocumentMatrix(herbata_stem)
    herbata_stem_m <- as.matrix(herbata_stem_tdm)
    
    herbata_stem_term <- rowSums(herbata_stem_m)
    herbata_stem_term <- sort(herbata_stem_term, decreasing = TRUE)
    
    # chmura z stemmingiem
    
    wordcloud(names(herbata_stem_term), herbata_stem_term, max.words = 50, colors = "steelblue4")
    
###### Czwarte zajêcia ZADANIA 2/2 ######     
    
    # http://web.ae.katowice.pl/elearning/moodle/file.php/1349/NLPiTM_cw3stem_nst1718.html
    # Pakiety które mog¹ siê przydaæ
    
    install.packages(c("stringr", "tm", "SnowballC", "wordcloud"))
    library("stringr")
    library("tm")
    library("SnowballC")
    library("wordcloud")
    
    
    # Funkcja czyszcz¹ca korpus
    
    czysc_korpus <- function(corpus, slowa = ""){
      corpus <- tm_map(corpus, stripWhitespace)
      corpus <- tm_map(corpus, removePunctuation)
      corpus <- tm_map(corpus, content_transformer(tolower))
      corpus <- tm_map(corpus, removeNumbers)
      corpus <- tm_map(corpus, removeWords, c(stopwords("en"), slowa))
      return(corpus)
    }
    
    # Przestrzeñ robocza
    
    setwd("~/Wyklad i cwiczenia 20171104")
    
    
    przyslowia <- scan("przyslowia.txt", encoding = "UTF-8", what="character", sep=",")
    
    przyslowia_czyste <- removePunctuation(przyslowia)
    przyslowia_czyste <- str_replace(przyslowia_czyste, "–", "")
    
    przyslowia_czyste <- tolower(przyslowia_czyste)
    
    stopWords <- c("czego", "czy", "i", "tego", "w", "z")
    przyslowia_czyste <- removeWords(przyslowia_czyste, stopWords)
    
    przyslowia_czyste <- stripWhitespace(przyslowia_czyste)
    przyslowia_czyste <- str_trim(przyslowia_czyste)
    
    przyslowia_zrodlo <- VectorSource(przyslowia_czyste)
    przyslowia_korp <- VCorpus(przyslowia_zrodlo)
    
    przyslowia_tdm <- TermDocumentMatrix(przyslowia_korp)
    przyslowia_m <- as.matrix(przyslowia_tdm)
    przyslowia_term <- rowSums(przyslowia_m)
    przyslowia_term <- sort(przyslowia_term, decreasing = TRUE)
    
    # chmura bez stemmingu
    
    wordcloud(names(przyslowia_term), przyslowia_term, max.words = 50, colors = "steelblue4")
    
    # lematyzacja
    
    # Uproszczona wersja (za dlugo by to trwa³o)
    slownikMaly <- read.csv2("slownik.txt", header=F, stringsAsFactors=FALSE)
    podstawaMaly<-slownikMaly[,1]
    names(podstawaMaly)<-slownikMaly[,2]
    przyslowia_lemmy <- str_replace_all(przyslowia_czyste, podstawaMaly)
    
    przyslowia_zrodlo_lem <- VectorSource(przyslowia_lemmy)
    przyslowia_korp_lem <- VCorpus(przyslowia_zrodlo_lem)
    
    przyslowia_tdm_lem <- TermDocumentMatrix(przyslowia_korp_lem)
    przyslowia_m_lem <- as.matrix(przyslowia_tdm_lem)
    przyslowia_term_lem <- rowSums(przyslowia_m_lem)
    przyslowia_term_lem <- sort(przyslowia_term_lem, decreasing = TRUE)
    
    # chmura z stemmingiem
    
    wordcloud(names(przyslowia_term_lem), przyslowia_term_lem, max.words = 50, colors = "steelblue4")
    
###### Pi¹te zajêcia Teoria ######     
    
    # http://web.ae.katowice.pl/elearning/moodle/file.php/1349/NLPiTM_cw4a_nst1718.html
    
    # instalacja i zaczytanie bibliotek
    
    install.packages(c("tm", "dplyr", "stringr"))
    
    library("dplyr")
    library("tm")
    library("stringr")
    
    # zaczytanie tekstu
    
    przyslowia <- scan("przyslowia.txt", what="character", sep=",")
    
    # obróbka
    
    przyslowia_czyste <- removePunctuation(przyslowia)
    przyslowia_czyste <- str_replace(przyslowia_czyste, "–", "")
    
    przyslowia_czyste <- tolower(przyslowia_czyste)
    
    stopSlowa <- c("czego", "czy", "i", "tego", "w", "z")
    przyslowia_czyste <- removeWords(przyslowia_czyste, stopSlowa)
    
    przyslowia_czyste <- stripWhitespace(przyslowia_czyste)
    przyslowia_czyste <- str_trim(przyslowia_czyste)
    
    # lematyzacja
    
    slownikMaly <- read.csv2("slownik.txt", header=F, stringsAsFactors=FALSE)
    podstawaMaly<-slownikMaly[,1]
    names(podstawaMaly)<-slownikMaly[,2]
    przyslowia_lemmy <- str_replace_all(przyslowia_czyste, podstawaMaly)
    
    # macierz term-document
    
    przyslowia_zrodlo <- VectorSource(przyslowia_lemmy)
    przyslowia_korp <- VCorpus(przyslowia_zrodlo)
    
    przyslowia_tdm <- TermDocumentMatrix(przyslowia_korp)
    inspect(przyslowia_tdm)
    
    # analiza
    
    findFreqTerms(przyslowia_tdm, 9)
    
    przyslowia_m <- as.matrix(przyslowia_tdm)
    
    sum(przyslowia_m !=0) 
    
    sum(przyslowia_m == 0)/prod(dim(przyslowia_m))
    
    # informacja o rzadkoœci wystêpowania (1 - ile razy siê pojawi³/liczbe dokumentów)
    (rzadkoscTermow <- sort(1-rowSums(przyslowia_m)/nDocs(przyslowia_tdm)))
    
    # Zostaw wszystkie termy które pojawiaj¹ siê wiêcej ni¿ 90% razy
    removeSparseTerms(przyslowia_tdm, 0.11)
    
    # termy które zosta³y (wystêpuj¹ w wiêcej ni¿ 90% dokumentów)
    Terms(removeSparseTerms(przyslowia_tdm, 0.11))
    
    rzadkoscTermow[rzadkoscTermow < 0.11]
    
    # najczêœciej przyjmuje siê ok. 95%, ale tutaj ustawiamy 89%
    
    removeSparseTerms(przyslowia_tdm, 0.89)
    
    Terms(removeSparseTerms(przyslowia_tdm, 0.89))
    
    length(rzadkoscTermow[rzadkoscTermow < 0.89])
    
    # wspó³wystêpowanie termów w korpusie
    
    # jakie termy maj¹ tendencjê do wspó³wystêpowania z okreœlonym termem
    # korelacja = 0 oznacza brak dopasowania 1 oznacza idealne dopasowanie, daliœmy 0 ¿eby znaleŸæ wszystkie powi¹zane
    findAssocs(przyslowia_tdm, "jesieñ", 0.0)
    
    # korelacja miêdzy termami to samo co wy¿ej (bez biblioteki - liczone rêcznie)
    cor(t(przyslowia_m))["jesieñ",] %>% 
      sort(decreasing = T) %>% 
      round(2)
    
    # odleg³oœæ euklidesowa miêdzy termami i jesieni¹ czym mniej tym bardziej powi¹zane
    as.matrix(dist(przyslowia_m))["jesieñ",] %>% 
      sort(decreasing = T) %>% 
      round(2)
    
    # wizualizacja
    heatmap(przyslowia_m)
    
    # Grupowanie termów
    
    dtm_odleg <- dist(przyslowia_m, method = "manhattan")
    klastry <- hclust(dtm_odleg, method = "average")
    plot(klastry)
    
    # sparametryzowana mapa ciep³a wybra³em swoje metody
    heatmap(przyslowia_m,
            distfun = function(x) dist(x, method = "manhattan"),
            hclustfun = function(x) hclust(x, method = "average"))

###### Pi¹te zajêcia ZADANIA ######
    
    # instalacja bilbiotek i przestrzeñ robocza
    
    install.packages(c("tm", "stringr", "dplyr", "ggplot2", "SnowballC"))
                     
     library("dplyr")
     library("stringr")
     library("tm")
     library("SnowballC")
     library("ggplot2")
     setwd("~/Text Mining/Wyklad i cwiczenia 20171125")
     
     ###### Zadanie 1
     
     # zaczytanie danych
     
     korpusA  <-VCorpus(DirSource(paste(getwd(),"/pos",sep="")), readerControl = list(language="en"))
     korpusB  <-VCorpus(DirSource(paste(getwd(),"/neg",sep="")), readerControl = list(language="en"))
     korpusC <- c(korpusA, korpusB)
     
     
     # ma³e litery
     czysty_korpus<-tm_map(korpusC, content_transformer(tolower))
     
     # usuniêcie cyfr (liczb, numerów)
     czysty_korpus<-tm_map(czysty_korpus, removeNumbers)
     
     # usuniecie znaków przestankowych
     czysty_korpus<-tm_map(czysty_korpus, removePunctuation)
     
     # usuniêcie nieistotnych s³ów
     czysty_korpus<-tm_map(czysty_korpus, removeWords, c(stopwords("en")))
     
     # stemming (bez uzupe³niania)
     czysty_korpus<-tm_map(czysty_korpus, stemDocument)
     
     # usuniêcie bia³ych znaków
     czysty_korpus<-tm_map(czysty_korpus, stripWhitespace)
     
     # Tworzenie 4 macierzy Term dokument z ró¿nymi wagami 
     tdm_licz<- TermDocumentMatrix(czysty_korpus)
     tdm_bin<- TermDocumentMatrix(czysty_korpus,control = list(weighting = weightBin))
     tdm_log<- TermDocumentMatrix(czysty_korpus, control = list(weighting= function(x) weightSMART(x, spec="lnn")))
     tdm_tfldf<- TermDocumentMatrix(czysty_korpus, control = list(weighting=weightTfIdf))
     
     # usuwanie rzadnkich term
     tdm_licz2<-removeSparseTerms(tdm_licz, sparse = 0.95)
     tdm_bin2<-removeSparseTerms(tdm_bin, sparse = 0.95)
     tdm_log2<-removeSparseTerms(tdm_log, sparse = 0.95)
     tdm_tfldf2<-removeSparseTerms(tdm_tfldf, sparse = 0.95)
     
     # funkcja do wykresu
     wykres <- function(macierz_tdm, color="grey", title="") {
       mat_licz<-as.matrix(macierz_tdm)
       sums_licz<-rowSums(mat_licz)
       sums_licz<-sort(sums_licz, decreasing = TRUE)
       barplot(sums_licz[1:10], col = color, main = title)
     }
     
     par(mfrow=c(2,2))
     # wykres dla tdm_licz2
     wykres(tdm_licz2, "orange", "liczebnoœciowa")
     
     # wykres dla tdm_bin2
     wykres(tdm_bin2, "blue", "binarna")
     
     # wykres dla tdm_log2
     wykres(tdm_log2, "green", "logarytmiczna")
     
     #wykres dla tdm_tfldf2
     wykres(tdm_tfldf2, "brown", "tfldf")
     
###### Szóste zajêcia TEORIA ######     
     
     # Instalacja pakietów i ustawienie przestrzeni roboczej
     
     setwd("~/Textm 20171217/text_library")
     install.packages(c("tm", "dendextend", "ggplot2", "dplyr", "proxy",  "stringr"))
     
     library("proxy")
     library("ggplot2")
     library("dendextend")
     library("dplyr")
     library("tm")
     library("stringr")
     
     ########################## GRUPOWANIE #####################
     
     # Miary odleg³oœci
     
     #c("jesieñ", "nie", "nie")
     #c("jesieñ", "nie", "zima", "zima")
     
     d1 <- c(1,2,0)
     d2 <- c(1,1,2)
     
     # Miara euklidesowa
     
     sqrt(sum((d1-d2)^2))
     
     # z biblioteki
     dist(matrix(c(d1,d2), 2, byrow = TRUE), method = "euclidean")
     
     # Miara kosinusowa
     
     cos_licz <- sum(d1*d2)
     cos_mian <- sqrt(sum(d1*d1)) * sqrt(sum(d2*d2))
     1-cos_licz/cos_mian
     
     # sum(d1*d2) == d1 %*% d2
     
     # z biblioteki
     dist(matrix(c(d1,d2), 2, byrow = TRUE), method = "cosine")
     
     # Miara Jaccarda
     
     jac_licz <- length(intersect(c("jesieñ", "nie", "nie"), c("jesieñ", "nie", "zima", "zima")))
     
     jac_mian <- length(union(c("jesieñ", "nie", "nie"), c("jesieñ", "nie", "zima", "zima")))
     
     1-jac_licz/jac_mian
     
     # z biblioteki
     dist(matrix(c(d1,d2), 2, byrow = TRUE), method = "jaccard")
     
     # https://web.ue.katowice.pl/elearning/moodle/file.php/1349/NLPiTM_cw9_st1718.html
     
     # Zaczytanie 
     
     przyslowia <- scan("przyslowia.txt", what="character", sep=",", encoding = "UTF-8")
     
     przyslowia_czyste <- removePunctuation(przyslowia)
     przyslowia_czyste <- str_replace(przyslowia_czyste, "–", "")
     
     przyslowia_czyste <- tolower(przyslowia_czyste)
     
     stopSlowa <- c("czego", "czy", "i", "tego", "w", "z")
     przyslowia_czyste <- removeWords(przyslowia_czyste, stopSlowa)
     
     przyslowia_czyste <- stripWhitespace(przyslowia_czyste)
     przyslowia_czyste <- str_trim(przyslowia_czyste)
     
     # Lematyzacja z uproszczonym s³ownikiem s³ów
     
     slownikMaly <- read.csv2("slownik.txt", header=F, stringsAsFactors=FALSE)
     podstawaMaly<-slownikMaly[,1]
     names(podstawaMaly)<-slownikMaly[,2]
     przyslowia_lemmy <- str_replace_all(przyslowia_czyste, podstawaMaly)
     
     # Utworzenie macierzy dokument-term z wagami liczebnoœciowymi
     
     przyslowia_zrodlo <- VectorSource(przyslowia_lemmy)
     przyslowia_korp <- VCorpus(przyslowia_zrodlo)
     
     przyslowia_dtm <- DocumentTermMatrix(przyslowia_korp)
     
     # Grupowanie hierarchiczne
     
     # Obliczenie odleg³oœci pomiêdzy dokumentami
     
     przyslowia_dm <- as.matrix(przyslowia_dtm)
     odl <- dist(przyslowia_dm)
     
     # Grupowanie hierarchiczne
     
     hg <- hclust(odl)
     
     # Dendogram
     
     plot(hg)
     
     # Poprawianie Dendogramu
     
     hg_ladne <- as.dendrogram(hg)
     
     # zmiana atrybutów etykiet obiektów i ga³êzi nale¿¹cych do skupieñ
     hg_ladne <- color_labels(hg_ladne,3, col = c("royalblue", "orangered", "seagreen"))
     hg_ladne <- color_branches(hg_ladne,3, col = c("royalblue", "orangered", "seagreen"))
     
     # rysowanie dendogramu
     plot(hg_ladne, main = paste("Dendogram na podstawie miary:\n", "euclidean"))
     rect.dendrogram(hg_ladne, k = 3, border = "grey20", lty = 2) 
     
     # Grupowanie niehierarchiczne      
     
     # Normalizacja wszystkich wektorów reprezentuj¹cych dokumenty, czyli normalizacja wierszy macierzy dokument-term
     
     przyslowia_scale <- t(scale(t(przyslowia_dm),
                                 center=FALSE,
                                 scale=sqrt(rowSums(przyslowia_dm^2))))
     
     # alternatywna metoda
     # przyslowia_scale <- przyslowia_dm/apply(przyslowia_dm, MARGIN=1, FUN=function(x) sum(x^2)^.5)
     
     # grupowanie k-means
     
     km <- kmeans(przyslowia_scale, 3) # 3 bo spodziewamy siê 3 klastrów
     km
     
     
     # dzia³ania
     
     sort(km$centers[1,], decreasing = T)
     sort(km$centers[2,], decreasing = T)
     colnames(km$centers)[km$centers[1,] != 0]
     
     colnames(km$centers)[km$centers[2,] != 0]
     
     km$cluster == 1
     
     Docs(przyslowia_dtm[km$cluster == 1,])
     findFreqTerms(przyslowia_dtm[km$cluster == 1,], 2)
     
     findFreqTerms(przyslowia_dtm[km$cluster == 2,], 2)
     
###### Szóste zajêcia ZADANIE ######      
     
     ###### ZADANIE DOMOWE ######
     
     # Zaczytanie 
     
     przyslowia <- scan("przyslowia.txt", what="character", sep=",", encoding = "UTF-8")
     
     przyslowia_czyste <- removePunctuation(przyslowia)
     przyslowia_czyste <- str_replace(przyslowia_czyste, "–", "")
     
     przyslowia_czyste <- tolower(przyslowia_czyste)
     
     stopSlowa <- c("czego", "czy", "i", "tego", "w", "z")
     przyslowia_czyste <- removeWords(przyslowia_czyste, stopSlowa)
     
     przyslowia_czyste <- stripWhitespace(przyslowia_czyste)
     przyslowia_czyste <- str_trim(przyslowia_czyste)
     
     # Lematyzacja z uproszczonym s³ownikiem s³ów
     
     slownikMaly <- read.csv2("slownik.txt", header=F, stringsAsFactors=FALSE)
     podstawaMaly<-slownikMaly[,1]
     names(podstawaMaly)<-slownikMaly[,2]
     przyslowia_lemmy <- str_replace_all(przyslowia_czyste, podstawaMaly)
     
     # Utworzenie macierzy dokument-term z wagami liczebnoœciowymi
     
     przyslowia_zrodlo <- VectorSource(przyslowia_lemmy)
     przyslowia_korp <- VCorpus(przyslowia_zrodlo)
     
     przyslowia_dtm <- DocumentTermMatrix(przyslowia_korp)
     
     przyslowia_dm <- as.matrix(przyslowia_dtm)
     
     # Definicja funkcji 
     
     rys_dend <- function(macierzTDM, metoda){
       odl <- dist(przyslowia_dm, method = metoda)
       hg <- hclust(odl, method = "ward.D")
       hg_ladne <- as.dendrogram(hg)
       hg_ladne <- color_labels(hg_ladne,3, col = c("royalblue", "orangered", "seagreen"))
       hg_ladne <- color_branches(hg_ladne,3, col = c("royalblue", "orangered", "seagreen"))
       plot(hg_ladne, main = paste("Dendogram na podstawie miary:\n", metoda))
       rect.dendrogram(hg_ladne, k = 3, border = "grey20", lty = 2)
     }
     
     rys_dend(przyslowia_dm, "euclidean")
     
     par(mfrow=c(2,2))
     
     # wykres dla euclidian
     rys_dend(przyslowia_dm, "euclidean")
     
     # wykres dla manhatan
     rys_dend(przyslowia_dm, "manhattan")
     
     # wykres dla cosine
     rys_dend(przyslowia_dm, "cosine")
     
     # wykres dla jaccard
     rys_dend(przyslowia_dm, "jaccard")
     
###### Siódme zajêcia TEORIA ######    
     
     # Instalacja pakietów i ustawienie przestrzeni roboczej
     
     setwd("~/Textm 20171217/text_library")
     install.packages(c("tm", "dendextend", "ggplot2", "dplyr", "proxy",  "stringr"))
     
     library("proxy")
     library("ggplot2")
     library("dendextend")
     library("dplyr")
     library("tm")
     library("stringr")
     
     ########################## GRUPOWANIE #####################
     
     # Miary odleg³oœci
     
     #c("jesieñ", "nie", "nie")
     #c("jesieñ", "nie", "zima", "zima")
     
     d1 <- c(1,2,0)
     d2 <- c(1,1,2)
     
     # Miara euklidesowa
     
     sqrt(sum((d1-d2)^2))
     
     # z biblioteki
     dist(matrix(c(d1,d2), 2, byrow = TRUE), method = "euclidean")
     
     # Miara kosinusowa
     
     cos_licz <- sum(d1*d2)
     cos_mian <- sqrt(sum(d1*d1)) * sqrt(sum(d2*d2))
     1-cos_licz/cos_mian
     
     # sum(d1*d2) == d1 %*% d2
     
     # z biblioteki
     dist(matrix(c(d1,d2), 2, byrow = TRUE), method = "cosine")
     
     # Miara Jaccarda
     
     jac_licz <- length(intersect(c("jesieñ", "nie", "nie"), c("jesieñ", "nie", "zima", "zima")))
     
     jac_mian <- length(union(c("jesieñ", "nie", "nie"), c("jesieñ", "nie", "zima", "zima")))
     
     1-jac_licz/jac_mian
     
     # z biblioteki
     dist(matrix(c(d1,d2), 2, byrow = TRUE), method = "jaccard")
     
     # https://web.ue.katowice.pl/elearning/moodle/file.php/1349/NLPiTM_cw9_st1718.html
     
     # Zaczytanie 
     
     przyslowia <- scan("przyslowia.txt", what="character", sep=",", encoding = "UTF-8")
     
     przyslowia_czyste <- removePunctuation(przyslowia)
     przyslowia_czyste <- str_replace(przyslowia_czyste, "–", "")
     
     przyslowia_czyste <- tolower(przyslowia_czyste)
     
     stopSlowa <- c("czego", "czy", "i", "tego", "w", "z")
     przyslowia_czyste <- removeWords(przyslowia_czyste, stopSlowa)
     
     przyslowia_czyste <- stripWhitespace(przyslowia_czyste)
     przyslowia_czyste <- str_trim(przyslowia_czyste)
     
     # Lematyzacja z uproszczonym s³ownikiem s³ów
     
     slownikMaly <- read.csv2("slownik.txt", header=F, stringsAsFactors=FALSE)
     podstawaMaly<-slownikMaly[,1]
     names(podstawaMaly)<-slownikMaly[,2]
     przyslowia_lemmy <- str_replace_all(przyslowia_czyste, podstawaMaly)
     
     # Utworzenie macierzy dokument-term z wagami liczebnoœciowymi
     
     przyslowia_zrodlo <- VectorSource(przyslowia_lemmy)
     przyslowia_korp <- VCorpus(przyslowia_zrodlo)
     
     przyslowia_dtm <- DocumentTermMatrix(przyslowia_korp)
     
     # Grupowanie hierarchiczne
     
     # Obliczenie odleg³oœci pomiêdzy dokumentami
     
     przyslowia_dm <- as.matrix(przyslowia_dtm)
     odl <- dist(przyslowia_dm)
     
     # Grupowanie hierarchiczne
     
     hg <- hclust(odl)
     
     # Dendogram
     
     plot(hg)
     
     # Poprawianie Dendogramu
     
     hg_ladne <- as.dendrogram(hg)
     
     # zmiana atrybutów etykiet obiektów i ga³êzi nale¿¹cych do skupieñ
     hg_ladne <- color_labels(hg_ladne,3, col = c("royalblue", "orangered", "seagreen"))
     hg_ladne <- color_branches(hg_ladne,3, col = c("royalblue", "orangered", "seagreen"))
     
     # rysowanie dendogramu
     plot(hg_ladne, main = paste("Dendogram na podstawie miary:\n", "euclidean"))
     rect.dendrogram(hg_ladne, k = 3, border = "grey20", lty = 2) 
     
     # Grupowanie niehierarchiczne      
     
     # Normalizacja wszystkich wektorów reprezentuj¹cych dokumenty, czyli normalizacja wierszy macierzy dokument-term
     
     przyslowia_scale <- t(scale(t(przyslowia_dm),
                                 center=FALSE,
                                 scale=sqrt(rowSums(przyslowia_dm^2))))
     
     # alternatywna metoda
     # przyslowia_scale <- przyslowia_dm/apply(przyslowia_dm, MARGIN=1, FUN=function(x) sum(x^2)^.5)
     
     # grupowanie k-means
     
     km <- kmeans(przyslowia_scale, 3) # 3 bo spodziewamy siê 3 klastrów
     km
     
     
     # dzia³ania
     
     sort(km$centers[1,], decreasing = T)
     sort(km$centers[2,], decreasing = T)
     colnames(km$centers)[km$centers[1,] != 0]
     
     colnames(km$centers)[km$centers[2,] != 0]
     
     km$cluster == 1
     
     Docs(przyslowia_dtm[km$cluster == 1,])
     findFreqTerms(przyslowia_dtm[km$cluster == 1,], 2)
     
     findFreqTerms(przyslowia_dtm[km$cluster == 2,], 2)
     
###### Siódme zajêcia ZADANIA ###### 
     
     ###### ZADANIE DOMOWE ######
     
     # Zaczytanie 
     
     przyslowia <- scan("przyslowia.txt", what="character", sep=",", encoding = "UTF-8")
     
     przyslowia_czyste <- removePunctuation(przyslowia)
     przyslowia_czyste <- str_replace(przyslowia_czyste, "–", "")
     
     przyslowia_czyste <- tolower(przyslowia_czyste)
     
     stopSlowa <- c("czego", "czy", "i", "tego", "w", "z")
     przyslowia_czyste <- removeWords(przyslowia_czyste, stopSlowa)
     
     przyslowia_czyste <- stripWhitespace(przyslowia_czyste)
     przyslowia_czyste <- str_trim(przyslowia_czyste)
     
     # Lematyzacja z uproszczonym s³ownikiem s³ów
     
     slownikMaly <- read.csv2("slownik.txt", header=F, stringsAsFactors=FALSE)
     podstawaMaly<-slownikMaly[,1]
     names(podstawaMaly)<-slownikMaly[,2]
     przyslowia_lemmy <- str_replace_all(przyslowia_czyste, podstawaMaly)
     
     # Utworzenie macierzy dokument-term z wagami liczebnoœciowymi
     
     przyslowia_zrodlo <- VectorSource(przyslowia_lemmy)
     przyslowia_korp <- VCorpus(przyslowia_zrodlo)
     
     przyslowia_dtm <- DocumentTermMatrix(przyslowia_korp)
     
     przyslowia_dm <- as.matrix(przyslowia_dtm)
     
     # Definicja funkcji 
     
     rys_dend <- function(macierzTDM, metoda){
       odl <- dist(przyslowia_dm, method = metoda)
       hg <- hclust(odl, method = "ward.D")
       hg_ladne <- as.dendrogram(hg)
       hg_ladne <- color_labels(hg_ladne,3, col = c("royalblue", "orangered", "seagreen"))
       hg_ladne <- color_branches(hg_ladne,3, col = c("royalblue", "orangered", "seagreen"))
       plot(hg_ladne, main = paste("Dendogram na podstawie miary:\n", metoda))
       rect.dendrogram(hg_ladne, k = 3, border = "grey20", lty = 2)
     }
     
     rys_dend(przyslowia_dm, "euclidean")
     
     par(mfrow=c(2,2))
     
     # wykres dla euclidian
     rys_dend(przyslowia_dm, "euclidean")
     
     # wykres dla manhatan
     rys_dend(przyslowia_dm, "manhattan")
     
     # wykres dla cosine
     rys_dend(przyslowia_dm, "cosine")
     
     # wykres dla jaccard
     rys_dend(przyslowia_dm, "jaccard")
     
###### Ósme zajêcia TEORIA ###### 
     
     ### 2018-01-27 Klasyfikacja cz 1 https://web.ue.katowice.pl/elearning/moodle/file.php/1349/NLPiTM_cw11_st1718.html
     
     # Instalacja pakietów
     
     #install.packages(c("dplyr", "kernlab", "caret", "class", "e1071"))
     
     # Zaczytanie bibliotek
     
     library("dplyr")
     library("kernlab")
     library("caret")
     library("class")
     library("e1071")
     data("spam")
     
     #### Przygotowanie danych i algorytm knn ####
     
     # Rozpiêtoœæ wartoœci wag dla ka¿dej zmiennej
     
     spam %>%
       select(-58) %>% 
       summarise_all(funs(max(.)-min(.))) %>% 
       as.matrix() %>% 
       dotchart(cex=0.5, pch = 16, col = "royalblue")
     
     # Wizualizacja bez zmiennych informuj¹cych o d³ugoœci ci¹gów znaków
     
     spam %>%
       select(-c(55:58)) %>% 
       summarise_all(funs(max(.)-min(.))) %>% 
       as.matrix() %>% 
       dotchart(cex=0.5, pch = 16, col = "royalblue")
     
     # Normalizacja
     
     normalizuj <- function(x){
       (x-min(x))/(max(x)-min(x))
     }
     
     spam_norm <- spam %>% 
       select(-type) %>% 
       mutate_all(funs(normalizuj(.)))
     
     # Rozpiêtoœæ wag po normalizacji
     
     spam_norm %>%
       summarise_all(funs(max(.)-min(.))) %>% 
       as.matrix() %>% 
       dotchart(cex=0.5, pch = 16, col = "royalblue")
     
     # Dodanie zmiennej objaœnianej
     
     spam_norm <-  spam_norm %>% 
       bind_cols(Klasa = spam$type)
     
     # Podia³ na zbiór ucz¹cy i testowy
     
     library("caret")
     wUczacym <- createDataPartition(spam$type, p = 0.7, list = FALSE)
     Uczacy <- spam[wUczacym,]
     Testowy <- spam[-wUczacym,]
     
     # Budowa klasyfikatora
     
     library("class") 
     modelSpamKnn <- knn(train = Uczacy[,-58],
                         test = Testowy[,-58],
                         cl = Uczacy[,58],
                         k = 13) 
     head(modelSpamKnn)
     
     # Macierz pomy³ek
     
     confusionMatrix(modelSpamKnn, Testowy$type)
     
     #### Klasyfikator naiwny bayesa ####
     
     # https://web.ue.katowice.pl/elearning/moodle/file.php/1349/NLPiTM_st_w6Bayes_1617.nb.html
     
     # zaczytanie danych
     
     dane<-read.table("spam.txt", header = T, sep = ",")
     
     # podgl¹d danych
     
     table(dane$Spam)
     
     by(dane, dane$Spam, summary)
     
     # Analiza w³aœciwa
     
     library(e1071)
     modelSpamBay<-naiveBayes(Spam ~ ., data = dane)
     modelSpamBay
     
     predict(modelSpamBay, dane[,-5]);dane[,5]           
     
     # Macierz pomy³ek
     
     table(predict(modelSpamBay, dane[,-5]), dane[,5])
     
     # Prawdopodobieñstwo czy spam
     
     round(predict(modelSpamBay, dane[,-5], type = c("raw")),4)
     
     # Pe³na analiza
     
     cbind(round(predict(modelSpamBay, dane[,-5], type = c("raw")),4),
           Predykcja = predict(modelSpamBay, dane[,-5]),
           Empiryczne = dane[,5])
     
     
###### Ósme zajêcia ZADANIA ######     

     #### Zadanie 1 ####
     
     # Instalacja pakietów
     
     install.packages(c("dplyr", "kernlab", "caret", "class", "e1071"))
     
     # Zaczytanie bibliotek
     
     library("dplyr")
     library("kernlab")
     library("caret")
     library("class")
     library("e1071")
     data("spam")
     
     # Przygotowanie danych
     
     # Normalizacja
     
     normalizuj <- function(x)
     {
       (x-min(x))/(max(x)-min(x))
     }
     
     spam_norm <- spam %>% 
       select(-type) %>% 
       mutate_all(funs(normalizuj(.)))
     
     # Dodanie zmiennej objaœnianej
     
     spam_norm <-  spam_norm %>% 
       bind_cols(Klasa = spam$type)
     
     # Funkcja do zadania
     
     Spam_classifer<-function(k)
     {
       # Podzia³ na zbiór ucz¹cy i testowy
       
       library("caret")
       wUczacym <- createDataPartition(spam_norm$Klasa, p = 0.7, list = FALSE)
       Uczacy <- spam_norm[wUczacym,]
       Testowy <- spam_norm[-wUczacym,]
       
       # Budowa klasyfikatora
       
       library("class") 
       modelSpamKnn <- knn(train = Uczacy[,-58],
                           test = Testowy[,-58],
                           cl = Uczacy[,58],
                           k = k)
       # Macierz pomy³ek
       
       CM<-confusionMatrix(modelSpamKnn, Testowy$Klasa)
       print(paste0("Trafnoœæ klasyfikatora k-nn, przy k = ", k, " wynosi: ", CM$overall["Accuracy"]))
     }
     
     Spam_classifer(1)
     Spam_classifer(3)
     Spam_classifer(7)
     
     
     #### Zadanie 2 ####
     
     # Przygotowanie danych
     spam_bin <- spam %>% 
       select(-c(55:58)) %>% 
       mutate_all(funs(as.factor(if_else(. != 0, 1,0))))
     
     spam_bin <-  spam_bin %>% 
       bind_cols(Klasa = spam$type)
     
     # Podzia³ na zbiór ucz¹cy i testowy
     library("caret")
     wUczacym <- createDataPartition(spam_bin$Klasa, p = 0.7, list = FALSE)
     Uczacy <- spam_bin[wUczacym,]
     Testowy <- spam_bin[-wUczacym,]
     
     # Budowa modelu
     library(e1071)
     modelSpamBay<-naiveBayes(Klasa ~ ., data = spam_bin)
     
     spam_przewid <- predict(modelSpamBay, newdata = Testowy)
     CM <- confusionMatrix(spam_przewid, Testowy$Klasa)
     
     print(paste0("Trafnoœæ klasyfikacji algorytmu naiwnego Bayes wynios³a ", CM$overall["Accuracy"]))
     
##### GRUPOWANIE cz 2 #####
     
  # https://web.ue.katowice.pl/elearning/moodle/file.php/1349/NLPiTM_cw12_st1718.html
       
  ## TEORIA
       
    library("dplyr")
    library("kernlab")
    library("caret")
    library("rpart")
    library("rpart.plot")
    library("e1071")
    data("spam")
    
  # Klasyfikacja z wykorzystaniem drzew klasyfikacyjnych
    
    # Przygotowanie danych
    
    normalizuj <- function(x){
      (x-min(x))/(max(x)-min(x))
    }
    
    spam_norm <- spam %>% 
      select(-type) %>% 
      mutate_all(funs(normalizuj(.)))
    
    spam_norm <-  spam_norm %>% 
      bind_cols(Klasa = spam$type)
    

    
    # Podzia³ danych
    wUczacym <- createDataPartition(spam_norm$Klasa, p = 0.7, list = FALSE)
    Uczacy_norm <- spam_norm[wUczacym,]
    Testowy_norm <- spam_norm[-wUczacym,]
    
    table(Uczacy_norm$Klasa)
    
    table(Testowy_norm$Klasa)

    # Model
    
    modelSpam1 <- rpart(Klasa ~ .,
                        data = Uczacy_norm,
                        method = "class")
    # Podgl¹d
    modelSpam1
    summary(modelSpam1)
    
    # Wizualizacja
    rpart.plot(modelSpam1, type = 2, extra = 2)
    
    # Wybór informacji wyœwietlanych w wêz³ach
    # rpart.plot(modelSpam1, type = 2, extra = 4)
    # rpart.plot(modelSpam1, type = 2, extra = 9)
    # rpart.plot(modelSpam1, type = 2, extra = +100)
    
    # Ocena trafnoœci
    przewSpam1 <- predict(modelSpam1, Testowy_norm, type = "class")
    confusionMatrix(przewSpam1, Testowy_norm$Klasa)
    
    # Wizualizacja 
    plotcp(modelSpam1)
    
    # Przyciêcie modelu na podstawie wykresu
    modelSpam1_przy <- prune(modelSpam1, cp = 0.011)
    
    # wizualizacja
    rpart.plot(modelSpam1_przy, type = 2, extra = 2)
    
    # Ocena trafnoœci po przyciêciu
    przewSpam1_przy <- predict(modelSpam1_przy, Testowy_norm, type = "class")
    confusionMatrix(przewSpam1_przy, Testowy_norm$Klasa)
    
    # Mozna lepiej kontrolowaæ przyciêcie
    przyci_control <- rpart.control(minsplit = 103)
    # przyci_control <- rpart.control(minbucket = 50)
    # przyci_control <- rpart.control(maxdepth = 3)
    
    modelSpam2 <- rpart(Klasa ~ .,
                        data = Uczacy_norm,
                        method = "class",
                        control = przyci_control)
    # Wizualizacja po przyciêciu
    rpart.plot(modelSpam2, extra = 2)
    
    # Trafnoœæ
    przewSpam2 <- predict(modelSpam2, Testowy_norm, type = "class")
    confusionMatrix(przewSpam2, Testowy_norm$Klasa)
    
  ## Zadanie
    library("tm")
    library("stringr")
    # Szykowanie korpusu
    
    sciezka <- paste0(getwd(), "/wszystkie")
    rec_zrodlo <- DirSource(sciezka)
    rec_korpus <- VCorpus(rec_zrodlo)
    # korpus
    rec_korpus <- tm_map(rec_korpus, content_transformer(tolower))
    rec_korpus <- tm_map(rec_korpus, removeNumbers)
    rec_korpus <- tm_map(rec_korpus, removeWords, c(stopwords("en"), "one", "two", "three", "make", "get", "movie", "movies", "film", "films"))
    rec_korpus <- tm_map(rec_korpus, stemDocument)
    rec_korpus <- tm_map(rec_korpus, removePunctuation)
    rec_korpus <- tm_map(rec_korpus, stripWhitespace)
    
    # Document term tu chyba trzeba
    rec_tdm <- DocumentTermMatrix(rec_korpus)
    
    # Usuwanie rzadkich term
    rec_tdm_br<-removeSparseTerms(rec_tdm, sparse = 0.95)
    
    # Przerabianie na macierz
    rec_m<-as.matrix(rec_tdm_br)
    
    
    # Przygotowanie danych
    
    normalizuj <- function(x){
      (x-min(x))/(max(x)-min(x))
    }
    
    rec_df<-as.data.frame(rec_m)
    
    rec_df <- rec_df %>% 
      mutate_all(funs(normalizuj(.)))
    
    rec_m <-  rec_m %>% 
      bind_cols(Klasa = str_detect(Docs(rec_norm), "pos"))
    
    a_df<-as.data.frame(a)
    str_detect(Docs(a_df), "neg")
    
    # Chuj pokona³o mnie to zadanie nie wiem jak to zrobiæ :(
    
###### ***ANALIZA SENTYMENTU***  TEORIA ######
     
     # Biblioteki
     
     install.packages(c("sentimentr", "dplyr", "ggplot2", "tidyr", "readr"))
     
     library("sentimentr")
     library("dplyr")
     library("ggplot2")
     library("tidyr")
     library("readr")
     
     #### Przyk³ad ####
     
     # Analiza sentymentu
     
     tekst <- c("Bought it as a random gift for my daughter and she loves it!!!!!",
                "I bought this for my daughter and family. Everybody loves Alexa!",
                "Pretty disappointing. It's pretty worthless.",
                "Disappointing and frustrating ? I'm returning Echo")
     
     # wyci¹ganie zdañ
     get_sentences(tekst)
     
     # wyci¹ganie termów (MUSI BYÆ NAJNOWSZE R !)
     extract_sentiment_terms(tekst)  
     
     extract_sentiment_terms(tekst) %>% unnest(negative)
     
     extract_sentiment_terms(tekst) %>% unnest(positive)
     
     # Analiza nastroju zdañ
     (wynik <- sentiment(tekst, polarity_dt = lexicon::hash_sentiment_huliu))
     
     # Wykres
     plot(wynik)
     
     # Ca³y dokument
     (wynik_by <- sentiment_by(tekst, polarity_dt = lexicon::hash_sentiment_huliu))
     
     # Wykres
     plot(wynik_by)
     
     # Przegl¹d pod k¹tem emocji w zdaniach
     highlight(wynik_by)
     
     # Wizualizacja oceny nastroju wszystkich dokumentów
     
     ggplot(wynik_by, aes(element_id, ave_sentiment)) +
       geom_bar(stat = "identity") +
       labs(title = "Analiza nastrojów opinii", x = "Opinie", y = "Ocena sentymentu") +
       theme_classic()
     
     # £adniejsza wizualizacja
     
     wynik_by %>%
       mutate(kolor = ifelse(ave_sentiment == 0, 
                             "Neutralna",
                             ifelse(ave_sentiment < 0, "Negatywna", "Pozytywna"))) %>%
       ggplot(aes(element_id, ave_sentiment, fill = kolor, color = kolor)) +
       geom_bar(stat = "identity") +
       labs(title = "Analiza nastrojów opinii", x = "Opinie", y = "Ocena sentymentu") +
       theme_classic()
     
     # W³asne kolory
     
     moje_kolory <- c("deeppink", "gold", "green3")
     
     wynik_by %>%
       mutate(kolor = ifelse(ave_sentiment == 0,
                             "Neutralna",
                             ifelse(ave_sentiment < 0, "Negatywna", "Pozytywna"))) %>%
       ggplot(aes(element_id, ave_sentiment, fill = kolor, color = kolor)) +
       geom_bar(stat = "identity") +
       scale_fill_manual(values = moje_kolory) +
       scale_color_manual(values = moje_kolory) +
       labs(title = "Analiza nastrojów opinii", x = "Opinie", y = "Ocena sentymentu") +
       theme_classic()
     
     # Modyfikacja s³ów “kluczowych”
     
     library("lexicon")
     # Przyk³ady s³owników
     head(hash_sentiment_huliu)
     hash_sentiment_huliu[hash_sentiment_huliu$x == "pretty",]
     head(hash_valence_shifters)  
     hash_valence_shifters[hash_valence_shifters$x == "pretty"]
     
     # Dodawanie s³ów
     nowe_slowo <- data.frame(x = "pretty", y = 2)
     hash_sentiment_huliu_moja <- update_key(hash_sentiment_huliu, drop = "pretty") 
     hash_valence_shifters_moja <- update_key(hash_valence_shifters,
                                              x = nowe_slowo)
     # Ponowna ocena ze zmienionym znaczeniem pretty
     
     (wynik_by_pretty <- sentiment_by(tekst,
                                      polarity_dt = hash_sentiment_huliu_moja,
                                      valence_shifters_dt = hash_valence_shifters_moja,
                                      n.before = 5))
     
     # wykres(wynik_by_pretty)
     
     wynik_by_pretty %>%
       mutate(kolor = ifelse(ave_sentiment == 0, "Neutralna", ifelse(ave_sentiment < 0, "Negatywna", "Pozytywna"))) %>%
       ggplot(aes(element_id, ave_sentiment, fill = kolor, color = kolor)) +
       geom_bar(stat = "identity") +
       scale_fill_manual(values = moje_kolory) +
       scale_color_manual(values = moje_kolory) +
       labs(x = "Opinie", y = "Ocena sentymentu") +
       theme_minimal()
     
     
     ### Analiza nastroju dokumentów dla grup dokumentów ###
     
     # Podgl¹d bazy
     data(presidential_debates_2012)
     head(presidential_debates_2012)
     presidential_debates_2012$dialogue[1:4]
     
     # Analiza
     (wynik_pres <- with(presidential_debates_2012, sentiment_by(dialogue, person)))
     
     # Wizualizacja
     plot(wynik_pres)
     
###### ***ANALIZA SENTYMENTU***  ZADANIA ######
     
     # Biblioteki
     
     install.packages(c("sentimentr", "dplyr", "ggplot2", "tidyr", "readr"))
     
     library("sentimentr")
     library("dplyr")
     library("ggplot2")
     library("tidyr")
     library("readr")
     
     # Zaczytanie i przerobienie na tekst
     
     coffee <- read.csv2("coffee_tweets.csv")
     tea <- read.csv2("tea_tweets.csv")
     
     tea_tekst<-as.character(tea$text)
     coffee_tekst<-as.character(coffee$text)
     
     # Analiza
     
     (wynik_tea <- sentiment_by(tea_tekst, polarity_dt = lexicon::hash_sentiment_huliu))
     (wynik_coffee <- sentiment_by(coffee_tekst, polarity_dt = lexicon::hash_sentiment_huliu))
     
     # Wykresy
     
     moje_kolory <- c("deeppink", "gold", "green3")
     
     # TEA
     wynik_tea %>%
       mutate(kolor = ifelse(ave_sentiment == 0,
                             "Neutralna",
                             ifelse(ave_sentiment < 0, "Negatywna", "Pozytywna"))) %>%
       ggplot(aes(element_id, ave_sentiment, fill = kolor, color = kolor)) +
       geom_bar(stat = "identity") +
       scale_fill_manual(values = moje_kolory) +
       scale_color_manual(values = moje_kolory) +
       labs(title = "Analiza nastrojów opinii - tea tweets", x = "Opinie", y = "Ocena sentymentu") +
       theme_classic()
     
     # COFFEE
     wynik_coffee %>%
       mutate(kolor = ifelse(ave_sentiment == 0,
                             "Neutralna",
                             ifelse(ave_sentiment < 0, "Negatywna", "Pozytywna"))) %>%
       ggplot(aes(element_id, ave_sentiment, fill = kolor, color = kolor)) +
       geom_bar(stat = "identity") +
       scale_fill_manual(values = moje_kolory) +
       scale_color_manual(values = moje_kolory) +
       labs(title = "Analiza nastrojów opinii - coffee tweets", x = "Opinie", y = "Ocena sentymentu") +
       theme_classic()
     
###########################################################
#                 PLIK Z PASTEBIN                         #
###########################################################
     
     getwd()
     setwd("D:/Studia/Magisterskie/Semestr III/Przetwarzanie")
     # tabela danych -> df
     # wektor -> c("..","...","..") / vec
     # # wiele plików -> dir
     
     library(tm)
     tekst_df <- data.frame(tekst=c("Tekst pierwszy", "Tekst drugi"))
     zrodlo_df<-DataframeSource(tekst_df)
     zrodlo_df$content
     
     tekst_vec <- c("Tekst pierwszy", "Tekst drugi")
     zrodlo_vec <- VectorSource(tekst_vec)
     
     zrodlo_dir <-DirSource(paste0(getwd(),"/Teksty/"))
     zrodlo_dir
     
     korpus_df<-VCorpus(zrodlo_df)
     korpus_vec<-VCorpus(zrodlo_vec)
     korpus_dir<-VCorpus(zrodlo_dir)
     zrodlo_dir <-DirSource(paste0(getwd(),"/Teksty/"))
     #zadanie Wczytaj dane z coffe_tweets.csv. Zidentyfikuj kolumne zawierajaca teksty wiadomosci.
     #1. utworz korpus z 20 pierwszych cwierkow
     #2. wektor tekstowy z 20 pierwszych cwierkow
     # korpus z wektora 20 pierwszych cwierkow
     #3. w foldrze cwierki swotrz 20 plikow tekstowych do ktorych wpisz 20 kolejnych cwierkow
     # korpus z wektora 2- pierwszych cwierkow
     #1
     kawa <- read.csv2(paste0(getwd(),"/coffee_tweets.csv"))
     class(kawa)
     podzial<-data.frame(head(kawa[,1],20))
     zrodlo_kawa <- DataframeSource(podzial)
     korpus_df<-VCorpus(zrodlo_kawa)
     #2
     
     kawa <- read.csv2(paste0(getwd(),"/coffee_tweets.csv"))
     vektor<-as.vector(kawa$text)
     zrodlo_kawa<-VectorSource(head(as.vector(kawa$text),20))
     korpus_kawa<-VCorpus(zrodlo_kawa)
     #3
     kawa <- read.csv2(paste0(getwd(),"/coffee_tweets.csv"))
     vektor<-as.vector(kawa$text)
     dir.create(file.path(getwd(), "cwierki"), showWarnings = FALSE)
     for(i in 1:20)
     {
       write(vektor[i],file=paste0(getwd(),"/Cwierki/cwierk",i,".txt"))
     }
     zrodlo_kawa<-DirSource(directory = paste0(getwd(),"/Cwierki/"))
     korpus_dir<-VCorpus(zrodlo_kawa)
     
     #zajecia 2016-10-24
     library(tm)
     
     tekstANG<-"<b>She</b> woke up 6 A.M. It\'s so early! She was only 10% awake and began drinking coffee in front of her computer"
     tekstPOL<-"To jest 4. przys³owie: \"Œw. Bat³omiej pogodny, jesieñ pogodna\" "
     
     tolower(tekstANG)
     tolower(tekstPOL)
     
     removePunctuation(tekstANG)
     removePunctuation(tekstPOL)
     
     # nastepne zajecia library(qdap)
     
     removeNumbers(tekstANG)
     removeNumbers(tekstPOL)
     
     stripWhitespace(tekstANG)
     stripWhitespace(tekstPOL)
     
     #stio wirds
     "stop words"
     stopwords("en")
     ?stopwords
     
     removeWords(tekstANG, stopwords("en"))
     
     new_stops <-c("coffee","cup", stopwords("en"))
     removeWords(tekstANG, new_stops)
     
     stopWordsPL <-c("Œw.","to")
     removeWords(tekstPOL, stopWordsPL)
     zzzz<-gsub("Œ","", tekstPOL)
     
     # dla zainterestowanych library(stringr)
     przyslowia<-scan("przyslowia.txt", fileEncoding="UTF-8", what="character", sep=",")
     przyslowia_zr_vec <- VectorSource(przyslowia)
     przyslowia_korp<-VCorpus(przyslowia_zr_vec)
     przyslowia_korp[[1]]$content
     
     przyslowia_czyste <-tm_map(przyslowia_korp, content_transformer(tolower))
     przyslowia_czyste[[10]]$content
     
     przyslowia_czyste<-tm_map(przyslowia_czyste, removePunctuation)
     przyslowia_czyste[[3]]$content
     
     stopWordsPL <- c("tak","to","tego","czego","jaka","taka","i","czy","w","z","nim","jakiej","tak¹","jaki","tak¹¿","tak¹æ","taki")
     przyslowia_czyste <-tm_map(przyslowia_czyste, removeWords, stopWordsPL)
     
     przyslowia_czyste <-tm_map(przyslowia_czyste, content_transformer(function(x) gsub("œ", "", x)))
     
     library(tm)
     kawa<-read.csv2("coffee_tweets.csv")
     kawa_zr_vec <-VectorSource(kawa$text)
     kawa_korp <-VCorpus(kawa_zr_vec)
     
     #stworzenie funkcji dokonujacej kompletnego oczyszczenia tekstu, z mozliwoscia dodania przez uzytkownika wlasnych zbednych slow (ang)
     
     czysc_korpus <- function(czysty_korpus, lista_slow=NULL) {
       library(tm)
       czysty_korpus<-tm_map(czysty_korpus, removePunctuation)
       czysty_korpus<-tm_map(czysty_korpus, content_transformer(tolower))
       czysty_korpus<-tm_map(czysty_korpus, removeNumbers)
       czysty_korpus<-tm_map(czysty_korpus, stripWhitespace)
       czysty_korpus<-tm_map(czysty_korpus, removeWords, c(lista_slow, stopwords("en")))
       return(czysty_korpus)
     }
     clear_text<-czysc_korpus(kawa_korp,c("coffee"))
     
     # cwiczenia 3
     kawa_tdm <- TermDocumentMatrix(clear_text)
     kawa_tdm
     
     findFreqTerms(kawa_tdm,100)
     
     kawa_m<-as.matrix(kawa_tdm)
     dim(kawa_m)
     
     kawa_term <- rowSums(kawa_m)
     head(kawa_term)
     
     kawa_term <- sort(kawa_term, decreasing=TRUE)
     head(kawa_term)
     
     barplot(kawa_term[1:10], col="tan", las=2)
     ## zad 1
     kawa_term<-czysc_korpus(kawa_korp,c("coffee"))
     ## zad 2
     library(wordcloud)
     wordcloud(names(kawa_term), kawa_term, max.words = 50, colors="steelblue4")
     wordcloud(names(kawa_term), kawa_term, max.words= 50, colors=c("grey80", "tan", "darkorange4"))
     
     ##ZAD 3
     herbata<-read.csv2("tea_tweets.csv")
     herbata_zr_vec <-VectorSource(herbata$text)
     herbata_korp <-VCorpus(herbata_zr_vec)
     herbata_korp<-czysc_korpus(herbata_korp,c("teatime","tea"))
     herbata_tdm <- TermDocumentMatrix(herbata_korp)
     herbata_m<-as.matrix(herbata_tdm)
     herbata_term <- rowSums(herbata_m)
     herbata_term <- sort(herbata_term, decreasing=TRUE)
     wordcloud(names(herbata_term), herbata_term, max.words = 50, colors="steelblue4")
     
     ##
     kawa<-read.csv2("coffee_tweets.csv")
     kawaTekst <- paste(kawa$text, collapse = " ")
     herbata<-read.csv2("tea_tweets.csv")
     herbataTekst <- paste(herbata$text, collapse = " ")
     
     razemTekst <- c(kawaTekst, herbataTekst)
     
     razem_source <- VectorSource(razemTekst)
     razem_korp <- VCorpus(razem_source)
     razem_czysty <- czysc_korpus(razem_korp, c("coffee", "teatime", "tea"))
     razem_tdm <- TermDocumentMatrix(razem_czysty)
     razem_m <- as.matrix(razem_tdm)
     commonality.cloud(razem_m, max.words = 50, colors = "steelblue4")
     razem_tdm_nazwy <- razem_tdm
     colnames(razem_tdm_nazwy) <- c("kawa", "herbata")
     
     # a nastêpnie wyœwietliæ chmurê
     razem_m_nazwy <- as.matrix(razem_tdm_nazwy)
     comparison.cloud(razem_m_nazwy, max.words = 50, colors = c("orangered3", "darkolivegreen3"))
     
     # zadanie domowe
     kawa<-paste(readLines("Tekst1.txt"), collapse=" ", header=FALSE)
     herbata<-paste(readLines("Tekst2.txt"), collapse=" ", header=FALSE)
     
     razemTekst <- c(kawa, herbata)
     
     razem_source <- VectorSource(razemTekst)
     razem_korp <- VCorpus(razem_source)
     razem_czysty <- czysc_korpus(razem_korp, c("false","one","can","even","priceget","'ll","'LL","`ll","'II"))
     razem_tdm <- TermDocumentMatrix(razem_czysty)
     razem_m <- as.matrix(razem_tdm)
     commonality.cloud(razem_m, max.words = 60, colors = "red2")
     razem_tdm_nazwy <- razem_tdm
     colnames(razem_tdm_nazwy) <- c("pcmasterrace", "consoles")
     
     # a nastêpnie wyœwietliæ chmurê
     razem_m_nazwy <- as.matrix(razem_tdm_nazwy)
     comparison.cloud(razem_m_nazwy, max.words = 100, colors = c("blue2", "orange"))
     
     #zajecia 2016-11-07
     install.packages(c("tm","stringr","wordcloud","SnowballC"))
     library(tm)
     library(stringr)
     library(wordcloud)
     library(SnowballC)
     setwd("D:/Studia/Magisterskie/Semestr III/Przetwarzanie")
     
     slowa <- c("argue","argued","argues","arguing")
     
     rdzen<-stemDocument(slowa)
     rdzen
     
     slownik<-c("argue")
     kompletne_slowa<-stemCompletion(rdzen,slownik)
     kompletne_slowa
     
     stemDocument("John is argumentative. He argues about everything, yesterday was arguing for one penny")
     
     tekst<-"John is argumentative. He argues about everything, yesterday was arguing for one penny"
     
     tekst_punc<-removePunctuation(tekst)
     slowa<-str_split(tekst_punc,' ')
     
     rdzen<-stemDocument(slowa[[1]])
     
     slownik <-c("argue","everything","penny")
     
     kompletne_slowa<-stemCompletion(rdzen,slownik)
     
     kompletne_slowa<-stemCompletion(rdzen,unlist(slowa))
     
     #zastanowienie sie nad porzadkiem kodu, ograniczyc sie do zdania tego john is argumentative
     
     kawa_stem<-tm_map(clear_text,stemDocument)
     # tu kod wczesniejszy z termdocumentmatrix
     
     przyslowia<-scan("przyslowia.txt", encoding ="UTF-8", what="character", sep=",")
     przyslowia_czyste<-removePunctuation(przyslowia)
     przyslowia_czyste<-str_replace(przyslowia_czyste, "– ", "")
     przyslowia_czyste<-tolower(przyslowia_czyste)
     stopWords<-c("czego","czy","i","tego","w","z")
     przyslowia_czyste<-removeWords(przyslowia_czyste,stopWords)
     przyslowia_czyste<-stripWhitespace(przyslowia_czyste)
     
     slownik <- read.csv2("slownik.txt", header=F, stringsAsFactors=FALSE)
     podstawa<-slownik[,1]
     names(podstawa)<-slownik[,2]
     przyslowia_lemmy<-str_replace_all(przyslowia_czyste,podstawa)
     
     #zadanie
     
     create_complete_vector<-function(tekst, words=NULL)
     {
       library(tm)
       library(stringr)
       #zastosowalem biblioteke hunspell zamiast tm-a do stemmingu. Dodatkowo musialem zmienic litery na male
       library(hunspell)
       tekst_punc <- removePunctuation(tekst)
       tekst_punc<-tolower(tekst_punc)
       slowa <- str_split(tekst_punc, ' ')
       print(slowa)
       rdzenie <- hunspell_stem(unlist(slowa),dict="en_US")
       print(rdzenie)
       kompletne_slowa <- stemCompletion(rdzenie, unlist(slowa), type = "prevalent")
       
     }
     tekst<-"John is argumentative. He argues about everything, yesterday was arguing for one penny"
     wynik<-create_complete_vector(tekst)
     print(wynik)
     
     #zajecia 14.11.2016
     getwd()
     setwd("D:/Studia/Magisterskie/Semestr III/Przetwarzanie")
     library("stringr")
     grep('ac', c('caryca', 'plac', 'skacz', 'aczkolwiek'))
     grepl('ac', c('caryca', 'plac', 'skacz', 'aczkolwiek'))
     grep('ac', 'aczkolwiek caryca skacze przez plac')
     str_detect(c('caryca', 'plac', 'skacz', 'aczkolwiek'), 'ac')
     grep('ac', c('caryca', 'plac', 'skacz', 'aczkolwiek'), value = TRUE)
     grep('ac', 'aczkolwiek caryca skacze przez plac', value = TRUE)
     str_extract(c('caryca', 'plac', 'skacz', 'aczkolwiek'), 'ac')
     str_extract('aczkolwiek caryca skacze przez plac', 'ac')
     str_extract_all(c('caryca', 'plac', 'skacz', 'aczkolwiek'), 'ac')
     str_extract_all('aczkolwiek caryca skacze przez plac', 'ac')
     zdanie <- 'Zadanie na dziœ: zadwoniæ do Oskara (687543190), odnaleŸæ poczkê (879 987 423) i zadzwoniæ 543876123'
     str_extract_all(zdanie, '[0-9]{9}')
     regexpr('ac', c('caryca', 'plac', 'skacz', 'aczkolwiek'))
     regexpr('ac', 'aczkolwiek caryca skacze przez plac')
     gregexpr('ac', c('caryca', 'plac', 'skacz', 'aczkolwiek'))
     gregexpr('ac', 'aczkolwiek caryca skacze przez plac')
     str_locate(c('caryca', 'plac', 'skacz', 'aczkolwiek'), 'ac')
     str_locate('aczkolwiek caryca skacze przez plac', 'ac')
     str_locate_all(c('caryca', 'plac', 'skacz', 'aczkolwiek'), 'ac')
     str_locate_all('aczkolwiek caryca skacze przez plac', 'ac')
     substr('aczkolwiek caryca skacze przez plac', 4, 13)
     sub('ac', 'CA', c('caryca', 'plac', 'skacz', 'aczkolwiek'))
     str_replace(c('caryca', 'plac', 'skacz', 'aczkolwiek'), 'ac', 'CA')
     str_replace_all(c('caryca', 'plac', 'skacz', 'aczkolwiek'), 'ac', 'CA')
     strsplit('aczkolwiek caryca skacze przez plac', '[ ]')
     str_split('aczkolwiek caryca skacze przez plac', '[ ]', 3)
     zdania <- c('Pierwsze zdanie do rozdzielenia',
                 'Pierwsze zdanie do rozdzielenia')
     str_split(zdania, '[ ]', 2)
     
     #zadanie 1
     tekst <- "Dzisiaj mamy 10 dzieñ miesi¹ca 03 roku 2011"
     string_position<-gregexpr('[0-9]', tekst)[[1]]
     #zadanie 2
     tekst <- "Dzisiaj mamy 10 dzieñ miesi¹ca 03 roku 2011"
     str_extract_all(tekst,'[a-zA-Z¿Ÿæñ¹œ³êó¯ÆÑ¥Œ£ÊÓ]{4,}')
     #zadanie 3
     kod <- '<p>linia tekstu <b>pogrubienie</b> kolejny tekst <em>wyróznienie</em>.</p>'
     str_split(kod, '</?[a-zA-Z]{1,3}>')
     #zadanie 4
     get_tweets<-function(tweety)
     {
       library(stringr)
       return(str_extract_all(tweety, '#[a-zA-Z]+'))
     }
     #zadanie 5
     get_non_tweets<-function(tweety)
     {
       library(stringr)
       return(str_extract_all(tweety, '\b[a-zA-Z]+'))
     }
     #zadanie 6
     .*p.t.*
       
       
       #zajecia 21.11.2016
       install.packages(c("tm", "dendextend", "qdap", "ggplot2"))
     
     library("tm")
     library("dendextend")
     library("qdap")
     library("ggplot2")  
     setwd("D:/Studia/Magisterskie/Semestr III/Przetwarzanie")
     
     kawa <- read.csv2("coffee_tweets.csv")
     kawa_zr_vec <- VectorSource(kawa$text)
     kawa_korp <- VCorpus(kawa_zr_vec)
     czysc_korpus <- function(corpus, slowa = ""){
       corpus <- tm_map(corpus, stripWhitespace)
       corpus <- tm_map(corpus, removePunctuation)
       corpus <- tm_map(corpus, content_transformer(tolower))
       corpus <- tm_map(corpus, removeNumbers)
       corpus <- tm_map(corpus, removeWords, c(stopwords("en"), slowa))
       return(corpus)
     }
     
     kawa_czysty <- czysc_korpus(kawa_korp, "coffee")
     kawa_tdm <- TermDocumentMatrix(kawa_czysty)
     
     kawa_shop <- findAssocs(kawa_tdm, "shop", 0.2)
     kawa_shop
     list_vect2df(kawa_shop)
     
     shop_zal <- list_vect2df(kawa_shop)[, 2:3]
     head(shop_zal)
     
     ggplot(shop_zal, aes(x = X3, y = X2)) + 
       geom_point(size = 3, color = "steelblue") +
       theme_minimal()
     
     kawa_tdm1<-removeSparseTerms(kawa_tdm, sparse = 0.95)
     dim(kawa_tdm1)
     
     Terms(kawa_tdm1)
     
     kawa_tdm2<-removeSparseTerms(kawa_tdm, sparse = 0.975)
     dim(kawa_tdm2)
     Terms(kawa_tdm2)
     
     kawa_m2 <- as.matrix(kawa_tdm2)
     kawa_odleg <- dist(kawa_m2)
     
     klastry2 <- hclust(kawa_odleg)
     plot(klastry2)
     
     klastry2_ladne <- as.dendrogram(klastry2)
     
     # zmiana atrybutów wybranych ga³êzi 
     klastry2_ladne <- branches_attr_by_labels(klastry2_ladne, c("shop", "starbucks"), "orangered")
     
     plot(klastry2_ladne, main = "£adniejszy dendrogram")
     rect.dendrogram(klastry2_ladne, k = 3, border = "steelblue")
     
     #zadanie
     herbata <- read.csv2("tea_tweets.csv")
     kawa_zr_vec <- VectorSource(herbata$text)
     kawa_korp <- VCorpus(kawa_zr_vec)
     kawa_czysty <- czysc_korpus(kawa_korp, c("tea","teatime","https"))
     kawa_tdm <- TermDocumentMatrix(kawa_czysty)
     kawa_tdm2<-removeSparseTerms(kawa_tdm, sparse = 0.945)
     
     kawa_m2 <- as.matrix(kawa_tdm2)
     kawa_odleg <- dist(kawa_m2)
     klastry2 <- hclust(kawa_odleg)
     klastry2_ladne <- as.dendrogram(klastry2)
     
     # zmiana atrybutów wybranych ga³êzi 
     klastry2_ladne <- branches_attr_by_labels(klastry2_ladne, c("cup","pot","teaparty","sugar"), "orangered")
     
     plot(klastry2_ladne, main = "£adniejszy dendrogram")
     rect.dendrogram(klastry2_ladne, k = 3, border = c("steelblue","green","red"))
     
     # zajecia 28-11-2016
     install.packages(c("tm", "dendextend", "ggplot2"))
     
     library("tm")
     library("dendextend")
     library("ggplot2")
     setwd("D:/Studia/Magisterskie/Semestr III/Przetwarzanie")
     corpusA  <-Corpus(DirSource(paste(getwd(),"/pos",sep="")), readerControl = list(language="en"))
     corpusB  <-Corpus(DirSource(paste(getwd(),"/neg",sep="")), readerControl = list(language="en"))
     corpusC <- c(corpusA, corpusB)
     czysty_korpus<-tm_map(corpusC, content_transformer(tolower))
     czysty_korpus<-tm_map(czysty_korpus, removeNumbers)
     czysty_korpus<-tm_map(czysty_korpus, removeWords, c(stopwords("en")))
     czysty_korpus<-tm_map(czysty_korpus, stemDocument)
     czysty_korpus<-tm_map(czysty_korpus, removePunctuation)
     czysty_korpus<-tm_map(czysty_korpus, stripWhitespace)
     term_licz<- TermDocumentMatrix(czysty_korpus)
     term_bin<- TermDocumentMatrix(czysty_korpus,control = list(weighting = weightBin))
     term_log<- TermDocumentMatrix(czysty_korpus, control = list(weighting= function(x) weightSMART(x, spec="lnn")))
     term_tfldf<- TermDocumentMatrix(czysty_korpus, control = list(weighting=weightTfIdf))
     
     term_licz2<-removeSparseTerms(term_licz, sparse = 0.95)
     term_bin2<-removeSparseTerms(term_bin, sparse = 0.95)
     term_log2<-removeSparseTerms(term_log, sparse = 0.95)
     term_tfldf2<-removeSparseTerms(term_tfldf, sparse = 0.95)
     
     
     mat_licz<-as.matrix(term_log2)
     sums_licz<-rowMeans(mat_licz)
     sums_licz<-sort(sums_licz, decreasing = TRUE)
     
     barplot(sums_licz[1:20], las=2)
     
     ## 05-12-2016
     install.packages(c("tm", "dendextend", "ggplot2", "stringr", "RWeka"))
     
     library("tm")
     library("ggplot2")
     library("dendextend")
     library("stringr")
     library("RWeka")
     setwd("D:/Studia/Magisterskie/Semestr III/Przetwarzanie")
     
     sciezka <- paste0(getwd(), "/wszystkie")
     rec_zrodlo <- DirSource(sciezka)
     rec_korpus <- VCorpus(rec_zrodlo)
     
     rec_korpus <- tm_map(rec_korpus, content_transformer(tolower))
     rec_korpus <- tm_map(rec_korpus, removeNumbers)
     rec_korpus <- tm_map(rec_korpus, removeWords, c(stopwords("en"), "one", "two", "three", "make", "get", "movie", "movies", "film", "films"))
     rec_korpus <- tm_map(rec_korpus, stemDocument)
     rec_korpus <- tm_map(rec_korpus, removePunctuation)
     rec_korpus <- tm_map(rec_korpus, stripWhitespace)
     rec_mat<- TermDocumentMatrix(rec_korpus)
     rec_mat2<-removeSparseTerms(rec_mat, sparse = 0.95)
     inspect(rec_mat2)
     dtm_m <- as.matrix(rec_mat2)
     dtm_odleg <- dist(dtm_m)
     klastry <- hclust(dtm_odleg)
     klastry <- as.dendrogram(klastry)
     plot(klastry, main = "Liczebnoœci")
     klastry2<-kmeans(dtm_m, 2)
     
     findFreqTerms(rec_mat[klastry2$cluster == 2,], 2)
     
     #zajecia 12-12-2016
     setwd("D:/Studia/Magisterskie/Semestr III/Przetwarzanie")
     library(tm)
     library(stringr)
     library(caret)
     library(party)
     sciezka <- paste0(getwd(), "/wszystkie")
     rec_zrodlo <- DirSource(sciezka)
     rec_korpus <- VCorpus(rec_zrodlo)
     
     rec_korpus <- tm_map(rec_korpus, content_transformer(tolower))
     rec_korpus <- tm_map(rec_korpus, removeNumbers)
     rec_korpus <- tm_map(rec_korpus, removeWords, c(stopwords("en"), "one", "two", "three", "make", "get", "movie", "movies", "film", "films"))
     rec_korpus <- tm_map(rec_korpus, stemDocument)
     rec_korpus <- tm_map(rec_korpus, removePunctuation)
     rec_korpus <- tm_map(rec_korpus, stripWhitespace)
     #rec_mat<- DocumentTermMatrix(rec_korpus)
     #term_licz<- TermDocumentMatrix(rec_korpus)
     #rec_mat<- TermDocumentMatrix(rec_korpus,control = list(weighting = weightBin))
     #term_log<- TermDocumentMatrix(rec_korpus, control = list(weighting= function(x) weightSMART(x, spec="lnn")))
     term_tfldf<- TermDocumentMatrix(rec_korpus, control = list(weighting=weightTfIdf))
     
     rec_mat2<-removeSparseTerms(rec_mat, sparse = 0.95)
     
     #tabela danyh
     #opinia<-ifelse(str_detect(Docs(rec_mat2), "pos"), "pos","neq")
     #t<-as.matrix(rec_mat2)
     #df<-as.data.frame(t)
     #df$klasa<-opinia
     
     rec_df<-data.frame(as.matrix(rec_mat2), klasa= ifelse(str_detect(Docs(rec_mat2), "pos"), "pos","neq"))
     drzewko<-ctree(klasa~.,data=rec_df)
     
     wUczacym<-createDataPartition(rec_df$klasa, p=0.7, list=FALSE)
     Uczacy<-rec_df[wUczacym,]
     Testowy<-rec_df[-wUczacym,]
     
     # zajecia 19-12-2016
     #ciag dalszy poprzednich zajec
     prop.table(table(Uczacy$klasa))
     prop.table(table(Testowy$klasa))
     
     rec_model_Ucz <-ctree(klasa ~ ., data=Uczacy)
     plot(rec_model_Ucz)
     
     #weryfikacja
     rec_przewid<-predict(rec_model_Ucz, newdata=Testowy)
     table(rec_przewid, Testowy$klasa)
     
     x<-confusionMatrix(rec_przewid, Testowy$klasa)
     Tfldf<-x$overall['Accuracy']
     table(Liczebnosciowa,Binarna,Logarytmiczna,Tfldf)
     x<-merge(Liczebnosciowa,Binarna,by.x=accuracy,by.y=accuracy)
     Wagi<-c("Liczebniosciowa","Binarna","Logarytmiczna","Tfldfd")
     lista<-list(Liczebnosciowa=Liczebnosciowa,Binarna=Binarna,Logarytmiczna=Logarytmiczna,Tfldf=Tfldf)
     data.frame(Accurancy = round(sapply(lista,function(x) x$overall["Accuracy"]),4),row.names=names(lista))
     
     #### 09-01-2017
     setwd("D:/Studia/Magisterskie/Semestr III/Przetwarzanie")
     install.packages(c("sentimentr", "dplyr", "ggplot2"))
     
     library("sentimentr")
     library("dplyr")
     library("ggplot2")
     tekst <- c("Bought it as a random gift for my daughter and she loves it!!!!!",
                "I bought this for my daughter and family. Everybody loves Alexa!",
                "Pretty disappointing. It's pretty worthless.",
                "Disappointing and frustrating ? I'm returning Echo")
     extract_sentiment_terms(tekst)
     get_sentences(tekst)
     (wynik <- sentiment(tekst))
     plot(wynik)
     plot(wynik$sentiment/sum(abs(wynik$sentiment))*100, type = "l")
     
     (wynik_by <- sentiment_by(tekst))
     plot(wynik_by)
     highlight(wynik_by)
     
     ggplot(wynik_by, aes(element_id, ave_sentiment)) +
       geom_bar(stat = "identity") +
       labs(title = "Analiza nastrojów opinii", x = "Opinie", y = "Ocena sentymentu") +
       theme_minimal()
     
     wynik_by %>%
       mutate(kolor = ifelse(ave_sentiment == 0, 
                             "Neutralna",
                             ifelse(ave_sentiment < 0, "Negatywna", "Pozytywna"))) %>%
       ggplot(aes(element_id, ave_sentiment, fill = kolor, color = kolor)) +
       geom_bar(stat = "identity") +
       labs(title = "Analiza nastrojów opinii", x = "Opinie", y = "Ocena sentymentu") +
       theme_minimal()
     
     moje_kolory <- c("deeppink", "gold", "green3")
     
     wynik_by %>%
       mutate(kolor = ifelse(ave_sentiment == 0,
                             "Neutralna",
                             ifelse(ave_sentiment < 0, "Negatywna", "Pozytywna"))) %>%
       ggplot(aes(element_id, ave_sentiment, fill = kolor, color = kolor)) +
       geom_bar(stat = "identity") +
       scale_fill_manual(values = moje_kolory) +
       scale_color_manual(values = moje_kolory) +
       labs(title = "Analiza nastrojów opinii", x = "Opinie", y = "Ocena sentymentu") +
       theme_minimal()
     
     data("polarity_table")
     head(polarity_table)
     polarity_table[polarity_table$x == "pretty",]
     data("valence_shifters_table")
     head(valence_shifters_table)
     valence_shifters_table[valence_shifters_table$x == "pretty"]
     nowe_slowo <- data.frame(x = "pretty", y = 2)
     polarity_table_moja <- update_key(polarity_table, drop = "pretty") 
     valence_shifters_table_moja <- update_key(valence_shifters_table,
                                               x = nowe_slowo,
                                               comparison = polarity_table_moja)
     
     (wynik_by_pretty <- sentiment_by(tekst,
                                      polarity_dt = polarity_table_moja,
                                      valence_shifters_dt = valence_shifters_table_moja,
                                      n.before = 5))
     wynik_by_pretty %>%
       mutate(kolor = ifelse(ave_sentiment == 0, "Neutralna", ifelse(ave_sentiment < 0, "Negatywna", "Pozytywna"))) %>%
       ggplot(aes(element_id, ave_sentiment, fill = kolor, color = kolor)) +
       geom_bar(stat = "identity") +
       scale_fill_manual(values = moje_kolory) +
       scale_color_manual(values = moje_kolory) +
       labs(x = "Opinie", y = "Ocena sentymentu") +
       theme_minimal()
     
     sciezka <- paste0(getwd(), "/wszystkie")
     
     kawa<-read.csv2("coffee_tweets.csv")
     kawaTekst <- paste(kawa$text)
     herbata<-read.csv2("tea_tweets.csv")
     herbataTekst <- paste(herbata$text)
     
     razemTekst <- c(kawaTekst, herbataTekst)
     
     (wynik_by <- sentiment_by(kawaTekst))
     #plot(wynik_by)
     #highlight(wynik_by)
     
     moje_kolory <- c("red2", "darkgray", "green2")
     
     wynik_by %>%
       mutate(kolor = ifelse(ave_sentiment == 0,
                             "Neutralna",
                             ifelse(ave_sentiment < 0, "Negatywna", "Pozytywna"))) %>%
       ggplot(aes(element_id, ave_sentiment, fill = kolor, color = kolor)) +
       geom_bar(stat = "identity") +
       scale_fill_manual(values = moje_kolory) +
       scale_color_manual(values = moje_kolory) +
       labs(title = "Analiza nastrojów opinii", x = "Opinie", y = "Ocena sentymentu") +
       theme_minimal()
     
     data(presidential_debates_2012)
     head(presidential_debates_2012)
     (wynik_pres <- with(presidential_debates_2012, sentiment_by(dialogue, person)))
     plot(wynik_pres)
     
     #zajecia 16-01-2017
     install.packages(c("topicmodels", "tm", "ggplot2"))
     setwd("D:/Studia/Magisterskie/Semestr III/Przetwarzanie")
     library("topicmodels")
     library("tm")
     library("ggplot2")
     tekst_topic <- c("I had a peanut butter sandwich for breakfast.",
                      "I like to eat almonds, peanuts and walnuts.",
                      "My neighbor got a little dog yesterday.",
                      "Cats and dogs are mortal enemies.",
                      "You mustn’t feed peanuts to your dog.")
     zrodlo_topic <- VectorSource(tekst_topic)
     korpus_topic <- VCorpus(zrodlo_topic)
     dtm_topic <-  DocumentTermMatrix(korpus_topic,
                                      control = list(stemming = TRUE,
                                                     stopwords = TRUE,
                                                     removeNumbers = TRUE,
                                                     removePunctuation = TRUE))
     as.matrix(dtm_topic)
     colSums(as.matrix(dtm_topic))
     lda_topic <- LDA(dtm_topic, 2, control = list(seed = 1652))
     # str(lda_topic)
     (tematy <- topics(lda_topic))
     (tematy_term <- terms(lda_topic))
     tematy_term[tematy]
     tematy1_df <- data.frame(dokument = 1:5, Tekst = tekst_topic, Tematy=tematy_term[tematy])
     (tematy_termy4 <- terms(lda_topic, 18))
     str(tematy_termy4)
     tematy_termy4[1,][tematy]
     tematy_termy4[,1]
     # paste(tematy_termy4[,1], collapse = "/ ")
     tematy_termy4 <- apply(tematy_termy4, 2, paste, collapse = "/ ")
     tematy4_df <- data.frame(dokument = 1:5, Tekst = tekst_topic, Tematy=tematy_termy4[tematy])
     beta_topic <- lda_topic@beta
     colnames(beta_topic) <- lda_topic@terms
     beta_topic
     beta_t1 <- sort(beta_topic[1,], decreasing = T)
     beta_t2 <- sort(beta_topic[2,], decreasing = T)
     
     tabela_topic <- data.frame(Topic = rep(c(1,2), each = 5),
                                Term = c(names(beta_t1)[1:5],names(beta_t2)[1:5]),
                                beta=c(beta_t1[1:5], beta_t2[1:5]))
     ggplot(tabela_topic, aes(Term, beta, fill = factor(Topic))) + 
       geom_bar(stat = "identity", show.legend = FALSE) +
       facet_wrap(~ Topic) +
       coord_flip() +
       theme_bw
     
     lda_topic@gamma
     #zadanie
     sciezka <- paste0(getwd(), "/wszystkie")
     rec_zrodlo <- DirSource(sciezka)
     rec_korpus <- VCorpus(rec_zrodlo)
     rec_korpus <- tm_map(rec_korpus, content_transformer(tolower))
     rec_korpus <- tm_map(rec_korpus, removeNumbers)
     rec_korpus <- tm_map(rec_korpus, removeWords, c(stopwords("en"), "one", "two", "three", "make", "get", "movie", "movies", "film", "films"))
     rec_korpus <- tm_map(rec_korpus, stemDocument)
     rec_korpus <- tm_map(rec_korpus, removePunctuation)
     rec_korpus <- tm_map(rec_korpus, stripWhitespace)
     
     dtm_topic <-  DocumentTermMatrix(rec_korpus)
     lda_topic <- LDA(dtm_topic, 2, control = list(seed = 1652))
     (tematy <- topics(lda_topic))
     (tematy_term <- terms(lda_topic))
     tematy_term[tematy]
     #tematy1_df <- data.frame(dokument = 1:1000, Tekst = data.frame(text = sapply(rec_korpus, as.character), stringsAsFactors = FALSE), Tematy=tematy_term[tematy])
     (tematy_termy4 <- terms(lda_topic, 8))
     str(tematy_termy4)
     tematy_termy4[1,][tematy]
     tematy_termy4[,1]
     
     tematy_termy4 <- apply(tematy_termy4, 2, paste, collapse = "/ ")
     #tematy4_df <- data.frame(dokument = 1:8, Tekst = tekst_topic, Tematy=tematy_termy4[tematy])
     (tematy_termy4 <- terms(lda_topic, 8))
     
     beta_topic <- lda_topic@beta
     colnames(beta_topic) <- lda_topic@terms
     head(beta_topic)
     
     beta_t1 <- sort(beta_topic[1,], decreasing = T)
     beta_t2 <- sort(beta_topic[2,], decreasing = T)
     
     tabela_topic <- data.frame(Topic = rep(c(1,2), each = 50),
                                Term = c(names(beta_t1)[1:1000],names(beta_t2)[1:1000]),
                                beta=c(beta_t1[1:1000], beta_t2[1:1000]))
     
     ggplot(tabela_topic, aes(Term, beta, fill = factor(Topic))) + 
       geom_bar(stat = "identity", show.legend = FALSE) +
       facet_wrap(~ Topic) +
       coord_flip() +
       theme_bw()
     
     lda_topic@gamma