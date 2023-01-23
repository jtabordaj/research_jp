source("./dependencies.R")

grabData("ocupados", ".csv2", 1, 12)
allDataFrames <- names(which(unlist(eapply(.GlobalEnv, is.data.frame))))

# Data cleaning
for(i in allDataFrames){
    assign(paste(i, sep=""), simplifierOcupados(get(i))); 
}
ocupados <- standardizeTitlesOcup()
rownames(ocupados) <- c(1:nrow(ocupados))

# Validations
ocupados[is.na(ocupados)] <- 0
ocupados[ocupados == Inf] <- 0

# Editing data
ocupados$FEX_C_2011 <- gsub("\\d\\.\\d\\d\\d\\.\\d\\d\\d\\.\\d\\d\\d$?", "", ocupados$FEX_C_2011)
ocupados$FEX_C_2011 <- as.numeric(ocupados$FEX_C_2011)

if(theYear != 2020){
ocupados <-  ocupados %>%
    mutate(maxWage = ((pmax(P6500, P6750, P550, P7070))))
} else {
    ocupados <- ocupados %>%
   mutate(maxWage = ((pmax(P6500, P6750))))
}

ocupados <- ocupados %>% filter(maxWage > 0)
ocupados <- ocupados %>% filter(maxWage != 98 & maxWage != 99) # Si responde 98 o 99 en salario no sirve pues no sabe
ocupados <- ocupados %>% mutate(conformeContrato = ifelse(P6422 == 1, 1, 0)) # 1 Si
ocupados <- ocupados %>% mutate(quiereCambiar = ifelse(P7130 == 1, 1, 0)) # 1 Si
ocupados <- ocupados %>% mutate(conformeTrabajo = ifelse(P7170S1 == 1, 1, 0)) # 1 Si
ocupados <- ocupados %>% mutate(ingresosTrabajo = INGLABO) # Mensual
ocupados <- ocupados %>% mutate(horasTrabajo = P6800) # Semanal
ocupados <- ocupados %>% mutate(subempleadoHoras = ifelse(P7090 == 1, 1, 0)) # 1 Si
ocupados <- ocupados %>% mutate(subempleadoIngresos = ifelse(P7140S2 == 1, 1, 0)) # 1 Si
ocupados <- ocupados %>% mutate(posicionOcupacional = ifelse(P6430 == 1 | P6430 == 3 | P6430 == 6 | P6430 == 7 | P6430 == 8, 1,
    ifelse(P6430 == 2, 2,
    ifelse(P6430 == 4, 3, 
    ifelse(P6430 == 5, 4, 
    ifelse(P6430 == 9, 5, 5))))  
))
ocupados <- ocupados %>% mutate(cotizaPension = ifelse(P6920 == 1 | P6920 == 3, 1, 0)) # 1 Si

if(theYear != 2021){
ocupados$RAMA2D <- as.numeric(ocupados$RAMA2D)
ocupados <- ocupados %>% mutate(actividadEconomica = ifelse(RAMA2D >= 01 & RAMA2D <= 05 ,"AtB",
    ifelse(RAMA2D >= 10 & RAMA2D <= 14, "C",
    ifelse(RAMA2D >= 15 & RAMA2D <= 37,"D",
    ifelse(RAMA2D >= 40 & RAMA2D <= 41, "E",
    ifelse(RAMA2D == 45, "F",
    ifelse(RAMA2D >= 50 & RAMA2D <= 55, "GtH",
    ifelse(RAMA2D >= 60 & RAMA2D <= 64, "I",
    ifelse(RAMA2D >= 65 & RAMA2D <= 74, "JtK",
    ifelse(RAMA2D >= 75 & RAMA2D <= 93, "LtQ", "Otro")))))))))
)} else if(theYear == 2021){
ocupados$RAMA2D_R4 <- as.numeric(ocupados$RAMA2D_R4)
ocupados <- ocupados %>% mutate(actividadEconomica = ifelse(RAMA2D_R4 >= 01 & RAMA2D_R4 <= 03, "AtB",
    ifelse(RAMA2D_R4 >= 05 & RAMA2D_R4 <= 09, "C",
    ifelse(RAMA2D_R4 >= 10 & RAMA2D_R4 <= 33, "D",
    ifelse(RAMA2D_R4 >= 35 & RAMA2D_R4 <= 39, "E",
    ifelse(RAMA2D_R4 >= 41 & RAMA2D_R4 <= 43, "F",
    ifelse(RAMA2D_R4 >= 45 & RAMA2D_R4 <= 47 | RAMA2D_R4 >= 55 & RAMA2D_R4 <= 56, "GtH",
    ifelse(RAMA2D_R4 >= 49 & RAMA2D_R4 <= 53 | RAMA2D_R4 >= 58 & RAMA2D_R4 <= 63, "I",
    ifelse(RAMA2D_R4 >= 64 & RAMA2D_R4 <= 82, "JtK",
    ifelse(RAMA2D_R4 >= 84 & RAMA2D_R4 <= 98 & RAMA2D_R4 != 92, "LtQ", "Otro")))))))))
)}

# https://www.colombia.com/colombia-info/departamentos

ocupados$DPTO <- ocupados$DPTO %>% as.numeric()
ocupados <- ocupados %>% mutate(region = ifelse(DPTO == 08 | DPTO == 13 | DPTO == 23 | DPTO == 47 | DPTO == 20 | DPTO == 44 | DPTO == 70, "Caribe",
    ifelse(DPTO == 05 | DPTO == 15 | DPTO == 17 | DPTO == 25 | DPTO == 41 | DPTO == 54 | DPTO == 63 | DPTO == 66 | DPTO == 68 | DPTO == 08 | DPTO == 73 | DPTO == 11, "Central",
    ifelse(DPTO == 19 | DPTO == 27 | DPTO == 52 | DPTO == 76, "Pacifico",
    ifelse(DPTO == 50 | DPTO == 18 | DPTO == 19, "Oriental", NA))))
)


# Export
ocupadosWrite <- c("DIRECTORIO", 
    "SECUENCIA_P", 
    "ORDEN", 
    "conformeContrato", 
    "quiereCambiar", 
    "conformeTrabajo", 
    "ingresosTrabajo", 
    "actividadEconomica", 
    "horasTrabajo", 
    "subempleadoHoras", 
    "subempleadoIngresos",
    "cotizaPension",
    "posicionOcupacional",
    "region"
)

writeOcupados <- ocupados
writeOcupados <- writeOcupados %>% select(all_of(ocupadosWrite))
write_xlsx(writeOcupados, paste("./output/ocupados",theYear,".xlsx", sep = ""))
paste("Wrote ",substitute(ocupados)," at ./output/ocupados",theYear,".xslx", sep = "")


### PUEDE SER UTIL MAS ADELANTE


## En caso tal el fexp sea caracter y no se pueda hacer coerce
# df$FEX_C_2011 <- gsub("\\d\\.\\d\\d\\d\\.\\d\\d\\d\\.\\d\\d\\d$?", "", df$FEX_DPTO_C)

