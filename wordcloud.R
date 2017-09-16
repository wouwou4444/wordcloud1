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
