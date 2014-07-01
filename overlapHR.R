#######################################################################################################
#
# overlapHR
# A R code to automate animals home range estimates and overlap based on minimum convex polygon method
#
#
########################################################################################################

#######################################################################################################
# These lines of code are product of the Neotropical Lizard Behavioral Ecology-NeoLiBE group from Brazil
#
# By Daniel C. Passos and Conrado A. B. Galdino 
# Version v1.0rc1; October 2013
# Reviewed: 07 May 2014
# Last Review: 01 July 2014
#
#########################################################################################################

#########################################################################################################################
# ATTENTION: You are free to use, modify and forward this code under the GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007 :)  ########################################################################################################################

#######################################################################################################
#  ACKNOWLEDGMENTS:
#
#  We are grateful to Augusto Ribas for providing the code on HR overlap http://r-sig-ecology.471788.n2.nabble.com/Estimating-HR-overlap-by-adehabitatHR-td7409589.html
#
#  CABG Thanks Fundação de Amparo à Pesquisa do Estado de Minas Gerais-FAPEMIG for the support
#
#########################################################################################################



#ATTENTION: This code is only able to calculate polygons area, inspect your point database for any conformation that did not forms a polygon, such as a line :D

#############################
#Citation advice
#############################

print("If you need to cite this code please use: Passos, D. C; Galdino C. A. B; Rocha, C. F. D. 20XX. Challenges and perspectives for studies on home range of Brazilian lizards. South American Jour. Herpetol. xx:yy-zz")
cat ("Just press [enter] again")
readline();
print("&")
print(citation("adehabitatHR"))
cat ("Just press [enter] again")
readline();


####################################################
#Routine for check install and load “rgeos” package #
###################################################

if(is.element('rgeos', installed.packages()[,1]) == FALSE) {
	install.packages('rgeos') 
}else(is.element('rgeos', installed.packages()[,1]) == TRUE)
{print("You already have installed the rgeos package!")
}

#cat ("Press [enter] please")
#readline();
repeat 
{
print("Do you want to load rgeos at this time?[y] or [n]")
a=scan(what=character(),nmax=1);

if(a=="y"){
	print("Loading the package")
	library('rgeos')
	print("rgeos package is ready to use")
	print("next time you need to load rgeos package please do it manually");
break;
}else if (a=="n"){
	print("Ok, maybe you consider to do it later")
break;

}else {print("Please type lower case y or n")

}
}


###########################################################
#Routine to check install and load “adehabitatHR” package #
##########################################################

if(is.element('adehabitatHR', installed.packages()[,1]) == FALSE) {
	install.packages('adehabitatHR') 
}else {is.element('adehabitatHR', installed.packages()[,1]) == TRUE}
{print("You already have installed the adehabitatHR package!")
}
#cat ("Press [enter] please")
#readline();
repeat
{
print("Do you want to load adehabitatHR at this time?[y] or [n]")
cat(" "); b=scan(what=character(),nmax=1);
if(b=="y"){ 
	print("Loading adehabitatHR package")
	library('adehabitatHR')
	cat ("Just press [enter] again")
	readline();
	print("adehabitatHR is ready to use")
	print("next time you need to load adehabitatHR please do it manually")
break;
}else if (b=="n"){
	print("Ok, maybe you consider to do it later")
break;
}else {print("Please type lower case y or n")
}
}

######################
#Loading data into R 
#ATTENTION: We are assuming that the data file (here named spatdata.csv) have a colection of  x and y points for each individual; we recommend you to see and run this code with the the example file spatdata.csv"
# ATTENTION: The package adehabitatHR will not generate polygons if you have less than 5 points per individual
######################

pointdata = read.csv("spatdata.csv", header=TRUE, sep=",")  # pay spetial attention in the type of columm separator you're using here we used "," you can change it accordling.

print(pointdata) # inspecting the object “pointdata”
 

###############################
#Setting spatial coordinates #
##############################
 
locations=data.frame(pointdata$x,pointdata$y)

identities=data.frame(pointdata$id)

coordinates(identities)<-locations

###################################################################################################################
#Generating home ranges R object for each individual in a sample and asking for show and write a file with HR data#
###################################################################################################################

hranges=mcp(identities, percent=95, unin='m', unout='m2')    # Generates the object “hranges” that contains the home range estimates in squared meters for each individual.

hranges.df=as.data.frame(hranges)

print("Do you want to see values of home ranges? [y] or [n]")
cat ("press y if yes or n if you don't: ")
print("Press [enter], please!")
cat(" "); c=scan(what=character(),nmax=1);
repeat
{
if(c=="y"){ 
	print(hranges.df)	
	print("Check in your work folder for HRanges.csv file")
	write.csv(hranges.df, "HRanges.csv")
break;
}else if(c=="n"){
	print("Ok, maybe you consider to do it later")
break;
}else{ print("Please type lower case y or n")
}
}
########################################################
#Asking to print the plot with the home ranges
########################################################

print("Do you want to see the plot of the home ranges?")
cat ("press y if yes or n if you don't: ")
print("Press [enter], please!")
cat(" "); c=scan(what=character(),nmax=1);
repeat
{
if(c=="y"){ 
	plot(hranges)
break;
}else if(c=="n"){
	print("Ok, maybe you consider to do it later")
break;
}else{ print("Please type lower case y or n")
}
}
###########################################################################################################
#Generating the matrix with the ABSOLUTE values of pairs of individuals ranges overlaps 
###########################################################################################################

abs_Matrix=matrix(NA, abs(length(levels(pointdata$id))), abs(length(levels(pointdata$id))), dimnames=list(c(levels(pointdata$id)),c(levels(pointdata$id))))


for(i in 1:abs(length(levels(pointdata$id)))){
for(j in 1:abs(length(levels(pointdata$id)))){
p1 <- as(hranges@'polygons'[[i]]@'Polygons'[[1]]@'coords',"gpc.poly")
p2 <- as(hranges@'polygons'[[j]]@'Polygons'[[1]]@'coords',"gpc.poly")
abs_Matrix[i,j] <-area.poly(p1)+area.poly(p2)-area.poly(union(p1,p2))
}}
print(abs_Matrix)
print("It will give to you the file with your matrix")
cat ("Press [enter] please")
readline();
print("Check in your work folder for The_Matrix.csv file")
write.csv(abs_Matrix, "The_Matrix.csv")


###########################################################################################################
#Generating the matrix with the RELATIVE values of pairs of individuals ranges overlaps 
###########################################################################################################

rel_Matrix <- matrix(NA, abs(length(levels(pointdata$id))), abs(length(levels(pointdata$id))), dimnames=list(c(levels(pointdata$id)),c(levels(pointdata$id))))
	for(i in 1:abs(length(levels(pointdata$id)))){
               areas.percent<-(abs_Matrix[,i])/hranges$area[i]
               rel_Matrix[,i]<-areas.percent
               }
print(rel_Matrix)
print("It will give to you the file with your matrix of relative vallues")
cat ("Press [enter] please")
readline();
print("Check in your work folder for Rel_Matrix.csv file")
write.csv(rel_Matrix, "rel_Matrix.csv")

