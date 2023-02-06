joinCriteria <- c("DIRECTORIO", "SECUENCIA_P")

paradata2012 <- left_join(data2012, desocupados2012.xlsx, by = joinCriteria)

branch <- data2012

branch <- branch[!branch$DIRECTORIO %in% paradata2012$DIRECTORIO & !branch$SECUENCIA_P %in% paradata2012$SECUENCIA_P, ]
