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
