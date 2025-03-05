Sys.setlocale("LC_ALL","English")
Sys.setenv(LANGUAGE='en')

getwd()
setwd('D:/R-Intro/R-Intro/')

# Reading the data
life <- read.csv("data/dataset - life expectancy/Life Expectancy Data.csv");
head(life)

# set with observations regarding Poland
lifePL <-subset(life, Country=="Poland")

# overview of the whole dataset
View(lifePL)

# set with observations regarding Poland | Germany
lifePLDE <-subset(life, Country=="Poland" | Country == "Germany")
View(lifePLDE)

### Graphics with plot function ####
help("plot")

plot(lifePL$Life.expectancy)

plot(x=lifePL$Year, 
     y=lifePL$Life.expectancy)

# line plot
plot(x=lifePL$Year, 
     y=lifePL$Life.expectancy, 
     type = "l")

# line plot with points
plot(x=lifePL$Year, 
     y=lifePL$Life.expectancy, 
     type = "b")

# step plot
plot(x=lifePL$Year, 
     y=lifePL$Life.expectancy, 
     type = "s")

# changing the range of x variable  
plot(x=lifePL$Year, 
     y=lifePL$Life.expectancy, 
     type = "b",
     xlim=c(2005, 2010))

# changing the range of x and y (zooming the plot) 
plot(x=lifePL$Year, 
     y=lifePL$Life.expectancy, 
     type = "b",
     xlim=c(2005, 2010),
     ylim=c(75, 76.5))

### GDP plot ####
plot(lifePL$Year, lifePL$GDP, type="b")

# adding a title
plot(lifePL$Year, 
     lifePL$GDP, 
     type="b",
     main="GDP in Poland")


# adding a title
plot(lifePL$Year, 
     log(lifePL$GDP), 
     type="b",
     main="GDP in Poland")

# log
plot(lifePL$Year, 
     log(lifePL$GDP),
     type="b",
     main="GDP in Poland",
     sub="GDP values are log-transformed")

plot(lifePL$Year, 
     lifePL$GDP,
     type="b",
     log = "y",
     main="GDP in Poland",
     sub="GDP values are log-transformed")


plot(lifePL$Year, 
     lifePL$GDP,
     type="b",
     log = "y",
     main="GDP in Poland",
     sub="GDP values are log-transformed",
     xlab="Year",
     ylab="log GDP")


### Density plot ###
density(lifePL$Life.expectancy)
plot(density(lifePL$Life.expectancy))

### Bar plot
?barplot
barplot(lifePL$Life.expectancy)
barplot(lifePL$Life.expectancy, ylim=c(0, 80))
barplot(lifePL$Life.expectancy, 
        ylim=c(0, 80),
        col="aquamarine")

### Histogram
?hist
hist(lifePL$Life.expectancy)
hist(lifePL$Life.expectancy, freq = TRUE)
hist(lifePL$Life.expectancy, freq = FALSE)

hist(lifePL$Life.expectancy, breaks = c(50,60,70,80,90))
hist(lifePL$Life.expectancy, breaks = seq(70,80, 2))

# function lines allows to add new lines to the plot
# function points is for adding points

hist(lifePL$Life.expectancy, freq = TRUE)
lines(density(lifePL$Life.expectancy))

hist(lifePL$Life.expectancy, freq = FALSE)
lines(density(lifePL$Life.expectancy))

hist(lifePL$Life.expectancy, freq = FALSE, breaks = seq(70,80, by=1))
lines(density(lifePL$Life.expectancy))

?points


### Box plot
summary(lifePL$Life.expectancy)

boxplot(lifePL$Life.expectancy)

### Summarizing data with group comparison ###
boxplot(lifePLDE$Life.expectancy ~ lifePLDE$Country)
boxplot(life$Life.expectancy ~ life$Country)

boxplot(lifePLDE$Life.expectancy ~ lifePLDE$Country, names=c("DE", "PL")) # Labels for group

boxplot(lifePLDE$Life.expectancy ~ lifePLDE$Country,
        names=c("DE", "PL"),
        xlab="Country",
        ylab="Life expectancy",
        main = "Comparison of life expectancy in Poland and in Germany",
        sub="Values for 2000-2015")

boxplot(lifePLDE$Life.expectancy ~ lifePLDE$Country,
        names=c("DE", "PL"),
        xlab="Country",
        ylab="Life expectancy",
        main = "Comparison of life expectancy in Poland and in Germany",
        sub="Values for 2000-2015",
        col="lightgreen")

### Violin plot
# install.packages("vioplot")
library(vioplot)

vioplot(lifePLDE$Life.expectancy)

vioplot(lifePLDE$Life.expectancy ~ lifePLDE$Country)

ioplot(lifePLDE$Life.expectancy ~ lifePLDE$Country,
       col = "lightgray")

### Dotchart - identification of the outliners

dotchart(lifePL$Life.expectancy)

dotchart(lifePL$Life.BMI)

dotchart(lifePLDE$BMI, groups = factor(lifePLDE$Country))

### Investigating the relations between variables
plot(lifePL)

str(lifePL)
pairs(lifePL[,c("Life.expectancy", "GDP", "Population", "Schooling")])

pairs(lifePL[,c(4,17:18,22)])

pairs(lifePL[,c(4,17:18,22)], panel = panel.smooth)

### Correlation plot
install.packages("PerformanceAnalytics")
library(PerformanceAnalytics)

chart.Correlation(lifePL[,c(4,17:18,22)], histogram = TRUE, pch=19)

install.packages("corrplot")
library(corrplot)

dev.off()
corrplot(cor(lifePL[, c(4,17:18, 22)]))
corrplot(cor(lifePL[, c(4,17:18, 22)]), type = "lower", order = "hclust")
corrplot(cor(lifePL[, c(4,17:18, 22)]), type = "upper", order = "hclust",
         method = "number", add = TRUE)

corrplot.mixed(cor(lifePL[, c(4,17:18, 22)]), upper = "number", 
               lower = "circle", order = "alphabet")

### Additional resources 
# https://rstudio-pubs-static.s3.amazonaws.com/84527_6b8334fd3d9348579681b24d156e7e9d.html

# https://ramnathv.github.io/pycon2014-r/visualize/base_graphics.html

# https://statsandr.com/blog/descriptive-statistics-in-r/#mosaic-plot


