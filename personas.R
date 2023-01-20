source("./dependencies.R")

grabData("personas", ".dta", 1, 12)
allDataFrames <- names(which(unlist(eapply(.GlobalEnv,is.data.frame))))
onlyPersonas <- allDataFrames[grep("^personas", allDataFrames)]

#Data Cleaning
for(i in onlyPersonas){
    assign(paste(i, sep=""), simplifierPers(get(i))); 
}
personas <- standardizeTitlesPers()
rownames(personas) <- c(1:nrow(personas))

# Validations
personas[is.na(personas)] <- 0
personas[personas == Inf] <- 0


mergeCriteria <- c("DIRECTORIO", "SECUENCIA_P", "ORDEN", "DPTO")
data <- inner_join(wages, personas, by = mergeCriteria)

# Export

write_xlsx(data, paste("./output/personas",theYear,".xlsx", sep = ""))
