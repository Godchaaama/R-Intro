### Bài tập thực hành về biểu đồ và trực quan hóa dữ liệu trong R ######################################################################

# 1. Biểu đồ histogram với các tùy chỉnh
# a) Sử dụng bộ dữ liệu USArrests (có sẵn trong R) để vẽ biểu đồ histogram
# hiển thị phân phối của biến Murder (tỷ lệ giết người).
hist(USArrests$Murder, main = "Phân phối số vụ giết người ở Mỹ",
     xlab = "Số vụ giết người / 100,000 dân",
     col = "lightblue",
     border = "darkblue"
)

# b) Sử dụng bảng màu Zissou1 từ gói wesanderson để tạo một vector gồm 10 màu liên tục
# và áp dụng các màu này cho các cột trong biểu đồ histogram.
# Lưu ý: Bạn có thể giả định rằng gói wesanderson đã được cài đặt và tải khi nộp bài.
#library(wesanderson)
if(require(wesanderson)){
  # Tạo một vector 10 màu liên tục
  zissou_colors <- wes_palette("Zissou1", 10, type="continuous")
  
  # Vẽ histogram
  hist(USArrests$Murder, main = "Phân phối số vụ giết người ở Mỹ",
       xlab = "Số vụ giết người / 100,000 dân",
       col = zissou_colors,
       border = "darkblue"
  )
}

# c) Tạo một biểu đồ histogram thứ hai cho biến Rape (tỷ lệ hiếp dâm) và tô màu các cột
# bằng bảng màu Moonrise1 (4 màu rời rạc) từ gói wesanderson.
if(require(wesanderson)){
  # Tạo một vector 10 màu liên tục
  Moonrise1_colors <- wes_palette("Moonrise1", 5, type="discrete")
  
  # Vẽ histogram
  hist(USArrests$Rape, main = "Phân phối số vụ hiếp dâm ở Mỹ",
       xlab = "Số vụ hiếp dâm / 100,000 dân",
       col = Moonrise1_colors,
       border = "darkblue"
  )
}



# d) Thiết lập cửa sổ đồ họa để hiển thị hai cột, một hàng.
par(mfrow=c(1,2))

# e) Vẽ hai biểu đồ histogram cạnh nhau.
# Vẽ histogram
hist(USArrests$Murder, main = "Phân phối số vụ giết người ở Mỹ",
     xlab = "Số vụ giết người / 100,000 dân",
     col = zissou_colors,
     border = "darkblue"
)
# Vẽ histogram
hist(USArrests$Rape, main = "Phân phối số vụ hiếp dâm ở Mỹ",
     xlab = "Số vụ hiếp dâm / 100,000 dân",
     col = Moonrise1_colors,
     border = "darkblue"
)

# f) Khôi phục lại cài đặt mặc định cho môi trường đồ họa.
par(mfrow=c(1,1))

# 2. Biểu đồ boxplot với các tùy chỉnh cho dữ liệu bảo hiểm
# a) Đọc tệp insurance.csv (từ thư mục chi phí y tế) vào R và lưu vào biến insurance.
# Kiểm tra dữ liệu đã được tải đúng chưa và kiểu dữ liệu của các biến có phù hợp không.
# Chuyển đổi các biến sex (giới tính), smoker (người hút thuốc) và region (khu vực) sang kiểu factor.
setwd("D:/R-Intro/R-Intro/data/graphics - medical cost personal dataset")
insurance <- read.csv("insurance.csv")

# Kiểm tra dữ liệu
str(insurance)

# Chuyển đổi
insurance$sex <- factor(insurance$sex)
insurance$smoker <- factor(insurance$smoker)
insurance$region <- factor(insurance$region)

# Kiểm tra dữ liệu
str(insurance)

# b) Tạo biểu đồ boxplot cho biến charges (chi phí) theo region (khu vực).
# Đổi tên các trục thành "Chi phí y tế" và "Khu vực".
boxplot(
  charges ~ region,
  data = insurance,
  xlab="Region",
  ylab="Medical charges"
)

# c) Thay đổi màu sắc của các 'hộp' (box) theo từng khu vực và thêm chú thích.
# Sử dụng bảng màu viridis với 4 màu rời rạc.
# Lưu ý: Bạn có thể giả định rằng gói viridis đã được cài đặt và tải khi nộp bài.
if(require(viridis)){
  # Tạo 4 màu từ bảng viridis
  region_colors <- viridis(4, option = "D")
  
  boxplot(
    charges ~ region,
    data = insurance,
    xlab="Region",
    ylab="Medical charges",
    col = region_colors
  )
  
}

# d) Tạo chú thích (legend) ở góc trên bên phải của biểu đồ.
# Đặt tên các phần tử trong chú thích giống hệt tên các danh mục trong biểu đồ.
# Gợi ý: Bạn có thể sử dụng hàm levels() để lấy tên tự động.
# Đảm bảo màu sắc trong chú thích trùng khớp với màu sắc của các hộp.
# Khi nộp bài, chỉ cần cung cấp dòng mã tạo chú thích.
legend("topright",
       legend=levels(insurance$region),
       fill= region_colors,
       title = "Region")


### LẤY ĐIỂM THỰC HÀNH
# 3. Biểu đồ cột cho dữ liệu Thế vận hội
# a) Đọc dữ liệu Tokyo 2021 từ thư mục olympic games và lưu vào biến games.
# b) Chuẩn bị biểu đồ cột hiển thị 10 quốc gia giành nhiều huy chương bạc nhất.
# Tạo một bộ dữ liệu mới "silver10" chứa 10 quốc gia có số huy chương bạc cao nhất,
# sắp xếp theo thứ tự giảm dần của biến Silver.Medal (số huy chương bạc).
# Đầu tiên, sắp xếp dữ liệu theo biến Silver.Medal, sau đó giới hạn lại còn 10 quan sát đầu tiên.
# Hãy kết hợp các bước này thành một dòng mã duy nhất.
# Nộp dòng mã ngắn nhất mà vẫn đạt được yêu cầu.
# c) Sử dụng hàm barplot() để vẽ biểu đồ cột cho biến Silver.Medal.
# d) Thêm nhãn bên dưới các cột (sử dụng tham số names.arg trong hàm barplot).
# Sử dụng giá trị từ biến NOCCode làm nhãn (mã quốc gia).
# e) Thêm tiêu đề "Top 10 huy chương bạc".
# f) Cá nhân hóa biểu đồ:
#    - Sửa đổi phong cách của chữ
#    - Thay đổi tiêu đề trục
#    - Thêm bảng màu bạn thích
#    - Tùy chỉnh các phần tử khác để làm biểu đồ hấp dẫn hơn
# Lưu biểu đồ thành tệp PNG và đặt tên theo mã số sinh viên của bạn.
# Nộp biểu đồ này vào bài kiểm tra. :)