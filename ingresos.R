source("./dependencies.R")

grabData("ingresos", ".dta", 1, 12)
allDataFrames <- names(which(unlist(eapply(.GlobalEnv,is.data.frame))))
onlyIngresos <- allDataFrames[grep("^ingresos", allDataFrames)]

# Data Cleaning

for(i in onlyIngresos){
    assign(paste(i, sep=""), simplifierIng(get(i))); 
}
ingresos <- standardizeTitlesPers()
rownames(ingresos) <- c(1:nrow(ingresos))