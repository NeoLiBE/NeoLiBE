#A R script to estimate home range size and plot home range polygons by minimum convex polygon method
# Code by D. Passos
# Created in 
# Last review: 07 May 2014
# A product of the NeoLiBE Group from Brazil

#Script to estimate home range size and plot home range polygons by minimum convex polygon method in R environment

#---------------------------------------------------------
# 1st Step: Installing and loading “adehabitatHR” package.
#---------------------------------------------------------
 
install.packages(“adehabitatHR”)   # to install “adehabitatHR” package.

library(“adehabitatHR”)      # to load “adehabitatHR” package.
 
#---------------------------------------------------------
# 2nd Step: Loading and viewing the database with spatial points (coordinates x e y) of each individual (id) from a .csv file.
#---------------------------------------------------------
 
data = read.csv(‘dados.csv’, header=T, sep=’;’)                # to load the object “data”.

data                      # to see the object “data”.
 
#---------------------------------------------------------
# 3rd Step: Estimating home range sizes per individual by minimum convex polygon method.
#---------------------------------------------------------
 
locations=data.frame(data$x,data$y)   # to create the data.frame “locations” that contains just the coordinates “x” and “y” from object “data”.

identities=data.frame(data$id)        # to create the data.frame “identities” that contains just the individual names “id” from object “data”.

locations=coordinates(identities)     # to link the objects “locations” and “identities” in spatial class data.

areas=mcp(identities, percent=95, unin='m', unout='m2')   to create the object “areas” that contains the home range estimates for each individual.

areas       # to see the object “areas”.

#---------------------------------------------------------
# 4th Step: Exporting the home range estimates in a .csv file.
#---------------------------------------------------------
 
sink(“home_range.csv”)      # to start the creation of the export file "home_range.csv" in the working directory.

as.data.frame(areas)      # to send the object “areas” to the file “home_range.csv”.

sink()       # to finish the creation of the file "home_range.csv".
 
#---------------------------------------------------------
# 5th Step: Plotting the home range areas by minimum convex polygon method.
#---------------------------------------------------------
 
polygons=plot(areas)       # to create the minimum convex polygons.

polygons           # to see the minimum convex polygons.

#---------------------------------------------------------
# 6th Step: Exporting the minimum convex polygons in a .png file.
#---------------------------------------------------------
png(file=”polygons.png”)  # to start the creation of the export file "polygons.png" in the working directory.

polygons=plot(areas)  # to send the object “polygons” to the file “polígonos.png”.

dev.off()       # to finish the creation of the file "polygons .png".







