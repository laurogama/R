#Definir o diretório onde estão os arquivos e serão gravados outros
setwd("~/ana/doutorado/jcr2")
getwd()
#Carregar o app Bibliometrix para o ambiente R
library(bibliometrix)
library(readxl)
# Carrega uma planilha excel como Dataframe

excel_data = read_excel("~/Documents/ana/doutorado/jcr2/amostra_final.xlsx")
df = data.frame(excel_data)
View(df)
results <- biblioAnalysis(df)
summary(results, k = 10, pause = FALSE)
CR <- citations(df, field = "article", sep=";")
cbind(CR$Cited[1:10])

AU_CO <- metaTagExtraction(df, Field = "AU_CO", sep = ";")
# Cria uma rede de co-citação por autores
NetMatrix <- biblioNetwork(AU_CO,
                           analysis = "collaboration",
                           network = "countries",
                           sep = ";")
#plots a bibliographic network.
net <-
  networkPlot(
    NetMatrix,
    n = 30,
    type = "auto",
    Title = "Collaboration from Autors Network",
    labelsize = 1
  )
#executa o VOSviewer
net2VOSviewer(net, vos.path = "~/Downloads/VOSviewer_1.6.15_jar")
biblioshiny()
