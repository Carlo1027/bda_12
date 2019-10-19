#Instrucciones Repetitivas
for (i in 1:10) {
  print(i*i)
}

x <- 1
while (x < 10) {
  print(x*x)
  x <- x+1
}

#Instrucciones Condicionales
a <- 5
if (a%%2 == 0) {
  print("Par")
} else {
  print("Impar")
}

#Funciones
sumar <- function(dato1,dato2) {
  return(dato1+dato2)
}
sumar(2,3)

max2num <- function(a,b) {
  mx<-(abs(a+b)+abs(a-b))/2 # max(a,b)
  return(mx)
}
max2num(2,5)

# Recursividad
factorial <- function(n) {
  if(n == 1) return(1)
  
  while(n>1) {
    return(n*factorial(n-1))
  }
  #if(n==1) return(1)
  #else return(n*factorial(n-1))
}

factorial(6)

# Cual es el resultado mas probable al lanzar 2 dados
lanzamientos <- 1000
resultados <- c(rep(0,12))
for (x in 1:lanzamientos) {
  d1 = sample(1:6, 1)
  d2 = sample(1:6, 1)
  r = d1+d2
  resultados[r] <- resultados[r]+1
}
resultados
i <- 1
for (rn in resultados) {
  if(rn == max(resultados)) {
    print(i)
  }
  i <- i+1
}
plot(resultados)
