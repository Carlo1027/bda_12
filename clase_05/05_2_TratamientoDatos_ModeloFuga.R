#import data
load(file = "clase_04/df_desa.Rdata")
colnames(df.desa)
df.desa.F = df.desa

#CreditScore
#========================
# TRATAMIENTO DE COTAS INF
#========================
qa <- quantile(df.desa.F$CreditScore, probs = 0.01) # empiezo en 0.01 y se va subiendo
qa #432.86 p1
#x <- ifelse( df.desa.F$CreditScore < qa, qa, df.desa.F$CreditScore)
#boxplot(x)

df.desa.F$CreditScore <- ifelse( df.desa.F$CreditScore < qa, qa, df.desa.F$CreditScore)

#Geography

#Gender

#Age
#========================
# TRATAMIENTO DE COTAS SUP
#========================
qa <- quantile(df.desa.F$Age, probs = 0.96) # empiezo en 0.99 y se va bajando
qa #62 p96
#x <- ifelse( df.desa.F$Age > qa, qa, df.desa.F$Age)
#boxplot(x)

df.desa.F$Age <- ifelse( df.desa.F$Age > qa, qa, df.desa.F$Age)

#Tenure
#Balance
df.desa.F$Balance<- log2(df.desa.F$Balance)
#hist(df.desa.F$Balance)

#NumOfProducts
#========================
# TRATAMIENTO DE COTAS SUP
#========================
qa <- quantile(df.desa.F$NumOfProducts, probs = 0.99) # empiezo en 0.99 y se va bajando
qa #3 p99
#x <- ifelse( df.desa.F$NumOfProducts > qa, qa, df.desa.F$NumOfProducts)
#boxplot(x)

df.desa.F$NumOfProducts <- ifelse( df.desa.F$NumOfProducts > qa, qa, df.desa.F$NumOfProducts)

#HasCrCard
#IsActiveMember
#EstimatedSalary
#========================
# TRATAMIENTO DE MISSINGS
#========================
df.desa.F$EstimatedSalary <- ifelse( is.na(df.desa.F$EstimatedSalary),
                                     mean(df.desa.F$EstimatedSalary, na.rm = TRUE), #100001.1
                                     df.desa.F$EstimatedSalary)

save(df.desa.F, file = "clase_05/df_desa_F.Rdata")