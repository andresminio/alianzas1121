#Alianzas Argentina 2011-2021  
#Cargar libraries
library(tidyverse)
library(arm) 
library(ergm)
library(statnet)
library(foreign)
library(igraph)

Data1<-read_csv(".csv")


T <- Data1[,1:53]
T<- as.matrix(T)
Tt<-t(T)%*%T

# Abrimos un objeto Tiff para guardar el grafico
net<-graph.adjacency(Tt,mode="undirected",weighted=TRUE,diag=FALSE) 
summary(net)

#Agrega el "count" de colaboracion para ponderar cuan frecuentemente cooperan
E(net)$weight
V(net)
tiff(filename = "alianzas15.tiff", width = 8, height = 8, units = "in", pointsize = 14, compression = c("none"), bg = "white", res =800)
plot.igraph(net,vertex.label=V(net)$name, layout=layout.fruchterman.reingold, vertex.color=factor(V(net)), vertex.size=log(diag(Tt)), edge.width=E(net)$weight/4, vertex.label.cex=log(diag(Tt))/5, edge.curved=TRUE, edge.lty=3, edge.width=.3, edge.color=gray(.8), vertex.label.dist=rnorm(length(V(net)),.2,.03))
dev.off()

#guarda la matriz de datos
write.csv(Tt, file="matriz15.csv", row.names=F) 
