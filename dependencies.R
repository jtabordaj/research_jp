library(tidyverse)
library(ggplot2)
library(dplyr)
library(plyr)
library(readxl)
library(writexl)
library(haven)
library(purrr)

# diccionario datos  https://microdatos.dane.gov.co/catalog/599/data_dictionary 
# salarios en https://www.salariominimocolombia.net/historico/ 

# data sources
theYear <- 2012

readFilesCSV <- function(monthStart, monthEnd, survey){
    if(survey == "ocupados"){
    for(i in monthStart:monthEnd){
        #pathArea <- paste("./data/",theYear,"/",i,"/area_ocupados.csv", sep = "");
        pathCabecera <- paste("./data/",theYear,"/",i,"/cabecera_ocupados.csv", sep = "");
        pathResto <- paste("./data/",theYear,"/",i,"/resto_ocupados.csv", sep = "");
        #assign(paste("ocupArea.",i, sep=""), read_csv(pathArea)); 
        assign(paste("ocupCabecera.",i, sep=""), read_csv(pathCabecera), envir=.GlobalEnv);
        assign(paste("ocupResto.",i, sep=""), read_csv(pathResto), envir=.GlobalEnv);
    }} else if(survey == "personas"){
    for(i in monthStart:monthEnd){
        #pathArea <- paste("./data/",theYear,"/",i,"/area_personas.csv", sep = "");
        pathCabecera <- paste("./data/",theYear,"/",i,"/cabecera_personas.csv", sep = "");
        pathResto <- paste("./data/",theYear,"/",i,"/resto_personas.csv", sep = "");
        #assign(paste("personasArea.",i, sep=""), read_csv(pathArea)); 
        assign(paste("personasCabecera.",i, sep=""), read_csv(pathCabecera), envir=.GlobalEnv);
        assign(paste("personasResto.",i, sep=""), read_csv(pathResto), envir=.GlobalEnv)
    }} else if(survey == "actividades"){
    for(i in monthStart:monthEnd){
        #pathArea <- paste("./data/",theYear,"/",i,"/area_actividades.csv", sep = "");
        pathCabecera <- paste("./data/",theYear,"/",i,"/cabecera_actividades.csv", sep = "");
        pathResto <- paste("./data/",theYear,"/",i,"/resto_actividades.csv", sep = "");
        #assign(paste("actividadesArea.",i, sep=""), read_csv(pathArea)); 
        assign(paste("actividadesCabecera.",i, sep=""), read_csv(pathCabecera), envir=.GlobalEnv);
        assign(paste("actividadesResto.",i, sep=""), read_csv(pathResto), envir=.GlobalEnv)
        }} else if(survey == "ingresos"){
    for(i in monthStart:monthEnd){
        #pathArea <- paste("./data/",theYear,"/",i,"/area_ingresos.csv", sep = "");
        pathCabecera <- paste("./data/",theYear,"/",i,"/cabecera_ingresos.csv", sep = "");
        pathResto <- paste("./data/",theYear,"/",i,"/resto_ingresos.csv", sep = "");
        #assign(paste("ocupArea.",i, sep=""), read_csv(pathArea)); 
        assign(paste("personaCabecera.",i, sep=""), read_csv(pathCabecera), envir=.GlobalEnv);
        assign(paste("personaResto.",i, sep=""), read_csv(pathResto), envir=.GlobalEnv)
    }}
}


readFilesCSV2 <- function(monthStart, monthEnd, survey){
    if(survey == "ocupados"){
    for(i in monthStart:monthEnd){
        #pathArea <- paste("./data/",theYear,"/",i,"/area_ocupados.csv", sep = "");
        pathCabecera <- paste("./data/",theYear,"/",i,"/cabecera_ocupados.csv", sep = "");
        pathResto <- paste("./data/",theYear,"/",i,"/resto_ocupados.csv", sep = "");
        #assign(paste("ocupArea.",i, sep=""), read_csv2(pathArea)); 
        assign(paste("ocupCabecera.",i, sep=""), read_csv2(pathCabecera), envir=.GlobalEnv);
        assign(paste("ocupResto.",i, sep=""), read_csv2(pathResto), envir=.GlobalEnv);
    }} else if(survey == "personas"){
    for(i in monthStart:monthEnd){
        #pathArea <- paste("./data/",theYear,"/",i,"/area_personas.csv", sep = "");
        pathCabecera <- paste("./data/",theYear,"/",i,"/cabecera_personas.csv", sep = "");
        pathResto <- paste("./data/",theYear,"/",i,"/resto_personas.csv", sep = "");
        #assign(paste("personasArea.",i, sep=""), read_csv2(pathArea)); 
        assign(paste("personasCabecera.",i, sep=""), read_csv2(pathCabecera), envir=.GlobalEnv);
        assign(paste("personasResto.",i, sep=""), read_csv2(pathResto), envir=.GlobalEnv)
    }} else if(survey == "actividades"){
    for(i in monthStart:monthEnd){
        #pathArea <- paste("./data/",theYear,"/",i,"/area_actividades.csv", sep = "");
        pathCabecera <- paste("./data/",theYear,"/",i,"/cabecera_actividades.csv", sep = "");
        pathResto <- paste("./data/",theYear,"/",i,"/resto_actividades.csv", sep = "");
        #assign(paste("actividadesArea.",i, sep=""), read_csv2(pathArea)); 
        assign(paste("actividadesCabecera.",i, sep=""), read_csv2(pathCabecera), envir=.GlobalEnv);
        assign(paste("actividadesResto.",i, sep=""), read_csv2(pathResto), envir=.GlobalEnv) 
        }} else if(survey == "ingresos"){
    for(i in monthStart:monthEnd){
        #pathArea <- paste("./data/",theYear,"/",i,"/area_ingresos.csv", sep = "");
        pathCabecera <- paste("./data/",theYear,"/",i,"/cabecera_ingresos.csv", sep = "");
        pathResto <- paste("./data/",theYear,"/",i,"/resto_ingresos.csv", sep = "");
        #assign(paste("ingresosArea.",i, sep=""), read_csv2(pathArea)); 
        assign(paste("ingresosCabecera.",i, sep=""), read_csv2(pathCabecera), envir=.GlobalEnv);
        assign(paste("ingresosResto.",i, sep=""), read_csv2(pathResto), envir=.GlobalEnv)
    }}
}

readFilesDTA <- function(monthStart, monthEnd, survey){
    if(survey == "ocupados"){
    for(i in monthStart:monthEnd){
        #pathArea <- paste("./data/",theYear,"/",i,"/area_ocupados.dta", sep = "");
        pathCabecera <- paste("./data/",theYear,"/",i,"/cabecera_ocupados.dta", sep = "");
        pathResto <- paste("./data/",theYear,"/",i,"/resto_ocupados.dta", sep = "");
        #assign(paste("ocupArea.",i, sep=""), read_dta(pathArea)); 
        assign(paste("ocupCabecera.",i, sep=""), read_dta(pathCabecera), envir=.GlobalEnv);
        assign(paste("ocupResto.",i, sep=""), read_dta(pathResto), envir=.GlobalEnv);
    }} else if(survey == "personas"){
    for(i in monthStart:monthEnd){
        pathArea <- paste("./data/",theYear,"/",i,"/area_personas.dta", sep = "");
        pathCabecera <- paste("./data/",theYear,"/",i,"/cabecera_personas.dta", sep = "");
        pathResto <- paste("./data/",theYear,"/",i,"/resto_personas.dta", sep = "");
        #assign(paste("personasArea.",i, sep=""), read_csv2(pathArea)); 
        assign(paste("personasCabecera.",i, sep=""), read_dta(pathCabecera), envir=.GlobalEnv);
        assign(paste("personasResto.",i, sep=""), read_dta(pathResto), envir=.GlobalEnv);
    }} else if(survey == "actividades"){
    for(i in monthStart:monthEnd){
        #pathArea <- paste("./data/",theYear,"/",i,"/area_actividades.dta", sep = "");
        pathCabecera <- paste("./data/",theYear,"/",i,"/cabecera_actividades.dta", sep = "");
        pathResto <- paste("./data/",theYear,"/",i,"/resto_actividades.dta", sep = "");
        #assign(paste("actividadesArea.",i, sep=""), read_dta(pathArea)); 
        assign(paste("actividadesCabecera.",i, sep=""), read_dta(pathCabecera), envir=.GlobalEnv);
        assign(paste("actividadesResto.",i, sep=""), read_dta(pathResto), envir=.GlobalEnv)
    }} else if(survey == "ingresos"){
    for(i in monthStart:monthEnd){
        pathArea <- paste("./data/",theYear,"/",i,"/area_ingresos.dta", sep = "");
        pathCabecera <- paste("./data/",theYear,"/",i,"/cabecera_ingresos.dta", sep = "");
        pathResto <- paste("./data/",theYear,"/",i,"/resto_ingresos.dta", sep = "");
        #assign(paste("ingresosArea.",i, sep=""), read_dta(pathArea)); 
        assign(paste("ingresosCabecera.",i, sep=""), read_dta(pathCabecera), envir=.GlobalEnv);
        assign(paste("ingresosResto.",i, sep=""), read_dta(pathResto), envir=.GlobalEnv)
    }}
}

grabData <- function(survey, dataType, monthStart, monthEnd){
    if(dataType == ".csv"){
        readFilesCSV(monthStart, monthEnd, survey)
    } else if(dataType == ".csv2"){
        readFilesCSV2(monthStart, monthEnd, survey)
    } else if(dataType == ".dta"){
        readFilesDTA(monthStart, monthEnd, survey)
    }
}

grabOutputs <- function(){
   outputFiles <- list.files("./output") 
   for(i in outputFiles){
    path <- paste("./output/",i, sep = "")
    assign(paste(i, sep = ""), read_xlsx(path), envir = .GlobalEnv)
   }
}

## Methods ocupados

varNamesOcup <- c("DIRECTORIO", "directorio", "Directorio",
    "SECUENCIA_P", "Secuencia_p", "secuencia_p",
    "ORDEN", "Orden", "orden",
    "P6920", "p6920",
    "P6422", "p6422",
    "P7130", "p7130",
    "P7170S1", "p7170S1", "P7170s1", "p7170s1",
    "P6500", "p6500",
    "P7070", "p7070",
    "P6750", "p6750",
    "P550", "p550",
    "INGLABO", "inglabo", "Inglabo",
    "P6800", "p6800",
    "P7090", "p7090",
    "P7140S2", "p7140s2", "P7140s2", "p7140s2",
    "P6430", "p6430",
    "RAMA2D", "Rama2d", "rama2d",
    "RAMA4D", "Rama4d", "rama4d",
    "RAMA2D_R4", "Rama2d_r4", "rama2d_r4",
    "RAMA4D_R4", "Rama4d_r4", "rama4d_r4",
    "DPTO", "dpto", "Dpto",
    "Mes", "mes", "MES",
    "fex_c_2011", "FEX_C_2011", "Fex_c_2011"
)

simplifierOcupados <- function(x){
    x %>% select(any_of(varNamesOcup))
}

standardizeTitlesOcup <- function(){
    dflist <- list()
    for(df in allDataFrames){
        dflist[[df]] <- get(df)
    }
    for (i in 1:length(dflist)) {
        colnames(dflist[[i]]) <- toupper(colnames(ocupCabecera.9))
    }
    df_combined <- do.call(rbind, dflist)
}

# Methods personas

varNamesPers <- c("DIRECTORIO", "directorio", "Directorio",
    "SECUENCIA_P", "Secuencia_p", "secuencia_p",
    "ORDEN", "Orden", "orden",
    "P6020", "p6020",
    "P6040", "p6040",
    "P6070", "p6070",
    "P6090", "p6090",
    "P6210", "p6210",
    "DPTO", "dpto", "Dpto"
)

simplifierPersonas <- function(x){
    x %>% select(any_of(varNamesPers))
}

standardizeTitlesPers <- function(){
    dflistIng <- list()
    for(df in onlyPersonas){
        dflistIng[[df]] <- get(df)
    }
    for (i in 1:length(dflistIng)) {
        colnames(dflistIng[[i]]) <- toupper(colnames(personasCabecera.9))
    }
    df_combined <- do.call(rbind, dflistIng)
}

# Methods actividades

varNamesActiv <- c("DIRECTORIO", "directorio", "Directorio",
    "SECUENCIA_P", "Secuencia_p", "secuencia_p",
    "ORDEN", "Orden", "orden",
    "P7480S3A1", "p7480S3A1", "P7480s3A1", "p7480s3A1", "P7480s3a1"
)

simplifierActividades <- function(x){
    x %>% select(any_of(varNamesActiv))
}

standardizeTitlesAct <- function(){
    dflistAct <- list()
    for(df in onlyActividades){
        dflistAct[[df]] <- get(df)
    }
    for (i in 1:length(dflistAct)) {
        colnames(dflistAct[[i]]) <- toupper(colnames(actividadesCabecera.9))
    }
    df_combined <- do.call(rbind, dflistAct)
}

# Methods ingreso

varNamesIngr <- c("DIRECTORIO", "directorio", "Directorio",
    "SECUENCIA_P", "Secuencia_p", "secuencia_p",
    "ORDEN", "Orden", "orden",
    "P7500S1A1", "p7500s1a1", "P7500S1a1", "P7500s1A1", "p7500S1a1", "p7500S1A1", "P7500s1a1",
    "P7500S2A1", "p7500s2a1", "P7500S2a1", "P7500s2A1", "p7500S2a1", "p7500S2A1", "P7500s2a1",
    "P7500S3A1", "p7500s3a1", "P7500S3a1", "P7500s3A1", "p7500S3a1", "p7500S3A1", "P7500s3a1",
    "P7510S1A1", "p7510s1a1", "P7510S1a1", "P7510s1A1", "p7510S1a1", "p7510S1A1", "P7510s1a1",
    "P7510S2A1", "p7510s2a1", "P7510S2a1", "P7510s2A1", "p7510S2a1", "p7510S2A1", "P7510s2a1",
    "P7510S3A1", "p7510s3a1", "P7510S3a1", "P7510s3A1", "p7510S3a1", "p7510S3A1", "P7510s3a1",
    "P7510S5A1", "p7510s5a1", "P7510S5a1", "P7510s5A1", "p7510S5a1", "p7510S5A1", "P7510s5a1",
    "P7510S6A1", "p7510s6a1", "P7510S6a1", "P7510s6A1", "p7510S6a1", "p7510S6A1", "P7510s6a1",
    "P7510S7A1", "p7510s7a1", "P7510S7a1", "P7510s7A1", "p7510S7a1", "p7510S7A1", "P7510s7a1"
)

simplifierIngresos <- function(x){
    x %>% select(any_of(varNamesIngr))
}

standardizeTitlesIng <- function(){
    dflistIng <- list()
    for(df in onlyIngresos){
        dflistIng[[df]] <- get(df)
    }
    for (i in 1:length(dflistIng)) {
        colnames(dflistIng[[i]]) <- toupper(colnames(ingresosCabecera.9))
    }
    df_combined <- do.call(rbind, dflistIng)
}

# Methods plot

limitanei <- function(prob){
    data.frame(quantile(wages$maxWage, probs = prob))[1,1];
}

densityPlot <- function(data, axis, min, max){
    ggplot(data, aes(x=axis)) + 
    geom_density() +
    scale_x_continuous(limits = c(min,max)) +
    theme_bw()
}


# cabecera = cabecera xd
# resto = rural disperso
# cabecera + resto = departamento
# sumatoria(departamentos) = Nacional
# sumatoria(area) = Nacional 13 Ciudades y AM
# Si se va a simplificar para hallar cabecera o area hay que agregar la variable AREA
# en 2007 el fexp viene por aparte
