#Levantamos la data de desarrollo
load(file = "clase_04/df_desa.Rdata")
head(df.desa)
str(df.desa)
summary(df.desa)

#=====================================
#Analisis Univariado
#=====================================
#Variables Cualitativas
str(df.desa) # los factores
#Geography
cuadro <- table(df.desa$Geography)
barplot(cuadro)
etiquetas <- paste(c("France","Germany","Spain"),
                   round((cuadro/margin.table(cuadro)*100),2))
pie(cuadro, labels = etiquetas)

table(df.desa$Geography) # frecuencia absoluta
cumsum(cuadro) # Frecuencia absoluta acumulada

x <- cuadro/margin.table(cuadro) # frecuencia relativa
pie(x)

#Gender
jpeg('clase_04/Gender.jpg')
cuadro <- table(df.desa$Gender)
barplot(cuadro)
dev.off()

#HasCrCard
#IsActiveMember
#Exited
var1 <- c("HasCrCard","IsActiveMember","Exited")
for (v in var1) {
  jpeg(paste('Clase_04/',v,'.jpg'))
  cuadro <- table(df.desa[,v])
  barplot(cuadro)
  dev.off()
}

#Variables cuantitativas
str(df.desa)
hist(df.desa$CreditScore)
boxplot(df.desa$CreditScore)

#Medidas de Tendencia Central
mean(df.desa$CreditScore)
median(df.desa$CreditScore)
#Medidas de Dispersión
min(df.desa$CreditScore)
max(df.desa$CreditScore)
rango <- (max(df.desa$CreditScore)-min(df.desa$CreditScore))
var(df.desa$CreditScore)
sd(df.desa$CreditScore)
sd(df.desa$CreditScore)/mean(df.desa$CreditScore) # coeficiente de variación = 0.1486145
sd(df.desa$Age)/mean(df.desa$Age) # 0.2697539, es más disperso que CreditScore

#Medidas de Posición
quantile(df.desa$Age) #Cuartiles
d <- quantile(df.desa$Age, probs = seq(0,1, 0.1)) #Deciles
d[1] #Decil 1
d[[1]] #Valor del decil 1

varN = c("Age", "Tenure", "Balance", "NumOfProducts", "EstimatedSalary")
idx <- c(0)
min <- c(0)
i <- 1
for (v in varN) {
  idx[i] <- i
  min[i] <- min(df.desa$v)
  i <- i + 1
}
temp <- data.frame(idx,varN,min)
temp

#graficos
summary(df.desa)
hist(df.desa$Age)
boxplot(df.desa$Age)




