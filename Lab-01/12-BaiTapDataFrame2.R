# Sử dụng bộ dữ liệu có sẵn CO2 cho các nhiệm vụ sau:
CO2

# 1. In giá trị CO2 uptake từ lớn nhất đến nhỏ nhất.
# 2. Hiển thị các dòng của bộ dữ liệu CO2, nơi Type được đặt thành Quebec và Treatment thành chilled.
# 3. Hiển thị các dòng của bộ dữ liệu CO2, nơi uptake lớn hơn 40 và
# bộ dữ liệu được sắp xếp theo giá trị conc từ nhỏ nhất đến lớn nhất.
# Thử giải chỉ một dòng. Nếu bạn cần tạo
# một đối tượng trung gian - đặt tên là 'temp'.
# 4. Làm thế nào để có được một sắp xếp ngẫu nhiên của bộ dữ liệu CO2? GỢI Ý: Bạn có thể muốn có một
# vector với các chỉ số ngẫu nhiên sẽ đến từ kết quả order(unif(...)).
# set.seed(123)
# missCO2 <- CO2
# missCO2[c(as.integer(runif(10)*nrow(missCO2)),14:16),"uptake"] <- NA
# missCO2[c(as.integer(runif(10)*nrow(missCO2)),14:16),"conc"] <- NA
# missCO2$weight <- paste0(as.integer(runif(nrow(missCO2))*30),"kg")
# 5. Hiển thị các dòng của bộ dữ liệu missCO2 có ít nhất một giá trị bị thiếu.
# 6. Điền các giá trị uptake bị thiếu với giá trị 20.
# 7. Điền các giá trị conc bị thiếu với giá trị trung bình của conc.
# 8. Trích xuất giá trị số từ biến weight và lưu chúng trong cột mới
# "weightNumber".