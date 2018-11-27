## Library
library("dplyr")
source("./functions/cleanBoletimUrna.R")
## define paths
### globals 
g <- list()
g$inputDataPath <- "/data/electionBrazil/bweb_estado/"
g$dataCleanPath <- "/data/electionBrazil/bweb_estado_clean"
g$listOfFiles <- list.files(g$inputDataPath)
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
  
  ## Write to file
  filepathWrite <- file.path(g$dataCleanPath)
  write.csv2(x = tmpDataFrame,
             file = paste(filepathWrite, paste0("clean_", ufCode, ".csv"), sep = "/"))
  
  cat(" DONE!\n")
}



df <- cleanBoletimUrna(filePath = paste0("/data/electionBrazil/bweb_estado/, 
                                         bweb_1t_SP_101020182030.csv"),
                       keepVars = g$keep)


filePathSP <- file.path("/data/electionBrazil/bweb_estado/",
                        "bweb_1t_SP_101020182030.csv")


tmpDataFrame <- data.table::fread(file = filePathSP,
                                  encoding = "Latin-1",
                                  stringsAsFactors = FALSE)
vec1 <- tmpDataFrame[CD_ELEICAO]

