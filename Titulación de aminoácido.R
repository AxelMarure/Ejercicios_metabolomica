2+2
2^(-4)
suma <- 2+2 #el símbolo <- es para asignar nombres a valores y guardarlos
suma
2+suma
suma+2
CHO <- 535000 #los comentarios se ponen con hashtag antes
Vero <- 1350000 
TOTAL <- CHO +Vero 
TOTAL
x <- 35
y <- 22
w <- "34" #todo lo que se ponga entre comillas, lo considera como texto
z <- "25"
x+y
w+z
#Los vectores son secuencias de números, los data frames (DF) tienen muchos vectores (son tablas, cada vector es una columna)
V1 <- c(1,2,3)
V2 <- c(4,5,6)
V3 <- c(7,8,9)
V4 <- c("M","D","Z")
DF_V <-data.frame(V4,V1,V2,V3) #tienes que poner DF antes del nombre si quieres guardarlo
View(DF_V)#tiene que ser V no v (mayúsucula)
install.packages("readr")#instalar
library("readr")#ejecutar. Siempre se tiene que instalar y ejecutar el paquete que vas a usar
library("readr")
setwd("~/Desktop/UNIVERSIDAD/8º SEMESTRE/METABOLÓMICA/Ejercicio R" )#tienes que guardarlo en la carpeta correspondiente
library(readr)
datos_titulacion_2_ <- read_csv("datos_titulacion (2).csv") 
View(datos_titulacion_2_)
titulacion <- read_csv(file = "https://raw.githubusercontent.com/ManuelLaraMVZ/titulacion_amino_acidos/main/datos_titulacion%20(2).csv") #esto fue par bajar los dtos desde internet
head(titulacion) #head es para ver el encabezado (la h es en minúscula)
install.packages("ggplot2") #paquete para hacer la gráfica
library("ggplot2")
grafica <- ggplot(datos_titulacion_2_,aes(x=Volumen,y=pH))+
  geom_line()+
  labs(title = "Titulación de cisteína", x="Volumen", y="pH")+
  theme_dark()
grafica #para visualizar la gráfica
ggsave("titulación_repertorio.jpeg", plot=grafica, width=6, height=4, dpi=500)
