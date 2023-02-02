source("./dependencies.R")

grabData("desocupados", ".csv2", 1, 12)
allDataFrames <- names(which(unlist(eapply(.GlobalEnv,is.data.frame))))
onlyDesocup <- allDataFrames[grep("^desocup", allDataFrames)]


# Remember:
# Revisar si esta/agregar p6050 en caracteristicas generales
# Necesito dsi en modulo desocupados o una variable que de desempleo