install.packages(c("sentimentr", "dplyr", "ggplot2", "tidyr", "readr"))
install.packages("zeallot")
install.packages("backports")

library("sentimentr")
library("dplyr")
library("ggplot2")
library("tidyr")
library("readr")
library("lexicon")

tekst <- c("Bought it as a random gift for my daughter and she loves it!!!!!",
           "I bought this for my daughter and family. Everybody loves Alexa!",
           "Pretty disappointing. It's pretty worthless.",
           "Disappointing and frustrating ? I'm returning Echo")

get_sentences(tekst)

# ponizsza czasem moze dawac nam bledy, trzeba sprawdzac pozytywne i negatywne
# zmiana slownika
extract_sentiment_terms(tekst, polarity_dt = lexicon::hash_sentiment_huliu)

# obejrzenie slownika
head(lexicon::hash_sentiment_huliu)

# nim dokonuje sie analizy trzeba sprawdzic czy ma sie odpowiedni slownik, bo w zaleznosci od slownika wyniki moga byc inne

extract_sentiment_terms(tekst) %>% unnest(negative)

# ktora wypowiedz jes bardziej negatywne/pozytywna
extract_sentiment_terms(tekst) %>% unnest(positive)

# wyliczenie ladunku emocjonalnego dla kazdego slowa
wynik <- sentiment(tekst, polarity_dt = lexicon::hash_sentiment_huliu)

plot(wynik)


# zbiorcze wyliczenie ladunku emocjonalnego dla calej wypowiedzi
(wynik_by <- sentiment_by(tekst, polarity_dt = lexicon::hash_sentiment_huliu))

plot(wynik_by)

# pokazuje jako html, ktore zdania sa pozytywne, ktore negatywne
tekst %>%
  tibble() %>% 
  mutate(review = get_sentences(tekst)) %$%
  sentiment_by(review) %>%
  highlight()

# wykres czarno-bialy dla calych zdan czy sa negatywne czy pozytywne
ggplot(wynik_by, aes(element_id, ave_sentiment)) +
  geom_bar(stat = "identity") +
  labs(title = "Analiza nastrojów opinii", x = "Opinie", y = "Ocena sentymentu") +
  theme_classic()


# wykres kolorowy dla calych zdan czy sa negatywne czy pozytywne
wynik_by %>%
  mutate(kolor = ifelse(ave_sentiment == 0,
                        "Neutralna",
                        ifelse(ave_sentiment < 0, "Negatywna", "Pozytywna"))) %>%
  ggplot(aes(element_id, ave_sentiment, fill = kolor, color = kolor)) +
  geom_bar(stat = "identity") +
  labs(title = "Analiza nastrojów opinii", x = "Opinie", y = "Ocena sentymentu") +
  theme_classic()




hash_sentiment_huliu[hash_sentiment_huliu$x == "pretty",]
# Plot -> Lexicon -> Valence Shifters - tutaj pokazuje, ktory numerek warto przypisac np nowo dodawanemu slowu

# tworzenie tabeli, w ktorej definiuje slowo i jego wartosc
nowe_slowo <- tibble(x = "pretty", y = 3)

# usuniecie ze slownika slowa pretty
hash_sentiment_huliu_moja <- update_key(hash_sentiment_huliu, drop = "pretty")

# dodaje wczesniej utworzona tabele do slownika
hash_valence_shifters_moja <- update_key(hash_valence_shifters,
                                         x = nowe_slowo)

# n.before ile slow rozdzielac moze slowo modyfikowane od oryginalu? Jesli ave_sentiment jest na - to negatywna, jesli na + to pozytywna
(wynik_by_pretty <- sentiment_by(tekst,
                                 polarity_dt = hash_sentiment_huliu_moja,
                                 valence_shifters_dt = hash_valence_shifters_moja,
                                 n.before = 5))

wynik_by_pretty %>%
  mutate(kolor = ifelse(ave_sentiment == 0, "Neutralna", ifelse(ave_sentiment < 0, "Negatywna", "Pozytywna"))) %>%
  ggplot(aes(element_id, ave_sentiment, fill = kolor, color = kolor)) +
  geom_bar(stat = "identity") +
  scale_fill_manual(values = moje_kolory) +
  scale_color_manual(values = moje_kolory) +
  labs(x = "Opinie", y = "Ocena sentymentu") +
  theme_minimal()
