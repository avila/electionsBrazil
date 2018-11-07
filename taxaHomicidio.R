library(readr)
library(dplyr)
library(tidyr)

############ 
# AQUI
g <- list()
g$cid101 <- paste0("X", 85:99)
g$cid102 <- c("Y00", paste0("Y0", 1:9))
g$cid103 <- c("Y35", "Y36")
g$cid <- c(g$cid101, g$cid102, g$cid103)
datavio <- datasus::sim_obt10_mun(linha = "Município",
                                  #conteudo = "AC",
                                  coluna = "Ano do Óbito",
                                  periodo = 2016,
                                  categoria_cid10 = g$cid)

head(datavio)
datavio[grepl("o Paulo", datavio$Município),]



datavio <- datavio %>%
  separate(col = Município, into = c("id", "Municipio"), extra = "merge")
head(datavio)
datavio[grepl("São Paulo", datavio$Municipio),]




# write.csv2(x = datavio,
# file = file.path(g$dataCleanPath, "datavio.csv"))
##################
# Pattern = paste(lst_A, collapse="|")
# grepl(Pattern, lst_B)
# DT_result <- data.table(lst_B, result=grepl(Pattern, lst_B))
# df_AC$NM_MUNICIPIO 
# length(unique(df_AC$NM_MUNICIPIO))
# sum(DT_result$result)

tmp <- read.csv("dataClean/datasusViolencia.csv",
                stringsAsFactors = FALSE,
                na.strings = "-")
######################

## Population 

dataPop <- read_csv("dataInput/estimativa_dou_2016_20160913.csv",
                    col_types = cols(`POPULAÇÃO ESTIMADA` = col_double()))

dim(dataPop)
dim(datavio)


