source("./edit_eam/dependencies.R")

# Data cleaning

readEAM()
eam17 <- simplify(eam_17.csv, varNamesEAM)
eam18 <- simplify(eam_18.csv, varNamesEAM)

colnames(eam17)[4:7] <- paste0(colnames(eam17)[4:7], "17")
colnames(eam18)[4:7] <- paste0(colnames(eam18)[4:7], "18")
# Merge test

mergeCriteriaEAM <- c("nordemp", "ciiu4", "dpto")

main1718 <- inner_join(eam17, eam18, by = mergeCriteriaEAM)