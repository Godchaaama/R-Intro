# Mô phỏng biến ngẫu nhiên trong R
# 2.2.1. Biến ngẫu nhiên rời rạc
# Chúng ta có thể mô phỏng một biến 
# ngẫu nhiên rời rạc như việc tung đồng xu bằng cách sử dụng hàm sample()

# Mô phỏng tung đồng xu 10 lần
# "heads" = mặt ngửa, "tails" = mặt sấp
set.seed(123) # Để kết quả cáo thể tái lập được
coin_flips <- sample(c("heads", "tails"), size = 10, replace = TRUE)
print(coin_flips)

# Trong đoạn code này, sample() được sử dụng để chọn ngẫu nhiên “heads” hoặc “tails” với mỗi lần tung đồng xu. Tham số replace = TRUE cho phép chọn lại các giá trị (giống như tung đồng xu nhiều lần).

# 2.2.2. Biến ngẫu nhiên liên tục
# Đối với biến ngẫu nhiên liên tục, chúng ta thường sử dụng phân phối chuẩn. Hàm rnorm() trong R có thể được sử dụng để tạo mẫu từ một phân phối chuẩn:

# Tạo một mẫu ngẫu nhiên của chiều cao theo phân phối chuẩn
# Giả sử trung bình chiều cao các bạn là 170cm và độ lệch chuẩn là 10cm
set.seed(123)
heights <- rnorm(n=100, mean=170, sd=10)

# Hiển thị 10 giá trị đầu tiên
head(heights, 10)

# Tạo biểu đồ histogram để quan sát phân phối
hist(heights, breaks = 20, 
     main = "Phân phối chiều cao(cm)", 
     xlab ="Chiều cao (cm)", 
     col = "skyblue", 
     border="white")



