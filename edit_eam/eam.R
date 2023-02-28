source("./edit_eam/dependencies.R")

# Data cleaning

readEAM()
eam17 <- simplify(eam_17.csv, varNamesEAM)
eam18 <- simplify(eam_18.csv, varNamesEAM)