## Library
library(dplyr)
source("./functions/cleanBoletimUrna.R")
## define paths
### globals 
g <- list()
g$inputDataPath <- "/home/avila/data"
g$listOfFiles <- list.files(g$inputDataPath)
g$dataCleanPath <- "./dataClean"
g$tmp <- g$listOfFiles[1]
g$keep <- c("CD_ELEICAO",
            "NM_VOTAVEL",
            "NR_PARTIDO",
            "NR_VOTAVEL",
            "CD_MUNICIPIO",
            "NM_MUNICIPIO",
            "QT_VOTOS")

listOfFiles <- list.files(g$inputDataPath)

for (file in listOfFiles) {
  cat(paste("reading:", file))
  
  # check if already done
  ufCode <- substr(file, 9,10)
  if (any(grepl(ufCode, list.files(g$dataCleanPath)))) {
    cat("  already there!\n")
    next
    }
  filepath <- file.path(g$inputDataPath, file)
  tmpDataFrame <- cleanBoletimUrna(filePath = filepath, keepVars = g$keep)
  dataName <- paste("df", ufCode, sep = "_")
  assign(dataName, tmpDataFrame)
  cat(" DONE!\n")
}


listOfVar <- ls()[grepl("df_", ls())]
for (var in listOfVar) {
  cat("writing: ", var)
  # define vars
  filepath <- file.path(g$dataCleanPath, var)
  
  # check if already done
  if (any(grepl(var, list.files(g$dataCleanPath)))) {
    cat("  already there!\n")
    next
  }
  
  # write csv
  write.csv2(x = eval(as.symbol(var)),file = filepath)
  cat(" DONE!\n")
}
write.csv2(x = df_AC, file = file.path(g$dataCleanPath, "df_AC.csv"))


