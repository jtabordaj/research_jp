grabData(".csv", 1, 12, "personas")

allDataFrames <- names(which(unlist(eapply(.GlobalEnv,is.data.frame))))

onlyPersonas <- allDataFrames[grep("^persona", allDataFrames)]


for(i in onlyPersonas){
    assign(paste(i, sep=""), simplifierPers(get(i))); 
}

people <- getPeople()

rownames(people) <- c(1:nrow(people))
people[is.na(people)] <- 0
people[people == Inf] <- 0


mergeCriteria <- c("DIRECTORIO", "SECUENCIA_P", "ORDEN", "DPTO")
data <- inner_join(wages, people, by = mergeCriteria)

write_xlsx(data, paste("./data",theYear,".xlsx", sep = ""))
