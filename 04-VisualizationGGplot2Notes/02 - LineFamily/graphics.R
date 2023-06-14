# ggplot 2 grammar

library(ggplot2)

df_01 <- read.csv("matrix_01.csv", header = TRUE)


A <- c(2, 1, 4, 9)
B <- c(3, 2, 5, 12)
C <- c(4, 1, 15, 8)
D <- c("a", "a", "b", "b")

mydata <- data.frame(A, B, C, D)

mydata

p <- ggplot(data = mydata, mapping = aes(x = A, y = C))
p

p <- p + geom_point(mapping = aes(shape = D), stat = "identity", size = 4, position = "identity")
p

p <- p + scale_x_continuous() + scale_y_log10()
p

p <- p + coord_cartesian()
p

p <- p + coord_polar()
p

p <- p + coord_cartesian()
p


p <- p + facet_grid(cols = vars(D))
p


ggplot(data = mydata, mapping = aes(x = A, y = C)) +  # 使用ggplot，数据为mydata，映射为x是A而y是C
  geom_point(mapping = aes(shape =D),  # geom层面使用散点
             stat = "identity",
             size = 4,
             position = "identity") + 
  scale_x_continuous() + 
  scale_y_log10() + # 比例
  coord_cartesian() +
  
  facet_grid(cols = vars(D));




# ggplot2 line
library(ggplot2)

p <- ggplot(data = mpg, mapping = aes(x = displ, y = hwy))
p
p + geom_point()

p + geom_line()

p + geom_line() + geom_point()

p + geom_point() + geom_line()

p + geom_path()

p + geom_polygon()



## ggsave
p <- ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + geom_point()
p
ggsave("plot1.pdf")  # 开始保存

p <- ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + geom_point() + labs(title = "Plot title", x = "Displacement", y = "Highway") + theme(text = element_text(size = 15, family = "Poppins"))
p

ggsave("plot1.pdf", device = cairo_pdf)




# line family
library(babynames)
baby_df <- babynames

library(dplyr)

anna <- filter(baby_df, name == "Anna", sex == "F")
anna

anna <- filter(baby_df, name == "Anna", sex == "F")
anna

theme_set(theme_minimal())  # 较浅的背景
ggplot(anna, aes(x = year, y = n)) + geom_line()
ggplot(anna, aes(x = year, y = n)) + geom_path()
ggplot(anna, aes(x = year, y = n)) + geom_step()
ggplot(anna, aes(x = year, y = n)) + geom_area()


ggplot(anna, aes(x = year, y = n)) + geom_line(linewidth = 1.2, alpha = 0.5, linetype = "dashed")


# multiple lines
install.packages("viridis")

library("viridis")
baby <- filter(babynames, name %in% c("Anna", "Emma", "Clara"), sex == "F")

ggplot(baby, aes(x = year, y = n)) + geom_line()
ggplot(baby, aes(x = year, y = n, group = name, color = name)) + geom_line(linewidth = 1) 

# 或者我们可以这样做
ggplot(baby, aes(x = year, y = n, group = name, color = name)) + geom_line() + scale_color_viridis(discrete = T)


# line plot exercise
# 首先对babynames进行筛选，将
baby_ex <- filter(babynames, name %in% c("Jessica", "Natalie", "Saray"), sex == "F")
# 将年份选出来
baby_ex_range <- filter(baby_ex, year > 1980 & year < max(baby$year))
# 开始进行绘制
ggplot(baby_ex_range, aes(x = year, y = n, group = name, color = name)) + geom_line()


ggplot(baby_ex_range, aes(x = year, y = n, group = name, color = name)) + geom_line(size = 1.1) +
  scale_color_viridis(discrete = T) + geom_point(size = 3)
