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

# 3 ---------------------------------------------------------------------
hrabia_korpus_oczyszczony[[3]]$content
hrabia_korpus_oczyszczony[[4]]$content

slowa_100 <- unlist(strsplit(hrabia_korpus_oczyszczony[[3]]$content, " "))
slowa_101 <- unlist(strsplit(hrabia_korpus_oczyszczony[[4]]$content, " "))

slowa_wspolne <- intersect(slowa_100, slowa_101)

slowa_wspolne

slowa_wspolne_zrodlo <- VectorSource(slowa_wspolne)
slowa_wspolne_korpus <- VCorpus(slowa_wspolne_zrodlo)

slowa_wspolne_macierz_term_document <- f_steeming_korpusu(slowa_wspolne_korpus)

slowa_wspolne_macierz_term_document <- TermDocumentMatrix(slowa_wspolne_korpus)
slowa_wspolne_macierz <- as.matrix(slowa_wspolne_macierz_term_document)
slowa_wspolne_term <- rowSums(slowa_wspolne_macierz)
slowa_wspolne_term <- sort(slowa_wspolne_term, decreasing = TRUE)

wordcloud(names(slowa_wspolne_term), slowa_wspolne_term, max.words = 50, colors = "steelblue4")
#----------------------------------------------------------------------------------------------------------------
