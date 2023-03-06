theSurvey <- 1718

if(theSurvey == 1718){
    source("./edit_eam/edit1718.R")
} else {
 "xD"
}

edit <- simplify(edit, varNamesOutput)

write_xlsx(edit, paste("./edit_eam/outputs/data1718.xlsx", sep = ""))
paste("Wrote ",substitute(data1718)," at ./edit_eam/outputs/data1718.xlsx", sep = "")
