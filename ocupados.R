source("./dependencies.R")

grabData("ocupados", ".dta", 1, 12)
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

# Export

write_xlsx(ocupados, paste("./output/ocupados",theYear,".xlsx", sep = ""))




### PUEDE SER UTIL MAS ADELANTE


## En caso tal el fexp sea caracter y no se pueda hacer coerce
# df$FEX_C_2011 <- gsub("\\d\\.\\d\\d\\d\\.\\d\\d\\d\\.\\d\\d\\d$?", "", df$FEX_DPTO_C)

##Plots

# ocupados9010 <- ocupados %>% filter(maxWage >= limitanei(.1) & maxWage <= limitanei(.9))
# densityPlot(ocupados, ocupados$maxWage, limitanei(.1), limitanei(.9))
# theMedian <- summary(ocupados9010$maxWage)[3]
# theMean <- summary(ocupados9010$maxWage)[4]
# shareBelow <- length(which(ocupados9010$maxWage < minWage/1000))
# shareMiddle <- length(which(ocupados9010$maxWage >= minWage/1000 & ocupados9010$maxWage <= 2*(minWage/1000)))
# shareUpper <- length(which(ocupados9010$maxWage > 2*(minWage/1000) & ocupados9010$maxWage <= 3*(minWage/1000)))
# shareRich <- length(which(ocupados9010$maxWage > 3*(minWage/1000)))
# response <- paste("El salario minimo es",minWage, ", la media es", theMean, ", la mediana es", theMedian,", hay",shareBelow,"personas con un salario inferior al minimo,",
#     shareMiddle,"personas con uno entre 1 y 2 salarios minimos, ",
#     shareUpper ,"personas entre 2 y 3 SM, y",
#     shareRich,"personas con mas de 3 SM", sep = " "
# )

