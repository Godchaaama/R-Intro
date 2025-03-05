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
