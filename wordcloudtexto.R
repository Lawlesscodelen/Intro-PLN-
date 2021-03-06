#Codigos de varias ramas del derecho: https://www.boe.es/biblioteca_juridica/index.php?tipo=C


#########Wordcloud##################
#####Instalamos y cargamos las libreriass que nos hacen falta
install.packages("tm")
install.packages("wordcloud")
install.packages("pdftools")
install.packages("dplyr")
install.packages("wordcloud2")
library(tm)
library(wordcloud)
library(pdftools)
library(dplyr)
library(wordcloud2)


#Cargamos el documento donde vamos a hacer el wordcloud, para ello pon la ruta, por ejemplo:
dt = pdf_text("C:/Users/elen/Documents/peru.pdf", opw = "" , upw = "")

#Pasamos el texto entero a Corpus para que sea legible.
docs <- Corpus(VectorSource(dt))


#Empezamos a limpiar: quitamos numeros, puntuaciones y espaciados extras
docs <- docs %>%
  tm_map(removeNumbers) %>%
  tm_map(removePunctuation) %>%
  tm_map(stripWhitespace)

# Convertimos el texto todo a miniscula
docs <- tm_map(docs, content_transformer(tolower))


# Quitamos palabras frecuentes del lenguaje 
docs <- tm_map(docs, removeWords, stopwords("spanish"))



#Convertimos el texto en una matriz con la frecuencia de las palabras
dtm <- TermDocumentMatrix(docs)
m <- as.matrix(dtm)
r <- sort(rowSums(m),decreasing=TRUE)
f <- data.frame(word = names(r),freq=r)

#Vemos las 10 primeras palabras 
head(f, 10)

#Generamos el wordcloud o la nube de palabras
wordcloud2(f, size=1.6, color='random-light', backgroundColor="black")


#Vemos la frecuencia de palabras 
findFreqTerms(dtm, lowfreq = 0)