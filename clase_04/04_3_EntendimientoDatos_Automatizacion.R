#levantamos la data de desarrollo
load(file="clase_04/df_desa.Rdata")


#================================
#Analisis Univariado
#================================
#Graficos
tipoDato<-sapply(df.desa, class) #names(variables)[1] variables[[2]]
variables<-colnames(df.desa)
ruta<-paste("clase_04/tablero",Sys.time())
ruta<-gsub(" ", "_", gsub(":", "", ruta, fixed = TRUE), fixed = TRUE)
dir.create(ruta)
p_o<-par()
i<-1
for (v in variables) {
  if(tipoDato[[i]]=="factor"){
    jpeg(gsub(" ","",paste(ruta,"/",v,".jpg")),width = 800)
    par(mfrow=c(1,2))
    cuadro<-table(df.desa[,v])
    barplot(cuadro)
    etiquetas<-paste(round((cuadro/margin.table(cuadro))*100,2),"% ",names(cuadro))
    pie(cuadro/margin.table(cuadro), labels = etiquetas)
    dev.off()
  }else{
    jpeg(gsub(" ","",paste(ruta,"/",v,".jpg")),width = 800)
    par(mfrow=c(1,2))
    hist(df.desa[,v], xlab = v)
    boxplot(df.desa[,v])
    dev.off()
  }
  i<-i+1
}
p_o

#================================
#Analisis Bivar  ~ target vs variable
#================================

tbl<-table(df.desa$Exited,df.desa$Gender)
tbl
tblp<-tbl[2,]/table(df.desa$Gender)
tblp
nx=names(tblp)
nx
barplot(tbl,names.arg=nx)
par(new=TRUE)
#plot(tblp,col="red",type="l")
plot(tblp, col="red",type="l",ylab="",xlab="",axes=FALSE)
axis(4)
p_o

#-------------- dato continuo
df<-na.omit(df.desa$Age)
d_var<-as.integer(cut(df,
                    quantile(df, 
                    probs = 0:10/10,
                    include.lowest=TRUE)))
d_var
barplot(table(d_var))


i<-1
for (v in variables) {
  if(tipoDato[[i]]=="factor"){
    jpeg(gsub(" ","",paste(ruta,"/",v,"_bi.jpg")),width = 800)
    tbl<-table(df.desa[,"Exited"],df.desa[,v])
    tblp<-tbl[2,]/table(df.desa[,v])
    nx=names(tblp)
    barplot(tbl,names.arg=nx)
    #cuadro<-table(df.desa[,v])
    #barplot(cuadro)
    par(new=TRUE)
    plot(tblp, col="red",type="l",ylab="",xlab="",axes=FALSE)
    axis(4)
    dev.off()
  }else{
    df<-na.omit(df.desa[,v])
    d_var<-as.integer(cut(df,
                          unique(quantile(df, 
                          probs = 0:10/10,
                          include.lowest=TRUE))))
    jpeg(gsub(" ","",paste(ruta,"/",v,"_bi.jpg")),width = 800)
    tbl<-table(df.desa[,"Exited"],d_var)
    #tbl
    tblp<-tbl[2,]/table(d_var)
    #tblp
    nx=names(tblp)
    #nx
    barplot(tbl,names.arg=nx)
    #cuadro<-table(df.desa[,v])
    #barplot(cuadro)
    par(new=TRUE)
    plot(tblp, col="red",type="l",ylab="",xlab="",axes=FALSE)
    axis(4)
    dev.off()
  }
  i<-i+1
}
dev.off()
p_o


#Indicadores Estadisticos

idx=c(0)
td=c(0)
me=c(0)
md=c(0)
min=c(0)
max=c(0)
var=c(0)
sd=c(0)
cv=c(0)
q1=c(0)
q3=c(0)
i<-1

for(v in variables) {
  idx[i]<-i
  td[i]<-tipoDato[[i]]
  df<-na.omit(df.desa[,v])
  if(tipoDato[[i]]!="factor"){
    me[i]<-mean(df)
    md[i]<-median(df)
    min[i]<-min(df)
    max[i]<-max(df)
    var[i]<-var(df)
    sd[i]<-sd(df)
    cv[i]<-sd(df)/mean(df)
    q1[i]<-quantile(df)[[2]]
    q3[i]<-quantile(df)[[4]]
  }else{
    me[i]<-""
    md[i]<-""
    min[i]<-""
    max[i]<-""
    var[i]<-""
    sd[i]<-""
    cv[i]<-""
    q1[i]<-""
    q3[i]<-""
  }
  i<-i+1
}
resultados<-data.frame(idx,variables,td,me,md,min,max,var,sd,cv,q1,q3)

html<-"<html><title>Entendimiento de Datos</title><body>"
html<-paste(html,
            "<table border=1><thead><tr>",
            "<th>Nro</th>",
            "<th>Variable</th>",
            "<th>Analisis Univariado</th>",
            "<th>Analisis Bivariado</th>",
            "</tr></thead>")
for(i in 1:nrow(resultados)){
  fila<-paste("<tr>",
              "<td>",resultados[i,"idx"],"</td>",
              "<td>",
              "<b>",resultados[i,"variables"],"</b>",
              "<ul>",
              "<li>Tipo:",resultados[i,"td"],"</li>",
              "<li>Media:",resultados[i,"me"],"</li>",
              "<li>Mediana:",resultados[i,"md"],"</li>",
              "<li>Minimo:",resultados[i,"min"],"</li>",
              "<li>Maximo:",resultados[i,"max"],"</li>",
              "<li>Varianza:",resultados[i,"var"],"</li>",
              "<li>Desv St:",resultados[i,"sd"],"</li>",
              "<li>Coef. Var:",resultados[i,"cv"],"</li>",
              "<li>Q1:",resultados[i,"q1"],"</li>",
              "<li>Q3:",resultados[i,"q3"],"</li>",
              "</ul>",
              "</td>",
              "<td><img src='",gsub(" ","",paste(resultados[i,"variables"],".jpg'"), fixed = TRUE),
              "width='600'></td>",
              "<td><img src='",gsub(" ","",paste(resultados[i,"variables"],"_bi.jpg'"), fixed = TRUE),
              "width='600'></td>",
              "</tr>")
  html<-paste(html,fila)#resultados[i,"td"]
}
html<-paste(html,"</body>")
fileConn<-file(gsub(" ","",paste(ruta,"/output1.html")))
writeLines(html, fileConn)
close(fileConn)
