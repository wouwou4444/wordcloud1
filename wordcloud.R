#cloudword

#Lire un fichier caractère par caractère, et séparer le contenu ligne par ligne.
text.vector_char <- scan("http://edutechwiki.unige.ch/fmediawiki/api.php?action=parse&page=Civilization&format=xml",
                         what="character", sep="\n")
#Vérification
text.vector_char
help(scan)

text <- 'ceci est une phrase'
text
scan(text, sep="\n")

Texte1 <- "Bonjour!" 
nchar(Texte1, type = "chars")
Texte2 <- c("Bonjour", "à", "vous", "tous", "!")
nchar(Texte2, type = "chars")

####################
###### Step 2 : install and load packages
####################

# Installer
install.packages("tm")  # pour le text mining
install.packages("SnowballC") # pour le text stemming
install.packages("wordcloud") # générateur de word-cloud 
install.packages("RColorBrewer") # Palettes de couleurs
# Charger
library("tm")
library("SnowballC")
library("wordcloud")
library("RColorBrewer")

#####
# Lire le fichier texte
filePath <- "http://www.sthda.com/sthda/RDoc/example-files/martin-luther-king-i-have-a-dream-speech.txt"
text <- readLines(filePath)
# Charger les données comme un corpus
docs <- Corpus(VectorSource(text))
str(docs)
inspect(docs)

####################
###### Step 3
####################

### Load file
SN <- read.csv(file = "d:\\valbuz\\wordcloud\\liste_de_tickets_summary.csv")
SN
docs <- Corpus(VectorSource(SN$Summary))
inspect(docs)

# Transformation and normalisation of spaces
toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
docs <- tm_map(docs, toSpace, "/")
docs <- tm_map(docs, toSpace, "@")
docs <- tm_map(docs, toSpace, "\\'")

##### Stemming 
# Convertir le texte en minuscule
docs <- tm_map(docs, content_transformer(tolower))
# Supprimer les nombres
docs <- tm_map(docs, removeNumbers)
# Supprimer les mots vides anglais
docs <- tm_map(docs, removeWords, stopwords("english"))
# Supprimer votre propre liste de mots non désirés
docs <- tm_map(docs, removeWords, c("blabla1", "blabla2")) 
# Supprimer les ponctuations
docs <- tm_map(docs, removePunctuation)
# Supprimer les espaces vides supplémentaires
docs <- tm_map(docs, stripWhitespace)
# Text stemming
# docs <- tm_map(docs, stemDocument)
docs <- tm_map(docs, removeWords, c("un", "une")) 


########################
######### Step 4 
########################

dtm <- TermDocumentMatrix(docs)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
d
head(d, 10)


########################
######### Step 5 
########################
set.seed(1234)
wordcloud(words = d$word, freq = d$freq, min.freq = 1,
          max.words=200, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))
