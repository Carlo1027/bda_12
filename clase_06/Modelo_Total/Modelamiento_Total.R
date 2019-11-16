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

save(df.desa.F.train, file = "clase_06/Modelo_Total/df_desa_F_train.Rdata")
save(df.desa.F.test, file = "clase_06/Modelo_Total/df_desa_F_test.Rdata")

#==============================
# ARBOL DE DECISION
#==============================
# En este caso no se requiere recodificar las variables categoricas
library(rpart)
modelo1 <- rpart(formula = Exited ~ . ,
                data = df.desa.F.train,
                method = "class")

#Atributos del modelo
str(modelo1)
summary(modelo1) # variable importante: Age 51%, NumOfProducts 29%, IsActiveMember 15%
print(modelo1)

# viendo el arbol
install.packages("rpart.plot")
library(rpart.plot)
rpart.plot(modelo1)

# Quitando las variables menos importantes
colnames(df.desa.F.train)
modelo2 <- rpart(formula = Exited ~ CreditScore
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
summary(modelo2)
rpart.plot(modelo2)

#Evaluando los modelos 1 y 2 
y_pred <- predict(object = modelo1, newdata = df.desa.F.test, type = "class")
cm <- table(y_pred, df.desa.F.test$Exited)
cm #Exito : (2236 + 215) / 2876 = 0.8522253

y_pred <- predict(object = modelo2, newdata = df.desa.F.test, type = "class")
cm <- table(y_pred, df.desa.F.test$Exited)
cm #Exito : (2242 + 188) / 2876 = 0.8449235

#Guardando las versiones
saveRDS(modelo1, "clase_07/modelo1.rds")
saveRDS(modelo2, "clase_07/modelo2.rds")

#==============================
# REGRESION LOGISTICA
#==============================
# Es importante hacer el Encoding categorical variables

head(df.desa.F.train)

df<-df.desa.F.train
df$Geography <- factor(df$Geography, 
                       levels = c("France", "Spain", "Germany"),
                       labels = c(1,2,3))

df$Gender <- factor(df$Gender, 
                       levels = c("Female", "Male"),
                       labels = c(1,2))

summary(df)
modelo3<-glm(formula = Exited ~ . ,
             family = binomial,
             data = df)

summary(modelo3)
saveRDS(modelo3, "clase_07/modelo3_RegLog.rds")

#validar el modelo
df<-df.desa.F.test
df$Geography <- factor(df$Geography, 
                       levels = c("France", "Spain", "Germany"),
                       labels = c(1,2,3))

df$Gender <- factor(df$Gender, 
                    levels = c("Female", "Male"),
                    labels = c(1,2))

p_pred <- predict(object = modelo3, newdata = df, type = "response")
summary(p_pred)
y_pred = ifelse(p_pred > 0.5, 1, 0)
cm<- table(y_pred, df.desa.F.test$Exited)
cm #Exito : (2208 + 131) / 2876 = 0.8132823

