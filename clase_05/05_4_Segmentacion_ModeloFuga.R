#levantamos la data tratada
load(file="clase_05/df_desa_F.Rdata")

#Segmentacion por Geografia
df.desa.F.FS <- subset(df.desa.F,
                       select = c("CreditScore","Gender",
                                  "Age","Tenure",
                                  "Balance","NumOfProducts",
                                  "HasCrCard","IsActiveMember",
                                  "EstimatedSalary","Exited"),
                       subset = df.desa.F$Geography != "Germany"
                         )



df.desa.F.G <- subset(df.desa.F,
                       select = c("CreditScore","Gender",
                                  "Age","Tenure",
                                  "Balance","NumOfProducts",
                                  "HasCrCard","IsActiveMember",
                                  "EstimatedSalary","Exited"),
                       subset = df.desa.F$Geography == "Germany"
                )

save(df.desa.F.FS, file = "clase_05/df_desa_F_FS.Rdata")
save(df.desa.F.G, file = "clase_05/df_desa_F_G.Rdata")