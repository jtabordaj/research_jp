source("./edit_eam/dependencies.R")

### Data cleaning

readEDIT()
edit1718 <- simplify(edit_1718.csv, varNamesEDIT)
edit <- edit1718

### Mutates

## Tipo de innovacion

edit$I1R4C2[is.na(edit$I1R4C2)] <- 0
edit <- edit %>% mutate(innProceso = I1R4C2) # numero de procesos

edit$I1R6C2[is.na(edit$I1R6C2)] <- 0
edit <- edit %>% mutate(innProducto = I1R6C2) # numero de productos

edit$I1R5C2[is.na(edit$I1R5C2)] <- 0
edit <- edit %>% mutate(innOrganizacional = I1R5C2) # numero de organizacionales

## Impacto de la innovacion

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

edit$I2R10C1[is.na(edit$I2R13C1)] <- 3
edit$I2R11C1[is.na(edit$I2R14C1)] <- 3
edit$I2R12C1[is.na(edit$I2R15C1)] <- 3
edit <- edit %>% mutate(reduceCostoOtros = ifelse(I2R13C1 != 3 | I2R14C1 != 3 | I2R15C1 != 3, 1, 0)) #1 = Reduce otros costos (regulaciones, reciclaje, impuestos)

## Taxonomia de la innovacion

edit$I1R4C2N[is.na(edit$I1R4C2N)] <- 0
edit <- edit %>% mutate(innRadical = I1R4C2N) # numero de radicales

edit$I1R4C2M[is.na(edit$I1R4C2M)] <- 0
edit <- edit %>% mutate(innIncremental = I1R4C2M) # numero de incrementales

## Tipo de empresa innovadora

edit <- edit %>% mutate(innovadorAmplio = ifelse(TIPOLO == "AMPLIA", 1, 0)) #1 = Innovador amplio
edit <- edit %>% mutate(noInnovadora = ifelse(TIPOLO == "NOINNO", 1, 0)) #1 = No innovadora
edit <- edit %>% mutate(innovadorEstricto = ifelse(TIPOLO == "ESTRIC", 1, 0)) #1 = Innovador estricto
edit <- edit %>% mutate(innovadorPotencial = ifelse(TIPOLO == "POTENC", 1, 0)) #1 = Innovador potencial
edit <- edit %>% mutate(otroTipo = ifelse(TIPOLO != "ESTRIC" | TIPOLO != "NOINNO" | TIPOLO != "POTENC" | TIPOLO != "AMPLIA" |, 1, 0)) #1 = Otro tipo

## Uso de TICs

edit$II1R4C1[is.na(edit$II1R4C1)] <- 0
edit$II1R4C1[is.na(edit$II1R4C1)] <- 0
edit <- edit %>% mutate(usaTICs = ifelse(II1R4C1 > 0 | II1R4C2 > 0, 1,0)) #1 = Gasta en TICs

## Networking de innovacion

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

edit$V3R3C1[is.na(edit$V3R1C1)] <- 0
edit$V3R5C1[is.na(edit$V3R2C1)] <- 0
edit$V3R6C1[is.na(edit$V3R4C1)] <- 0

edit <- edit %>% mutate(networkEmpresas = ifelse(V3R1C1 == 1| V3R4C1 == 1 | V3R2C1 == 1, 1, 0)) #1 = Hizo networking con empresas

edit$V3R3C1[is.na(edit$V3R1C8)] <- 0
edit$V3R5C1[is.na(edit$V3R2C8)] <- 0
edit$V3R6C1[is.na(edit$V3R4C8)] <- 0

edit <- edit %>% mutate(modificaOtros = ifelse(V3R4C8 == 1 | V3R2C8 == 1 | V3R1C8 == 1, 1, 0)) #1 = Modificaciones de otras empresas

edit <- edit %>% mutate(sinNetwork = ifelse(modificaOtros != 1 | networkEmpresas != 1 | networkNoEmpresa != 1, 1, 0)) #1 = No hay networking (Innova solo la empresa)

# Cuando hagas dicc revisa las organizaciones de cada coso

 
