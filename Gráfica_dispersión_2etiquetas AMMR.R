#Creador: Axel Marure
#Gráfica de dispersión

library(pacman)
p_load("readr", "ggplot2", "dplyr", "ggrepel")
#ggrepel es para etiquetar datos en una gráfica

datos <- read.csv(file="https://raw.githubusercontent.com/ManuelLaraMVZ/Transcript-mica/main/DesnutridasvsEunutridas.csv")
head(datos)

#Obtener controles
controles <- datos %>% 
  filter(Condicion=="Control")
head(controles)

#Promedios control
promedios_control <- controles %>%  
  summarise(Mean_C1=mean(Cx1),
            Mean_C2=mean(Cx2),
            Mean_C3=mean(Cx3),
            Mean_T1=mean(T1),
            Mean_T2=mean(T2),
            Mean_T3=mean(T3)) %>% 
  mutate(Gen="promedio_controles") %>% 
  select(7,1,2,3,4,5,6)
promedios_control

#Extraer genes 
genes <- datos %>% 
  filter(Condicion=="Target") %>% 
  select(-2)
head(genes)

#∆CT (interés-referencia)
DCT <- genes %>% mutate(DCT_C1=2^-(Cx1-promedios_control$Mean_C1),
                        DCT_C2=2^-(Cx2-promedios_control$Mean_C2),
                        DCT_C3=2^-(Cx3-promedios_control$Mean_C3),
                        DCT_T1=2^-(T1-promedios_control$Mean_T1),
                        DCT_T2=2^-(T2-promedios_control$Mean_T2),
                        DCT_T3=2^-(T3-promedios_control$Mean_T3)) %>% 
  select(-2,-3,-4,-5,-6,-7)
head(DCT)

#agrupación DCTs
promedios_DCT <- DCT %>% 
  mutate(Mean_DCT_Cx=(DCT_C1+ DCT_C2+ DCT_C3)/3,
         Mean_DCT_Tx=(DCT_T1+ DCT_T2+ DCT_T3)/3)

promedios_DCT

#grafica
grafica_puntos <- ggplot(promedios_DCT, mapping=aes(x=Mean_DCT_Cx,y=Mean_DCT_Tx),
                         colour=cut)+
  geom_point(size=2,color="blue")+
  labs(title="Condición control vs. tratamiento",
       caption= "Creador:Axel Marure",
       x=expression("Condición control 2"^"-DCT"), 
       y= expression("Tratamiento 2"^"-DCT"))+
  geom_smooth(method = "lm", color="black",
              alpha=0.05, linewidth=1, span=1)+
  theme_minimal()+
  theme(panel.background = element_rect(fill="white"),#fondo blanco
        panel.grid.major = element_blank(),#sin enrejado
        axis.text = element_text(family="Times",size=12),#texto de ejes tamaño 12 y tipo times
        axis.title = element_text(family="Times",size=14, face="bold"),#leyenda ejes tamaño 14
        legend.title =element_text(family="Times",size=14), #texto de leyenda tamaño 14 y tipo
        legend.text = element_text(family="Times",size=14)) #texto de etiquetas de leyenda tamaño 14
grafica_puntos

#identificación genes
top_10 <- promedios_DCT %>% 
  select(1,8,9) %>% 
  top_n(10, Mean_DCT_Cx) %>% 
  arrange(desc(Mean_DCT_Cx))
head(top_10)

grafica_dispersion2 <- grafica_puntos+
  geom_label_repel(data= top_10,
                   mapping=aes(x=Mean_DCT_Cx,
                               y=Mean_DCT_Tx,
                               label=Gen),
                   label.padding = unit(0.2, "lines"),
                   max.overlaps = 20)
grafica_dispersion2
#Guardar
ggsave("grafica_dispersion.jpeg",plot = grafica_dispersion2, width=7, height= 5, dpi=300)






