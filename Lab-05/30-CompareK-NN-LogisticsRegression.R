# SO SÁNH MÔ HÌNH K-NN VÀ LOGISTIC REGRESSION CHO BÀI TOÁN PHÂN LOẠI BỆNH TIỂU ĐƯỜNG
# ================================================================================

# Mô tả bài tập:
# Trong bài tập này, chúng ta sẽ so sánh hiệu suất của hai mô hình phân lớp phổ biến:
# k-Nearest Neighbors (k-NN) và Logistic Regression trong bài toán phân loại bệnh tiểu đường
# sử dụng bộ dữ liệu Pima Indians Diabetes từ Kaggle.

# Tải dữ liệu từ Kaggle
# - Truy cập vào trang web: https://www.kaggle.com/datasets/uciml/pima-indians-diabetes-database
# - Tải file "diabetes.csv" về máy của bạn
# - Đặt file vào thư mục làm việc của R

# Bước 1: Tải các thư viện cần thiết
library(class)      # Cho thuật toán k-NN
library(caret)      # Cho các công cụ đánh giá và phân chia dữ liệu
library(dplyr)      # Cho xử lý dữ liệu
library(ggplot2)    # Cho vẽ biểu đồ
library(corrplot)   # Cho vẽ ma trận tương quan
library(pROC)       # Cho vẽ đường cong ROC

# Bước 2: Đọc và khám phá dữ liệu

# Đọc dữ liệu
library(readr)
diabetes <- read_csv("D:/R-Intro/R-Intro/Lab-05/diabetes.csv")
View(diabetes)

# Xem cấu trúc dữ liệu
str(diabetes)

# Xem thông tin chung
summary(diabetes)

# Kiểm tra giá trị thiếu
cat("Số lượng giá trị thiếu trong mỗi cột:\n")
colSums(is.na(diabetes))

# Kiểm tra giá trị 0 không hợp lệ cho một số đặc trưng
cat("\nSố lượng giá trị 0 không hợp lệ trong một số cột:\n")
zero_counts <- sapply(diabetes[c("Glucose", "BloodPressure", "SkinThickness", "Insulin", "BMI")], 
                      function(x) sum(x == 0))
print(zero_counts)

# Phân phối biến mục tiêu
table(diabetes$Outcome)
prop.table(table(diabetes$Outcome)) * 100

# Bước 3: Trực quan hóa dữ liệu

# 3.1 Vẽ ma trận tương quan giữa các đặc trưng
corr_matrix <- cor(diabetes)
#png("correlation_matrix.png", width = 800, height = 600)
corrplot(corr_matrix, method = "circle", type = "upper", 
         tl.col = "black", tl.srt = 45,
         title = "Ma trận tương quan giữa các đặc trưng")
dev.off()

# 3.2 Vẽ biểu đồ phân bố của các đặc trưng theo nhóm Outcome
# Chuyển đổi Outcome thành yếu tố
diabetes$Outcome <- factor(diabetes$Outcome, levels = c(0, 1), 
                           labels = c("Không mắc bệnh", "Mắc bệnh"))

# Vẽ biểu đồ hộp cho từng đặc trưng
par(mfrow = c(2, 4))
for (col in 1:8) {
  boxplot(diabetes[, col] ~ diabetes$Outcome,
          main = names(diabetes)[col],
          xlab = "Kết quả",
          ylab = "Giá trị",
          col = c("lightblue", "lightcoral"))
}
par(mfrow = c(1, 1))

# 3.3 Vẽ biểu đồ phân tán cho hai đặc trưng quan trọng (Glucose và BMI)
plot(diabetes$Glucose, diabetes$BMI,
     col = ifelse(diabetes$Outcome == "Mắc bệnh", "red", "blue"),
     pch = 16, cex = 0.8,
     xlab = "Glucose", ylab = "BMI",
     main = "Biểu đồ phân tán: Glucose vs BMI")
legend("topright", legend = levels(diabetes$Outcome),
       col = c("blue", "red"), pch = 16)

# Bước 4: Tiền xử lý dữ liệu

# 4.1 Xử lý các giá trị 0 không hợp lệ bằng imputation
# Lưu trữ dữ liệu gốc
diabetes_raw <- diabetes

# Thay thế giá trị 0 bằng NA
diabetes$Glucose[diabetes$Glucose == 0] <- NA
diabetes$BloodPressure[diabetes$BloodPressure == 0] <- NA
diabetes$SkinThickness[diabetes$SkinThickness == 0] <- NA
diabetes$Insulin[diabetes$Insulin == 0] <- NA
diabetes$BMI[diabetes$BMI == 0] <- NA

# Kiểm tra lại giá trị trước khi imputation
cat("\nSố lượng giá trị NA trước khi imputation:\n")
colSums(is.na(diabetes))

# Tính giá trị trung bình theo nhóm cho từng cột
# Nhóm "Không mắc bệnh"
mean_glucose_negative <- mean(diabetes$Glucose[diabetes$Outcome == "Không mắc bệnh"], na.rm = TRUE)
mean_bp_negative <- mean(diabetes$BloodPressure[diabetes$Outcome == "Không mắc bệnh"], na.rm = TRUE)
mean_skin_negative <- mean(diabetes$SkinThickness[diabetes$Outcome == "Không mắc bệnh"], na.rm = TRUE)
mean_insulin_negative <- mean(diabetes$Insulin[diabetes$Outcome == "Không mắc bệnh"], na.rm = TRUE)
mean_bmi_negative <- mean(diabetes$BMI[diabetes$Outcome == "Không mắc bệnh"], na.rm = TRUE)

# Nhóm "Mắc bệnh"
mean_glucose_positive <- mean(diabetes$Glucose[diabetes$Outcome == "Mắc bệnh"], na.rm = TRUE)
mean_bp_positive <- mean(diabetes$BloodPressure[diabetes$Outcome == "Mắc bệnh"], na.rm = TRUE)
mean_skin_positive <- mean(diabetes$SkinThickness[diabetes$Outcome == "Mắc bệnh"], na.rm = TRUE)
mean_insulin_positive <- mean(diabetes$Insulin[diabetes$Outcome == "Mắc bệnh"], na.rm = TRUE)
mean_bmi_positive <- mean(diabetes$BMI[diabetes$Outcome == "Mắc bệnh"], na.rm = TRUE)

# Điền giá trị thiếu cho nhóm "Không mắc bệnh"
diabetes$Glucose[is.na(diabetes$Glucose) & diabetes$Outcome == "Không mắc bệnh"] <- mean_glucose_negative
diabetes$BloodPressure[is.na(diabetes$BloodPressure) & diabetes$Outcome == "Không mắc bệnh"] <- mean_bp_negative
diabetes$SkinThickness[is.na(diabetes$SkinThickness) & diabetes$Outcome == "Không mắc bệnh"] <- mean_skin_negative
diabetes$Insulin[is.na(diabetes$Insulin) & diabetes$Outcome == "Không mắc bệnh"] <- mean_insulin_negative
diabetes$BMI[is.na(diabetes$BMI) & diabetes$Outcome == "Không mắc bệnh"] <- mean_bmi_negative

# Điền giá trị thiếu cho nhóm "Mắc bệnh"
diabetes$Glucose[is.na(diabetes$Glucose) & diabetes$Outcome == "Mắc bệnh"] <- mean_glucose_positive
diabetes$BloodPressure[is.na(diabetes$BloodPressure) & diabetes$Outcome == "Mắc bệnh"] <- mean_bp_positive
diabetes$SkinThickness[is.na(diabetes$SkinThickness) & diabetes$Outcome == "Mắc bệnh"] <- mean_skin_positive
diabetes$Insulin[is.na(diabetes$Insulin) & diabetes$Outcome == "Mắc bệnh"] <- mean_insulin_positive
diabetes$BMI[is.na(diabetes$BMI) & diabetes$Outcome == "Mắc bệnh"] <- mean_bmi_positive

# Kiểm tra lại giá trị sau khi imputation
cat("\nSố lượng giá trị NA sau khi imputation:\n")
colSums(is.na(diabetes))

# 4.2 Tách biến mục tiêu và đặc trưng
X <- diabetes[, 1:8]  # Đặc trưng
y <- diabetes$Outcome  # Biến mục tiêu

# 4.3 Chuẩn hóa dữ liệu
preproc <- preProcess(X, method = c("range"))  # Sử dụng Min-Max Scaling
X_scaled <- predict(preproc, X)

# Tạo dataframe cho Logistic Regression
diabetes_scaled <- cbind(X_scaled, Outcome = y)
View(diabetes_scaled)

# 4.4 Chia dữ liệu thành tập huấn luyện và tập kiểm tra
set.seed(123)
train_indices <- createDataPartition(y, p = 0.7, list = FALSE)
X_train <- X_scaled[train_indices, ]
X_test <- X_scaled[-train_indices, ]
y_train <- y[train_indices]
y_test <- y[-train_indices]

# Dataset
train_data <- diabetes_scaled[train_indices, ]
test_data <- diabetes_scaled[-train_indices, ]

# Bước 5: Xây dựng và đánh giá mô hình

# 5.1 Xây dựng và đánh giá mô hình K-NN

# Tìm giá trị k tối ưu
k_values <- seq(1, 30, by = 2)  # Chỉ dùng k lẻ để tránh trường hợp hòa
accuracies_knn <- numeric(length(k_values))

for (i in seq_along(k_values)) {
  k <- k_values[i]
  knn_pred <- knn(train = X_train, test = X_test, cl = y_train, k = k)
  accuracies_knn[i] <- sum(knn_pred == y_test) / length(y_test)
}

# Tìm k tối ưu
optimal_k <- k_values[which.max(accuracies_knn)]
max_accuracy_knn <- max(accuracies_knn)

# Vẽ biểu đồ độ chính xác theo giá trị k
plot(k_values, accuracies_knn, type = "b", 
     xlab = "Giá trị k", ylab = "Độ chính xác",
     main = "Độ chính xác của mô hình k-NN theo giá trị k",
     ylim = c(0.5, 0.9), pch = 19, col = "blue")
abline(h = max_accuracy_knn, lty = 2, col = "red")
text(optimal_k, max_accuracy_knn, 
     labels = paste("k =", optimal_k, ", acc =", round(max_accuracy_knn * 100, 1), "%"), 
     pos = 4, col = "red")
grid()

# Đánh giá mô hình K-NN với k tối ưu
knn_pred <- knn(train = X_train, test = X_test, cl = y_train, k = optimal_k, prob = TRUE)
knn_prob <- attr(knn_pred, "prob")
# Chuyển đổi xác suất để thể hiện xác suất mắc bệnh
knn_prob <- ifelse(knn_pred == "Mắc bệnh", knn_prob, 1 - knn_prob)
conf_matrix_knn <- confusionMatrix(knn_pred, y_test)

# Hiển thị kết quả K-NN
cat("\nKết quả K-NN với k =", optimal_k, ":\n")
print(conf_matrix_knn)

# 5.2 Xây dựng và đánh giá mô hình Logistic Regression

# Huấn luyện mô hình Logistic Regression
logit_model <- glm(Outcome ~ ., data = train_data, family = binomial(link = "logit"))

# Tóm tắt mô hình
summary(logit_model)

# Dự đoán xác suất trên tập kiểm tra
logit_prob <- predict(logit_model, newdata = test_data, type = "response")

# Chuyển đổi xác suất thành nhãn
logit_pred <- factor(ifelse(logit_prob > 0.5, "Mắc bệnh", "Không mắc bệnh"), 
                     levels = c("Không mắc bệnh", "Mắc bệnh"))

# Đánh giá mô hình Logistic Regression
conf_matrix_logit <- confusionMatrix(logit_pred, y_test)

# Hiển thị kết quả Logistic Regression
cat("\nKết quả Logistic Regression:\n")
print(conf_matrix_logit)

# Bước 6: So sánh hai mô hình

# 6.1 So sánh độ chính xác
cat("\n===== SO SÁNH HAI MÔ HÌNH =====\n")
cat("1. Độ chính xác (Accuracy):\n")
cat("   - K-NN (k =", optimal_k, "):", round(conf_matrix_knn$overall["Accuracy"] * 100, 2), "%\n")
cat("   - Logistic Regression:", round(conf_matrix_logit$overall["Accuracy"] * 100, 2), "%\n")

# 6.2 So sánh độ nhạy và độ đặc hiệu
cat("\n2. Độ nhạy (Sensitivity/Recall):\n")
cat("   - K-NN:", round(conf_matrix_knn$byClass["Sensitivity"] * 100, 2), "%\n")
cat("   - Logistic Regression:", round(conf_matrix_logit$byClass["Sensitivity"] * 100, 2), "%\n")

cat("\n3. Độ đặc hiệu (Specificity):\n")
cat("   - K-NN:", round(conf_matrix_knn$byClass["Specificity"] * 100, 2), "%\n")
cat("   - Logistic Regression:", round(conf_matrix_logit$byClass["Specificity"] * 100, 2), "%\n")

# 6.3 So sánh giá trị dự đoán dương và âm
cat("\n4. Giá trị dự đoán dương tính (Precision):\n")
cat("   - K-NN:", round(conf_matrix_knn$byClass["Pos Pred Value"] * 100, 2), "%\n")
cat("   - Logistic Regression:", round(conf_matrix_logit$byClass["Pos Pred Value"] * 100, 2), "%\n")

cat("\n5. Giá trị dự đoán âm tính (Negative Predictive Value):\n")
cat("   - K-NN:", round(conf_matrix_knn$byClass["Neg Pred Value"] * 100, 2), "%\n")
cat("   - Logistic Regression:", round(conf_matrix_logit$byClass["Neg Pred Value"] * 100, 2), "%\n")

# 6.4 So sánh điểm F1
cat("\n6. Điểm F1 (F1 Score):\n")
cat("   - K-NN:", round(conf_matrix_knn$byClass["F1"] * 100, 2), "%\n")
cat("   - Logistic Regression:", round(conf_matrix_logit$byClass["F1"] * 100, 2), "%\n")

# 6.5 So sánh đường cong ROC và AUC


# 6.6 So sánh trực quan
# Vẽ biểu đồ so sánh các chỉ số
metrics <- c("Accuracy", "Sensitivity", "Specificity", "Precision", "NPV", "F1")
knn_values <- c(
  conf_matrix_knn$overall["Accuracy"],
  conf_matrix_knn$byClass["Sensitivity"],
  conf_matrix_knn$byClass["Specificity"],
  conf_matrix_knn$byClass["Pos Pred Value"],
  conf_matrix_knn$byClass["Neg Pred Value"],
  conf_matrix_knn$byClass["F1"]
)
logit_values <- c(
  conf_matrix_logit$overall["Accuracy"],
  conf_matrix_logit$byClass["Sensitivity"],
  conf_matrix_logit$byClass["Specificity"],
  conf_matrix_logit$byClass["Pos Pred Value"],
  conf_matrix_logit$byClass["Neg Pred Value"],
  conf_matrix_logit$byClass["F1"]
)

# Tạo dataframe cho biểu đồ
comparison_df <- data.frame(
  Metric = metrics,
  KNN = knn_values,
  LogisticRegression = logit_values
)

# Vẽ biểu đồ so sánh
png("metrics_comparison.png", width = 800, height = 600)
barplot(t(comparison_df[, 2:3]), beside = TRUE,
        names.arg = comparison_df$Metric,
        col = c("blue", "red"),
        main = "So sánh các chỉ số giữa K-NN và Logistic Regression",
        ylab = "Giá trị", ylim = c(0, 1))
legend("topright", 
       legend = c("K-NN", "Logistic Regression"),
       fill = c("blue", "red"))
grid()
dev.off()

# Bước 7: Phân tích đặc trưng quan trọng từ Logistic Regression

# Tính odds ratio (tỷ số chênh) từ mô hình logistic
odds_ratios <- exp(coef(logit_model))
ci <- exp(confint(logit_model))
feature_importance <- data.frame(
  Feature = names(odds_ratios),
  OddsRatio = odds_ratios,
  LowerCI = ci[, 1],
  UpperCI = ci[, 2]
)

# Sắp xếp theo tầm quan trọng (tỷ số chênh)
feature_importance <- feature_importance[-1, ]  # Loại bỏ hệ số chặn
feature_importance <- feature_importance[order(abs(feature_importance$OddsRatio - 1), decreasing = TRUE), ]

cat("\n8. Đặc trưng quan trọng theo Logistic Regression:\n")
print(feature_importance)

# Vẽ biểu đồ tầm quan trọng của đặc trưng
png("feature_importance.png", width = 800, height = 600)
par(mar = c(8, 4, 4, 2) + 0.1)  # Tăng lề dưới cho tên đặc trưng dài
barplot(abs(feature_importance$OddsRatio - 1),
        names.arg = feature_importance$Feature,
        main = "Tầm quan trọng của đặc trưng (Logistic Regression)",
        ylab = "Mức độ ảnh hưởng (|OR - 1|)",
        col = "lightblue",
        las = 2)  # Xoay nhãn 90 độ
grid()
dev.off()

# Bước 8: Thử nghiệm với dữ liệu mới

# Tạo một hàm để dự đoán cho một bệnh nhân mới sử dụng cả hai mô hình
predict_diabetes <- function(patient_data) {
  # Chuẩn hóa dữ liệu mới
  patient_data_scaled <- predict(preproc, patient_data)
  
  # Dự đoán bằng K-NN
  knn_prediction <- knn(train = X_train, test = patient_data_scaled, 
                        cl = y_train, k = optimal_k, prob = TRUE)
  knn_prob <- attr(knn_prediction, "prob")
  if (knn_prediction != "Mắc bệnh") {
    knn_prob <- 1 - knn_prob
  }
  
  # Dự đoán bằng Logistic Regression
  logit_prob <- predict(logit_model, newdata = patient_data_scaled, type = "response")
  logit_prediction <- ifelse(logit_prob > 0.5, "Mắc bệnh", "Không mắc bệnh")
  
  return(list(
    knn = list(prediction = as.character(knn_prediction), probability = knn_prob),
    logit = list(prediction = logit_prediction, probability = logit_prob)
  ))
}

# Ví dụ: Dự đoán cho một bệnh nhân mới
new_patient <- data.frame(
  Pregnancies = 2,
  Glucose = 130,
  BloodPressure = 70,
  SkinThickness = 20,
  Insulin = 150,
  BMI = 30.5,
  DiabetesPedigreeFunction = 0.5,
  Age = 45
)

result <- predict_diabetes(new_patient)
cat("\nDự đoán cho bệnh nhân mới:\n")
cat("K-NN:\n")
cat("- Kết quả:", result$knn$prediction, "\n")
cat("- Xác suất mắc bệnh:", round(result$knn$probability * 100, 2), "%\n\n")
cat("Logistic Regression:\n")
cat("- Kết quả:", result$logit$prediction, "\n")
cat("- Xác suất mắc bệnh:", round(result$logit$probability * 100, 2), "%\n")

