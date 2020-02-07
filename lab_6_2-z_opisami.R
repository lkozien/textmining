install.packages(c("topicmodels", "tm", "ggplot2", "dplyr", "tidyr"))
install.packages("SnowballC")

library("topicmodels")
library("tm")
library("ggplot2")
library("dplyr")
library("tidyr")
library("SnowballC")

tekst_topic <- c("I had a peanut butter sandwich for breakfast.",
                 "I like to eat almonds, peanuts and walnuts.",
                 "My neighbor got a little dog yesterday.",
                 "Cats and dogs are mortal enemies.",
                 "You mustn’t feed peanuts to your dog.")

zrodlo_topic <- VectorSource(tekst_topic)
korpus_topic <- VCorpus(zrodlo_topic)

# w tym wypadku wagi powinny byc liczebnosciowe, nic nie zmieniac
dtm_topic <-  DocumentTermMatrix(korpus_topic,
                                 control = list(stemming = TRUE,
                                                stopwords = TRUE,
                                                removeNumbers = TRUE,
                                                removePunctuation = TRUE))
as.matrix(dtm_topic)

dim(dtm_topic)

# funckja LDA uruchamia funkcje, ktora znajduje tematy. 2 oznacza ile tematow chcemy odnalezc. Beta, Gamma to rozklady prawdopodobienstwa czym charakteryzuja sie poszczegolne tematu
lda_topic <- LDA(dtm_topic, 2, control = list(seed = 1652))

# ktory temat zostal zdefiniowany dla ktorego dokumentu
(tematy <- topics(lda_topic))

# ktory numer to ktory temat
(tematy_term <- terms(lda_topic))

# wyswietl mi 4 najistotniejsze slowa dla danego tematu
(tematy_termy4 <- terms(lda_topic, 4))

# @beta to wartosci czestotliwosci wystepowania danego slowa, ale ma wartosci ujemne. Im mniejsza liczba, tym czesciej wystepuje
lda_topic@beta # exp() lub abs()

# dzieki uzyciu exp, zostaje zastosowana funkcja wykladnicza  zostaja usuniete minusy, male roznice zwiekszamy (przy logarytmicznym duze roznice zmniejszamy)
beta_df <- data_frame(term = lda_topic@terms, w¹tek1 = exp(lda_topic@beta[1, ]), w¹tek2 = exp(lda_topic@beta[2, ]))

x <- -10:1
y <- exp(x)
plot(x, y)


beta_tidy <- gather(beta_df, w¹tek, beta, -term)

beta_top <- beta_tidy %>% 
  group_by(w¹tek) %>% 
  top_n(5, beta) %>% 
  ungroup() %>% 
  arrange(w¹tek, -beta)