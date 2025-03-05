# Phân Phối Xác Suất
# Phân phối xác suất mô tả cách giá trị của biến ngẫu nhiên được phân bố. Có nhiều loại phân phối xác suất, và sự lựa chọn giữa chúng phụ thuộc vào tính chất của dữ liệu và ngữ cảnh của vấn đề.

# 3.1. Các loại phân phối phổ biến
# 3.1.1. Phân phối chuẩn (Normal Distribution)
# Phân phối chuẩn là một trong những 
# phân phối quan trọng nhất, 
# đặc trưng cho nhiều hiện tượng tự nhiên. 
# Nó được mô tả bởi hai tham số: 
# trung bình (mean) và độ lệch chuẩn 
# (standard deviation).

# Tạo mẫu từ phân phối chuẩn
set.seed(123)
normal_sample <- rnorm(n = 1000, mean = 50, sd = 10)

# Vẽ histogram
hist(normal_sample, breaks = 30, main = "Phân phối chuẩn",
     xlab = "Giá trị", col = "blue", border = "white",
     prob = TRUE) # prob = TRUE để hiển thị mật độ xác suất

# Thêm đường cong mật độ xác suất
curve(dnorm(x, mean=50, sd=10), col="red", lwd=2, add=TRUE)

# 3.1.2. Phân phối Poisson (Poisson Distribution)
# Phân phối Poisson được sử dụng để mô tả số sự kiện 
# xảy ra trong một khoảng thời gian hoặc không gian 
# cố định. Nó được mô tả bởi một tham số: lambda 
# (tỷ lệ hoặc cường độ trung bình).
# Tạo mẫu từ phân phối Poisson
set.seed(123)
poisson_sample <- rpois(n=1000, lambda=4)
barplot(table(poisson_sample)/length(poisson_sample),
        main = "Phân phối possion (lambda=4)",
        xlab="Giá trị", ylab = "Xác suất", col="green"
        )

# 3.1.3. Phân phối đều (Uniform Distribution)
# Trong phân phối đều, tất cả các giá trị trong 
# khoảng có xác suất xuất hiện bằng nhau. 
# Nó được mô tả bởi hai tham số: 
# giá trị nhỏ nhất (min) và giá trị lớn nhất (max).
# Tạo mẫu từ phân phối đều
set.seed(123)
uniform_sample <- runif(n = 1000, min = 0, max = 1)

# Vẽ histogram
hist(uniform_sample, breaks = 30, main = "Phân phối đều",
     xlab = "Giá trị", col = "red", border = "white",
     prob = TRUE)

# Thêm đường lý thuyết
abline(h = 1, col = "blue", lwd = 2)


# 3.1.4. Phân phối mũ (Exponential Distribution)
# Phân phối mũ thường được sử dụng để mô tả thời
# gian giữa các sự kiện xảy ra theo quy luật mũ. 
# Nó được mô tả bởi một tham số: tỷ lệ (rate).
# Tạo mẫu từ phân phối mũ
set.seed(123)
exponential_sample <- rexp(n = 1000, rate = 0.2)

# Vẽ histogram
hist(exponential_sample, breaks = 30, main = "Phân phối mũ",
     xlab = "Giá trị", col = "orange", border = "white",
     prob = TRUE)

# Thêm đường lý thuyết
curve(dexp(x, rate = 0.2), col = "blue", lwd = 2, add = TRUE)

# Chọn Mẫu Ngẫu Nhiên
# Chọn mẫu ngẫu nhiên đóng một vai trò cực kỳ quan trọng trong nghiên cứu thống kê và phân tích dữ liệu. Đây là một phương pháp cần thiết để đảm bảo rằng mẫu được thu thập có khả năng đại diện chính xác cho tổng thể quần thể mà không gặp phải sự thiên lệ.
# Tạo một vector từ 1 đến 10
numbers <- 1:100

# Chọn 5 số ngẫu nhiên
random_sample <- sample(numbers, size = 5)
print("Mẫu ngẫu nhiên cơ bản:")
random_sample

# 4.3.2. Chọn mẫu với thay thế
# Khi chọn mẫu với thay thế, mỗi phần tử có thể được chọn nhiều lần:
random_sample <- sample(numbers, size = 5, )
print("Mẫu ngẫu nhiên cơ bản:")
random_sample

# 4.3.4. Chọn mẫu từ DataFrame
set.seed(123)
df <- data.frame(matrix(rnorm(20), nrow=10000))
df


data(airquality)
# Chọn ngẫu nhiên 5 dòng bằng cách lấy mẫu chỉ số hàng
set.seed(123)
random_indices <- sample(nrow(airquality), 5)
print("Các chỉ số hàng được chọn:")
print(random_indices)

# Lấy ra 5 dòng dựa trên chỉ số đã chọn, đặt drop=FALSE để đảm bảo kết quả vẫn là dataframe
random_rows <- airquality[random_indices, , drop = FALSE]
random_rows
