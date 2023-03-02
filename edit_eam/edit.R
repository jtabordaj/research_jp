source("./edit_eam/dependencies.R")

### Data cleaning

readEDIT()
edit1718 <- simplify(edit_1718.csv, varNamesEDIT)
edit <- edit1718

### Mutates

## Tipo de innovacion
# Numericas

edit$I1R4C2[is.na(edit$I1R4C2)] <- 0
edit <- edit %>% mutate(innProceso = I1R4C2) # numero de procesos

edit$I1R6C2[is.na(edit$I1R6C2)] <- 0
edit <- edit %>% mutate(innProducto = I1R6C2) # numero de productos

edit$I1R5C2[is.na(edit$I1R5C2)] <- 0
edit <- edit %>% mutate(innOrganizacional = I1R5C2) # numero de organizacionales

## Impacto de la innovacion
# Dummys

edit$I2R1C1[is.na(edit$I2R1C1)] <- 3
edit <- edit %>% mutate(mejoraBS = ifelse(I2R1C1 != 3, 1, 0)) #1 = Hay mejoras B/S

edit$I2R2C1[is.na(edit$I2R2C1)] <- 3
edit <- edit %>% mutate(aumentaBS = ifelse(I2R2C1 != 3, 1, 0)) #1 = Aumenta gama B/S

edit$I2R3C1[is.na(edit$I2R3C1)] <- 3
edit$I2R4C1[is.na(edit$I2R4C1)] <- 3
edit <- edit %>% mutate(mantienePosicion = ifelse(I2R3C1 != 3 | I2R4C1 != 3, 1, 0)) #1 = Le ayuda a mantener posicion de mercado

edit$I2R5C1[is.na(edit$I2R5C1)] <- 3
edit <- edit %>% mutate(aumentaProductividad = ifelse(I2R5C1 !=3, 1, 0)) #1 = Le aumento la productividad

edit$I2R6C1[is.na(edit$I2R6C1)] <- 3
edit$I2R7C1[is.na(edit$I2R7C1)] <- 3
edit$I2R8C1[is.na(edit$I2R8C1)] <- 3
edit$I2R9C1[is.na(edit$I2R9C1)] <- 3
edit <- edit %>% mutate(reduceCostoFactores = ifelse(I2R6C1 != 3 | I2R7C1 != 3 | I2R8C1 != 3 | I2R9C1 != 3, 1, 0)) #1 = Reduce costo de factores

edit$I2R10C1[is.na(edit$I2R10C1)] <- 3
edit$I2R11C1[is.na(edit$I2R11C1)] <- 3
edit$I2R12C1[is.na(edit$I2R12C1)] <- 3
edit <- edit %>% mutate(reduceCostoLogistico = ifelse(I2R10C1 != 3 | I2R11C1 != 3 | I2R12C1 != 3, 1, 0)) #1 = Reduce costos transporte/com/reparacion

edit$I2R13C1[is.na(edit$I2R13C1)] <- 3
edit$I2R14C1[is.na(edit$I2R14C1)] <- 3
edit$I2R15C1[is.na(edit$I2R15C1)] <- 3
edit <- edit %>% mutate(reduceCostoOtros = ifelse(I2R13C1 != 3 | I2R14C1 != 3 | I2R15C1 != 3, 1, 0)) #1 = Reduce otros costos (regulaciones, reciclaje, impuestos)

## Taxonomia de la innovacion
# Numeric

edit$I1R4C2N[is.na(edit$I1R4C2N)] <- 0
edit <- edit %>% mutate(innRadical = I1R4C2N) # numero de radicales

edit$I1R4C2M[is.na(edit$I1R4C2M)] <- 0
edit <- edit %>% mutate(innIncremental = I1R4C2M) # numero de incrementales

## Tipo de empresa innovadora
# Dummys

edit <- edit %>% mutate(innovadorAmplio = ifelse(TIPOLO == "AMPLIA", 1, 0)) #1 = Innovador amplio
edit <- edit %>% mutate(noInnovadora = ifelse(TIPOLO == "NOINNO", 1, 0)) #1 = No innovadora
edit <- edit %>% mutate(innovadorEstricto = ifelse(TIPOLO == "ESTRIC", 1, 0)) #1 = Innovador estricto
edit <- edit %>% mutate(innovadorPotencial = ifelse(TIPOLO == "POTENC", 1, 0)) #1 = Innovador potencial
edit <- edit %>% mutate(otroTipo = ifelse(innovadorAmplio + noInnovadora + innovadorEstricto + innovadorPotencial == 0, 1, 0)) #1 = Otro tipo

## Uso de TICs
# Dummy

edit$II1R4C1[is.na(edit$II1R4C1)] <- 0
edit$II1R4C2[is.na(edit$II1R4C2)] <- 0
edit <- edit %>% mutate(usaTICs = ifelse(II1R4C1 > 0 | II1R4C2 > 0, 1,0)) #1 = Gasta en TICs

## Networking de innovacion
# Dummys

edit$V3R3C1[is.na(edit$V3R3C1)] <- 0
edit$V3R5C1[is.na(edit$V3R5C1)] <- 0
edit$V3R6C1[is.na(edit$V3R6C1)] <- 0
edit$V3R7C1[is.na(edit$V3R7C1)] <- 0
edit$V3R8C1[is.na(edit$V3R8C1)] <- 0
edit$V3R9C1[is.na(edit$V3R9C1)] <- 0
edit$V3R10C1[is.na(edit$V3R10C1)] <- 0
edit$V3R11C1[is.na(edit$V3R11C1)] <- 0
edit$V3R12C1[is.na(edit$V3R12C1)] <- 0

edit <- edit %>% mutate(networkNoEmpresa = ifelse(V3R3C1 == 1 | V3R5C1 == 1 | V3R6C1 == 1 | V3R7C1 == 1 | V3R8C1 == 1 | V3R9C1 == 1 | V3R10C1 == 1 | V3R11C1 == 1 | V3R12C1 == 1, 1, 0)) #1 = Hizo networking con no-empresas

edit$V3R1C1[is.na(edit$V3R1C1)] <- 0
edit$V3R2C1[is.na(edit$V3R2C1)] <- 0
edit$V3R4C1[is.na(edit$V3R4C1)] <- 0

edit <- edit %>% mutate(networkEmpresas = ifelse(V3R1C1 == 1| V3R4C1 == 1 | V3R2C1 == 1, 1, 0)) #1 = Hizo networking con empresas

edit$V3R1C8[is.na(edit$V3R1C8)] <- 0
edit$V3R2C8[is.na(edit$V3R2C8)] <- 0
edit$V3R4C8[is.na(edit$V3R4C8)] <- 0

edit <- edit %>% mutate(modificaOtros = ifelse(V3R4C8 == 1 | V3R2C8 == 1 | V3R1C8 == 1, 1, 0)) #1 = Modificaciones de otras empresas

edit <- edit %>% mutate(sinNetwork = ifelse(modificaOtros + networkEmpresas + networkNoEmpresa == 0, 1, 0)) #1 = No hay networking (Innova solo la empresa)

# Cuando hagas dicc revisa las organizaciones de cada coso

## Personal ocupado
# Numerics + Categories

edit <- edit %>% mutate(totOcupados2017 = IV1R11C1)
edit <- edit %>% mutate(totOcupados2018 = IV1R11C2)

edit <- edit %>% mutate(catOcupados2017 = ifelse(IV1R11C1 <= 10, 1, 
    ifelse(IV1R11C1 > 10 & IV1R11C1 <= 50, 2,
    ifelse(IV1R11C1 > 50 & IV1R11C1 <= 200, 3, 
    ifelse(IV1R11C1 > 200, 4, 0))))
) # 1 = Menos de 10. 2 = Entre 10 y 50. 3 = Entre 50 y 200. 4 = Mas de 200 

edit <- edit %>% mutate(catOcupados2018 = ifelse(IV1R11C2 <= 10, 1, 
    ifelse(IV1R11C2 > 10 & IV1R11C2 <= 50, 2,
    ifelse(IV1R11C2 > 50 & IV1R11C2 <= 200, 3, 
    ifelse(IV1R11C2 > 200, 4, 0))))
) # 1 = Menos de 10. 2 = Entre 10 y 50. 3 = Entre 50 y 200. 4 = Mas de 200 

## CIIU
# Categories, pero numericas

colnames(edit)[2] <- "ciiu4"
edit <- edit %>% mutate(ciiu4Digitos = ciiu4)

## Personal en ACTI
# Numerics

edit$IV1R11C3[is.na(edit$IV1R11C3)] <- 0
edit$IV1R11C4[is.na(edit$IV1R11C4)] <- 0

edit <- edit %>% mutate(ocupadosACTI2017 = IV1R11C3)
edit <- edit %>% mutate(ocupadosACTI2018 = IV1R11C4)

edit <- edit %>% mutate(ratioActi2017 = ocupadosACTI2017/totOcupados2017)
edit <- edit %>% mutate(ratioActi2018 = ocupadosACTI2018/totOcupados2018)

edit[isNaN(edit)] <- 0

## Capital humano educacion
# Numerics

edit$IV1R7C1[is.na(edit$IV1R7C1)] <- 0
edit$IV1R8C1[is.na(edit$IV1R8C1)] <- 0

edit$IV1R7C2[is.na(edit$IV1R7C2)] <- 0
edit$IV1R8C2[is.na(edit$IV1R8C2)] <- 0

edit <- edit %>% mutate(educadosColegio2017 = IV1R7C1 + IV1R8C1)
edit <- edit %>% mutate(educadosColegio2017 = IV1R7C2 + IV1R8C2)

edit$IV1R4C1[is.na(edit$IV1R4C1)] <- 0
edit$IV1R5C1[is.na(edit$IV1R5C1)] <- 0
edit$IV1R6C1[is.na(edit$IV1R6C1)] <- 0
edit$IV1R9C1[is.na(edit$IV1R9C1)] <- 0

edit$IV1R4C2[is.na(edit$IV1R4C2)] <- 0
edit$IV1R5C2[is.na(edit$IV1R5C2)] <- 0
edit$IV1R6C2[is.na(edit$IV1R6C2)] <- 0
edit$IV1R9C2[is.na(edit$IV1R9C2)] <- 0

edit <- edit %>% mutate(educadosSuperior2017 = IV1R4C1 + IV1R5C1 + IV1R6C1 + IV1R9C1)
edit <- edit %>% mutate(educadosSuperior2018 = IV1R4C2 + IV1R5C2 + IV1R6C2 + IV1R9C2)

edit$IV1R1C1[is.na(edit$IV1R1C1)] <- 0
edit$IV1R2C1[is.na(edit$IV1R2C1)] <- 0
edit$IV1R3C1[is.na(edit$IV1R3C1)] <- 0

edit$IV1R1C2[is.na(edit$IV1R1C2)] <- 0
edit$IV1R2C2[is.na(edit$IV1R2C2)] <- 0
edit$IV1R3C2[is.na(edit$IV1R3C2)] <- 0

edit <- edit %>% mutate(educadosPosgrado2017 = IV1R1C1 + IV1R2C1 + IV1R3C1)
edit <- edit %>% mutate(educadosPosgrado2018 = IV1R1C2 + IV1R2C2 + IV1R3C2)

edit$IV1R10C1[is.na(edit$IV1R10C1)] <- 0
edit$IV1R10C2[is.na(edit$IV1R10C2)] <- 0

edit <- edit %>% mutate(educadosOtro2017 = IV1R10C1)
edit <- edit %>% mutate(educadosOtro2018 = IV1R10C2)

## Ratio de ocupacion del capital humano
# Numerics
# Nota: la encuesta solo tiene ratios para 2018

edit$IV4R4C3[is.na(edit$IV4R4C3)] <- 0

edit <- edit %>% mutate(ocupadosProduccion = IV4R4C3)
edit <- edit %>% mutate(ratioProduccion = ocupadosProduccion/totOcupados2018)

edit$IV4R11C3[is.na(edit$IV4R11C3)] <- 0

edit <- edit %>% mutate(ocupadosID = IV4R11C3)
edit <- edit %>% mutate(ratioID = ocupadosID/totOcupados2018)

edit$IV4R1C3[is.na(edit$IV4R1C3)] <- 0
edit$IV4R2C3[is.na(edit$IV4R2C3)] <- 0
edit$IV4R5C3[is.na(edit$IV4R5C3)] <- 0

edit <- edit %>% mutate(ocupadosAdmin = IV4R1C3 + IV4R2C3 + IV4R5C3)
edit <- edit %>% mutate(ratioAdmin = ocupadosAdmin/totOcupados2018)

edit$IV4R3C3[is.na(edit$IV4R3C3)] <- 0
edit <- edit %>% mutate(ocupadosMarketing = IV4R3C3)
edit <- edit %>% mutate(ratioMarketing = ocupadosMarketing/totOcupados2018)

edit[isNaN(edit)] <- 0
