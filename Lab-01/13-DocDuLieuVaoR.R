# Thư mục làm việc
getwd() 

# Windows path: # wd < - "D:\R-Intro\R-Intro"
# transformation1: 
wd <- "D:\\R-Intro\\R-Intro"

# transformation2:
wd<- "D:/R-Intro/R-Intro"

setwd(wd)


path <- "data/notepadData.txt"
path <- "D:/R-Intro/R-Intro/data/notepadData.txt"

table1 <- read.table(path, header = TRUE, sep = " ")
View(table1)

summary(table1$price)

?read.table # Xem trợ giúp


#### other types
water <- read.csv("data/graphics - water quality/water_potability.csv", sep=",", dec=".")
View(water)

head(water)


# Đọc dữ liệu từ excel
install.packages("readxl") # cài đặt thư viện đọc file excel
library(readxl) # sử dụng thư viện

?read_excel

loanEXCEL1 <- read_excel("data/dataset - loan prediction/loan_prediction_excel.xlsx")
loanEXCEL1


loanEXCEL2 <- read_excel("data/dataset - loan prediction/loan_prediction_excel.xlsx", sheet = 2)
loanEXCEL2

loanEXCEL3 <- read_excel("data/dataset - loan prediction/loan_prediction_excel.xlsx", sheet = "LoanPred")
loanEXCEL3

class(loanEXCEL1)

loanEXCEL1 <- as.data.frame(loanEXCEL1)

class(loanEXCEL1)

# Clean the environment from unnecessary files
remove(loanEXCEL3)


### Cách xem và lưu các biến đang tôn tại
ls() # Xem tất các các đối tượng đang có trong bộ nhớ

# Lưu trữ xuống file
save(list = ls(all.names=TRUE), file="data/all.rda")

rm(list = ls(all.names = TRUE)) # cleaning the while memory

# Load data
load("data/all.rda")

# lưu trữ 1 đối tượng
save(loanEXCEL1, file="data/loanEXCEL1_inR.rda")


rm(loanEXCEL1)
loanEXCEL1

load("data/loanEXCEL1_inR.rda")
head(loanEXCEL1)

# lưu trữ 1 đối tượng
save(loanEXCEL1, loanEXCEL2, file="data/loanEXCEL12_inR.rda")


rm(loanEXCEL1)
loanEXCEL1






