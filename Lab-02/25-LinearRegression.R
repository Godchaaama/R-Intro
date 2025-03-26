# thay doi ngon ngu sang English
Sys.setlocale("LC_ALL", "English")
Sys.setenv(LANGUAGE="en")

# Xay dung linear regression model
summary(longley)

# Tom tat
str(longley)

#Ma tran tuong quan giua cac bien
cor(longley)a

cor(longley$GNP, longley$Employed)

# Xay model 1 bien 
model <- lm(GNP~Employed, data=longley)
model

summary(model)

model$coefficients
model$coefficients[[1]]
model$coefficients[[2]]

# Data Frame
model$model

# Xay model 2 bien
model1 <- lm(GNP~Employed+Armed.Forces, data=longley)
summary(model1)

model1$coefficients
model1$coefficients[[1]]
model1$coefficients[[2]]


#=====================
library(MASS)
data(Boston)

str(Boston)

summary(Boston)

# Ve ma tran tuong quan
pairs(Boston)

# Tính ma trận tương quan
correlation<-cor(Boston)
print(correlation["medv", ])

# plot bieu do phan tan giua so phong trung va gia nha
plot(Boston$rm, Boston$medv, 
     xlab="So phong trung binh (rm)",
     ylab="Gia nha trung binh medv",
     main="Moi quan he giua rm va medv",
     abline(lm(medv~rm, data=Boston), col="red"))
