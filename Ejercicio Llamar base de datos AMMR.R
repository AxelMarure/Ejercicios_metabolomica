#Creador: Axel Marure
#Llamado de bases de datos

#Llamar la base de datos desde la computadora

install.packages("readr")
library(readr)
titulacion <- read_csv("datos titulación.csv")
View(datos_titulación)

###########################################################################
#Llamar desde un repositorio (internet)

repositorio <- read_csv(file="https://raw.githubusercontent.com/ManuelLaraMVZ/titulacion_amino_acidos/main/datos_titulacion%20(2).csv")
head(repositorio)#para ver el encabezado
View(repositorio)#para ver la tabla

###########################################################################
#Gráfica

install.packages("ggplot2")
library(ggplot2)

grafica <- ggplot(repositorio,
                  aes(x=Volumen,
                  y=pH))+
geom_line()+
labs(title = "Titulacion cisteina",
     x="Volumen ácido (uL)",
     y="Valor de pH")+
  theme_dark()
  
grafica

ggsave("Titulacion_repertorio.jpeg", plot = grafica, 
       width = 6, 
       height = 4, 
       dpi = 500)#Para guardarlo en la carpeta de trabajo
