# 2 - Line Graphics

## Grammar

ggplot2的核心：图形分层语法。

假设我们需要给下表绘制图形：

![Untitled](2%20-%20Line%20Graphics%20d4246f17db7843ce896f1b26e1c8cfb0/Untitled.png)

绘制散点图，如何做？

![Untitled](2%20-%20Line%20Graphics%20d4246f17db7843ce896f1b26e1c8cfb0/Untitled%201.png)

进行转换：

![Untitled](2%20-%20Line%20Graphics%20d4246f17db7843ce896f1b26e1c8cfb0/Untitled%202.png)

不同的坐标：

![Untitled](2%20-%20Line%20Graphics%20d4246f17db7843ce896f1b26e1c8cfb0/Untitled%203.png)

绘制的逻辑为：

1. 首先选定数据集

![Untitled](2%20-%20Line%20Graphics%20d4246f17db7843ce896f1b26e1c8cfb0/Untitled%204.png)

1. 选择对应的x和y，以及形状：

![Untitled](2%20-%20Line%20Graphics%20d4246f17db7843ce896f1b26e1c8cfb0/Untitled%205.png)

1. 选择图形的类型：

![Untitled](2%20-%20Line%20Graphics%20d4246f17db7843ce896f1b26e1c8cfb0/Untitled%206.png)

1. 选择了标尺 scale

![Untitled](2%20-%20Line%20Graphics%20d4246f17db7843ce896f1b26e1c8cfb0/Untitled%207.png)

1. 进行统计转换：

![Untitled](2%20-%20Line%20Graphics%20d4246f17db7843ce896f1b26e1c8cfb0/Untitled%208.png)

总结为：

![Untitled](2%20-%20Line%20Graphics%20d4246f17db7843ce896f1b26e1c8cfb0/Untitled%209.png)

R语言代码如下所示：

```
a <- c(2, 1, 4, 9)
b <- c(3, 2, 5, 12)
c <- c(4, 1, 15, 8)
d <- c("a", "a", "b", "b")

mydata <- data.frame(a, b, c, d)

mydata

p <- ggplot(data = mydata, mapping = aes(x = a, y = c))
p
```

得到的结果为：

![Untitled](2%20-%20Line%20Graphics%20d4246f17db7843ce896f1b26e1c8cfb0/Untitled%2010.png)

这是一个空白图，x轴为a列，y轴为c列。

然后接下来的是进行绘制：

```
p <- p + geom_point(mapping = aes(shape = D), stat = "identity", size = 4, position = "identity")
p
```

得到的结果为：

![Untitled](2%20-%20Line%20Graphics%20d4246f17db7843ce896f1b26e1c8cfb0/Untitled%2011.png)

接着是添加一个比例：

```
p <- p + scale_x_continuous() + scale_y_log10()
p
```

得到的结果为：

![Untitled](2%20-%20Line%20Graphics%20d4246f17db7843ce896f1b26e1c8cfb0/Untitled%2012.png)

默认的坐标系：

```
p <- p + coord_cartesian()
p
```

![Untitled](2%20-%20Line%20Graphics%20d4246f17db7843ce896f1b26e1c8cfb0/Untitled%2013.png)

采用polar坐标系：

```
p <- p + coord_polar()
p
```

得到的结果为：

![Untitled](2%20-%20Line%20Graphics%20d4246f17db7843ce896f1b26e1c8cfb0/Untitled%2014.png)

我们将坐标系修改回来。

还有一个办法就是进行分页：

```
> p <- p + facet_grid(cols = vars(D))
> p
```

![Untitled](2%20-%20Line%20Graphics%20d4246f17db7843ce896f1b26e1c8cfb0/Untitled%2015.png)

上面的内容可以写在一起：

```
ggplot(data = mydata, mapping = aes(x = A, y = C)) +  # 使用ggplot，数据为mydata，映射为x是A而y是C
  geom_point(mapping = aes(shape =D),  # geom层面使用散点
             stat = "identity",
             size = 4,
             position = "identity") + 
  scale_x_continuous() + 
  scale_y_log10() + # 比例
  coord_cartesian() +
  
  facet_grid(cols = vars(D));
```

## line

这里使用mpg：

```
library(ggplot2)

p <- ggplot(data = mpg, mapping = aes(x = displ, y = hwy))
p
p + geom_point()
```

![Untitled](2%20-%20Line%20Graphics%20d4246f17db7843ce896f1b26e1c8cfb0/Untitled%2016.png)

这次尝试使用折线图：

```
p + geom_line()
```

![Untitled](2%20-%20Line%20Graphics%20d4246f17db7843ce896f1b26e1c8cfb0/Untitled%2017.png)

我们可以同时使用散点和折现：

```
p + geom_line() + geom_point()
```

![Untitled](2%20-%20Line%20Graphics%20d4246f17db7843ce896f1b26e1c8cfb0/Untitled%2018.png)

还有一个就是路径图：

```
p + geom_path()
```

得到的结果为：

![Untitled](2%20-%20Line%20Graphics%20d4246f17db7843ce896f1b26e1c8cfb0/Untitled%2019.png)

可以发现这个图非常的混乱。

可以尝试一下：

```
p + geom_polygon()
```

得到的结果为：

![Untitled](2%20-%20Line%20Graphics%20d4246f17db7843ce896f1b26e1c8cfb0/Untitled%2020.png)

我们可以尝试一下bar：

```
> p + geom_bar()
Error in `geom_bar()`:
! Problem while computing stat.
ℹ Error occurred in the 1st layer.
Caused by error in `setup_params()`:
! `stat_count()` must only have an x or y aesthetic.
Run `rlang::last_error()` to see where the error occurred.
```

可以发现这RStudio会报错。

这是因为geom_bar()是统计数据“计数”，因此只有X或者Y，不会展示X和Y之间的联系。

我们这里可以这样做：

```
> p <- ggplot(data = mpg, mapping = aes(x = displ)) + geom_bar()
> p
```

这是一些参数：

![Untitled](2%20-%20Line%20Graphics%20d4246f17db7843ce896f1b26e1c8cfb0/Untitled%2021.png)

例子：

```
> p <- ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + geom_point(shape = 8, size = 4)
> p
```

如下所示：

![Untitled](2%20-%20Line%20Graphics%20d4246f17db7843ce896f1b26e1c8cfb0/Untitled%2022.png)

接着是geom_bar()：

```
> p <- ggplot(data = mpg, mapping = aes(x = displ)) + geom_bar(fill = "red", shape = 8)
Warning message:
In geom_bar(fill = "red", shape = 8) :
  Ignoring unknown parameters: `shape`
> p
```

得到的结果为：

![Untitled](2%20-%20Line%20Graphics%20d4246f17db7843ce896f1b26e1c8cfb0/Untitled%2023.png)

因为shape不是geom_bar的美学之一，所以会报错。

这个一个列表：

![Untitled](2%20-%20Line%20Graphics%20d4246f17db7843ce896f1b26e1c8cfb0/Untitled%2024.png)

## 存储plot

ggsave可以用来保存plot：

![Untitled](2%20-%20Line%20Graphics%20d4246f17db7843ce896f1b26e1c8cfb0/Untitled%2025.png)

代码尝试：

```
> ## ggsave
> p <- ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + geom_point()
> p
> ggsave("plot1.pdf")  # 开始保存
Saving 3.42 x 2.52 in image
```

![Untitled](2%20-%20Line%20Graphics%20d4246f17db7843ce896f1b26e1c8cfb0/Untitled%2026.png)

我们还可以进行修改：

```
ggsave("plot1.pdf", width = 5, height = 5)
```

这样可以得到一个正方形的图形。

我们还可以加入更多的参数：

```
> p <- ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + geom_point() + labs(title = "Plot title", x = "Displacement", y = "Highway") + theme(text = element_text(size = 15, family = "Poppins"))
> p
There were 15 warnings (use warnings() to see them)
> ggsave("plot1.pdf", device = cairo_pdf())
Saving 7 x 7 in image
Error in grid.Call.graphics(C_text, as.graphicsAnnot(x$label), x$x, x$y,  : 
  字体类别出错
In addition: There were 50 or more warnings (use warnings() to see the first 50)
```

![Untitled](2%20-%20Line%20Graphics%20d4246f17db7843ce896f1b26e1c8cfb0/Untitled%2027.png)

```
> ggsave("plot1.pdf", device = cairo_pdf)
Saving 7 x 7 in image
```

## line plot family

如下图所示：

![Untitled](2%20-%20Line%20Graphics%20d4246f17db7843ce896f1b26e1c8cfb0/Untitled%2028.png)

在上图中：

1. x，y：x轴和y轴分别代表了什么变量
2. alpha：透明度
3. colour/color：色彩，也可以传递一个变量，R语言会按照变量中的数据类别数量类匹配颜色用来表示不同类别
4. linetype：线条的类型
5. size：线条的粗细
6. group：分组

linetype可以参考这幅图：

![Untitled](2%20-%20Line%20Graphics%20d4246f17db7843ce896f1b26e1c8cfb0/Untitled%2029.png)

这里安装和导入数据集：

```
library(babynames)
babynames
```

得到的结果为：

```
> babynames
# A tibble: 1,924,665 × 5
    year sex   name          n   prop
   <dbl> <chr> <chr>     <int>  <dbl>
 1  1880 F     Mary       7065 0.0724
 2  1880 F     Anna       2604 0.0267
 3  1880 F     Emma       2003 0.0205
 4  1880 F     Elizabeth  1939 0.0199
 5  1880 F     Minnie     1746 0.0179
 6  1880 F     Margaret   1578 0.0162
 7  1880 F     Ida        1472 0.0151
 8  1880 F     Alice      1414 0.0145
 9  1880 F     Bertha     1320 0.0135
10  1880 F     Sarah      1288 0.0132
# … with 1,924,655 more rows
# ℹ Use `print(n = ...)` to see more rows
```

然后我们开始进行操作：

```
# line family
library(babynames)
baby_df <- babynames

library(dplyr)

```

```
> anna <- filter(baby_df, name == "Anna")
> anna
# A tibble: 273 × 5
    year sex   name      n     prop
   <dbl> <chr> <chr> <int>    <dbl>
 1  1880 F     Anna   2604 0.0267  
 2  1880 M     Anna     12 0.000101
 3  1881 F     Anna   2698 0.0273  
 4  1881 M     Anna     16 0.000148
 5  1882 F     Anna   3143 0.0272  
 6  1883 F     Anna   3306 0.0275  
 7  1883 M     Anna     16 0.000142
 8  1884 F     Anna   3860 0.0281  
 9  1884 M     Anna     20 0.000163
10  1885 F     Anna   3994 0.0281  
# … with 263 more rows
# ℹ Use `print(n = ...)` to see more rows
```

我们得到了所有名为Anna的结果，但是这里我们需要的是女性，也就是所有sex被标记为F的Anna：

```
> anna
# A tibble: 138 × 5
    year sex   name      n   prop
   <dbl> <chr> <chr> <int>  <dbl>
 1  1880 F     Anna   2604 0.0267
 2  1881 F     Anna   2698 0.0273
 3  1882 F     Anna   3143 0.0272
 4  1883 F     Anna   3306 0.0275
 5  1884 F     Anna   3860 0.0281
 6  1885 F     Anna   3994 0.0281
 7  1886 F     Anna   4283 0.0279
 8  1887 F     Anna   4227 0.0272
 9  1888 F     Anna   4982 0.0263
10  1889 F     Anna   5062 0.0268
# … with 128 more rows
# ℹ Use `print(n = ...)` to see more rows
```

接着绘制一个折线图：

```
theme_set(theme_minimal())  # 较浅的背景
ggplot(anna, aes(x = year, y = n)) + geom_line()
```

![Untitled](2%20-%20Line%20Graphics%20d4246f17db7843ce896f1b26e1c8cfb0/Untitled%2030.png)

另一个形式：

```
ggplot(anna, aes(x = year, y = n)) + geom_step()
```

![Untitled](2%20-%20Line%20Graphics%20d4246f17db7843ce896f1b26e1c8cfb0/Untitled%2031.png)

使用area可以进行填充：

```
ggplot(anna, aes(x = year, y = n)) + geom_area()
```

![Untitled](2%20-%20Line%20Graphics%20d4246f17db7843ce896f1b26e1c8cfb0/Untitled%2032.png)

修改一下line的属性：

```
ggplot(anna, aes(x = year, y = n)) + geom_line(linewidth = 1.2, alpha = 0.5, linetype = "dashed")
```

![Untitled](2%20-%20Line%20Graphics%20d4246f17db7843ce896f1b26e1c8cfb0/Untitled%2033.png)

## drawing line plots with multiple lines

首先安装包：

```
install.packages("viridis")
```

接着筛选数据：

```
library("viridis")
baby <- filter(babynames, name %in% c("Anna", "Emma", "Clara"), sex == "F")
```

开始绘制：

```
ggplot(baby, aes(x = year, y = n)) + geom_line()
```

![Untitled](2%20-%20Line%20Graphics%20d4246f17db7843ce896f1b26e1c8cfb0/Untitled%2034.png)

这是因为对于x轴的每个值，我们对每个之都有一个观察值。

提升的一个方法是将相同的name组成一个group：

```
ggplot(baby, aes(x = year, y = n, group = name)) + geom_line()
```

结果为：

![Untitled](2%20-%20Line%20Graphics%20d4246f17db7843ce896f1b26e1c8cfb0/Untitled%2035.png)

在进一步的提升就是使用color来标注不同的name group：

```
ggplot(baby, aes(x = year, y = n, group = name, color = name)) + geom_line()
```

![Untitled](2%20-%20Line%20Graphics%20d4246f17db7843ce896f1b26e1c8cfb0/Untitled%2036.png)

接着来对line的size进行修改：

```
ggplot(baby, aes(x = year, y = n, group = name, color = name)) + geom_line(linewidth = 1)
```

![Untitled](2%20-%20Line%20Graphics%20d4246f17db7843ce896f1b26e1c8cfb0/Untitled%2037.png)

linewidth是关于line的属性，所以linewidth=1在geom_line()函数中。

或者我们可以这样做：

```
# 或者我们可以这样做
ggplot(baby, aes(x = year, y = n, group = name, color = name)) + geom_line() + scale_color_viridis(discrete = T)
```

![Untitled](2%20-%20Line%20Graphics%20d4246f17db7843ce896f1b26e1c8cfb0/Untitled%2038.png)

## line plot exercise

需要绘制这样的一张图：

![Untitled](2%20-%20Line%20Graphics%20d4246f17db7843ce896f1b26e1c8cfb0/Untitled%2039.png)

代码如下所示：

```
# line plot exercise
# 首先对babynames进行筛选，将
baby_ex <- filter(babynames, name %in% c("Jessica", "Natalie", "Saray"), sex == "F")
# 将年份选出来
baby_ex_range <- filter(baby_ex, year > 1980 & year < max(baby$year))
# 开始进行绘制
ggplot(baby_ex_range, aes(x = year, y = n, group = name, color = name)) + geom_line()

ggplot(baby_ex_range, aes(x = year, y = n, group = name, color = name)) + geom_line(size = 1.1) +
  scale_color_viridis(discrete = T) + geom_point(size = 3)
```

![Untitled](2%20-%20Line%20Graphics%20d4246f17db7843ce896f1b26e1c8cfb0/Untitled%2040.png)