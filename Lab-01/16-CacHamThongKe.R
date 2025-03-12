# Thống kê và Mô hình trong R

# Thiết lập môi trường
Sys.setlocale("LC_ALL", "English")
Sys.setenv(LANGUAGE = "en")

# 3 Thống kê cơ bản
# 3.1 Các hàm thống kê trong R
# 
# str()	Kiểm tra cấu trúc dữ liệu	str(df)
# min()	Giá trị nhỏ nhất	min(x, na.rm = TRUE)
# max()	Giá trị lớn nhất	max(x, na.rm = TRUE)
# mean()	Giá trị trung bình	mean(x, na.rm = TRUE)
# median()	Giá trị trung vị	median(x, na.rm = TRUE)
# quantile()	Phân vị (theo tỷ lệ %)	quantile(x, 0.25, na.rm = TRUE)
# IQR()	Khoảng tứ phân vị	IQR(x, na.rm = TRUE)
# sd()	Độ lệch chuẩn	sd(x, na.rm = TRUE)
# var()	Phương sai	var(x, na.rm = TRUE)

# 3.2 Sử dụng dữ liệu mẫu
# Sử dụng dữ liệu airquality có sẵn trong R
data(airquality)

# Hiển thị một số dòng đầu tiên
head(airquality)

# Xem cấu trúc dữ liệu
str(airquality)

# Xêm thông tin tổng quát
summary(airquality)

# 3.3 Tính giá trị nhỏ nhất và lớn nhất
# Giá trị nhỏ nhất của Ozone
min_ozone <- min(airquality$Ozone, na.rm = TRUE)
min_ozone

# Giá trị lớn nhất
max_ozone <- max(airquality$Ozone, na.rm = TRUE)

# Hiển thị đồng thời giá trị lớn nhất và nhỏ nhất
range(airquality$Ozone, na.rm = TRUE)

# 3.4 Tính trung bình và trung vị
# Trung bình của Ozone
mean_ozone <- mean(airquality$Ozone, na.rm = TRUE)
mean_ozone

# Cắt bớt một đoạn
mean(airquality$Ozone, na.rm=TRUE, trim = 0.1)

# Trung vị của Ozone
median_ozone <- median(airquality$Ozone, na.rm = TRUE)
median_ozone

# 3.5 Tính phân vị và khoảng tứ phân vị
Phân vị (Percentile)
# Phân vị thứ k (ký hiệu Pk) là giá trị mà dưới đó có k% số quan sát trong tập dữ liệu.
# Ví dụ:
# Phân vị thứ 25 (P25): 25% số quan sát có giá trị nhỏ hơn hoặc bằng P25
# Phân vị thứ 50 (P50): 50% số quan sát có giá trị nhỏ hơn hoặc bằng P50 (chính là trung vị)
# Phân vị thứ 75 (P75): 75% số quan sát có giá trị nhỏ hơn hoặc bằng P75

Khoảng tứ phân vị (Quartiles)
# Khoảng tứ phân vị chia dữ liệu thành bốn phần bằng nhau:
# Tứ phân vị thứ nhất (Q1): Chính là phân vị thứ 25 (P25). Là giá trị mà 25% số quan sát có giá trị nhỏ hơn hoặc bằng nó.
# Tứ phân vị thứ hai (Q2): Chính là phân vị thứ 50 (P50) hay trung vị. Là giá trị mà 50% số quan sát có giá trị nhỏ hơn hoặc bằng nó.
# Tứ phân vị thứ ba (Q3): Chính là phân vị thứ 75 (P75). Là giá trị mà 75% số quan sát có giá trị nhỏ hơn hoặc bằng nó.
# Khoảng tứ phân vị (IQR - Interquartile Range): Là khoảng cách giữa tứ phân vị thứ nhất và tứ phân vị thứ ba. IQR = Q3 - Q1.


# Phân vị 25%
Q1 <- quantile(airquality$Ozone, 0.25, na.rm=TRUE)
Q1

# Phân vị 50% (Q2 - Trung vị)
Q2 <- quantile(airquality$Ozone, 0.5, na.rm = TRUE)
Q2

# Phân vị 75% (Q3)
Q3 <- quantile(airquality$Ozone, 0.75, na.rm = TRUE)
Q3

# Tính tất cả phân vị cùng lúc
quantile(airquality$Ozone, probs = c(0, 0.25, 0.5, 0.75, 1), na.rm=TRUE)


# IQR
Q3-Q1
IQR_ozone <- IQR(airquality$Ozone, na.rm=TRUE)
IQR_ozone

# 3.6 Độ lệch chuẩn và phương sai

# Phương sai (Variance)
# Phương sai đo lường mức độ phân tán trung bình của các điểm dữ liệu so với giá trị trung bình của chúng.
# Công thức phương sai mẫu:
#   
# σ² = Σ(x - μ)²/n (cho tổng thể)
# s² = Σ(x - x̄)²/(n-1) (cho mẫu)
# 
# Trong đó:
#   
# x là giá trị của từng quan sát
# μ (hoặc x̄) là giá trị trung bình
# n là số lượng quan sát
# Σ là ký hiệu tổng
# Độ lệch chuẩn (Standard Deviation)
# Độ lệch chuẩn là căn bậc hai của phương sai. Nó có cùng đơn vị đo với dữ liệu gốc, nên dễ hiểu và sử dụng hơn.
# Công thức độ lệch chuẩn:
#   
# σ = √σ² (cho tổng thể)
# s = √s² (cho mẫu)

# Độ lệch chuẩn của Ozone
sd_ozone <- sd(airquality$Ozone, na.rm=TRUE)
sd_ozone

# Phương sai của Ozone
var_ozone <- var(airquality$Ozone, na.rm=TRUE)
var_ozone

sd_ozone^2

# 3.7 Tính toán tự động cho nhiều biến
lapply(airquality[,1:4], mean, na.rm=TRUE)

lapply(airquality[,1:4], sd, na.rm=TRUE)

# 3.8 Sử dụng package
# Cài đặt: install.packages("package_name")
# Sử dụng: library("package_name")
install.packages("pastecs")
library(pastecs)

# Tổng hợp thống kê cho 3 cột đầu tiên
stat.desc(airquality[,1:3])

# Làm tròn kết quả cho dễ đọc
round(stat.desc(airquality[,1:3]), 2)
