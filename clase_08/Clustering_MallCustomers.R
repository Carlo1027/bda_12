#data
df <- read.csv("clase_08/Mall_Customers.csv")
head(df)
#======================================================
#AGRUPANDO EN FUNCION DE 2 CARACTERISTICAS (VARIABLES)
#======================================================
df.instacia<-df[c(4,5)] #para visualiar los clusters (2 variables)
#par(mfrow=c(1,1))
plot(df.instacia) # 5 Grupos aparentemente
#Metodo para obtener el nro de grupos
set.seed(123)
km<-kmeans(x=df.instacia, centers = 1)
km$tot.withinss #269981.3 similaridad total dentro del grupo: (min)
km$betweenss    #5.820766e-11 similaridad entre grupos: (max)

km<-kmeans(x=df.instacia, centers = 2)
km$tot.withinss #183653.3 similaridad total dentro del grupo: (min)
km$betweenss    #86327.95 similaridad entre grupos: (max)

wss <- vector()
bss <- vector()
grupos<-c(1:10) #numero de grupos
for (i in grupos) {
  km<-kmeans(x=df.instacia, centers = i)
  wss[i]<-km$tot.withinss
  bss[i]<-km$betweenss
}

library(ggplot2)
ggplot()+
  geom_line(aes(x=grupos,y=wss), colour="red")+
  geom_line(aes(x=grupos,y=bss), colour="blue")
#----> nro de grupos optimo es 5

set.seed(123)
km<-kmeans(x=df.instacia, centers = 5)
#Asignando a cada instancia el grupo correspondiente
df.instacia["Grupo"]<-km$cluster
head(df.instacia)
#visualizando
library(cluster)
clusplot(x=df.instacia[,c(1,2)],clus = df.instacia$Grupo, color = TRUE)

#=============================================================
#AGRUPANDO EN FUNCION DE TODAS LAS CARACTERISTICAS (VARIABLES)
#=============================================================
df.instacia<-df[,2:5]
summary(df.instacia)
df.instacia$Genre<-as.numeric(factor(df.instacia$Genre,levels = c("Female","Male"), labels = c(1,0)))
#df.instacia<-scale(df.instacia)
summary(df.instacia)

#nro optimo de cluster (grupos)
wss <- vector()
bss <- vector()
grupos<-c(1:20) #numero de grupos
for (i in grupos) {
  set.seed(123)
  km<-kmeans(x=df.instacia, centers = i)
  wss[i]<-km$tot.withinss
  bss[i]<-km$betweenss
}

library(ggplot2)
ggplot()+
  geom_line(aes(x=grupos,y=wss), colour="red")+
  geom_line(aes(x=grupos,y=bss), colour="blue")
#----> nro de grupos optimo entre 8 y 10
set.seed(123)
km<-kmeans(x=df.instacia, centers = 10)

#Asignando a cada instancia el grupo correspondiente
df.instacia["Grupo"]<-km$cluster
#visualizando
library(cluster)
clusplot(x=df.instacia[,c(1,4)],clus = df.instacia$Grupo, color = TRUE)
