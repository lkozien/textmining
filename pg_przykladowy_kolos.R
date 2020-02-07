# 1 ---------------------------------------------------------------
hrabia_korpus_nieoczyszczony_oryginal <- f_wczytaj_dane_do_korpusu_z_wielku_plikow("hrabia") #"C:/Users/gryff/Documents/R/hrabia"
inspect(hrabia_korpus_nieoczyszczony_oryginal)
hrabia_korpus_nieoczyszczony_oryginal[[117]]$content

hrabia_korpus_z_ulozonymi_datasetami <- f_przeksztalc_wektory_datasetu_korpusu_do_pojedynczych_wektorow(hrabia_korpus_nieoczyszczony_oryginal, 117)
hrabia_korpus_z_ulozonymi_datasetami[[117]]$content

hrabia_korpus_oczyszczony <- f_czysc_korpus(hrabia_korpus_z_ulozonymi_datasetami)
hrabia_korpus_oczyszczony[[117]]$content






# 2 --------------------------------------------------------------
hrabia_macierz_term_dokument_oczyszczona <- TermDocumentMatrix(hrabia_korpus_oczyszczony, list(weighting = function(x) weightSMART(x, spec = "lnn")))
hrabia_termy_najczestsze <- f_usun_rzadke_termy(hrabia_macierz_term_dokument_oczyszczona, 0.95)
hrabia_termy_najczestsze

hrabia_macierz_dokument_term <- as.DocumentTermMatrix(hrabia_termy_najczestsze)

odleglosci <- f_oblicz_odleglosci_miedzy_dokumentami(hrabia_macierz_dokument_term)

hg <- hclust(odleglosci, method = "ward.D")
hg_ladne <- as.dendrogram(hg)
hg_ladne <- color_labels(hg_ladne,3, col = c("royalblue", "orangered", "seagreen"))
hg_ladne <- color_branches(hg_ladne,3, col = c("royalblue", "orangered", "seagreen"))
plot(hg_ladne, main = paste("Dendogram na podstawie miary:\n", "euclidean"))
rect.dendrogram(hg_ladne, k = 3, border = "grey20", lty = 2)







# 3 A -> 100 i 101 ---------------------------------------------------------------------
hrabia_korpus_oczyszczony[[3]]$content
hrabia_korpus_oczyszczony[[4]]$content

slowa_100 <- unlist(strsplit(hrabia_korpus_oczyszczony[[3]]$content, " "))
slowa_101 <- unlist(strsplit(hrabia_korpus_oczyszczony[[4]]$content, " "))

slowa_wspolne_100_101 <- intersect(slowa_100, slowa_101)

slowa_wspolne_100_101

slowa_wspolne_zrodlo_100_101 <- VectorSource(slowa_wspolne_100_101)
slowa_wspolne_korpus_100_101 <- VCorpus(slowa_wspolne_zrodlo_100_101)

slowa_wspolne_steem_100_101 <- f_steeming_korpusu(slowa_wspolne_korpus_100_101)

slowa_wspolne_macierz_100_101 <- as.matrix(slowa_wspolne_steem_100_101)
slowa_wspolne_term_100_101 <- rowSums(slowa_wspolne_macierz_100_101)
slowa_wspolne_term_100_101 <- sort(slowa_wspolne_term_100_101, decreasing = TRUE)

wordcloud(names(slowa_wspolne_term_100_101), slowa_wspolne_term_100_101, max.words = 50, colors = "steelblue4")
# 3 B -> 25 i 73 ---------------------------------------------------------------------
hrabia_korpus_oczyszczony[["rozdz25.txt"]]$content
hrabia_korpus_oczyszczony[["rozdz73.txt"]]$content

slowa_25 <- unlist(strsplit(hrabia_korpus_oczyszczony[["rozdz25.txt"]]$content, " "))
slowa_73 <- unlist(strsplit(hrabia_korpus_oczyszczony[["rozdz73.txt"]]$content, " "))

slowa_wspolne_25_73 <- intersect(slowa_25, slowa_73)

slowa_wspolne_25_73

slowa_wspolne_zrodlo_25_73 <- VectorSource(slowa_wspolne_25_73)
slowa_wspolne_korpus_25_73 <- VCorpus(slowa_wspolne_zrodlo_25_73)

slowa_wspolne_steem_25_73 <- f_steeming_korpusu(slowa_wspolne_korpus_25_73)

slowa_wspolne_macierz_25_73 <- as.matrix(slowa_wspolne_steem_25_73)
slowa_wspolne_term_25_73 <- rowSums(slowa_wspolne_macierz_25_73)
slowa_wspolne_term_25_73 <- sort(slowa_wspolne_term_25_73, decreasing = TRUE)

wordcloud(names(slowa_wspolne_term_25_73), slowa_wspolne_term_25_73, max.words = 50, colors = "steelblue4")






# 3 A -> 100 i 101 ---------------------------------------------------------------------

slowa_100 <- unlist(strsplit(hrabia_korpus_oczyszczony[[3]]$content, " "))
slowa_101 <- unlist(strsplit(hrabia_korpus_oczyszczony[[4]]$content, " "))

slowa_vector_100_101 <- c(slowa_100, slowa_101)
wyodrebnione_zdania_100_101 <- f_wyodrebnij_zdania(slowa_vector_100_101)
slowa_100_101_results <- f_analiza_sentymentu(slowa_vector_100_101)
f_rysuj_wykres_analizy_sentymentu(slowa_100_101_results)




# 3 A -> 25 i 73 ---------------------------------------------------------------------

slowa_25 <- unlist(strsplit(hrabia_korpus_oczyszczony[["rozdz25.txt"]]$content, " "))
slowa_73 <- unlist(strsplit(hrabia_korpus_oczyszczony[["rozdz73.txt"]]$content, " "))

slowa_vector_25_73 <- c(slowa_25, slowa_73)
wyodrebnione_zdania_25_73 <- f_wyodrebnij_zdania(slowa_vector_25_73)
slowa_25_73_results <- f_analiza_sentymentu(slowa_vector_25_73)
f_rysuj_wykres_analizy_sentymentu(slowa_25_73_results)