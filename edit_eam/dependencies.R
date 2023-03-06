## Requires

library(tidyverse)
library(ggplot2)
library(dplyr)
library(plyr)
library(readxl)
library(writexl)
library(haven)
library(purrr)

## General

simplify <- function(survey, variables){
    survey %>% select(any_of(variables))
}

isNaN <- function(x){
    do.call(cbind, lapply(x, is.nan))
}

hasNAs <- function(x){
    if(length(which(is.na(x))) == 0){
        print("No NAs")
    } else {
        print("NAs detected")
    }
}

## EAM

readEAM <- function(){
    fileList <- list.files("./edit_eam/data/eam")
    for(i in fileList){
    path <- paste("./edit_eam/data/eam/",i, sep = "")
    assign(paste(i, sep = ""), read_csv2(path), envir = .GlobalEnv)
   }
}

varNamesEAM <- c("NORDEMP", "Nordemp", "nordemp",
    "CIIU4", "Ciiu4", "ciiu4",
    "DPTO", "Dpto", "dpto",
    "PORCVT", "Porcvt", "porcvt",
    "VALORCX", "Valorcx", "valorcx",
    "VALORVEN", "Valorven", "valorven",
    "VALAGRI", "Valagri", "valagri"
)

## EDIT

readEDIT <- function(){
    fileList <- list.files("./edit_eam/data/edit")
    for(i in fileList){
    path <- paste("./edit_eam/data/edit/",i, sep = "")
    assign(paste(i, sep = ""), read_csv2(path), envir = .GlobalEnv)
   }
}

varNamesEDIT <- c("NORDEMP", "CIIU 4", "TIPOLO",
    "I1R4C2", "I1R4C2N", "I1R4C2M", "I1R6C2", "I1R5C2", 
    "I2R1C1", "I2R2C1", "I2R3C1", "I2R4C1", "I2R5C1", "I2R6C1", "I2R7C1", "I2R8C1", "I2R9C1", "I2R10C1", "I2R11C1", "I2R12C1", "I2R13C1", "I2R14C1", "I2R15C1",
    "I8R1C1",
    "I10R1C1", "I10R2C1", "I10R3C1", "I10R4C1", "I10R5C1", "I10R6C1", "I10R7C1", "I10R8C1", "I10R9C1", "I10R10C1", "I10R11C1", "I10R12C1", "I10R13C1", "I10R14C1",
    "II1R4C1", "II1R4C2", "II1R10C1", "II1R10C2",
    "III1R1C1", "III1R1C2", "III1R2C1", "III1R2C2", "III1R3C1", "III1R3C2", "III1R4C1", "III1R4C2", "III1R4C3", "III1R4C4", "III1R5C1", 
    "III1R5C2", "III1R5C3", "III1R5C4", "III1R6C1", "III1R6C2", "III1R7C1", "III1R7C2", "III1R6C3", "III1R6C4", "III1R7C3", "III1R7C4", 
    "III2R1C1", "III2R1C2",
    "III4R3C1", "III4R4C1", "III4R5C1", "III4R6C1",
    "IV1R1C1", "IV1R2C1", "IV1R3C1", "IV1R4C1", "IV1R5C1", "IV1R6C1", "IV1R7C1", "IV1R8C1", "IV1R9C1", "IV1R10C1",
    "IV1R1C2", "IV1R2C2", "IV1R3C2", "IV1R4C2", "IV1R5C2", "IV1R6C2", "IV1R7C2", "IV1R8C2", "IV1R9C2", "IV1R10C2",
    "IV1R11C1", "IV1R11C2", "IV1R11C3", "IV1R11C4", "IV4R11C2",
    "IV4R1C3", "IV4R2C3", "IV4R3C3", "IV4R4C3", "IV4R5C3" ,"IV4R6C3",
    "V2R1C1","V2R2C1", "V2R3C1", "V2R4C1", "V3R5C1", "V2R7C1", "V2R15C1", "V2R17C1",
    "V3R1C1", "V3R2C1", "V3R3C1", "V3R4C1", "V3R5C1", "V3R6C1", "V3R7C1", "V3R8C1", "V3R9C1", "V3R10C1", "V3R11C1", "V3R12C1", "V3R4C8", "V3R2C8", "V3R1C8",
    "VIII1R1C1", "VIII5R1C1", "VIII9R1C1", "VIII12R5C1", "VIII14R5C1", "VIII16R1C1", "VIII17R1C1"
)

## Output

varNamesOutput <- c("NORDEMP", "innProceso", "innProducto", "innOrganizacional", "mejoraBS", "aumentaBS", "mantienePosicion", "aumentaProductividad", "reduceCostoFactores",
"reduceCostoLogistico", "reduceCostoOtros", "innRadical", "innIncremental", "innovadorEstricto", "innovadorAmplio", "innovadorPotencial", "noInnovadora", "otroTipo",  
"usaTICs", "sinNetwork", "networkNoEmpresa", "networkEmpresas", "modificaOtros", "propietarioActual", "totOcupados2017", "totOcupados2018", "catOcupados2017", "catOcupados2018", 
"ciiu4Digitos", "deptoDivipola", "region", "valorAgregado2017", "valorAgregado2018", "productividadL2017", "productividadL2018", "ratioX2017", "ratioX2018", "ratioM2017", "ratioM2018",
"inversion2017", "inversion2018", "ocupadosACTI2017", "ocupadosACTI2018", "ratioActi2017", "ratioActi2018", "totOcupados2017", "totOcupados2018", "educadosColegio2017", "educadosColegio2018",
"educadosSuperior2017", "educadosSuperior2018", "educadosPosgrado2017", "educadosPosgrado2018", "educadosOtro2017", "educadosOtro2018", "ocupadosProduccion", "ratioProduccion", "ocupadosID", 
"ratioID", "ocupadosAdmin", "ratioAdmin", "ocupadosMarketing", "ratioMarketing", "hayMujeres", "recursosPropio2017", "recursosPropio2018", "recursosBanca2017", "recursosBanca2018", "recursosConglomerado2017", 
"recursosConglomerado2018", "recursosEmpresas2017", "recursosEmpresas2018", "contratoEstado", "sniSENA", "sniCamaraComercio", "sniICONTEC", "sniUnivSNCTI", "sniSIC", "sniMinciencias", "sniConsultores", "sniProcolombia", 
"sniINNPulsa", "obsRecursosPropios", "obsFinancExterno", "obsApoyoPublico", "obsInformacion", "obsPersonal", "obsRegulaciones", "obsCooperacion", "obsDerechosProp", "obsInspeccion", "obsApoyoPublico", "obsTramite", 
"obsIntermediacion", "obsRequisitos", "obsFinAtractiva", "obsDemanda", "obsTecnica", "obsImitacion", "obsRentabilidad", "bonosGerenciales", "bonosNoGerenciales", "ascensosGerenciales", "ascensosNoGerenciales",
"metasProduccion", "indicadoresDesemp") 
