source("./edit_eam/dependencies.R")

# Data cleaning

readEAM2("19.csv$")
readEAM("20.csv$")

eam19 <- simplify(eam_19.csv, varNamesEAM)
eam20 <- simplify(eam_20.csv, varNamesEAM)

colnames(eam19)[4:7] <- paste0(colnames(eam19)[4:7], "19")
colnames(eam20)[4:7] <- paste0(colnames(eam20)[4:7], "20")

colnames(eam19)[1] <- "NORDEMP"
colnames(eam19)[2] <- "CIIU 4"
colnames(eam19)[3] <- "DPTO"

colnames(eam20)[1] <- "NORDEMP"
colnames(eam20)[2] <- "CIIU 4"
colnames(eam20)[3] <- "DPTO"

## Merge

mergeCriteriaEAM <- c("NORDEMP", "CIIU 4", "DPTO")

main1920 <- inner_join(eam19, eam20, by = mergeCriteriaEAM)