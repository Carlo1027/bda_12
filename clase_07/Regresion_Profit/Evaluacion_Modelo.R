#Data
load(file = "clase_07/Regresion_Profit/df_test.Rdata")
#modelos
m_lm <- readRDS(file = "clase_07/Regresion_Profit/modelo_lm.rds")
m_dt_1 <- readRDS(file = "clase_07/Regresion_Profit/modelo_dt_1.rds")
m_dt_2 <- readRDS(file = "clase_07/Regresion_Profit/modelo_dt_2.rds")

#la prediccion con la muestra de test
y_pred_lm = predict(object = m_lm, newdata = df.test, type = "response")
y_pred_dt_1 = predict(object = m_dt_1, newdata = df.test)
y_pred_dt_2 = predict(object = m_dt_2, newdata = df.test)

#Plot de Resultados
install.packages("ggplot2")
library(ggplot2)
nobs <- seq(1,10)

ggplot()+
  geom_point(aes(x = nobs,y = df.test$Profit), color="black")+
  geom_point(aes(x = nobs,y = y_pred_lm), color="blue")+
  geom_line(aes(x = nobs,y = y_pred_dt_1), color="red")+
  geom_line(aes(x = nobs,y = y_pred_dt_2), color="orange")

#Plot de variaciones
var_lm=abs(y_pred_lm-df.test$Profit)/df.test$Profit
var_dt_1=abs(y_pred_dt_1-df.test$Profit)/df.test$Profit
var_dt_2=abs(y_pred_dt_2-df.test$Profit)/df.test$Profit

pbk<-par()
par(mfrow=(c(1,3)))
hist(var_lm)
hist(var_dt_1)
hist(var_dt_2)

#menor diferencia eje x
#la mayor cantidad esté en valores menores
#modelo ganador: m_lm
