theSurvey <- 1920

if(theSurvey == 1718){
    source("./edit_eam/edit_1718.R")
    edit <- simplify(edit, varNamesOutput)
    write_xlsx(edit, paste("./edit_eam/outputs/data1718.xlsx", sep = ""))
    paste("Wrote ",substitute(data1718)," at ./edit_eam/outputs/data1718.xlsx", sep = "")
} else {
    source("./edit_eam/edit_1920.R")
    edit <- simplify(edit, varNamesOutput1920)
    write_xlsx(edit, paste("./edit_eam/outputs/data1920.xlsx", sep = ""))
    paste("Wrote ",substitute(data1920)," at ./edit_eam/outputs/data1920.xlsx", sep = "")
}
rm(list = ls())
