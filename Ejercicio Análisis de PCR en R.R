
#Creador: Axel Marure
#Análisis de datos de tiempo real

install.packages("pacman")#pacman sirve para llamar e instalar otros paquetes

library(pacman)#library es para ejecutar

p_load("readr",#para llamar a las bases de datos
       "dplyr")#para facilitar el manejo de datos
library(dplyr)

#########################################################################

#Llamar la base de datos

datos_pcr <- read_csv(file="https://raw.githubusercontent.com/ManuelLaraMVZ/Transcript-mica/main/Genes.csv")

head(datos_pcr)
#######################################################################
#Obtención de genes de referencia y de interés

actina <- datos_pcr %>%
  slice(1)

actina

genes_interes <- datos_pcr %>% 
  slice(-1)

genes_interes

#######################################################################

#Promediar los controles y los tratamientos

promedio_actina <- actina %>% 
  mutate(mean_Cx=(C1+C2+C3)/3) %>% 
  mutate(mean_Tx=(T1+T2+T3)/3) %>% 
  select(Gen,mean_Tx,mean_Cx)

promedio_actina

promedio_GI <- genes_interes %>% 
  mutate(mean_Cx=(C1+C2+C3)/3) %>% 
  mutate(mean_Tx=(T1+T2+T3)/3) %>% 
  select(Gen,mean_Tx,mean_Cx)

promedio_GI


#########################################################################
#Análisis DCT

DCT <- promedio_GI %>% 
  mutate(DCT_Cx=(mean_Cx-promedio_actina$mean_Cx)) %>% 
  mutate(DCT_Tx=(mean_Tx-promedio_actina$mean_Tx)) %>% 
  select(Gen,DCT_Cx,DCT_Tx)

DCT
########################################################################

#Análisis DDCT

DDCT <- DCT %>% 
  mutate(DDCT=(DCT_Tx-DCT_Cx)) %>% 
  mutate("2^-DDCT"=(2^(-DDCT)))

DDCT


###############################################################

#Guardar tabla

write.csv(DDCT, "2DDCT.csv", row.names = FALSE)

