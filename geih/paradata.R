joinCriteria <- c("DIRECTORIO", "SECUENCIA_P")

##############################################################
paradata2012 <- left_join(data2012, desocupados2012.xlsx, by = joinCriteria)
paradata2012 <- paradata2012 %>% unique()
# Validations
paradata2012[is.na(paradata2012)] <- 0
paradata2012[paradata2012 == Inf] <- 0

##############################################################
paradata2021 <- left_join(data2021, desocupados2021.xlsx, by = joinCriteria)
paradata2021 <- paradata2021 %>% unique()
# Validations
paradata2021[is.na(paradata2021)] <- 0
paradata2021[paradata2021 == Inf] <- 0

## Export

write_xlsx(paradata2012, paste("./2012.xlsx", sep = ""))

write_xlsx(paradata2021, paste("./2021.xlsx", sep = ""))


# noEstan <- anti_join(df, df2, by = joinCriteria)
