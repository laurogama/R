

#Definir o diretório onde estão os arquivos e serão gravados outros
setwd("~/repos/R/biblioanalysis")
getwd()
#Carregar o app Bibliometrix para o ambiente R
library(bibliometrix)
#Importar os arquivos da busca para o ambiente R e convertê-los em dataframe
S = convert2df("scopus.bib", dbsource = "scopus", format = "bibtex")
View(S)
W = convert2df("savedrecs.bib", dbsource = "isi", format = "bibtex")
View(W)
#Fazer a união das duas tabelas com os dados das buscas nas base de dados
Database = mergeDbSources(S, W, remove.duplicated = TRUE)

View(Database)
dim(Database)
#Gravar a tabela resultante em um arquivo formato Excel para a limpeza final dos dados
library(openxlsx)
write.xlsx(Database, file = "Database.xlsx")
results <- biblioAnalysis(Database)
summary(results, k = 10, pause = FALSE)
writeLines(suma)
#biblioshiny()

#creates different bibliographic networks from a bibliographic data frame.
NetMatrix <- biblioNetwork(Database,
                           analysis = "co-occurrences",
                           network = "keywords",
                           sep = ";")
#plots a bibliographic network.
net <-
  networkPlot(
    NetMatrix,
    n = 30,
    type = "auto",
    Title = "Co-occurrence Network",
    labelsize = 1
  )
#executa o VOSviewer
net2VOSviewer(net, vos.path = "~/Downloads/VOSviewer_1.6.15_jar")