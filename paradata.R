joinCriteria <- c("DIRECTORIO", "SECUENCIA_P", "ORDEN")

paradata <- inner_join(desocupados, personas, by = joinCriteria)