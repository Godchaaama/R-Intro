# Các hàm cho phép bạn thêm các tính năng mới vào R 
# phù hợp nhất với nhu cầu của bạn. Chúng là các khối 
# mã có thể tái sử dụng và có thể được gọi nhiều lần 
# trong toàn bộ tập lệnh của bạn.

# Mẫu cơ bản của một hàm trong R
# "myFunction" là tên hàm do người dùng đặt
# "arguments" là danh sách các tham số đầu vào
myFunction <- function(arguments){
  # Phần thân của hàm chứa các phép tính và xử lý
  # ....
  # "result" là giá trị sẽ được trả về khi hàm kết thúc
  return (result);
}

# Ví dụ về các hàm có sẵn trong R
# max() trả về giá trị lớn nhất trong một vector
max(iris$Sepal.Length)  # Tìm giá trị lớn nhất của cột Sepal.Length trong bộ dữ liệu iris

# min() trả về giá trị nhỏ nhất trong một vector
min(iris$Sepal.Length)  # Tìm giá trị nhỏ nhất của cột Sepal.Length trong bộ dữ liệu iris

# Tính toán thủ công phạm vi (khoảng) của các biến
# Phạm vi = giá trị lớn nhất - giá trị nhỏ nhất
max(iris$Sepal.Length) - min(iris$Sepal.Length)  # Tính phạm vi của Sepal.Length
max(iris$Sepal.Width) - min(iris$Sepal.Width)    # Tính phạm vi của Sepal.Width
max(iris$Petal.Length) - min(iris$Petal.Length)  # Tính phạm vi của Petal.Length
max(iris$Petal.Width) - min(iris$Petal.Width)    # Tính phạm vi của Petal.Width

# Xây dựng hàm tự tạo để tính phạm vi
# Điều này giúp tránh lặp lại mã và làm code gọn gàng hơn
myRange <- function(variable){
  # Biến "variable" là vector đầu vào cần tính phạm vi
  rangeValue <- max(variable) - min(variable);  # Tính phạm vi bằng cách lấy giá trị lớn nhất trừ giá trị nhỏ nhất
  return(rangeValue);  # Trả về kết quả phạm vi
}

# Sử dụng hàm myRange vừa tạo
myRange(iris$Sepal.Length)  # Áp dụng hàm cho cột Sepal.Length

# Bổ sung thêm điều khiển để xử lý giá trị NA (Missing Values)
# Tham số "missingRemove" cho phép người dùng chọn có loại bỏ NA hay không
# Giá trị mặc định TRUE nghĩa là sẽ loại bỏ NA khi tính toán
myRange2 <- function(variable, missingRemove = TRUE){
  # na.rm là tham số của các hàm max() và min() để xử lý NA
  rangeValue <- max(variable, na.rm=missingRemove) - min(variable, na.rm=missingRemove);
  return(rangeValue);
}

# Tạo vector mới có chứa giá trị NA để kiểm tra
newV <- c(seq(1,20,4), NA)  # Vector gồm dãy 1,5,9,13,17 và một giá trị NA
newV  # Hiển thị vector để kiểm tra

# Thử nghiệm với hàm ban đầu
# Kết quả sẽ là NA vì hàm myRange không xử lý được NA
myRange(newV)

# Thử nghiệm với hàm cải tiến - sử dụng giá trị mặc định TRUE
# Kết quả là phạm vi thực của dữ liệu, bỏ qua NA
myRange2(newV)

# Thử nghiệm với tham số missingRemove = FALSE
# Kết quả sẽ là NA vì không loại bỏ NA khi tính toán
myRange2(newV, F)

# Thử nghiệm với tham số missingRemove = TRUE 
# Kết quả là phạm vi thực của dữ liệu, bỏ qua NA
myRange2(newV, T)

# Cách gọi hàm với tên tham số rõ ràng
# Thứ tự tham số không quan trọng khi chỉ định tên
myRange2(missingRemove = T, variable = newV)

# Bắt lỗi khi biến không tồn tại
# tryCatch cho phép xử lý lỗi một cách an toàn
tryCatch(
  {
    myRange(v)  # Biến v không tồn tại, sẽ gây lỗi
  },
  error = function(e){
    # Hàm này sẽ được gọi khi có lỗi xảy ra
    print("Error: Không thể tính khoảng giá trị cho dữ liệu bị thiếu");
  }
)

# Cách sử dụng lapply để áp dụng hàm cho nhiều cột cùng lúc
# lapply áp dụng một hàm cho mỗi phần tử trong danh sách hoặc data frame
# iris[,1:4] chọn 4 cột đầu tiên của bộ dữ liệu iris
lapply(iris[,1:4], myRange);  # Kết quả là danh sách phạm vi của 4 cột