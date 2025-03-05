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
plot(lifePLDE[lifePLDE$Country=="Poland", "Year"],
     lifePLDE[lifePLDE$Country=="Poland", "Life.expectancy"],
     ylim=c(73, 90)
)
lines(lifePLDE[lifePLDE$Country=="Germany", "Year"],
      lifePLDE[lifePLDE$Country=="Germany", "Life.expectancy"])

# 2.4 Thay đổi loại biểu đồ và kiểu đường
# Tiếp theo, chúng ta sẽ thay đổi biểu đồ từ điểm sang đường và tùy chỉnh kiểu đường:
plot(lifePLDE[lifePLDE$Country=="Poland", "Year"],
     lifePLDE[lifePLDE$Country=="Poland", "Life.expectancy"],
     ylim=c(73, 90),
     type = "l", # "Vẽ đường thay vì điểm",
     lty = 2 # đường đứt khúc  
)
lines(lifePLDE[lifePLDE$Country=="Germany", "Year"],
      lifePLDE[lifePLDE$Country=="Germany", "Life.expectancy"],
      lty=4 # kiểu đường chấm dài
)

# 2.5 Thêm chú thích (legend)
# Thêm chú thích để phân biệt giữa hai đường:
plot(lifePLDE[lifePLDE$Country=="Poland", "Year"],
     lifePLDE[lifePLDE$Country=="Poland", "Life.expectancy"],
     ylim=c(73, 90),
     type = "l", # "Vẽ đường thay vì điểm",
     lty = 2 # đường đứt khúc  
)
lines(lifePLDE[lifePLDE$Country=="Germany", "Year"],
      lifePLDE[lifePLDE$Country=="Germany", "Life.expectancy"],
      lty=4 # kiểu đường chấm dài
)

# Thêm chú thích
legend("topright", # Vị trí
       c("Poland", "Germany"),
       lty = c(2,4)
)

# 2.6 Thêm tiêu đề trục, tiêu đề chính
# Bây giờ chúng ta thêm tiêu đề cho các trục:
plot(lifePLDE[lifePLDE$Country=="Poland", "Year"],
     lifePLDE[lifePLDE$Country=="Poland", "Life.expectancy"],
     ylim=c(73, 90),
     type = "l", # "Vẽ đường thay vì điểm",
     lty = 2, # đường đứt khúc,
     xlab="Year",
     ylab="Life.expectancy",
     main="Life expectancy in PL and DE"
)
lines(lifePLDE[lifePLDE$Country=="Germany", "Year"],
      lifePLDE[lifePLDE$Country=="Germany", "Life.expectancy"],
      lty=4 # kiểu đường chấm dài
)

# Thêm chú thích
legend("topright", # Vị trí
       c("Poland", "Germany"),
       lty = c(2,4)
)


# 2.8 Thêm đường dọc, text
plot(lifePLDE[lifePLDE$Country=="Poland", "Year"],
     lifePLDE[lifePLDE$Country=="Poland", "Life.expectancy"],
     ylim=c(73, 90),
     type = "l", # "Vẽ đường thay vì điểm",
     lty = 2, # đường đứt khúc,
     xlab="Year",
     ylab="Life.expectancy",
     main="Life expectancy in PL and DE"
)
lines(lifePLDE[lifePLDE$Country=="Germany", "Year"],
      lifePLDE[lifePLDE$Country=="Germany", "Life.expectancy"],
      lty=4 # kiểu đường chấm dài
)

# Thêm chú thích
legend("topright", # Vị trí
       c("Poland", "Germany"),
       lty = c(2,4)
)

# Thêm một đường dọc để đánh dấu một năm cụ thể (ví dụ: 2004 - Ba Lan gia nhập EU):
abline(v=2004, lty=3, col ="red")

# Ghi text
text(2002, 76.5, labels=c("Poland in EU"))

# 2.10 Thêm mũi tên
# Thêm một mũi tên để chỉ đến sự kiện:

plot(lifePLDE[lifePLDE$Country=="Poland", "Year"], 
     lifePLDE[lifePLDE$Country=="Poland", "Life.expectancy"], 
     ylim = c(73, 90), 
     type = "l", 
     lty = 2,
     xlab = "Year", 
     ylab = "Life expectancy")

lines(lifePLDE[lifePLDE$Country=="Germany", "Year"], 
      lifePLDE[lifePLDE$Country=="Germany", "Life.expectancy"], 
      lty = 4)

legend("topleft", c("Poland", "Germany"), lty = c(2, 4))
title("Life expectancy in Poland and in Germany")
abline(v = 2004, lty = 3, col = "lightblue4")
text(2002, 76.5, labels = c("Poland in EU"))

# Thêm mũi tên
arrows(2002, 76, 2004, 75, col="lightskyblue3")

# 2.11 Thay đổi màu đường
plot(lifePLDE[lifePLDE$Country=="Poland", "Year"], 
     lifePLDE[lifePLDE$Country=="Poland", "Life.expectancy"], 
     ylim = c(73, 90), 
     type = "l", 
     lty = 2,
     xlab = "Year", 
     ylab = "Life expectancy", 
     col = "red")  # Màu cho đường Ba Lan

lines(lifePLDE[lifePLDE$Country=="Germany", "Year"], 
      lifePLDE[lifePLDE$Country=="Germany", "Life.expectancy"], 
      lty = 4, 
      col = "blue")  # Màu cho đường Đức

# Cập nhật chú thích với màu sắc mới
legend("topleft", c("Poland", "Germany"), 
       lty = c(2, 4), 
       col = c("red", "blue"))

title("Life expectancy in Poland and in Germany")
abline(v = 2004, lty = 3, col = "yellow")
text(2002, 76.5, labels = c("Poland in EU"))
arrows(2002, 76, 2004, 75, col = "green")


# 2.12 Thay đổi độ dày đường
# Điều chỉnh độ dày của các đường:
plot(lifePLDE[lifePLDE$Country=="Poland", "Year"], 
     lifePLDE[lifePLDE$Country=="Poland", "Life.expectancy"], 
     ylim = c(73, 90), 
     type = "l", 
     lty = 2,
     xlab = "Year", 
     ylab = "Life expectancy", 
     col = "red",
     lwd = 2
     )  # Màu cho đường Ba Lan

lines(lifePLDE[lifePLDE$Country=="Germany", "Year"], 
      lifePLDE[lifePLDE$Country=="Germany", "Life.expectancy"], 
      lty = 4, 
      col = "blue",
      lwd=2)  # Màu cho đường Đức

# Cập nhật chú thích với màu sắc mới
legend("topleft", c("Poland", "Germany"), 
       lty = c(2, 4), 
       col = c("red", "blue"), 
       lwd=2)

title("Life expectancy in Poland and in Germany")
abline(v = 2004, lty = 3, col = "brown", lwd=4)
text(2002, 76.5, labels = c("Poland in EU"))
arrows(2002, 76, 2004, 75, col = "green", lwd=3)

# 2.13 Thêm điểm đánh dấu
# Thêm điểm đặc biệt để đánh dấu một giá trị cụ thể:
max_le_germany <- max(lifePLDE[lifePLDE$Country=="Germany", "Life.expectancy"])
max_le_germany

year_max_le <- lifePLDE[lifePLDE$Country=="Germany" 
                        & lifePLDE$Life.expectancy==max_le_germany,
                        "Year"]
year_max_le

plot(lifePLDE[lifePLDE$Country=="Poland", "Year"], 
     lifePLDE[lifePLDE$Country=="Poland", "Life.expectancy"], 
     ylim = c(73, 90), 
     type = "l", 
     lty = 2,
     xlab = "Year", 
     ylab = "Life expectancy", 
     col = "red",
     lwd = 2
)  # Màu cho đường Ba Lan

lines(lifePLDE[lifePLDE$Country=="Germany", "Year"], 
      lifePLDE[lifePLDE$Country=="Germany", "Life.expectancy"], 
      lty = 4, 
      col = "blue",
      lwd=2)  # Màu cho đường Đức

# Cập nhật chú thích với màu sắc mới
legend("topleft", c("Poland", "Germany"), 
       lty = c(2, 4), 
       col = c("red", "blue"), 
       lwd=2)

title("Life expectancy in Poland and in Germany")
abline(v = 2004, lty = 3, col = "brown", lwd=4)
text(2002, 76.5, labels = c("Poland in EU"))
arrows(2002, 76, 2004, 75, col = "green", lwd=3)

# Them diem danh dau gia tri cau nhat
points(x=year_max_le, y=max_le_germany, pch=19, col="red")

# 2.15 Thay đổi hướng nhãn trục
# Thay đổi hướng các nhãn trục để dễ đọc hơn:

max_le_germany <- max(lifePLDE[lifePLDE$Country=="Germany", "Life.expectancy"])
max_le_germany

year_max_le <- lifePLDE[lifePLDE$Country=="Germany" 
                        & lifePLDE$Life.expectancy==max_le_germany,
                        "Year"]
year_max_le

plot(lifePLDE[lifePLDE$Country=="Poland", "Year"], 
     lifePLDE[lifePLDE$Country=="Poland", "Life.expectancy"], 
     ylim = c(73, 90), 
     type = "l", 
     lty = 2,
     xlab = "Year", 
     ylab = "Life expectancy", 
     col = "red",
     lwd = 2,
     las =1 #  # Hướng nhãn: 0=song song, 1=ngang, 2=vuông góc, 3=dọc
)  # Màu cho đường Ba Lan

lines(lifePLDE[lifePLDE$Country=="Germany", "Year"], 
      lifePLDE[lifePLDE$Country=="Germany", "Life.expectancy"], 
      lty = 4, 
      col = "blue",
      lwd=2)  # Màu cho đường Đức

# Cập nhật chú thích với màu sắc mới
legend("topleft", c("Poland", "Germany"), 
       lty = c(2, 4), 
       col = c("red", "blue"), 
       lwd=2)

title("Life expectancy in Poland and in Germany")
abline(v = 2004, lty = 3, col = "brown", lwd=4)
text(2002, 76.5, labels = c("Poland in EU"))
arrows(2002, 76, 2004, 75, col = "green", lwd=3)

# Them diem danh dau gia tri cau nhat
points(x=year_max_le, y=max_le_germany, pch=19, col="red")




