source("./dependencies.R")

grabData("ingresos", ".csv2", 1, 12)
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
ingresos <- ingresos %>% mutate(ingresosTransferencias = P7510S3A1 + P7510S1A1 + P7510S2A1)
ingresos <- ingresos %>% mutate(ingresosOtros = P7500S1A1 + P7500S2A1 + P7500S3A1 + P7510S5A1 + P7510S6A1 + P7510S7A1)
ingresos <- ingresos %>% mutate(maxTransf = ((pmax(ingresosTransferencias, ingresosOtros))))
ingresos <- ingresos %>% filter(maxTransf != 98 & maxTransf != 99) # Si responde 98 o 99 en transferencia no sirve pues no sabe
# Export

ingresosWrite <- c("DIRECTORIO", 
    "SECUENCIA_P", 
    "ORDEN",
    "ingresosTransferencias",
    "ingresosOtros",
    "maxTransf"
)

writeIngresos <- ingresos
writeIngresos <- writeIngresos %>% select(all_of(ingresosWrite))
write_xlsx(writeIngresos, paste("./output/ingresos",theYear,".xlsx", sep = ""))
paste("Wrote ",substitute(ingresos)," at ./output/ingresos",theYear,".xslx", sep = "")