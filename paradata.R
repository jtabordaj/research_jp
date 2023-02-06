joinCriteria <- c("DIRECTORIO", "SECUENCIA_P")

paradata2012 <- inner_join(data2012, desocupados2012.xlsx, by = joinCriteria)