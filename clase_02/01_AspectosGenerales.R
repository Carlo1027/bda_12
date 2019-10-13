?mean
help.start()
help.search("data.frame")
help(package="ggplot2")

str(iris) ## muestro el objeto

class(iris) ## definicion del objeto

install.packages("dplyr") ## instalando paquetes
library(dplyr) ## cargar el paquete en la sesion

a <- 2 ## asignacion de variable, tambien se puede usar '='
ls() ## listar las variables
rm(a) ## eliminar una variable del entorno
rm(list = ls()) ## eliminar todas las variables del entorno

b <- c(1,2,3)
2:6
seq(2, 5, by=0.5)
rep(1:5, times=3)
rep(1:3, each=3)