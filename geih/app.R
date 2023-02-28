source("./geih/ocupados.R")
rm(list = ls())
source("./geih/personas.R")
rm(list = ls())
source("./geih/actividades.R")
rm(list = ls())
source("./geih/ingresos.R")
rm(list = ls())
source("./geih/desocupados.R")
rm(list = ls())

# Remember to change years

######

source("./geih/dependencies.R")

grabOutputs()

joinCriteria <- c("DIRECTORIO", "SECUENCIA_P", "ORDEN")

data2021 <- inner_join(ocupados2021.xlsx, personas2021.xlsx, by = joinCriteria)
data2021 <- inner_join(data2021, actividades2021.xlsx, by = joinCriteria)
data2021 <- inner_join(data2021, ingresos2021.xlsx, by = joinCriteria )

data2012 <- inner_join(ocupados2012.xlsx, personas2012.xlsx, by = joinCriteria)
data2012 <- inner_join(data2012, actividades2012.xlsx, by = joinCriteria)
data2012 <- inner_join(data2012, ingresos2012.xlsx, by = joinCriteria )

######

joinCriteriaP <- c("DIRECTORIO", "SECUENCIA_P")

##############################################################
paradata2012 <- left_join(data2012, desocupados2012.xlsx, by = joinCriteriaP)
paradata2012 <- paradata2012 %>% unique()
# Validations
paradata2012[is.na(paradata2012)] <- 0
paradata2012[paradata2012 == Inf] <- 0

##############################################################
paradata2021 <- left_join(data2021, desocupados2021.xlsx, by = joinCriteriaP)
paradata2021 <- paradata2021 %>% unique()
# Validations
paradata2021[is.na(paradata2021)] <- 0
paradata2021[paradata2021 == Inf] <- 0

## Export

write_xlsx(paradata2012, paste("./geih/2012.xlsx", sep = ""))
write_xlsx(paradata2021, paste("./geih/2021.xlsx", sep = ""))
