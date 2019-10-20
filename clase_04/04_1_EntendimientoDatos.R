#Importacion de datos
df <- read.csv("clase_04/Churn_Customer.csv")
head(df)
summary(df)

#Selección de variables útiles
df <- subset(df, select = seq(4,14))

#Identificar los tipos de datos
str(df)
df$HasCrCard <- as.factor(df$HasCrCard)
df$IsActiveMember <- as.factor(df$IsActiveMember)
df$Exited <- as.factor(df$Exited)

summary(df)

#Definiendo la ventana de desarrollo del modelo
df.desa <- subset(df, subset = (Tenure > 0))
df.oof <- subset(df, subset = (Tenure == 0))

summary(df.desa$Exited)
summary(df$Exited)

#Guardando el resultado
save(df.desa, file = "clase_04/df_desa.Rdata")
save(df.oof, file = "clase_04/df_oof.Rdata")





