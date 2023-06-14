library(tidyverse)

ggplot(mpg) + geom_point(aes(x = class, y = hwy))

ggplot(mpg) + geom_smooth(aes(x = displ, y = hwy))

ggplot(mpg, aes(x = cty, y = hwy)) + geom_point(stat = "identity")
ggplot(mpg, aes(x = cty, y = hwy)) + geom_point(stat = "smooth")
ggplot(mpg, aes(x = cty, y = hwy)) + geom_smooth(stat = "identity")

ggplot(mpg, aes(x = cty)) + stat_count()
ggplot(mpg, aes(x = cty)) + geom_bar()

ggplot(mpg, aes(x = cty, y = hwy)) + geom_point()

ggplot(mpg, aes(x = cty, y = hwy)) +
  geom_point() + geom_smooth()


library("nlme")
head(Oxboys)

ggplot(Oxboys, aes(x = age, y = height)) + geom_line()
ggplot(Oxboys, aes(x = age, y = height, group = Subject)) + geom_line()

ggplot(Oxboys, aes(x = age, y = height, group = Subject)) + geom_line() + geom_smooth()

ggplot(mpg, aes(x = class, y = hwy)) + geom_point()

ggplot(mpg, aes(x = class, y = hwy)) + geom_point(alpha = 0.3)

ggplot(mpg, aes(x = class, y = hwy)) + stat_unique(alpha = 0.3)

ggplot(mpg, aes(x = class, y = hwy)) + geom_point(alpha = 0.3, stat = "unique")

ggplot(mpg, aes(x = class, y = hwy)) + stat_summary()

ggplot(mpg, aes(x = class, y = hwy)) + geom_point(alpha = 0.3, position = "jitter") +
  stat_summary(fun = mean, color = "red", size = 0.5)

ggplot(mpg, aes(x = class, y = hwy)) +
  geom_point(alpha = 0.3, position = "jitter") +
  geom_point(stat = "summary", fun = mean, color = "red", size = 4)


ggplot(mpg, aes(displ)) + geom_histogram(aes(y = ..count..))


ggplot(mpg, aes(x = class, y = hwy)) + geom_boxplot()
qqnorm(mpg$hwy)
qqline(mpg$hwy)
ggplot(mpg, aes(x = hwy)) + stat_ecdf()

ggplot(mpg, aes(x = hwy)) + geom_density()

ggplot(mpg, aes(x = displ)) + 
  geom_histogram(bins = 10, fill = "darkblue", alpha = 0.5) +
  geom_text(stat = "bin", bins = 10, aes(label = stat(count), y = stat(count)))


# 绘制小提琴图
ggplot(mpg, aes(x = class, y = hwy)) +
  geom_violin()


ggplot(mpg, aes(x = class, y = hwy)) +
  geom_violin() + geom_boxplot()


ggplot(mpg, aes(x = class, y = hwy)) +
  geom_violin(trim = F)


ggplot(mpg, aes(x = class, y = hwy)) +
  geom_violin(scale = "area")

ggplot(mpg, aes(x = class, y = hwy)) +
  geom_violin(scale = "count")


ggplot(mpg, aes(x = class, y = hwy)) +
  geom_violin(scale = "width")

ggplot(mpg, aes(x = class, y = hwy)) +
  geom_violin(draw_quantiles = c(0.25, 0.5, 0.75))

ggplot(mpg, aes(x = class, y = hwy)) +
  geom_violin(draw_quantiles = c(0.25, 0.5, 0.75), aes(fill = class))
