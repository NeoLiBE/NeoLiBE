#A R script to perform calculations of home-range overlap based on MCP method
# Thanks to Augusto Ribas for provide the code
#ATENTION: Requires package rgeos please use: install.packages("rgeos"), first
#ATENTION: This code is able to calculate only polygons areas, look at your database for any forms that is not a polygon, as a line :D


cp <- mcp(idsp[,1], unin="m", unout="m2") #idsp= vector type coordinate used to calculate mpc's
plot(cp) #For a visual inspection of home ranges overlaps
res<-matrix(NA,19,19,dimnames=list(c("12","13","16","17","18","20","22","24","25","26","29","30","31","32","34","35","41","42","43"),
c("12","13","16","17","18","20","22","24","25","26","29","30","31","32","34","35","41","42","43"))) # Make the matrix n x n (dimensions = number of individuals) to receive data of overlaped area 

for(i in 1:19){ #change number of loops to 1:n according to your number of individuals
for(j in 1:19){ #change number of loops to 1:n according to your number of individuals
	p1 <- as(cp@'polygons'[[i]]@'Polygons'[[1]]@'coords',"gpc.poly")
	p2 <- as(cp@'polygons'[[j]]@'Polygons'[[1]]@'coords',"gpc.poly")
	res[i,j] <- area.poly(p1)+area.poly(p2)-area.poly(union(p1,p2))
		}}


#Turn overlaped area to proportion

res2 <- matrix(NA,19,19,dimnames=list(c("12","13","16","17","18","20","22","24","25","26","29","30","31","32","34","35","41","42","43"),
                                   c("12","13","16","17","18","20","22","24","25","26","29","30","31","32","34","35","41","42","43")))
for(i in 1:19) {
               areas.percent<-(res[,i])/cp$area[i]
               res2[,i]<-areas.percent
               }
res2
