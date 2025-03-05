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

# Tạo dữ liệu giả định về tuổi thọ ở Poalnd và Đức từ 2000-2015
set.seed(123)
years <- 2000:2015

lifePL <- data.frame(
  Country = rep("Poland", 16),
  Year = years,
  Life.expectancy = 73 +(years-2000)*0.2+rnorm(16,0, 0.3)
)

lifeDE <- data.frame(
  Country = rep("Germany", 16),
  Year = years,
  Life.expectancy = 75+(years-2000)*0.25+rnorm(16,0, 0.3)
)

# Kết hợp dữ liệu 2 quốc gia
lifePLDE <- rbind(lifePL, lifeDE)

# head
head(lifePLDE)

# 2 Phương pháp từng bước để chỉnh sửa biểu đồ
# 2.1 Biểu đồ cơ bản - Lớp đầu tiên
plot(lifePLDE[lifePLDE$Country=="Poland", "Year"],
     lifePLDE[lifePLDE$Country=="Poland", "Life.expectancy"]
     )


# 2.2 Thêm lớp thứ hai
# Bây giờ, chúng ta thêm một đường cho tuổi thọ ở Đức:
plot(lifePLDE[lifePLDE$Country=="Poland", "Year"],
     lifePLDE[lifePLDE$Country=="Poland", "Life.expectancy"]
)
lines(lifePLDE[lifePLDE$Country=="Germany", "Year"],
      lifePLDE[lifePLDE$Country=="Germany", "Life.expectancy"])  

# 2.3 Điều chỉnh phạm vi trục Y
# Chúng ta điều chỉnh phạm vi của trục Y để có thể thấy rõ cả hai đường: