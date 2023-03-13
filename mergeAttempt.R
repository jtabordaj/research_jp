## To read outputs

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

