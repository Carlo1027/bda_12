#======================================
#levatamos la base de observacion
#======================================
load(file = "clase_04/df_oof.Rdata")
df.obs <- df.oof

#corremos el modelo (esto se obtiene de las ejecuciones del modelo)
model_impl <- readRDS("clase_07/modelo1.rds")
df.obs$CreditScore <- ifelse(df.obs$CreditScore < 432.86,
                             432.86,
                             df.obs$CreditScore)

df.obs$Age <- ifelse(df.obs$Age>62,62,df.obs$Age)
df.obs$NumOfProducts <- ifelse(df.obs$NumOfProducts>3,3,df.obs$NumOfProducts)
df.obs$EstimatedSalary <- ifelse(df.obs$EstimatedSalary>100001.1,100001.1,df.obs$EstimatedSalary)
y_pred <- predict(object = model_impl, type = "class", newdata = df.obs)

df.obs["y_pred"] <- y_pred
head(df.obs)

cm <- table(df.obs$y_pred, df.obs$Exited)
(cm[1,1]+cm[2,2])/sum(cm) #0.811138 : originalmente el exito del modelo fue 0.85

#Estabilidad de las variables
load(file = "clase_06/Modelo_Total/df_desa_F_train.Rdata")

PSI_var_Continuo <- function(sample.ref, sample.obs) {
  d <- quantile(sample.ref, probs = seq(from = 0, to = 1, by = 0.1))
  sample.ref <- cut(sample.ref, breaks = c(-Inf,d),labels = seq(0,10))
  
  d <- quantile(sample.obs, probs = seq(from = 0, to = 1, by = 0.1))
  sample.obs <- cut(sample.obs, breaks = c(-Inf,d),labels = seq(0,10))
  
  t <- table(sample.ref)
  feq_ref <- t/margin.table(t)
  t <- table(sample.obs)
  feq_obs <- t/margin.table(t)
  
  PSI <- sum((feq_obs - feq_ref)*log(feq_obs / feq_ref))
  return(PSI) 
}

sample.ref <- df.desa.F.train$CreditScore
sample.obs <- df.obs$CreditScore

PSI_var_Continuo (sample.ref, sample.obs)



