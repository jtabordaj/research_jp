source("./dependencies.R")

grabData("desocupados", fileExtension, 1, 12)
allDataFrames <- names(which(unlist(eapply(.GlobalEnv,is.data.frame))))
onlyDesocup <- allDataFrames[grep("^desocup", allDataFrames)]

# Data Cleaning
for(i in onlyDesocup){
    assign(paste(i, sep=""), simplifierDesocup(get(i))); 
}
desocupados <- standardizeTitlesDesocup()
rownames(desocupados) <- c(1:nrow(desocupados))

# Validations
desocupados[is.na(desocupados)] <- 0
desocupados[desocupados == Inf] <- 0

# Editing Data

# Necesito dsi en modulo desocupados o una variable que de desempleo

# Export
desocupadosWrite <- c("DIRECTORIO", 
    "SECUENCIA_P", 
    "dsi", "DSI", "Dsi"
)

writeDesocupados <- desocupados
writeDesocupados <- writeDesocupados %>% select(any_of(desocupadosWrite))
write_xlsx(writeDesocupados, paste("./output/desocupados",theYear,".xlsx", sep = ""))
paste("Wrote ",substitute(desocupados)," at ./output/desocupados",theYear,".xslx", sep = "")

