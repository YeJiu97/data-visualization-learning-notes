getwd()

# 一个变量
a <- "abcde"
a

# 移除
remove(a)

b <- "bcde"
ls()

# 移除
rm(b)

?read.csv()

# 打印
print("Hello R Programming")

# cat()打印
a <- "R"

cat("Hello ", a, "programming.")

# 安装ggplot2
# install.packages(ggplot2)

# 加载ggplot2
library(ggplot2)

# 内置数据集
mpg


# types
num = 123456
typeof(num)


# vectors
v1 <- c(1, 2, 3, 4, 5)
typeof(v1)
class(v1)

v2 <- c("a", "b", "c", "d")
typeof(v2)
class(v2)


# 指令生成
num_vector <- vector("numeric", length = 5)
num_vector


# 使用 : 来进行切割
vector_char <- c(1, 2, 3, 4, 5, 6, 7, 8)
vector_char
vector_char[2:4]

# 使用 : 来进行生成
vector_num <- c(1:10)
vector_num

# 使用 -n 来排除位于 n 位置的元素
vector_num[-2]
vector_num[-1]

# 使用c()来去除多个位置的元素
vector_num[c(-1, -3, -5)]

# 使用c()来获得特定位置的元素
vector_num[c(1, 4, 6, 9, 2)]

# 修改值
vector_char <- c("A", "B", "C")
vector_char

vector_char[1] <- "Modify"
vector_char

# 新元素
vector_char <- c(vector_char, "D")
vector_char

# mixing classes
vector_mix <- c(TRUE, "Hello")
vector_mix

vector_mix_2 <- c(1, FALSE)
vector_mix_2

class(vector_mix)
class(vector_mix_2)


vector_1 <- c(1, 2, 3, 4, 5)
typeof(vector_1)
class(vector_1)
vector_2 <- c("1", "2", "3", "4", "5")
typeof(vector_2)
class(vector_2)
vector_1 == vector_2

length(vector_1)
dim(vector_1)

vector_1 <- c(1, 2, 3, 4, 5)
vector_2 <- c(6, 7, 8, 9, 10)
vector_com <- c(vector_1, vector_2)
vector_com


# R list
l <- list()
class(l)

l <- list("Johm", 72, TRUE)
l


v <- c(1, 2, 3)
l <- list(l, v)
l

l[[1]][[2]]
length(l)

names(l) <- c("Name", "Age", "Retired", "Numbers", "Parents")


## Matrices
# 生成一个matrix

x <- matrix(1:12, nrow = 4, ncol = 3)
x

x <- matrix(1:12, nrow = 4, ncol = 3, byrow = TRUE)
x

y <- matrix(1:13, nrow = 4, ncol = 3)

y <- matrix(1:16, nrow = 4, ncol = 3)
y

z <- matrix(1:12, nrow = 4, ncol = 4)
z

j <- matrix("Hello", nrow= 4, ncol = 4)
j

myrows <- c("A", "B", "C", "D")
mycols <- c("col1", "col2", "col3", "col4")

matrix_1 <- matrix(1:16, nrow = 4, ncol = 4, dimnames = list(myrows, mycols))
matrix_1

colnames(matrix_1)
rownames(matrix_1)

rownames(matrix_1)[4] <- "ZZ"
rownames(matrix_1)


matrix_1[6]


matrix_1


# array
array_01 <- array(1:18, dim = c(3, 3, 2))
array_01


df <- data.frame(x = 1:3, y = 3:1)
df


person_names <- c("Alice", "Bob", "Charlie", "David")
ages <- c(45, 35, 25, 60)

df <- data.frame(person_names, ages)
df


typeof(df)
class(df)


vec_03 <- c(1, 2, 3, 4, 5, 6)
as.data.frame(vec_03)

length(df)

head(cars, n = 10)
tail(cars, n = 10)


cars_df <- cars
head(cars_df)
tail(cars_df)

# 查看cars数据集的速度列
cars_df$speed

# 查看cars数据集的dist列
cars_df$dist

# 注意区别
class(cars_df["speed"])
class(cars_df$speed)


# 条件判断选择
cars_df[cars_df$speed <= 7, ]

# 多个条件判断
cars_df[(cars_df$speed <= 7 & cars_df$dist >= 10), ]


# factor
x <- factor(c("AA", "BB", "CC"), levels = c("AA", "BB", "CC"))
x

is.factor(x)

class(x)

x <- factor(c("AA", "BB", "CC", "DD"), levels = c("AA", "BB", "CC"))
x

x <- factor(c("AA", "BB", "CC", "BB"), levels = c("AA", "BB", "CC"))
x


sample_df <- read.table("readSample.csv")
sample_df
is.data.frame(sample_df)

sample_df_csv <- read.csv("readSample.csv")
sample_df_csv

sample_df <- read.table("readSample.csv", header =  TRUE)
head(sample_df)


sample_df <- read.table("readSample.csv", header =  TRUE, sep = " ")
sample_df

sample_df <- read.table("readSample.csv", header = TRUE, stringsAsFactors = TRUE)
class(sample_df$Residence)



# 操作尝试
library(dplyr)
tf_df <- read.csv("transformSample.csv")
head(tf_df)
str(tf_df)  # 使用str()查看数据框的结构


# filter()函数
filter(tf_df, Age < 35)
filter(tf_df, Age < 35, Residence == "Boston")
filter(tf_df, Age < 35, Residence == "Boston" | Residence == "Middletown")
filter(tf_df, Age < 35, Residence %in% c("Boston", "Middletown"))




# select
select(tf_df, Age)
select(tf_df, Age, Residence)

select(tf_df, starts_with("Res"))
select(tf_df, ends_with("ts"))

rename_with(tf_df, toupper)
tf_df

select(filter(tf_df, Active == TRUE), Age)
filter(tf_df, Active == TRUE)


filter(tf_df, Active == TRUE) %>% select(Age)

arrange(tf_df, Age)
arrange(tf_df, desc(Age))

arrange(tf_df, Residence, Age)


# missing values
air_df <- airquality
air_df

complete.cases(air_df)


air_df[complete.cases(air_df), ]

na.omit(air_df)


# Date
date()


# merge 两个 DataFrames
x <- read.csv("transformSample.csv")
y <- read.csv("https://raw.githubusercontentcom/claragranell/data/main/transformSample.csv")
