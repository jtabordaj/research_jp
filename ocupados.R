source("./dependencies.R")
theYear <- 2015
grabData(".csv2", 1, 12, "ocupados")


allDataFrames <- names(which(unlist(eapply(.GlobalEnv,is.data.frame))))

for(i in allDataFrames){
    assign(paste(i, sep=""), simplifier(get(i))); 
}

wages <- getNationalWages()

wages$FEX_C_2011 <- gsub("\\d\\.\\d\\d\\d\\.\\d\\d\\d\\.\\d\\d\\d$?", "", wages$FEX_C_2011)
wages$FEX_C_2011 <- as.numeric(wages$FEX_C_2011)

wages$RAMA4D <- as.numeric(wages$RAMA4D)

rownames(wages) <- c(1:nrow(wages)) # nolint # nolint
wages[is.na(wages)] <- 0
wages[wages == Inf] <- 0

if(theYear >= 2007 && theYear <= 2008){
wages <- wages %>% 
    mutate(INGLABO = P6500 + P6750 + P550 + P7070)
}

if(theYear != 2020){
wages <-  wages %>%
    mutate(maxWage = ((pmax(P6500, P6750, P550, P7070))/1000))
} else {
    wages <- wages %>%
   mutate(maxWage = ((pmax(P6500, P6750))/1000))
}

write_xlsx(wages, paste("./wages",theYear,".xlsx", sep = ""))

wages <- wages %>% filter(maxWage > 0)

fexp <- getFexp()
fexp$FEX_C_2011 <- gsub("\\d\\.\\d\\d\\d\\.\\d\\d\\d\\.\\d\\d\\d$?", "", fexp$FEX_DPTO_C)

mergeCriteria <- c("DIRECTORIO", "SECUENCIA_P", "ORDEN")

wages <- inner_join(wages, fexp, by = mergeCriteria)


### PUEDE SER UTIL MAS ADELANTE
# wages9010 <- wages %>% filter(maxWage >= limitanei(.1) & maxWage <= limitanei(.9))
# densityPlot(wages, wages$maxWage, limitanei(.1), limitanei(.9))
# theMedian <- summary(wages9010$maxWage)[3]
# theMean <- summary(wages9010$maxWage)[4]
# shareBelow <- length(which(wages9010$maxWage < minWage/1000))
# shareMiddle <- length(which(wages9010$maxWage >= minWage/1000 & wages9010$maxWage <= 2*(minWage/1000)))
# shareUpper <- length(which(wages9010$maxWage > 2*(minWage/1000) & wages9010$maxWage <= 3*(minWage/1000)))
# shareRich <- length(which(wages9010$maxWage > 3*(minWage/1000)))
# response <- paste("El salario minimo es",minWage, ", la media es", theMean, ", la mediana es", theMedian,", hay",shareBelow,"personas con un salario inferior al minimo,",
#     shareMiddle,"personas con uno entre 1 y 2 salarios minimos, ",
#     shareUpper ,"personas entre 2 y 3 SM, y",
#     shareRich,"personas con mas de 3 SM", sep = " "
# )

