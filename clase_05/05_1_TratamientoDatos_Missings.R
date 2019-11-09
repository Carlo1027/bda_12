#Importando datos
load("clase_04/df_desa.Rdata")
summary(df.desa)

#========================
# TRATAMIENTO DE MISSINGS
#========================

#EstimatedSalary
df.desa.F = df.desa

df.desa.F$EstimatedSalary <- ifelse( is.na(df.desa.F$EstimatedSalary),
                            mean(df.desa.F$EstimatedSalary, na.rm = TRUE), #100001.1
                            df.desa.F$EstimatedSalary)
#validar
summary(df.desa.F)
par_orig = par()
par(mfrow=c(1,2))
hist(df.desa.F$EstimatedSalary)
hist(df.desa$EstimatedSalary)
par=par_orig

#========================
# TRATAMIENTO DE COTAS
#========================
qa <- quantile(df.desa.F$Age, probs = 0.96) # empiezo en 0.99 y se va bajando
qa #62 p96
x <- ifelse( df.desa.F$Age > qa,
                         qa,
                         df.desa.F$Age)

hist(x)
boxplot(x)

df.desa.F$Age <- ifelse( df.desa.F$Age > qa,
             qa,
             df.desa.F$Age)

#validar
summary(df.desa.F)
par_orig = par()
par(mfrow=c(1,2))
hist(df.desa.F$Age)
hist(df.desa$Age)
par=par_orig

#========================
# FEATURE SCALING
#========================
mean(df.desa.F$EstimatedSalary) #100001.1
sd(df.desa.F$EstimatedSalary) #57507.99
x <- (df.desa.F$EstimatedSalary - 100001.1) / 57507.99 #scale(df.desa.F$EstimatedSalary)
par(mfrow=c(1,2))
hist(df.desa.F$EstimatedSalary)
hist(x)

hist(log2(df.desa.F$EstimatedSalary))
hist(scale(log2(df.desa.F$EstimatedSalary)))

mean(log2(df.desa.F$EstimatedSalary)) #16.16905
sd(log2(df.desa.F$EstimatedSalary)) #1.441962
df.desa.F$EstimatedSalary = (log2(df.desa.F$EstimatedSalary) - 16.16905) / 1.441962

par(mfrow=c(1,2))
hist(df.desa$EstimatedSalary)
hist(df.desa.F$EstimatedSalary)

#========================
# MUESTREO BALANCEADO
#========================
library(caTools)
set.seed(123)
split = sample.split(df.desa.F$Exited, SplitRatio = 0.6)
df.desa.F.train <- subset(df.desa.F, split == TRUE)
df.desa.F.test <- subset(df.desa.F, split == FALSE)

pie(table(df.desa.F.training$Exited))
pie(table(df.desa.F.test$Exited))

save(df.desa.F.train, file = "clase_05/df_train.Rdata")
save(df.desa.F.train, file = "clase_05/df_test.Rdata")




