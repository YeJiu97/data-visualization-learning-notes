# 映射位置

library(tidyverse)

theme_set(theme_minimal())

p1 <- ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + geom_point()
p1


p2 <- ggplot() + geom_point(data = mpg, mapping = aes(x = displ, y = hwy))
p2


p1 + geom_line()

p2 + geom_line()

p2 + geom_line(data = mpg, mapping = aes(x = displ,  y = hwy))


ggplot(mpg, aes(displ, hwy, colour = class)) +
  geom_point() +
  geom_smooth(se = FALSE)

ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(colour = class)) +
  geom_smooth(se = FALSE)



# overriding
ggplot(data = mpg, aes(x = displ, y = hwy, color = hwy)) +
  geom_point()

ggplot(data = mpg, aes(x = displ, y = hwy, color = hwy)) + 
  geom_point(aes(size = hwy))

ggplot(data = mpg, aes(x = displ, y = hwy, color = hwy)) + 
  geom_point(aes(x = class))

ggplot(data = mpg, aes(x = displ, y = hwy, color = hwy)) +
  geom_point(aes(colour = NULL))


# setting 和 mapping
# mapping
ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(color = hwy, size = 3))

# setting
ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point(color = "darkblue", size = 3)



# data formats
lw <- read.csv("longWidedata.csv")
lw

ggplot(lw, aes(x = Year, color = Town)) +
  geom_line(aes(y = Males)) + geom_line(aes(y = Females), linetype = "dashed") +
  geom_point(aes(y = Males)) + geom_point(aes(y = Females))


library(reshape2)
melted_data <- melt(lw, id.vars = "Town")
melted_data

melted_data <- melt(lw, id.vars = c("Year", "Town"))
melted_data

ggplot(melted_data, aes(x = Year, y = value, color = Town)) +
  geom_line() + geom_point()



# scatter plot
library(dplyr)
library(ggplot2)
theme_set(theme_minimal())

starwars


humans <- filter(starwars, species == "Human")
humans

humans <- humans[!is.na(humans$mass), ]
humans


ggplot(humans, aes(x = mass, y = height)) + 
  geom_point()

ggplot(humans, aes(x = mass, y = height)) +
  geom_point(size = 4, alpha = 0.4)

ggplot(humans, aes(x = mass, y = height)) +
  geom_point(size = 4, alpha = 0.4, position = "jitter")



# 添加BMI列
humans <- mutate(humans, BMI = mass / (height / 100) ^ 2)

ggplot(humans, aes(x = mass, y = height)) +
  geom_point(aes(color = BMI), size = 4)

ggplot(humans, aes(x = mass, y = height)) +
  geom_point(aes(color = BMI), size = 4) +
  scale_color_gradient(low = "green", high  = "red")