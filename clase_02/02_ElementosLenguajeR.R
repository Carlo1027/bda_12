# Definicion de variables
x <- 5
y = 7

# Concatenar "paste"
a <- "Arriba"
b <- "Peru"
c <- paste(a, " ", b)

# Identificar tipo de dato
str(a)
class(a)

# Vectores
notas <- c(18,15,13)
x <- seq(1:10)
y <- seq(1,10, by = 2)
z <- rep(1:0, times=4)
w <- rep(1:0, each=4)
v <- c(notas,x,y,z,w,c(1,2,5))

# Liberar memoria
ls()
rm(list = c("w","x","y"))

# Metodos de los vectores
x <- table(v)
y <- sort(v)

# Seleccion de elementos
notas
notas=c(notas,20,7,12,5)
notas[2] # por indice

aprobados <- notas[notas > 10] # por valor
aprobados

# Funciones generales para Vectores
length(notas)
max(notas)
min(notas)
sd(notas)
log(notas)

############################################
# Matrices
############################################
x <- c(seq(1:3), rep(1, times=3), c(8,7,6))
m <- matrix(x, nrow = 3, ncol = 3) # Default by column
mn <- matrix(x, nrow = 3, ncol = 3, byrow = TRUE)

# Seleccion de elementos
m[2,]
m[,2]
m[1,3]
m[,c(1,3)]

############################################
# Listas
############################################
l <- list(x = notas, p1 = table(notas), p2 = aprobados, p3 = min(notas))
r <- l[c("p1","p2","p3")]
r$p3
r$p2

############################################
# Factores
############################################
genero <- c(0,0,0,0,1,1,1,0,1,0,1,0,1,0,0,1,1)
genero.factor <- as.factor(genero)
genero.factor
levels(genero.factor) = c("M","F")

############################################
# DATAFRAMES
############################################
df <- data.frame(x=seq(1,6),
                 y=rep(7,6),
                 z=c(10,11))
View(df)
head(df, n=4) # 4 primeros registros


df$x # df[[1]]
df[c("x","z")] # df[c(1,3)]
w <- df[c("y","z")] # df[, c("y","z")]
class(w)

df[, c("y","z")]
df
cbind(df, w=rep(1,6)) # agregar columna
rbind(df, c(6,7,4)) # insertar

# SELECT a,b, as B FROM tabla WHERE condicion
head(df)
df_1 <- df[, c("x","z")]
names(df_1)[2]=c("zz")
df_1[!(df_1$x > 5 & df_1$zz > 10),]
subset(df_1, !(df_1$x > 5 & df_1$zz > 10))

############################################
# GRAFICOS
############################################
plot(df$x)
plot(df$x, df$z)
hist(df$x)
pie(df$x)










