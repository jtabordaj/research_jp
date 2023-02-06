source("./dependencies.R")

grabData("personas", fileExtension, 1, 12)
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

# Editing data

personas <- personas %>% mutate(segmentoEdad = ifelse(P6040 <= 30, 1,
    ifelse(P6040 > 30 & P6040 <= 40, 2, 
    ifelse(P6040 > 40 & P6040 <= 50, 3,
    ifelse(P6040 > 50 & P6040 <= 60, 4,
    ifelse(P6040 > 60, 5, 0)
    ))))
)
personas <- personas %>% mutate(tienePareja = ifelse(P6070 == 1 | P6070 == 2 | P6070 == 3, 1, 0)) # 1 Si
personas <- personas %>% mutate(esFamiliaHogar = ifelse(P6050 <= 5, 1, 0)) # 1 Tiene vinculo familiar con el jefe del hogar 
personas <- personas %>% mutate(segmentoEducativo = ifelse(P6210 == 0 | 
    P6210 == 1 | 
    P6210 == 2 |
    P6210 == 3, 1,
    ifelse(P6210 == 4 | P6210 == 5, 2,
    ifelse(P6210 == 6, 3, 1)) 
))
personas <- personas %>% mutate(afiliadoSalud = ifelse(P6090 == 1, 0, 1)) # 0 Si esta afiliado

# Export
personasWrite <- c("DIRECTORIO", 
    "SECUENCIA_P", 
    "ORDEN", 
    "segmentoEdad",
    "tienePareja",
    "segmentoEducativo",
    "afiliadoSalud",
    "esFamiliaHogar"
)

writePersonas <- personas
writePersonas <- writePersonas %>% select(all_of(personasWrite))
write_xlsx(writePersonas, paste("./output/personas",theYear,".xlsx", sep = ""))
paste("Wrote ",substitute(personas)," at ./output/personas",theYear,".xslx", sep = "")
