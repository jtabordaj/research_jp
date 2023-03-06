source("./edit_eam/dependencies.R")

# Data cleaning

readEAM2("17.csv$")
readEAM2("18.csv$")

eam17 <- simplify(eam_17.csv, varNamesEAM)
eam18 <- simplify(eam_18.csv, varNamesEAM)

colnames(eam17)[4:7] <- paste0(colnames(eam17)[4:7], "17")
colnames(eam18)[4:7] <- paste0(colnames(eam18)[4:7], "18")

colnames(eam17)[1] <- "NORDEMP"
colnames(eam17)[2] <- "CIIU 4"
colnames(eam17)[3] <- "DPTO"

colnames(eam18)[1] <- "NORDEMP"
colnames(eam18)[2] <- "CIIU 4"
colnames(eam18)[3] <- "DPTO"

## Merge

mergeCriteriaEAM <- c("NORDEMP", "CIIU 4", "DPTO")

main1718 <- inner_join(eam17, eam18, by = mergeCriteriaEAM)