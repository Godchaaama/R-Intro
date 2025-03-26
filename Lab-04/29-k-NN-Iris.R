# PHÂN LỚP DỮ LIỆU BẰNG MÔ HÌNH k-NN TRÊN BỘ DỮ LIỆU IRIS
# ========================================================

# Bước 1: Tải dữ liệu và thư viện cần thiết
if (!require(class)) install.packages("class")  # Thư viện cho k-NN
if (!require(caret)) install.packages("caret")  # Thư viện cho đánh giá mô hình

library(class)
library(caret)

# Bộ dữ liệu Iris có sẵn trong R
data(iris)
dataset_name <- "Iris"

# Bước 2: Khám phá dữ liệu
cat("Thông tin về tập dữ liệu", dataset_name, ":\n")
cat("Số mẫu:", nrow(iris), "\n")
cat("Số đặc trưng:", ncol(iris) - 1, "\n")  # Trừ 1 do có biến mục tiêu

# Hiển thị cấu trúc dữ liệu
cat("\nCấu trúc dữ liệu:\n")
str(iris)

# Hiển thị 6 hàng đầu tiên
cat("\nSáu hàng đầu tiên của dữ liệu:\n")
print(head(iris))

# Thống kê mô tả
cat("\nThống kê mô tả về dữ liệu:\n")
print(summary(iris))

# Kiểm tra phân phối biến mục tiêu
cat("\nPhân phối biến mục tiêu (loài hoa):\n")
print(table(iris$Species))
print(prop.table(table(iris$Species)) * 100)  # Phần trăm

# Bước 3: Trực quan hóa dữ liệu
# Tạo ma trận biểu đồ phân tán cho 4 đặc trưng
par(mfrow = c(2, 3))  # Chia cửa sổ đồ họa thành 2x3

# Biểu đồ phân tán giữa Sepal.Length và Sepal.Width
plot(iris$Sepal.Length, iris$Sepal.Width,
     col = as.numeric(iris$Species),
     pch = as.numeric(iris$Species) + 14,
     xlab = "Chiều dài đài hoa (cm)",
     ylab = "Chiều rộng đài hoa (cm)",
     main = "Đài hoa: Chiều dài vs Chiều rộng")
legend("topright", legend = levels(iris$Species),
       col = 1:3, pch = 15:17, cex = 0.8)

# Biểu đồ phân tán giữa Petal.Length và Petal.Width
plot(iris$Petal.Length, iris$Petal.Width,
     col = as.numeric(iris$Species),
     pch = as.numeric(iris$Species) + 14,
     xlab = "Chiều dài cánh hoa (cm)",
     ylab = "Chiều rộng cánh hoa (cm)",
     main = "Cánh hoa: Chiều dài vs Chiều rộng")
legend("topleft", legend = levels(iris$Species),
       col = 1:3, pch = 15:17, cex = 0.8)

# Biểu đồ phân tán giữa Sepal.Length và Petal.Length
plot(iris$Sepal.Length, iris$Petal.Length,
     col = as.numeric(iris$Species),
     pch = as.numeric(iris$Species) + 14,
     xlab = "Chiều dài đài hoa (cm)",
     ylab = "Chiều dài cánh hoa (cm)",
     main = "Chiều dài: Đài hoa vs Cánh hoa")
legend("topleft", legend = levels(iris$Species),
       col = 1:3, pch = 15:17, cex = 0.8)

# Biểu đồ phân tán giữa Sepal.Width và Petal.Width
plot(iris$Sepal.Width, iris$Petal.Width,
     col = as.numeric(iris$Species),
     pch = as.numeric(iris$Species) + 14,
     xlab = "Chiều rộng đài hoa (cm)",
     ylab = "Chiều rộng cánh hoa (cm)",
     main = "Chiều rộng: Đài hoa vs Cánh hoa")
legend("topright", legend = levels(iris$Species),
       col = 1:3, pch = 15:17, cex = 0.8)

# Biểu đồ hộp cho từng biến theo loài
boxplot(Sepal.Length ~ Species, data = iris,
        col = 2:4,
        xlab = "Loài hoa",
        ylab = "Chiều dài đài hoa (cm)",
        main = "Phân phối chiều dài đài hoa theo loài")

boxplot(Petal.Length ~ Species, data = iris,
        col = 2:4,
        xlab = "Loài hoa",
        ylab = "Chiều dài cánh hoa (cm)",
        main = "Phân phối chiều dài cánh hoa theo loài")

# Đặt lại cấu hình đồ họa
par(mfrow = c(1, 1))

# Bước 4: Chia dữ liệu thành tập huấn luyện và tập kiểm tra
set.seed(123)  # Đặt seed cho khả năng tái tạo
train_indices <- createDataPartition(iris$Species, p = 0.7, list = FALSE)
train_data <- iris[train_indices, ]
test_data <- iris[-train_indices, ]

cat("\nKích thước tập huấn luyện:", dim(train_data), "\n")
cat("Kích thước tập kiểm tra:", dim(test_data), "\n")

# Bước 5: Chuẩn bị dữ liệu cho k-NN
# Tách đặc trưng và nhãn
train_features <- train_data[, 1:4]
test_features <- test_data[, 1:4]
train_labels <- train_data$Species
test_labels <- test_data$Species

# Chuẩn hóa dữ liệu sử dụng Min-Max Scaling
# Tính các thông số chuẩn hóa từ tập huấn luyện
min_max_values <- apply(train_features, 2, function(x) c(min(x), max(x)))

# Hàm chuẩn hóa Min-Max
normalize <- function(x, min_val, max_val) {
  return((x - min_val) / (max_val - min_val))
}

# Áp dụng chuẩn hóa cho từng đặc trưng
train_features_norm <- as.data.frame(mapply(function(x, i) {
  normalize(x, min_max_values[1, i], min_max_values[2, i])
}, x = train_features, i = 1:ncol(train_features)))

test_features_norm <- as.data.frame(mapply(function(x, i) {
  normalize(x, min_max_values[1, i], min_max_values[2, i])
}, x = test_features, i = 1:ncol(test_features)))

# Đảm bảo tên cột được giữ nguyên
colnames(train_features_norm) <- colnames(train_features)
colnames(test_features_norm) <- colnames(test_features)

# Bước 6: Áp dụng thuật toán k-NN với nhiều giá trị k
k_values <- 1:13
accuracies <- numeric(length(k_values))

for (i in 1:length(k_values)) {
  k <- k_values[i]
  knn_pred <- knn(train = train_features_norm, 
                  test = test_features_norm,
                  cl = train_labels, 
                  k = k)
  accuracies[i] <- sum(knn_pred == test_labels) / length(test_labels)
}

accuracies

# Tìm giá trị k tối ưu
k_optimal <- k_values[which.max(accuracies)]
max_accuracy <- max(accuracies)

# Hiển thị kết quả với các giá trị k khác nhau
cat("\nĐộ chính xác của mô hình k-NN với các giá trị k khác nhau:\n")
result_k <- data.frame(
  k = k_values,
  accuracy = round(accuracies * 100, 2)
)
print(head(result_k, 10))  # Hiển thị 10 giá trị k đầu tiên

cat("\nGiá trị k tối ưu:", k_optimal, "với độ chính xác:", round(max_accuracy * 100, 2), "%\n")

# Vẽ biểu đồ độ chính xác theo giá trị k
plot(k_values, accuracies, type = "b", 
     xlab = "Giá trị k", ylab = "Độ chính xác",
     main = "Độ chính xác của mô hình k-NN theo giá trị k",
     ylim = c(0.5, 1), pch = 19, col = "blue")
abline(h = max_accuracy, lty = 2, col = "red")
text(k_optimal, max_accuracy, 
     labels = paste("k =", k_optimal, ", acc =", round(max_accuracy * 100, 1), "%"), 
     pos = 4, col = "red")
grid()

# Bước 7: Áp dụng k-NN với giá trị k tối ưu
knn_optimal <- knn(train = train_features_norm, 
                   test = test_features_norm,
                   cl = train_labels, 
                   k = k_optimal)

# Tạo ma trận nhầm lẫn
confusion_matrix <- confusionMatrix(knn_optimal, test_labels)
cat("\nMa trận nhầm lẫn:\n")
print(confusion_matrix$table)

# Hiển thị các chỉ số đánh giá
cat("\nCác chỉ số đánh giá mô hình với k =", k_optimal, ":\n")
cat("Độ chính xác (Accuracy):", round(confusion_matrix$overall["Accuracy"], 4), "\n")
cat("Kappa:", round(confusion_matrix$overall["Kappa"], 4), "\n\n")


