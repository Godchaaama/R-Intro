# GIỚI THIỆU VỀ GGPLOT2 TRONG R
# ggplot2 là một package (gói) trong R, 
# được phát triển bởi Hadley Wickham, 
# dùng để tạo các biểu đồ đẹp và chuyên nghiệp. 
# Tên "ggplot2" xuất phát từ "Grammar of Graphics" 
# (Ngữ pháp đồ họa) - một cách tiếp cận có hệ thống 
# để mô tả và xây dựng đồ thị.

# Điểm mạnh của ggplot2:
#   
# Tạo biểu đồ chất lượng cao, phù hợp cho nghiên cứu và xuất bản
# Cú pháp nhất quán và dễ hiểu
# Khả năng tùy chỉnh cao
# Cộng đồng người dùng lớn và nhiều tài liệu hướng dẫn

# CÀI ĐẶT GGPLOT2
# Cài đặt gói nếu chưa có
install.packages("ggplot2")

# Load gói vào môi trường R
library(ggplot2)

# ggplot2 dựa trên ý tưởng rằng bất kỳ biểu đồ 
# nào cũng có thể được chia thành các thành phần cơ bản:
# Data: Dữ liệu bạn muốn hiển thị
# Aesthetics: Cách ánh xạ biến dữ liệu vào thuộc tính thị giác (vị trí, màu sắc, kích thước, hình dạng...)
# Geometries: Các đối tượng hình học biểu diễn dữ liệu (điểm, đường, cột...)
# Facets: Chia đồ thị thành nhiều đồ thị con dựa trên biến
# Statistics: Các phép biến đổi thống kê trên dữ liệu (trung bình, trung vị...)
# Coordinates: Hệ tọa độ sử dụng (Cartesian, polar...)
# Themes: Định dạng tổng thể của đồ thị

# CÚ PHÁP CƠ BẢN CỦA GGPLOT2
# Cú pháp cơ bản của ggplot2 được xây dựng theo mô hình "layer" (lớp):
# ggplot(data = <DATA>) + 
#   <GEOM_FUNCTION>(mapping = aes(<MAPPINGS>)) +
#   <COORDINATE_FUNCTION> +
#   <FACET_FUNCTION> +
#   <SCALE_FUNCTION> +
#   <THEME_FUNCTION>


# Ví dụ

# Biểu đồ điểm (Scatter plot)
str(mtcars)
ggplot(data = mtcars, aes(x = wt, y = mpg)) +
  geom_point()

# Biểu đồ điểm dùng để hiển thị mối quan hệ giữa hai biến số học.
# Mỗi điểm trên đồ thị đại diện cho một quan sát (một dòng dữ liệu).
# Rất hữu ích để phát hiện mối tương quan, phân cụm, và các mẫu trong dữ liệu.
# Trong ví dụ này, mỗi điểm đại diện cho một mẫu xe, vị trí của nó thể hiện mối quan hệ giữa trọng lượng xe và mức tiêu thụ nhiên liệu.

# Biểu đồ đường (Line plot) 
economics
str(mtcars)
ggplot(data = economics, aes(x = date, y = uempmed)) +
  geom_line()

# Biểu đồ đường được sử dụng để thể hiện dữ liệu liên tục theo thời gian hoặc theo một biến liên tục khác.


# Biểu đồ cột (Bar plot)
mpg
ggplot(data = mpg, aes(x=class))+
      geom_bar()

# Biểu đồ cột dùng để so sánh số lượng hoặc tần suất giữa các nhóm rời rạc.
# Khi chỉ định một biến rời rạc (như "class") cho trục x và sử dụng geom_bar(), ggplot2 tự động đếm số lượng quan sát trong mỗi nhóm.
# Chiều cao của mỗi cột tương ứng với số lượng quan sát trong nhóm đó.

# Biểu đồ hộp (Box plot)
mpg
ggplot(data = mpg, aes(x=class, y=hwy))+
  geom_boxplot()


# Biểu đồ hộp dùng để hiển thị phân phối của một biến số học theo các nhóm.
# Mỗi "hộp" thể hiện:
#   
#   Đường ngang ở giữa: giá trị trung vị (median)
# Cạnh dưới của hộp: tứ phân vị thứ nhất (Q1, 25%)
# Cạnh trên của hộp: tứ phân vị thứ ba (Q3, 75%)
# "Râu" (whiskers): thường kéo dài đến giá trị min/max trong phạm vi 1.5*IQR (khoảng tứ phân vị)
# Các điểm riêng lẻ: giá trị ngoại lai (outliers)
# 
# 
# Trong ví dụ này, mỗi hộp hiển thị phân phối của hiệu suất nhiên liệu trên đường cao tốc (hwy) cho mỗi phân khúc xe.
# Giúp so sánh trực quan phân phối giữa các nhóm về vị trí trung tâm, độ phân tán và các giá trị ngoại lai.


# Biểu đồ mật độ (Density plot)
ggplot(data = mpg, aes(x=hwy))+
  geom_density()


# Biểu đồ mật độ hiển thị phân phối của một biến liên tục.
# Tương tự như biểu đồ histogram nhưng mượt mà hơn, thể hiện ước tính của hàm mật độ xác suất.
# aes(x = hwy) chỉ định biến "hwy" (hiệu suất nhiên liệu trên đường cao tốc) cho trục x.
# geom_density() tính toán và vẽ đường mật độ.
# Đường cong cao ở những khu vực có nhiều quan sát (dữ liệu tập trung) và thấp ở những khu vực ít quan sát.
# Hữu ích để xem hình dạng tổng thể của phân phối dữ liệu (ví dụ: phân phối chuẩn, lệch phải, lệch trái, đa đỉnh).

# Biểu đồ violin (Violin plot)
ggplot(data = mpg, aes(x=class, y=hwy))+
  geom_violin()


# Biểu đồ violin là sự kết hợp giữa biểu đồ hộp và biểu đồ mật độ.
# Hiển thị phân phối của một biến số học theo các nhóm, tương tự như biểu đồ hộp.
# Hình dạng "violin" thể hiện mật độ xác suất của dữ liệu ở các giá trị khác nhau - phần rộng hơn có nhiều quan sát hơn.
# Trong ví dụ này, mỗi "violin" hiển thị phân phối của hiệu suất nhiên liệu trên đường cao tốc (hwy) cho mỗi phân khúc xe.
# So với biểu đồ hộp, biểu đồ violin cung cấp thông tin chi tiết hơn về hình dạng của phân phối (có thể thấy được phân phối đa đỉnh, độ lệch, v.v.).

# TÙY CHỈNH BIỂU ĐỒ
# Thêm tiêu đề và nhãn
ggplot(data = mtcars, aes(x = wt, y = mpg)) +
  geom_point() +
  labs(
    title = "Mối quan hệ giữa trọng lượng và hiệu suất nhiên liệu",
    subtitle = "Dữ liệu mrcars",
    x = "Trọng lượng (1000 lbs)",
    y = "Miles per Gallon",
    caption = "Nguồn: Motor Trand, 1974"
  )

# Hàm labs() được sử dụng để thêm các nhãn cho đồ thị:
#   
# title: Tiêu đề chính của đồ thị
# subtitle: Tiêu đề phụ, xuất hiện dưới tiêu đề chính
# x và y: Nhãn cho trục x và trục y
# caption: Chú thích xuất hiện ở góc dưới phải đồ thị


# Thay đổi màu sắc
ggplot(data = mpg, aes(x = displ, y = hwy, color = class)) +
  geom_point() +
  scale_color_brewer(palette = "Set1")
  

# aes(x = displ, y = hwy, color = class) ánh xạ:
# 
#   "displ" (dung tích động cơ) vào trục x
# "hwy" (hiệu suất nhiên liệu trên đường cao tốc) vào trục y
# "class" (phân khúc xe) vào màu sắc của điểm
# 
# 
# Khi thêm color = class vào ánh xạ thẩm mỹ, ggplot2 sẽ tự động gán một màu khác nhau cho mỗi phân khúc xe.
# scale_color_brewer(palette = "Set1") sử dụng bảng màu "Set1" từ thư viện ColorBrewer:
#   
#   ColorBrewer cung cấp các bảng màu được thiết kế chuyên nghiệp cho đồ thị
# "Set1" là một bảng màu rời rạc với các màu sắc tương phản cao, phù hợp cho dữ liệu phân loại
# 
# 
# Kết quả là một biểu đồ điểm với các phân khúc xe được hiển thị bằng các màu khác nhau, giúp dễ dàng nhận biết các nhóm


# Thay đổi chủ đề (theme)
ggplot(data = mtcars, aes(x = wt, y = mpg)) +
  geom_point() +
  theme_minimal()


# Cài đặt gói ggthemes
install.packages("ggthemes")
library(ggthemes)

ggplot(data = mtcars, aes(x = wt, y = mpg)) +
  geom_point() +
  labs(
    title = "Mối quan hệ giữa trọng lượng và hiệu suất nhiên liệu",
    subtitle = "Dữ liệu mrcars",
    x = "Trọng lượng (1000 lbs)",
    y = "Miles per Gallon",
    caption = "Nguồn: Motor Trand, 1974"
  ) +
  theme_excel_new()

ggplot(data = mtcars, aes(x = wt, y = mpg)) +
  geom_point() +
  labs(
    title = "Mối quan hệ giữa trọng lượng và hiệu suất nhiên liệu",
    subtitle = "Dữ liệu mrcars",
    x = "Trọng lượng (1000 lbs)",
    y = "Miles per Gallon",
    caption = "Nguồn: Motor Trand, 1974"
  ) +
  theme_economist()



ggplot(data = mtcars, aes(x = wt, y = mpg)) +
  geom_point() +
  labs(
    title = "Mối quan hệ giữa trọng lượng và hiệu suất nhiên liệu",
    subtitle = "Dữ liệu mrcars",
    x = "Trọng lượng (1000 lbs)",
    y = "Miles per Gallon",
    caption = "Nguồn: Motor Trand, 1974"
  ) +
  theme_wsj()


ggplot(data = mtcars, aes(x = wt, y = mpg)) +
  geom_point() +
  labs(
    title = "Mối quan hệ giữa trọng lượng và hiệu suất nhiên liệu",
    subtitle = "Dữ liệu mrcars",
    x = "Trọng lượng (1000 lbs)",
    y = "Miles per Gallon",
    caption = "Nguồn: Motor Trand, 1974"
  ) +
  theme_solarized()



ggplot(data = mtcars, aes(x = wt, y = mpg)) +
  geom_point() +
  labs(
    title = "Mối quan hệ giữa trọng lượng và hiệu suất nhiên liệu",
    subtitle = "Dữ liệu mrcars",
    x = "Trọng lượng (1000 lbs)",
    y = "Miles per Gallon",
    caption = "Nguồn: Motor Trand, 1974"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(color = "navy", face = "bold", size = 14),
    axis.title = element_text(face = "italic"),
    axis.text = element_text(color = "darkgrey"),
    panel.grid.major = element_line(color = "lightblue", linetype = "dashed"),
    panel.grid.minor = element_blank()
  )


# Tạo chủ đề tùy chỉnh
my_theme <- theme_minimal() +
  theme(
    plot.title = element_text(face = "bold", size = 14, hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5, color = "grey40"),
    axis.title = element_text(face = "italic"),
    axis.text = element_text(color = "navy"),
    panel.grid.major = element_line(color = "grey90"),
    panel.grid.minor = element_blank(),
    legend.position = "bottom",
    legend.title = element_text(face = "bold")
  )

# Text (sử dụng element_text()):
#   
#   plot.title: Tiêu đề chính
# plot.subtitle: Tiêu đề phụ
# axis.title: Tiêu đề của cả hai trục
# axis.title.x: Tiêu đề trục x
# axis.title.y: Tiêu đề trục y
# axis.text: Văn bản của các tích trên cả hai trục
# axis.text.x: Văn bản của các tích trục x
# axis.text.y: Văn bản của các tích trục y
# legend.title: Tiêu đề chú thích
# legend.text: Văn bản của các mục trong chú thích
# plot.caption: Chú thích ở dưới đồ thị
# 
# 
# Lines (sử dụng element_line()):
#   
#   axis.line: Đường trục
# panel.grid: Tất cả đường lưới
# panel.grid.major: Đường lưới chính
# panel.grid.minor: Đường lưới phụ
# panel.grid.major.x: Đường lưới chính theo chiều ngang
# panel.grid.major.y: Đường lưới chính theo chiều dọc
# 
# 
# Rectangles (sử dụng element_rect()):
#   
#   plot.background: Nền của toàn bộ đồ thị
# panel.background: Nền của vùng dữ liệu
# legend.background: Nền của chú thích
# legend.key: Nền của các ô trong chú thích
# 
# 
# Positioning:
#   
#   legend.position: Vị trí chú thích ("top", "bottom", "left", "right", "none", hoặc tọa độ c(x,y))
# legend.justification: Điểm neo của chú thích
# plot.margin: Lề xung quanh đồ thị
# 
# 
# 
# Các hàm element_*() chấp nhận các tham số như:
#   
#   color/colour: Màu sắc
# fill: Màu nền (cho rectangle)
# size: Kích thước
# linetype: Kiểu đường (1=solid, 2=dashed, 3=dotted, 4=dotdash, 5=longdash, 6=twodash)
# lineend: Kiểu kết thúc đường ("round", "butt", "square")
# face: Kiểu font ("plain", "italic", "bold", "bold.italic")
# hjust/vjust: Canh lề ngang/dọc (0=trái/dưới, 0.5=giữa, 1=phải/trên)
# angle: Góc xoay (đơn vị độ)
# 
# Sử dụng element_blank() để ẩn hoàn toàn một thành phần.

ggplot(data = mtcars, aes(x = wt, y = mpg)) +
  geom_point() +
  labs(
    title = "Mối quan hệ giữa trọng lượng và hiệu suất nhiên liệu",
    subtitle = "Dữ liệu mrcars",
    x = "Trọng lượng (1000 lbs)",
    y = "Miles per Gallon",
    caption = "Nguồn: Motor Trand, 1974"
  ) +
  my_theme


