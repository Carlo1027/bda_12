#importando la data
load(file = "clase_06/Modelo_Total/df_desa_F.Rdata")
summary(df.desa.F)

#Split train test (caTools)
install.packages("caTools")
library(caTools)
set.seed(123)
split <- sample.split(df.desa.F$Exited, SplitRatio = 0.7)
df.desa.F.train <- subset(df.desa.F, split == TRUE)
df.desa.F.test <- subset(df.desa.F, split == FALSE)

#==============================
# ARBOL DE DECISION
#==============================
# En este caso no se requiere recodificar las variables categoricas
library(rpart)
modelo <- rpart(formula = Exited ~ . ,
                data = df.desa.F.train,
                method = "class")

#Atributos del modelo
str(modelo)
summary(modelo) # variable importante: Age 51%, NumOfProducts 29%, IsActiveMember 15%
print(modelo)

# viendo el arbol
install.packages("rpart.plot")
library(rpart.plot)
rpart.plot(modelo)

# Quitando las variables menos importantes
colnames(df.desa.F.train)
modelo1 <- rpart(formula = Exited ~ CreditScore
                                  + Gender
                                  + Age
                                  + Tenure
                                  + Balance
                                  + NumOfProducts
                                  + HasCrCard
                                  + IsActiveMember
                                  + EstimatedSalary,
                data = df.desa.F.train,
                method = "class")
summary(modelo1)
rpart.plot(modelo1)

#Evaluando los modelos
y_pred <- predict(object = modelo, newdata = df.desa.F.test, type = "class")
cm <- table(y_pred, df.desa.F.test$Exited)
cm #Exito : (2236 + 215) / 2876 = 0.8522253

y_pred <- predict(object = modelo1, newdata = df.desa.F.test, type = "class")
cm <- table(y_pred, df.desa.F.test$Exited)
cm #Exito : (2242 + 188) / 2876 = 0.8449235

#==============================
# REGRESION LOGISTICA
#==============================







