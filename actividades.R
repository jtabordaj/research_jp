source("./dependencies.R")

grabData("actividades", ".dta", 1, 12)
allDataFrames <- names(which(unlist(eapply(.GlobalEnv,is.data.frame))))
onlyActividades <- allDataFrames[grep("^actividades", allDataFrames)]

# Data Cleaning
for(i in onlyActividades){
    assign(paste(i, sep=""), simplifierActividades(get(i))); 
}
actividades <- standardizeTitlesAct()
rownames(actividades) <- c(1:nrow(actividades))

# Validations
actividades[is.na(actividades)] <- 0
actividades[actividades == Inf] <- 0

# Editing Data

actividades <- actividades %>% filter(P7480S3A1 != 98 & P7480S3A1 != 99) # Si responde 98 o 99 en transferencia no sirve pues no sabe
actividades <- actividades %>% mutate(horasHogar = P7480S3A1)

# Export
actividadesWrite <- c("DIRECTORIO", 
    "SECUENCIA_P", 
    "ORDEN", 
    "horasHogar"
)

writeActividades <- ocupados
writeActividades <- writeActividades %>% select(all_of(actividadesWrite))
write_xlsx(writeActividades, paste("./output/actividades",theYear,".xlsx", sep = ""))