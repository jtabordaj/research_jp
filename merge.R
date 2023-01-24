source("./dependencies.R")

grabOutputs()

joinCriteria <- c("DIRECTORIO", "SECUENCIA_P", "ORDEN")

data2021 <- inner_join(ocupados2021.xlsx, personas2021.xlsx, by = joinCriteria)
data2021 <- inner_join(data2021, actividades2021.xlsx, by = joinCriteria)
data2021 <- inner_join(data2021, ingresos2021.xlsx, by = joinCriteria )

data2012 <- inner_join(ocupados2012.xlsx, personas2012.xlsx, by = joinCriteria)
data2012 <- inner_join(data2012, actividades2012.xlsx, by = joinCriteria)
data2012 <- inner_join(data2012, ingresos2012.xlsx, by = joinCriteria )

write_xlsx(data2012, paste("./2012.xlsx", sep = ""))
write_xlsx(data2021, paste("./2021.xlsx", sep = ""))

data2012$cotizaPension %>% table()
