#' ---
#' title: "Class 05 Data Visualization"
#' author: "Nadia Haghani"
#' ---

# Lets start with a scatterplot

#install.packages("ggplot2")
library(ggplot2) #load before using

# Every ggplot has a data + aes + geoms
p <- ggplot(data = cars) +
  aes(x=speed, y=dist) +
  geom_point() + 
  geom_smooth(method="lm")
  
p + labs(title = "My nice plot", 
         x= "Speed (MPH)", 
         y = "Distance (ft)") + 
  theme_bw()


# A More complicated dataset

# First read the dataset
url <- "https://bioboot.github.io/bimm143_S20/class-material/up_down_expression.txt"
genes <- read.delim(url)
head(genes)


# How many genes in dataset?
nrow(genes)

# How to access State col
table(genes$State)

# What % are up/down
prec <- table(genes$State) / nrow(genes) * 100
round(prec, 2)

# Make a basic scatterplot of genes dataset

ggplot(data = genes) + 
  aes(x = Condition1, y = Condition2) +
  geom_point()

# Adding color to the state of the gene

p <- ggplot(genes) +
  aes(x=Condition1, y=Condition2, col=State) + 
  geom_point()
p

# Change color

p + scale_colour_manual(values= c("blue", "grey", "red")) + 
  labs(title = "Gene Expression Changes Upon Drug Treatment",
      x = "Control (no drug)", 
      y = "Drug Treatment")

# OPTIONAL: going forward with gapmider dataset

url <- "https://raw.githubusercontent.com/jennybc/gapminder/master/inst/extdata/gapminder.tsv"
gapminder <- read.delim(url)

# install.packages("dplyr")

library(dplyr)
gapminder_2007 <- gapminder %>% filter(year==2007)

# Basic scatterplot of gapminder_2007 dataset
ggplot(gapminder_2007) +
  aes(x=gdpPercap, y=lifeExp, color=continent, size=pop) + 
  geom_point(alpha=0.5) #alpha argument makes points slightly transparent

ggplot(gapminder_2007) +
  aes(x=gdpPercap, y=lifeExp, color=pop) + # color=pop changes to continuous scale
  geom_point(alpha=0.8)

# Adjust point size

ggplot(gapminder_2007) + 
  geom_point(aes(x=gdpPercap, y=lifeExp, size=pop), alpha=0.5) + 
  scale_size_area(max_size = 10)
  

# Bar Plots attempted

gapminder_top5 <- gapminder %>% 
  filter(year==2007) %>% 
  arrange(desc(pop)) %>% 
  top_n(5, pop)

gapminder_top5

ggplot(gapminder_top5) + 
  geom_col(aes(x=country, y=pop))

# Q. Plot life expectancy by country

ggplot(gapminder_top5) +
  geom_col(aes(x=country, y=lifeExp))

# Filling bars with color

ggplot(gapminder_top5) + 
  geom_col(aes(x=country, y=pop, fill=lifeExp))


# Q. Plot population size by country

ggplot(gapminder_top5) + 
  aes(x=reorder(country, -pop), y=pop, fill=country) + 
  geom_col(col="gray30") + 
  guides(fill=FALSE)
  

# Advanced plot animations

#install.packages("gifski")
#install.packages("gganimate")

library(gapminder)

library(gganimate)

# # Setup nice regular ggplot of the gapminder data
# ggplot(gapminder, aes(gdpPercap, lifeExp, size = pop, colour = country)) +
#   geom_point(alpha = 0.7, show.legend = FALSE) +
#   scale_colour_manual(values = country_colors) +
#   scale_size(range = c(2, 12)) +
#   scale_x_log10() +
#   # Facet by continent
#   facet_wrap(~continent) +
#   # Here comes the gganimate specific bits
#   labs(title = 'Year: {frame_time}', x = 'GDP per capita', y = 'life expectancy') +
#   transition_time(year) +
#   shadow_wake(wake_length = 0.1, alpha = FALSE)






