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

## Merge to track 17-20

source("./edit_eam/dependencies.R")
fileListO <- list.files("./edit_eam/outputs")
for(i in fileListO){
    path <- paste("./edit_eam/outputs/",i, sep = "")
    assign(paste(i, sep = ""), read_xlsx(path), envir = .GlobalEnv)
}

distinct1718 <- data1718.xlsx %>% distinct(NORDEMP, .keep_all = TRUE)
distinct1920 <- data1920.xlsx %>% distinct(NORDEMP, .keep_all = TRUE)

mergeCriteriaAttempt <- c("NORDEMP", "ciiu4Digitos", "deptoDivipola", "region")

colnames(distinct1718) <- ifelse(
  colnames(distinct1718) %in% mergeCriteriaAttempt,
  colnames(distinct1718),
  paste0(colnames(distinct1718), "_1718")
)

colnames(distinct1920) <- ifelse(
  colnames(distinct1920) %in% mergeCriteriaAttempt,
  colnames(distinct1920),
  paste0(colnames(distinct1920), "_1920")
)


merged <- inner_join(distinct1718, distinct1920, by = mergeCriteriaAttempt)
merged <- merged %>% unique() %>% drop_na()

write_xlsx(merged, paste("./edit_eam/main.xlsx", sep = ""))
paste("Wrote ",substitute(merged)," at ./edit_eam/main.xlsx", sep = "")