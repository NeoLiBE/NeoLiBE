#Script para construir um gráfico sobre o outro FigXa,b,c

djan=read.csv('djan.csv', header=T, sep=";")
postscript("fig3.eps", width=8.6, height=8.6)
month<-factor(djan$month, levels=c("Sep","Oct","Nov","Dec","Jan","Feb","Mar","Apr","May", "Jun","Jul","Aug"))
par(oma=c(1,12,1,12),mfrow=c(3,1), bty="l", mar=c(1,2,1,2))
tplot(djan$resvte~month,ylab="TV", col.lab="black",cex.lab=1.5,font.lab=2,col.axis="black",cex.axis=1.4,font.axis=2,pch=20,col=1,cex=1.3, xaxt="n")
axis(side = 1, at =month, labels = FALSE, tck = -0.03)
text(1,23, "A", cex=1.8)
tplot(djan$resdts~month,ylab="STD", col.lab="black",cex.lab=1.5,font.lab=2,col.axis="black",cex.axis=1.4,font.axis=2,pch=20,col=1,cex=1.3, xaxt="n")
axis(side = 1, at = month, labels = FALSE, tck = -0.03)
text(1,80, "B", cex=1.8)
tplot(djan$resaeg~month,xlab="Months",ylab="GEH",col.lab="black",cex.lab=1.5,font.lab=2,col.axis="black",cex.axis=1.4,font.axis=2,pch=20,col=1,cex=1.3)
text(1,60, "C", cex=1.8)

dev.off()
