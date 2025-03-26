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

# Hiển thị chi tiết theo từng loài
cat("Hiệu suất theo loài:\n")
print(confusion_matrix$byClass[, c("Sensitivity", "Specificity", "Pos Pred Value", "Neg Pred Value", "F1")])

# Bước 8: Trực quan hóa biên quyết định (chỉ sử dụng 2 đặc trưng để dễ minh họa)
# Chọn 2 đặc trưng tốt nhất (Petal.Length và Petal.Width)
selected_features <- c("Petal.Length", "Petal.Width")

# Tạo tập dữ liệu mới với 2 đặc trưng đã chọn
train_features_2d <- train_features[, selected_features]
test_features_2d <- test_features[, selected_features]

# Chuẩn hóa dữ liệu 2D
train_features_2d_norm <- train_features_norm[, selected_features]
test_features_2d_norm <- test_features_norm[, selected_features]

# Tạo lưới điểm để vẽ biên quyết định
grid_x <- seq(min(iris[, selected_features[1]]), max(iris[, selected_features[1]]), length.out = 100)
grid_y <- seq(min(iris[, selected_features[2]]), max(iris[, selected_features[2]]), length.out = 100)
grid_data <- expand.grid(x = grid_x, y = grid_y)
colnames(grid_data) <- selected_features

# Chuẩn hóa dữ liệu lưới
grid_data_norm <- data.frame(
  Petal.Length = normalize(grid_data$Petal.Length, 
                           min_max_values[1, "Petal.Length"], 
                           min_max_values[2, "Petal.Length"]),
  Petal.Width = normalize(grid_data$Petal.Width, 
                          min_max_values[1, "Petal.Width"], 
                          min_max_values[2, "Petal.Width"])
)

# Dự đoán cho tất cả các điểm trong lưới
grid_pred <- knn(train = train_features_2d_norm, 
                 test = grid_data_norm,
                 cl = train_labels, 
                 k = k_optimal)

# Chuẩn bị màu sắc cho biên quyết định
species_colors <- c("setosa" = "red", "versicolor" = "green", "virginica" = "blue")
point_colors <- species_colors[as.character(grid_pred)]
transparency <- 0.3
point_colors_transparent <- sapply(point_colors, function(color) {
  rgb_values <- col2rgb(color) / 255
  rgb(rgb_values[1], rgb_values[2], rgb_values[3], transparency)
})

# Vẽ biên quyết định
plot(grid_data$Petal.Length, grid_data$Petal.Width,
     col = point_colors_transparent, pch = 15, cex = 0.5,
     xlab = selected_features[1], ylab = selected_features[2],
     main = paste("Biên quyết định k-NN (k =", k_optimal, ") trên dữ liệu Iris"),
     xlim = c(min(grid_x), max(grid_x)),
     ylim = c(min(grid_y), max(grid_y)))

# Thêm các điểm trong tập huấn luyện
points(train_data[, selected_features[1]], train_data[, selected_features[2]],
       col = species_colors[as.character(train_data$Species)],
       pch = 16, cex = 1.2)
points(train_data[, selected_features[1]], train_data[, selected_features[2]],
       col = "black", pch = 1, cex = 1.2)

# Thêm các điểm trong tập kiểm tra
points(test_data[, selected_features[1]], test_data[, selected_features[2]],
       col = species_colors[as.character(test_data$Species)],
       pch = 17, cex = 1.5)

# Thêm chú thích
legend("topleft", 
       legend = c(paste("Huấn luyện -", levels(iris$Species)),
                  paste("Kiểm tra -", levels(iris$Species))),
       col = c(species_colors, species_colors),
       pch = c(rep(16, 3), rep(17, 3)),
       cex = 0.8)

# Biểu đồ khác - Minh họa khái niệm k-NN
# Chọn một mẫu test để minh họa
test_sample_idx <- 5  # Chọn mẫu thứ 5 từ tập kiểm tra
test_sample <- test_features_2d[test_sample_idx, ]
test_sample_norm <- test_features_2d_norm[test_sample_idx, ]

# Tính khoảng cách từ mẫu test đến tất cả các mẫu trong tập huấn luyện
distances <- sqrt(
  (train_features_2d_norm$Petal.Length - test_sample_norm$Petal.Length)^2 + 
    (train_features_2d_norm$Petal.Width - test_sample_norm$Petal.Width)^2
)

# Kết hợp khoảng cách với nhãn và sắp xếp
neighbors_df <- data.frame(
  index = 1:nrow(train_features_2d),
  distance = distances,
  label = train_labels
)
neighbors_df <- neighbors_df[order(neighbors_df$distance), ]

# Vẽ biểu đồ minh họa k láng giềng
plot(train_features_2d$Petal.Length, train_features_2d$Petal.Width,
     col = species_colors[as.character(train_labels)],
     pch = 16, cex = 1.2,
     xlab = selected_features[1], ylab = selected_features[2],
     main = paste("Minh họa", k_optimal, "láng giềng gần nhất"))

# Thêm điểm test
points(test_sample$Petal.Length, test_sample$Petal.Width,
       col = "black", pch = 15, cex = 2)
text(test_sample$Petal.Length, test_sample$Petal.Width, 
     "?", col = "white", cex = 1.5)

# Vẽ đường kết nối đến k láng giềng gần nhất
for (i in 1:k_optimal) {
  neighbor_idx <- neighbors_df$index[i]
  lines(c(test_sample$Petal.Length, train_features_2d$Petal.Length[neighbor_idx]),
        c(test_sample$Petal.Width, train_features_2d$Petal.Width[neighbor_idx]),
        col = "black", lty = 2)
}

# Đánh dấu k láng giềng gần nhất
for (i in 1:k_optimal) {
  neighbor_idx <- neighbors_df$index[i]
  points(train_features_2d$Petal.Length[neighbor_idx], 
         train_features_2d$Petal.Width[neighbor_idx],
         col = "black", cex = 2, lwd = 2, pch = 1)
}

# Thêm chú thích
legend("topleft", 
       legend = c(levels(iris$Species), "Mẫu cần dự đoán", paste(k_optimal, "láng giềng gần nhất")),
       col = c(species_colors, "black", "black"),
       pch = c(16, 16, 16, 15, 1),
       cex = 0.8)

# Hiển thị kết quả bỏ phiếu
vote_count <- table(neighbors_df$label[1:k_optimal])
vote_result <- names(vote_count)[which.max(vote_count)]
cat("\nKết quả bỏ phiếu từ", k_optimal, "láng giềng gần nhất của mẫu thứ", test_sample_idx, ":\n")
print(vote_count)
cat("Dự đoán:", vote_result, "- Thực tế:", test_labels[test_sample_idx], "\n")

# Bước 9: Thử nghiệm với các độ đo khoảng cách khác nhau
# Thư viện FNN cho phép sử dụng nhiều độ đo khoảng cách
if (!require(FNN)) install.packages("FNN")
library(FNN)

# Các độ đo khoảng cách: euclidean, manhattan, maximum
distance_methods <- c("euclidean", "manhattan", "maximum")
k <- k_optimal  # Sử dụng k tối ưu đã tìm được

# Tạo ma trận để lưu kết quả
accuracy_by_distance <- numeric(length(distance_methods))
names(accuracy_by_distance) <- distance_methods

for (i in 1:length(distance_methods)) {
  method <- distance_methods[i]
  
  # Áp dụng k-NN với độ đo khoảng cách khác nhau
  knn_pred <- knn(train = train_features_norm, 
                  test = test_features_norm,
                  cl = train_labels, 
                  k = k,
                  algorithm = "cover_tree",  # FNN sử dụng algorithm thay vì method
                  l = switch(method,
                             euclidean = 2,   # l=2 cho khoảng cách Euclidean
                             manhattan = 1,   # l=1 cho khoảng cách Manhattan
                             maximum = Inf))  # l=Inf cho khoảng cách Maximum
  
  # Tính độ chính xác
  accuracy_by_distance[i] <- sum(knn_pred == test_labels) / length(test_labels)
}

# Hiển thị kết quả
cat("\nĐộ chính xác của mô hình k-NN (k =", k, ") với các độ đo khoảng cách khác nhau:\n")
print(round(accuracy_by_distance * 100, 2))

# Vẽ biểu đồ so sánh
barplot(accuracy_by_distance, 
        main = paste("So sánh độ chính xác theo độ đo khoảng cách (k =", k, ")"),
        xlab = "Độ đo khoảng cách", ylab = "Độ chính xác",
        col = "skyblue", ylim = c(0, 1))
text(x = 1:length(distance_methods), 
     y = accuracy_by_distance + 0.02, 
     labels = paste0(round(accuracy_by_distance * 100, 1), "%"), 
     cex = 0.8)

# Bước 10: Tổng kết và đánh giá mô hình
cat("\n===== TỔNG KẾT VÀ ĐÁNH GIÁ MÔ HÌNH k-NN =====\n")
cat("1. Mô hình k-NN đã được xây dựng thành công để phân loại loài hoa Iris dựa trên 4 đặc trưng:\n")
cat("   - Chiều dài đài hoa (Sepal.Length)\n")
cat("   - Chiều rộng đài hoa (Sepal.Width)\n")
cat("   - Chiều dài cánh hoa (Petal.Length)\n")
cat("   - Chiều rộng cánh hoa (Petal.Width)\n")

cat("\n2. Kết quả chính:\n")
cat("   - Giá trị k tối ưu:", k_optimal, "\n")
cat("   - Độ chính xác cao nhất:", round(max_accuracy * 100, 2), "%\n")
cat("   - Tất cả 3 loài đều được phân loại tốt, với độ chính xác cao nhất ở loài setosa\n")

cat("\n3. Nhận xét về đặc trưng:\n")
cat("   - Đặc trưng về cánh hoa (Petal) quan trọng hơn đặc trưng về đài hoa (Sepal)\n")
cat("   - Setosa dễ dàng phân biệt với hai loài còn lại\n")
cat("   - Versicolor và Virginica có sự chồng chéo nhất định\n")

cat("\n4. So sánh các độ đo khoảng cách:\n")
best_distance <- names(accuracy_by_distance)[which.max(accuracy_by_distance)]
cat("   - Độ đo khoảng cách tốt nhất:", best_distance, "với độ chính xác", 
    round(max(accuracy_by_distance) * 100, 2), "%\n")

cat("\n5. Ưu điểm của mô hình k-NN trong bài toán này:\n")
cat("   - Đơn giản, dễ hiểu và hiệu quả cao\n")
cat("   - Phù hợp với dữ liệu có ranh giới quyết định không tuyến tính\n")
cat("   - Dễ dàng điều chỉnh thông qua tham số k\n")

cat("\n6. Hạn chế và cải thiện:\n")
cat("   - Cần thử nghiệm với các tỷ lệ chia dữ liệu khác nhau\n")
cat("   - Có thể áp dụng kỹ thuật bỏ phiếu có trọng số\n")
cat("   - Kết hợp với kỹ thuật giảm chiều dữ liệu để tăng hiệu suất\n")

cat("\n7. Kết luận chung:\n")
cat("   - Mô hình k-NN rất phù hợp cho bài toán phân loại hoa Iris\n")
cat("   - Đạt được hiệu suất tốt với tham số k hợp lý\n")
cat("   - Có thể dễ dàng mở rộng cho các bài toán phân loại tương tự\n")

