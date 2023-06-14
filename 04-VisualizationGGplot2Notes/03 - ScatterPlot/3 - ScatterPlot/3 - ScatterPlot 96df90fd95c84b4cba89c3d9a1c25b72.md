# 3 - ScatterPlot

## 数据结构

R语言的ggplot2的格式如下所示：

![Untitled](3%20-%20ScatterPlot%2096df90fd95c84b4cba89c3d9a1c25b72/Untitled.png)

可以发现这里有两个data相关的层。

默认情况之下，ggplot2的代码如下所示：

```
ggplot(data = mydata, mapping = aes(x = A, y = B)
```

这里的参数是在ggplot()函数中，这就意味着之后的所有的几何图都会继承该数据并且使用该数据。

但是还有另一个方法：

```
ggplot() + geom_point(data = mydata, mapping = aes(x = A, y = B))
```

这样一来就是将ggplot()调用留空，然后为每个layer指定数据和映射。如果还需要添加line layer，那么需要在geom_line()函数中添加指定的数据集和映射。

一个具体的例子如下所示：

```
library(tidyverse)
theme_set(theme_minimal())

p1 <- ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + geom_point()
p1
```

![Untitled](3%20-%20ScatterPlot%2096df90fd95c84b4cba89c3d9a1c25b72/Untitled%201.png)

接着layer添加参数而不是全局参数：

```
p2 <- ggplot() + geom_point(data = mpg, mapping = aes(x = displ, y = hwy))
p2
```

![Untitled](3%20-%20ScatterPlot%2096df90fd95c84b4cba89c3d9a1c25b72/Untitled%202.png)

从两张图来看，可以认为输出的结果是一致的。

但是这里需要考虑在geom_point()上面在添加一个geom_line()的情况：

```
p1 + geom_line()
```

![Untitled](3%20-%20ScatterPlot%2096df90fd95c84b4cba89c3d9a1c25b72/Untitled%203.png)

如果p2直接这样做，则不会有任何的改变：

```
p2 + geom_line()
```

![Untitled](3%20-%20ScatterPlot%2096df90fd95c84b4cba89c3d9a1c25b72/Untitled%204.png)

正确的做法应该是这样的：

```
p2 + geom_line(data = mpg, mapping = aes(x = displ,  y = hwy))
```

![Untitled](3%20-%20ScatterPlot%2096df90fd95c84b4cba89c3d9a1c25b72/Untitled%205.png)

选择哪种方式如下所示：

1. 如果只有一个layer，无论是在main plot还是layer都是可以的
2. 如果有多个layer，但是使用的都是相同的数据集和映射，那么在main plot
3. 如果有多个layer，并且使用不同的数据集或者映射，那么在每一个layer单独声明数据集和映射

不同的选择导致的结果并不相同，这是一个例子：

```
ggplot(mpg, aes(displ, hwy, colour = class)) +
  geom_point() +
  geom_smooth(se = FALSE)
```

![Untitled](3%20-%20ScatterPlot%2096df90fd95c84b4cba89c3d9a1c25b72/Untitled%206.png)

```
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(colour = class)) +
  geom_smooth(se = FALSE)
```

![Untitled](3%20-%20ScatterPlot%2096df90fd95c84b4cba89c3d9a1c25b72/Untitled%207.png)

这两者的核心区别在于：前者的colour = class是全局映射，但是后者的colour = class则是geom_point()这一个layer的映射，而geom_smooth()没有受到任何的影响。

注意：可以不适用x=和y=，但是这样需要特别注意参数的前后顺序。

## 重写

如果一个ggplot layer已经被声明了，那么接下来的subsequent layers将会inherit这些aesthetics。

如果想要修改，则可以这样做：

1. add aesthetics
2. override aesthetics
3. remove aesthetics

一段代码：

```
ggplot(data = mpg, aes(x = displ, y = hwy, color = hwy)) +
  geom_point()
```

![Untitled](3%20-%20ScatterPlot%2096df90fd95c84b4cba89c3d9a1c25b72/Untitled%208.png)

假设我们想要添加一种美感并且符合希望的大小的点：

```
ggplot(data = mpg, aes(x = displ, y = hwy, color = hwy)) + 
  geom_point(aes(size = hwy))
```

![Untitled](3%20-%20ScatterPlot%2096df90fd95c84b4cba89c3d9a1c25b72/Untitled%209.png)

```
ggplot(data = mpg, aes(x = displ, y = hwy, color = hwy)) + 
  geom_point(aes(x = class))
```

![Untitled](3%20-%20ScatterPlot%2096df90fd95c84b4cba89c3d9a1c25b72/Untitled%2010.png)

但是我并不喜欢这种颜色，所以我可以将其设置为NULL：

```
ggplot(data = mpg, aes(x = displ, y = hwy, color = hwy)) +
  geom_point(aes(colour = NULL))
```

![Untitled](3%20-%20ScatterPlot%2096df90fd95c84b4cba89c3d9a1c25b72/Untitled%2011.png)

## Setting v.s. Mapping

在R语言中，ggplot2中，setting和mapping是两个重要的概念。

Setting指的是全局的设定，这些设定会被应用到所有的图层(layer)中。例如，设定整个ggplot2使用的数据集、坐标轴标签字体、颜色、大小等等。

Mapping指的是将数据的一个变量映射到图形的一些属性上，例如将数据的x轴映射到图形的x轴上，将数据的颜色映射到图形的颜色上。每一个图层都可以有自己的mapping，而这些mapping只会被应用到该图层上。

因此，两者的区别是：setting是全局的设定，而mapping只应用于指定的图层(layer)。

例子：

```
# setting 和 mapping

# mapping
ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(color = hwy, size = 3))

# setting
ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point(color = "darkblue", size = 3)
```

![Untitled](3%20-%20ScatterPlot%2096df90fd95c84b4cba89c3d9a1c25b72/Untitled%2012.png)

![Untitled](3%20-%20ScatterPlot%2096df90fd95c84b4cba89c3d9a1c25b72/Untitled%2013.png)

## Data Formats 和 Melt Function

使用数据集：

```
# data formats
lw <- read.csv("longWidedata.csv")
lw

Town Year Males Females
1 Springfield 2000   200     300
2 Springfield 2020   250     250
3 Warrenville 2000  1000    1200
4 Warrenville 2020  1100    1250
5  Middletown 2000   750     600
6  Middletown 2020   500     550
```

可以发现lw的数据的宽度大于了长度，也就是列数大于了行数，对于这样的一类数据集，将其成为宽格式。

需要注意的是：这种格式并不是使用ggplot()绘图的最佳格式。

如果要绘制这样的图：

![Untitled](3%20-%20ScatterPlot%2096df90fd95c84b4cba89c3d9a1c25b72/Untitled%2014.png)

这里有两个数据点：2000年和2020年，并且还有不同城镇的男性和女性人数。

```
ggplot(lw, aes(x = Year, color = Town)) +
  geom_line(aes(y = Males)) + geom_line(aes(y = Females), linetype = "dashed") +
  geom_point(aes(y = Males)) + geom_point(aes(y = Females))
```

![Untitled](3%20-%20ScatterPlot%2096df90fd95c84b4cba89c3d9a1c25b72/Untitled%2015.png)

一个更好的方法是将数据转换为长格式：

![Untitled](3%20-%20ScatterPlot%2096df90fd95c84b4cba89c3d9a1c25b72/Untitled%2016.png)

方法是使用R语言的melt()包中的reshape2可用函数。

![Untitled](3%20-%20ScatterPlot%2096df90fd95c84b4cba89c3d9a1c25b72/Untitled%2017.png)

代码如下所示：

```
> library(reshape2)

载入程辑包：‘reshape2’

The following object is masked from ‘package:tidyr’:

    smiths

Warning message:
程辑包‘reshape2’是用R版本4.2.3 来建造的 
> melted_data <- melt(lw, id.vars = "Town")
> melted_data
          Town variable value
1  Springfield     Year  2000
2  Springfield     Year  2020
3  Warrenville     Year  2000
4  Warrenville     Year  2020
5   Middletown     Year  2000
6   Middletown     Year  2020
7  Springfield    Males   200
8  Springfield    Males   250
9  Warrenville    Males  1000
10 Warrenville    Males  1100
11  Middletown    Males   750
12  Middletown    Males   500
13 Springfield  Females   300
14 Springfield  Females   250
15 Warrenville  Females  1200
16 Warrenville  Females  1250
17  Middletown  Females   600
18  Middletown  Females   550
```

id.vars参数为想要保持原样的变量，measure.vars则为有兴趣测量的那些变量。

所以在这里，id.vars需要添加Year。

```
> melted_data <- melt(lw, id.vars = c("Year", "Town"))
> melted_data
   Year        Town variable value
1  2000 Springfield    Males   200
2  2020 Springfield    Males   250
3  2000 Warrenville    Males  1000
4  2020 Warrenville    Males  1100
5  2000  Middletown    Males   750
6  2020  Middletown    Males   500
7  2000 Springfield  Females   300
8  2020 Springfield  Females   250
9  2000 Warrenville  Females  1200
10 2020 Warrenville  Females  1250
11 2000  Middletown  Females   600
12 2020  Middletown  Females   550
```

然后来复现一下之前的代码：

```
ggplot(melted_data, aes(x = Year, y = value, color = Town)) +
  geom_line() + geom_point()
```

![Untitled](3%20-%20ScatterPlot%2096df90fd95c84b4cba89c3d9a1c25b72/Untitled%2018.png)

可以发现代码变得简洁了很多。

## Scatter Plot

首先需要导入库和设置主题：

```
# scatter plot
library(dplyr)
library(ggplot2)
theme_set(theme_minimal())
```

使用的数据集为starwars：

```
> starwars
# A tibble: 87 × 14
   name     height  mass hair_…¹ skin_…² eye_c…³ birth…⁴ sex  
   <chr>     <int> <dbl> <chr>   <chr>   <chr>     <dbl> <chr>
 1 Luke Sk…    172    77 blond   fair    blue       19   male 
 2 C-3PO       167    75 NA      gold    yellow    112   none 
 3 R2-D2        96    32 NA      white,… red        33   none 
 4 Darth V…    202   136 none    white   yellow     41.9 male 
 5 Leia Or…    150    49 brown   light   brown      19   fema…
 6 Owen La…    178   120 brown,… light   blue       52   male 
 7 Beru Wh…    165    75 brown   light   blue       47   fema…
 8 R5-D4        97    32 NA      white,… red        NA   none 
 9 Biggs D…    183    84 black   light   brown      24   male 
10 Obi-Wan…    182    77 auburn… fair    blue-g…    57   male 
# … with 77 more rows, 6 more variables: gender <chr>,
#   homeworld <chr>, species <chr>, films <list>,
#   vehicles <list>, starships <list>, and abbreviated
#   variable names ¹hair_color, ²skin_color, ³eye_color,
#   ⁴birth_year
# ℹ Use `print(n = ...)` to see more rows, and `colnames()` to see all variable names
```

首先我们只考虑人类，因为身高之类的变量对于机器人而言意义不大：

```
> humans <- filter(starwars, species == "Human")
> humans
# A tibble: 35 × 14
   name     height  mass hair_…¹ skin_…² eye_c…³ birth…⁴ sex  
   <chr>     <int> <dbl> <chr>   <chr>   <chr>     <dbl> <chr>
 1 Luke Sk…    172    77 blond   fair    blue       19   male 
 2 Darth V…    202   136 none    white   yellow     41.9 male 
 3 Leia Or…    150    49 brown   light   brown      19   fema…
 4 Owen La…    178   120 brown,… light   blue       52   male 
 5 Beru Wh…    165    75 brown   light   blue       47   fema…
 6 Biggs D…    183    84 black   light   brown      24   male 
 7 Obi-Wan…    182    77 auburn… fair    blue-g…    57   male 
 8 Anakin …    188    84 blond   fair    blue       41.9 male 
 9 Wilhuff…    180    NA auburn… fair    blue       64   male 
10 Han Solo    180    80 brown   fair    brown      29   male 
# … with 25 more rows, 6 more variables: gender <chr>,
#   homeworld <chr>, species <chr>, films <list>,
#   vehicles <list>, starships <list>, and abbreviated
#   variable names ¹hair_color, ²skin_color, ³eye_color,
#   ⁴birth_year
# ℹ Use `print(n = ...)` to see more rows, and `colnames()` to see all variable names
```

接着将NA值去除掉：

```
humans <- humans[!is.na(humans$mass), ]
humans

# A tibble: 22 × 14
   name     height  mass hair_…¹ skin_…² eye_c…³ birth…⁴ sex  
   <chr>     <int> <dbl> <chr>   <chr>   <chr>     <dbl> <chr>
 1 Luke Sk…    172    77 blond   fair    blue       19   male 
 2 Darth V…    202   136 none    white   yellow     41.9 male 
 3 Leia Or…    150    49 brown   light   brown      19   fema…
 4 Owen La…    178   120 brown,… light   blue       52   male 
 5 Beru Wh…    165    75 brown   light   blue       47   fema…
 6 Biggs D…    183    84 black   light   brown      24   male 
 7 Obi-Wan…    182    77 auburn… fair    blue-g…    57   male 
 8 Anakin …    188    84 blond   fair    blue       41.9 male 
 9 Han Solo    180    80 brown   fair    brown      29   male 
10 Wedge A…    170    77 brown   fair    hazel      21   male 
# … with 12 more rows, 6 more variables: gender <chr>,
#   homeworld <chr>, species <chr>, films <list>,
#   vehicles <list>, starships <list>, and abbreviated
#   variable names ¹hair_color, ²skin_color, ³eye_color,
#   ⁴birth_year
# ℹ Use `print(n = ...)` to see more rows, and `colnames()` to see all variable names
```

接着开始使用散点图：

```
ggplot(humans, aes(x = mass, y = height)) + 
  geom_point()
```

![Untitled](3%20-%20ScatterPlot%2096df90fd95c84b4cba89c3d9a1c25b72/Untitled%2019.png)

可以发现图中有一些点可以存在着重叠的情况，所以这里来进行进一步的修改：

```
ggplot(humans, aes(x = mass, y = height)) +
  geom_point(size = 4, alpha = 0.4)
```

![Untitled](3%20-%20ScatterPlot%2096df90fd95c84b4cba89c3d9a1c25b72/Untitled%2020.png)

再进一步的提升为：

```
# 添加BMI列
humans <- mutate(humans, BMI = mass / (height / 100) ^ 2)

ggplot(humans, aes(x = mass, y = height)) +
  geom_point(aes(color = BMI), size = 4)
```

![Untitled](3%20-%20ScatterPlot%2096df90fd95c84b4cba89c3d9a1c25b72/Untitled%2021.png)

```
ggplot(humans, aes(x = mass, y = height)) +
  geom_point(aes(color = BMI), size = 4) +
  scale_color_gradient(low = "green", high  = "red")
```

![Untitled](3%20-%20ScatterPlot%2096df90fd95c84b4cba89c3d9a1c25b72/Untitled%2022.png)

## Scatter Plot Exercises

要做绘制一张如下所示的图形：

![Untitled](3%20-%20ScatterPlot%2096df90fd95c84b4cba89c3d9a1c25b72/Untitled%2023.png)

```
library(dplyr)
class_info <- summarise(group_by(mpg, class),
n=n(), hwy=mean(hwy))
```