# Cài đặt và tải các gói cần thiết
if (!require(MASS)) install.packages("MASS")
if (!require(caret)) install.packages("caret")

library(MASS)      # Chứa bộ dữ liệu Boston
library(caret)     # Chia dữ liệu và đánh giá mô hình

# Bước 1: Tải dữ liệu Boston housing
data(Boston)
X <- Boston[, 1:13]  # Tất cả các biến trừ biến mục tiêu
y <- Boston$medv     # Biến mục tiêu là giá nhà trung bình
dataset_name <- "Boston housing"

# Bước 2: Khám phá dữ liệu
cat("Thông tin về tập dữ liệu", dataset_name, ":\n")
cat("Số mẫu:", nrow(X), "\n")
cat("Số đặc trưng:", ncol(X), "\n\n")

cat("Năm hàng đầu tiên của dữ liệu:\n")
print(head(X))

# Hiển thị thống kê mô tả
cat("\nThống kê mô tả về dữ liệu:\n")
print(summary(X))

# Bước 3: Phân chia dữ liệu thành tập huấn luyện và tập kiểm tra
set.seed(42)  # Đặt seed cho khả năng tái tạo
train_indices <- createDataPartition(y, p = 0.8, list = FALSE)
X_train <- X[train_indices, ]
X_test <- X[-train_indices, ]
y_train <- y[train_indices]
y_test <- y[-train_indices]

cat("\nKích thước tập huấn luyện:", dim(X_train), "\n")
cat("Kích thước tập kiểm tra:", dim(X_test), "\n")

# Bước 4-5: Xây dựng và huấn luyện mô hình hồi quy tuyến tính
model <- lm(y_train ~ ., data = X_train) # Dau . la lay tat ca

summary(model)
# Bước 6: Kiểm tra hệ số hồi quy
coef_df <- data.frame(
  feature = names(coef(model)[-1]),
  coefficient = coef(model)[-1]
)
coef_df <- coef_df[order(coef_df$coefficient, decreasing = TRUE), ]

cat("\nHệ số hồi quy:\n")
print(coef_df)
cat("Hệ số chặn (Intercept):", coef(model)[1], "\n")

# Bước 7: Dự đoán trên tập kiểm tra
y_pred <- predict(model, newdata = X_test)

# Bước 8: Đánh giá mô hình
mse <- mean((y_test - y_pred)^2)
mse
rmse <- sqrt(mse)
rmse
r2 <- 1 - sum((y_test - y_pred)^2) / sum((y_test - mean(y_test))^2)

cat("\nĐánh giá mô hình:\n")
cat("Mean Squared Error (MSE):", round(mse, 4), "\n")
cat("Root Mean Squared Error (RMSE):", round(rmse, 4), "\n")
cat("R-squared (R²):", round(r2, 4), "\n")

# Bước 9: Trực quan hóa kết quả
# So sánh giá trị thực tế và dự đoán
plot(y_test, y_pred, 
     main = "So sánh giữa giá trị thực tế và dự đoán",
     xlab = "Giá trị thực tế", 
     ylab = "Giá trị dự đoán",
     pch = 16, 
     col = "blue")
abline(0, 1, col = "red", lwd = 2, lty = 2)  # Đường thẳng y=x
grid()