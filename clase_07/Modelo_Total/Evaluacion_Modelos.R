#Importanto los modelos a Evaluar
model_1 <- readRDS("clase_07/modelo1.rds")
model_2 <- readRDS("clase_07/modelo2.rds")
model_3 <- readRDS("clase_07/modelo3_RegLog.rds")

load(file = "clase_06/Modelo_Total/df_desa_F_test.Rdata")

#Modelo 1
y_pred <- predict(object = model_1, type = "class", newdata = df.desa.F.test)
cm <- table(y_pred, df.desa.F.test$Exited)
(cm[1,1]+cm[2,2])/sum(cm) #Exito del modelo = 0.85
(cm[1,2])/sum(cm[1,]) # Falso Positivo, Error tipo 1!!! = 0.14

#Modelo 2
y_pred <- predict(object = model_2, type = "class", newdata = df.desa.F.test)
cm <- table(y_pred, df.desa.F.test$Exited)
(cm[1,1]+cm[2,2])/sum(cm) #Exito del modelo = 0.84
(cm[1,2])/sum(cm[1,]) # Falso Positivo, Error tipo 1!!! = 0.14

#Modelo 3
df<-df.desa.F.test
df$Geography <- factor(df$Geography, 
                       levels = c("France", "Spain", "Germany"),
                       labels = c(1,2,3))

df$Gender <- factor(df$Gender, 
                    levels = c("Female", "Male"),
                    labels = c(1,2))

p_pred <- predict(object = model_3, type = "response", newdata = df)
y_pred = ifelse(p_pred > 0.5, 1, 0)
cm <- table(y_pred, df.desa.F.test$Exited)
(cm[1,1]+cm[2,2])/sum(cm) #Exito del modelo = 0.81
(cm[1,2])/sum(cm[1,]) # Falso Positivo, Error tipo 1!!! = 0.16
### Automatizar en un pipeline











