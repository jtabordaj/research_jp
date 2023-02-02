source("./dependencies.R")

grabData("desocupados", ".csv2", 1, 12)
allDataFrames <- names(which(unlist(eapply(.GlobalEnv,is.data.frame))))
onlyDesocup <- allDataFrames[grep("^desocup", allDataFrames)]
