#######################################################################################################
#
# HunteR
# A R code to automate animals home range estimates and overlap based on minimum convex polygon method
#
#
########################################################################################################

#######################################################################################################
# These lines of code are product of the Neotropical Lizards Behavioral Ecology -- NeoLiBE group from Brazil
#
# By Daniel C. Passos and Conrado A. B. Galdino
# Version v1.04; 
# Former reviews: v1.03 in 03 July 2014
#Last review: 29 September 2019; 15 October 2015
#
#########################################################################################################

#########################################################################################################################
# ATTENTION: You are free to use, modify and forward this code under the GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007 :) ########################################################################################################################

#######################################################################################################
# ACKNOWLEDGMENTS:
#
# We are grateful to Augusto Ribas for providing the code on HR overlap http://r-sig-ecology.471788.n2.nabble.com/Estimating-HR-overlap-by-adehabitatHR-td7409589.html
#
# CABG Thanks Fundação de Amparo à Pesquisa do Estado de Minas Gerais-FAPEMIG for the support
#
#########################################################################################################



#ATTENTION: This code is only able to calculate polygons area, inspect your point database for any conformation that did not forms a polygon, such as a line :D



################
#Welcome message
################
cat(rep("\n",64)) #Writes empty lines to give the sense of a clean screen
writeLines("")
print("#####################")
print("Welcome to HunteR!")
print("#####################")
writeLines("")
cat ("Just press [enter] to start this script")
  readline();
writeLines("")


###################################################
#Routine to check install and load “rgeos” package 
###################################################

print("Checking for the required rgeos package")
cat ("Just press [enter]")
  readline();
writeLines("")
if (is.element('rgeos', installed.packages()[, 1]) == FALSE) {
  print("Let's install now the package")
  install.packages('rgeos')
} else (is.element('rgeos', installed.packages()[, 1]) == TRUE)
  {
  print("You already have installed the rgeos package!")
  }
writeLines("")

#Check if the user want to load package rgeos

repeat {
print("Do you want to load rgeos at this time?[y] or [n]")
a <- scan(what = character(), nmax = 1);
while (length(a) == 0) {
  print("Do you want to load rgeos at this time?[y] or [n]")
  a <- scan(what = character(), nmax = 1);
}
if (a == "y") {
  print("Loading the package")
  library('rgeos')
  print("rgeos package is ready to use")
  writeLines("")
  print("next time you need to load rgeos package please do it manually");
break;
} else if (a == "n") {
  writeLines("")
  print("Ok, maybe you consider to do it later")
  writeLines("")
break;
} else { 
  print("Please type lower case y or n")
  cat("Just press [enter] again")
  readline();
}
}


##########################################################
#Routine to check install and load “adehabitatHR” package 
##########################################################

print("Checking for the required adehabitatHR package")
cat ("Just press [enter]")
  readline();
if (is.element('adehabitatHR', installed.packages()[, 1]) == FALSE) {
  print("Let's install now the package")
  install.packages('adehabitatHR')
} else (is.element('adehabitatHR', installed.packages()[, 1]) == TRUE)
  {
  print("You already have installed the adehabitatHR package!")
  }

#Check if user want to load package adehabitatHR

repeat {
print("Do you want to load adehabitatHR at this time?[y] or [n]")
cat(" "); b <- scan(what = character(),nmax = 1);
while (length(b) == 0) {
  print("Do you want to load rgeos at this time?[y] or [n]")
  b <- scan(what = character(), nmax = 1); 
  }
if (b == "y") {
  print("Loading adehabitatHR package")
  library('adehabitatHR')
  cat ("Just press [enter] again")
  readline();
  print("adehabitatHR is ready to use")
  writeLines("")
  print("next time you need to load adehabitatHR please do it manually")
  writeLines("")
break;
} else if (b == "n") {
  writeLines("")
  print("Ok, maybe you consider to do it later")
  writeLines("")
break;
} else {
  print("Please type lower case y or n")
  cat("Just press [enter] again")
  readline();
  }
}

#############################
#Citation advice
#############################

repeat {
print("Do you want to see the citations for this code and for used packages? [y] or [n]")
cit <- scan(what = character(), nmax = 1);
while (length(cit) == 0) {
  print("Do you want to load rgeos at this time?[y] or [n]")
  cit <- scan(what = character(), nmax = 1);
}  
if (cit == "y") {
   print("If you need to cite this code please use:"); print("Passos, D. C; Galdino C. A. B; Rocha, C. F. D. 2015. Challenges and Perspectives for Studies on Home Range of Lizards from South America. South American Jour. Herpetol. 10(2):82-89 DOI:10.2994/SAJH-D-14-00023.1")
  cat("Just press [enter] again")
  readline();
  if (is.element('adehabitatHR', installed.packages()[, 1]) == FALSE) {
  print("You haven't installed the package")
} else (print(citation("adehabitatHR")))
  cat ("Just press [enter] again")
  readline();
if (is.element('rgeos', installed.packages()[, 1]) == FALSE) {
  print("You haven't installed the package")
} else (print(citation("rgeos")))
  cat ("Just press [enter] again")
  readline();
break;
} else if (cit == "n") {
  writeLines("")
  print("Ok, maybe you consider to do it later")
  writeLines("")
break;
} else { 
  print("Please type lower case y or n")
  cat("Just press [enter] again")
  readline();
}
}



######################
#Loading data into R
#ATTENTION: We are assuming that the data file (here named spatdata.csv) have a colection of x and y points for each individual; we recommend you to see and run this code with the the example file spatdata.csv"
# ATTENTION: The package adehabitatHR will not generate polygons if you have less than 5 points per individual
######################

pointdata <- read.csv("spatdata.csv", header = TRUE, sep = ",") # pay spetial attention in the type of columm separator you're using. Here we used "," you can change it accordling

#Check if user want to see the object with stored data.

repeat {
print("Do you want to inspect your R object corresponding to your data file?")
print("press y if yes or n if you don't: ")
cat(" "); g <- scan(what = character(), nmax = 1);
while (length(g) == 0) {
  print("Do you want to load rgeos at this time?[y] or [n]")
  g <- scan(what = character(), nmax = 1);
} 
if (g == "y") {
  print(pointdata)	
break;
} else if(g == "n") {
  writeLines("")
  print("Ok, maybe later!")
  writeLines("")
break;
} else { 
  print("Please type lower case y or n")
  cat("Just press [enter] again")
  readline();
  writeLines("")
  }
}
 

#############################
#Setting spatial coordinates 
#############################
 
locations <- data.frame(pointdata$x,pointdata$y)
identities <- data.frame(pointdata$id)
coordinates(identities) <- locations


###################################################################################################################
#Generating home ranges R object for each individual in a sample and asking for show and write a file with HR data
###################################################################################################################

hranges <- mcp(identities, percent = 95, unin = 'm', unout = 'm2') 
hranges.df <- as.data.frame(hranges)


#Check if user want to see estimated home range values

repeat
{
print("Do you want the values of home ranges size?")
print("press y if yes or n if you don't: ")
cat(" "); c <- scan(what = character(), nmax = 1);
while (length(c) == 0) {
  print("Do you want to load rgeos at this time?[y] or [n]")
  c <- scan(what = character(), nmax = 1);
} 
if (c == "y") {
  print(hranges.df)
  cat("This will write a file with results in your disc; press [enter]")
  readline();
  writeLines("")	
  print("Check in your work folder for HRanges.csv file")
  writeLines("")
  write.csv(hranges.df, "HRanges.csv")
break;
} else if (c == "n") {
  writeLines("")
  print("Ok, maybe you consider to do it later")
  writeLines("")
break;
} else { 
  print("Please type lower case y or n")
  cat("Just press [enter] again")
  readline();
  }
}


#############################################################
#Asking for print the plot with the home ranges on the screen 
#############################################################
#Changed in 29/09/19 to plot animals ID's in the HR map

repeat
{
print("Do you want to see the map of the home ranges?")
print("press y if yes or n if you don't: ")
cat(" "); d <- scan(what = character(), nmax = 1);
while (length(d) == 0) {
  print("Do you want to load rgeos at this time?[y] or [n]")
  d <- scan(what = character(), nmax = 1);
} 
if(d == "y"){
  plot(hranges)
  text(coordinates(hranges), labels=sapply(slot(hranges, "polygons"), function(i) slot(i, "ID")), cex=0.6)
break;
} else if (d == "n") {
  print("This will generate the maps without animals' id's")
  writeLines("")
  plot(hranges)
break;
} 
}


###################################################
#Asking for print pdf image with the plot of HR's
###################################################

repeat
{
print("Do you want to write a pdf image of the home ranges?")
print("press y if yes or n if you don't: ")
cat(" "); e <- scan(what = character(), nmax = 1);
while (length(e) == 0) {
  print("Do you want to load rgeos at this time?[y] or [n]")
  e <- scan(what = character(), nmax = 1);
} 
if(e == "y"){
  pdf("homerangeGraph.pdf")
  plot(hranges)
  dev.off()
break;
} else if (e == "n") {
  writeLines("")
  print("Ok, maybe later!")
  writeLines("")
break;
} else { 
  print("Please type lower case y or n")
  cat("Just press [enter] again")
  readline();
  writeLines("")
}
}


##########
#Joking
##########

if (cit== "n" && a == "n" && b == "n" && g == "n" && c == "n" && d == "n") {
  writeLines("")
  print("####################################################")  
  print("Oh, no, no, no, no... You are so negativistic today!")
  print("####################################################") 
  writeLines("")
}
##############################################################################
                       #Asking for the analysis of HR Overlaps
##############################################################################

repeat
{
print("Do you want to proceed with the calculations of Home Ranges overlaps?")
print("press y if yes or n if you don't: ")
cat(" "); ovl <- scan(what = character(), nmax = 1);
while (length(ovl) == 0) {
  print("Do you want to proceed with the calculations of Home Ranges overlaps?[y] or [n]")
  ovl <- scan(what = character(), nmax = 1);
} 
if(ovl == "n"){
  stop("Thank you for using HunteR! The script is ended by you")
break;
}
else if () {
#########################################################################################
#Generating the matrix with the ABSOLUTE values of pairs of individuals ranges overlaps
#########################################################################################
writeLines("")
print("We will now generate the matrix with the 'absolute' overlap values")
cat ("Press [enter] please")
readline();
abs_Matrix <- matrix(NA, abs(length(levels(pointdata$id))), abs(length(levels(pointdata$id))), dimnames = list(c(levels(pointdata$id)), c(levels(pointdata$id))))
for(i in 1 : abs(length(levels(pointdata$id)))){
for(j in 1 : abs(length(levels(pointdata$id)))){
  p1 <- as(hranges@'polygons'[[i]]@'Polygons'[[1]]@'coords',"gpc.poly")
  p2 <- as(hranges@'polygons'[[j]]@'Polygons'[[1]]@'coords',"gpc.poly")
  abs_Matrix[i, j] <- area.poly(p1) + area.poly(p2) - area.poly(union(p1, p2))
}}
print(abs_Matrix)
print("This will give to you the file with your matrix")
cat ("Press [enter] please")
readline();
print("Check in your work folder for The_Matrix.csv file")
write.csv(abs_Matrix, "The_Matrix.csv")


########################################################################################
#Generating the matrix with the RELATIVE values of pairs of individuals ranges overlaps
########################################################################################

writeLines("")
writeLines("")
print("We will now generate the matrix with 'relative' overlap values")
cat ("Press [enter] please")
readline();
rel_Matrix <- matrix(NA, abs(length(levels(pointdata$id))), abs(length(levels(pointdata$id))), dimnames = list(c(levels(pointdata$id)), c(levels(pointdata$id))))
for (i in 1:abs(length(levels(pointdata$id)))) {
               areas.percent <- (abs_Matrix[, i])/hranges$area[i]
               rel_Matrix[, i] <- areas.percent
               }
print(rel_Matrix)
print("This will give to you the file with your matrix of relative values")
cat("Press [enter] please")
readline();
print("Check in your work folder for Rel_Matrix.csv file")
write.csv(rel_Matrix, "rel_Matrix.csv")
writeLines("")
writeLines("")
print("Hope now you have all results needed")
print("end [FIM] of this routine")
stop("HunteR will now sleep, thank you!")
  }
 }
