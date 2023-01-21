source("./dependencies.R")

grabData("ingresos", ".dta", 1, 12)
allDataFrames <- names(which(unlist(eapply(.GlobalEnv,is.data.frame))))
onlyIngresos <- allDataFrames[grep("^ingresos", allDataFrames)]

# Data Cleaning
for(i in onlyIngresos){
    assign(paste(i, sep=""), simplifierIngresos(get(i))); 
}
ingresos <- standardizeTitlesIng()
rownames(ingresos) <- c(1:nrow(ingresos))

# Validations
ingresos[is.na(ingresos)] <- 0
ingresos[ingresos == Inf] <- 0

# Editing data

ingresos <- ingresos %>% mutate(maxTransf = ((pmax(P7500S2A1, P7500S3A1, P7510S1A1, P7510S2A1, P7510S3A1))))
ingresos <- ingresos %>% filter(maxTransf > 0)
ingresos <- ingresos %>% filter(maxTransf != 98 & maxTransf != 99) # Si responde 98 o 99 en transferencia no sirve pues no sabe
