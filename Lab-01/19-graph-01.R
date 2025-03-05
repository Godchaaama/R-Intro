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


