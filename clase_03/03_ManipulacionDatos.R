#Importacion de datos
ds_A <- read.csv("clase_03/Social_Network_Ads.csv")
head(ds_A)

df_mayores <- subset(x=ds_A,
               select = c(Gender, Age, EstimatedSalary, Purchased),
               subset = (EstimatedSalary > 100000)
               )
head(df_mayores)

# Escribir
write.csv(df_mayores,"clase_03/df_mayores.csv")

# Merge
ds_B <- subset(ds_A, subset =  (Age < 30 & EstimatedSalary > 100000))
ds_C <- subset(ds_A, subset = (Age > 25 & EstimatedSalary > 130000 & Gender == 'Female'))
head(ds_B)
head(ds_C)

ds_BC = merge(x = ds_B, y = ds_C, by = "User.ID") # inner join
head(ds_BC)
ds_CB = merge(x = ds_B, y = ds_C, by = "User.ID", all.x = TRUE) # left join
head(ds_CB)

save(ds_CB, file = "clase_03/ds_CB.Rdata")




