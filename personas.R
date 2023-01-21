source("./dependencies.R")

grabData("personas", ".dta", 1, 12)
allDataFrames <- names(which(unlist(eapply(.GlobalEnv,is.data.frame))))
onlyPersonas <- allDataFrames[grep("^personas", allDataFrames)]

#Data Cleaning
for(i in onlyPersonas){
    assign(paste(i, sep=""), simplifierPersonas(get(i))); 
}
personas <- standardizeTitlesPers()
rownames(personas) <- c(1:nrow(personas))

# Validations
personas[is.na(personas)] <- 0
personas[personas == Inf] <- 0


# Export

write_xlsx(personas, paste("./output/personas",theYear,".xlsx", sep = ""))
