cleanBoletimUrna <- function(filePath, keepVars) {
  tmpDataFrame <- read.csv2(file = filePath,
                            encoding = "latin1",
                            stringsAsFactors = FALSE)
  
  tmpDataFrame <- tmpDataFrame[keepVars]
  
  tmpDataFrame <- tmpDataFrame %>% 
    filter(CD_ELEICAO == 295) %>% 
    group_by(CD_MUNICIPIO, NM_MUNICIPIO, NR_VOTAVEL, NM_VOTAVEL) %>% 
    summarise(votos = sum(QT_VOTOS))
  
  return(tmpDataFrame)
}

