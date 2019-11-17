#Levantando la data
df <- read.csv("clase_07/Regresion_Profit/50_Startups.csv")
summary(df)

#Codificando la variable categorica
df$State <- factor(df$State, 
                    levels = c("New York", "California", "Florida"),
                    labels = c(1,2,3))

save(df, file = "clase_07/Regresion_Profit/df_Total.Rdta")

#Separando Train y Test
library(caTools)
set.seed(123)
split <- sample.split(df$Profit, SplitRatio = 0.8)
df.train <- subset(df, split == TRUE)
df.test <- subset(df, split == FALSE)

save(df.train, file = "clase_07/Regresion_Profit/df_train.Rdata")
save(df.test, file = "clase_07/Regresion_Profit/df_test.Rdata")

#======================================
# REGRESION LINEAL MULTIPLE
#======================================
modelo_lm2 <- lm(formula = Profit ~ ., data = df.train)
summary(modelo_lm2) # Adjusted R-squared:  0.9425

# Pr debe ser menor a 0.05, vamos quitando variables cuyo Pr es > 0.05
modelo_lm2 <- lm(formula = Profit ~ R.D.Spend + Administration + Marketing.Spend,
                 data = df.train)
summary(modelo_lm2) # Adjusted R-squared:  0.9457

modelo_lm3 <- lm(formula = Profit ~ R.D.Spend + Marketing.Spend,
                 data = df.train)
summary(modelo_lm3) # Adjusted R-squared:  0.9468

modelo_lm4 <- lm(formula = Profit ~ R.D.Spend,
                 data = df.train)
summary(modelo_lm4) # Adjusted R-squared:  0.9434

#Mejor modelo: modelo_lm3 : backward propagation
saveRDS(modelo_lm3, "clase_07/Regresion_Profit/modelo_lm.rds")

#======================================
# ARBOL DE REGRESION
#======================================
load(file = "clase_07/Regresion_Profit/df_train.Rdata")
load(file = "clase_07/Regresion_Profit/df_test.Rdata")
library(rpart)
library(rpart.plot)
modelo_dt_1 <- rpart(formula = Profit ~ ., data = df.train)
summary(modelo_dt_1)
rpart.plot(modelo_dt_1)
saveRDS(modelo_dt_1, file = "clase_07/Regresion_Profit/modelo_dt_1.rds")

modelo_dt_2 <- rpart(formula = Profit ~ ., data = df.train, control = rpart.control(minsplit = 2))
summary(modelo_dt_2)
rpart.plot(modelo_dt_2)
saveRDS(modelo_dt_2, file = "clase_07/Regresion_Profit/modelo_dt_2.rds")









