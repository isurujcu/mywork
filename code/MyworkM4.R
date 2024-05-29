install.packages("usethis")
library(usethis)
use_git_config(user.name = "isurujcu", user.email = "isuruwmic@gmail.com")
gitcreds::gitcreds_set()
usethis ::use_github()

#----------------------------------------------------#
# MB5370: Module 4 - Data Science in R ####
# Date: 14/05/2024 - 17/05/2024
# Author: Isuru Wijesundara (14384313)
#
# Script Location:
# C:/Users/isuru/Desktop/Isuru/0_JCU/Semester_3/MB5370/Module 4_Data science in R/My_analysis_M4/mywork/code/MyworkM4.R
# Description: 
# This script demonstrates data visualization and end to end data analysis in R.
#----------------------------------------------------#


#----------------------------------------------------#
# Workshop 1: Data visulization in R ####


#----------------------------------------------------#
## Section 1: Basics of data visualization in R using an inbuilt dataset in R ####


# Description: 
# This section encompasses the basics of data visualization in R using an 
# inbuilt data set provided by R. Using this data set, plots will be constructed 
# and try out several ways for data visulization to obtain meaningful plots. 

# Install and load tidyverse packages ####
# First we need to install the relevant packages into the R work space. 

install.packages("tidyverse") # Delete this line once installed
library("tidyverse")


#----------------------------------------------------#
## Section 1.1: Creating a simple plot using mpg data frame in R ####

# the data frame that we use to build the basic map
?mpg #for further information about this data frame

# The mpg data frame found in ggplot2 is a dataset with observations 
# (234 rows of data) and variables
# Variables include displ: engine capacity of cars, hwy: fuel consumption
data(mpg)

# checking the structure of the data frame
head(mpg)
glimpse(mpg)
summary(mpg)

# creating the first plot using the mpg data frame
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))
# this plot shows the variation in the fuel consumption (hwy) of the cars with 
# the engine capacity (displ). Simply it shows a negative relationship between 
# hwy and displ.  


#----------------------------------------------------#
## Section 1.2: Changing the aesthetics of the plot ####

# Although the ggplot created the plot, it is not so clear which car types has 
# the highest fuel efficiency compared to others. 
# Therefore, we want to further construct this plot to get more 
# meaningful understanding of data. 

# to answer the question which cars types has highest efficiency compared to 
# others, we need to add two attributes, the geom and aesthetics. 

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, colour = class))
#this plot is more informative compared to the first plot created.

## Change point colour by class:
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, colour = class))

## Change point size by class:
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, size = class))
# here a warning message pops as "Using size for a discrete variable is not 
# advised". Here, class is a discrete variable (e.g., car types).
# ggplot2 warns because the variation in point size might not effectively convey 
# the differences between categories, and it might make the plot harder to read. 
  
## Change transparency (alpha) by class
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, alpha = class))
# Warning: Using alpha for a discrete variable is not advised.The warnings occur 
# because using alpha or size for discrete variables can be misleading or 
# less effective

# Change point shape by class:
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, shape = class))

# Make all points blue
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")


#----------------------------------------------------#
## Section 1.3: Facet and panel plots ####

## facet_wrap
# The facet_wrap function in ggplot2 is used to split a single plot into 
# multiple smaller plots, each displaying a subset of the data.
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)

# Main Plot: The base plot is a scatter plot with displ (engine capacity) on the 
# x-axis and hwy (fuel efficiency) on the y-axis.
# Faceting by Class: facet_wrap(~ class) splits the plot by the class variable 
# (car type). 
# Each subset of data corresponding to a different car type is displayed in 
# its own small plot.
# Number of Rows: nrow = 2 specifies that the small plots arranged in 2 rows.

## facet_grid
# The facet_grid function in ggplot2 creates a grid of plots, where each plot 
# represents a subset of the data based on the combinations of two categorical 
# variables.
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(drv ~ cyl)

# Main Plot: The base plot is a scatter plot with displ (engine capacity) 
# on the x-axis and hwy (fuel efficiency) on the y-axis.
# Faceting by drv and cyl: facet_grid(drv ~ cyl) creates a grid of plots. 
# Each plot corresponds to a unique combination of drv 
# (drive type, e.g., 4WD) and cyl (number of cylinders).
# Rows represent different levels of the drv variable.
# Columns represent different levels of the cyl variable.

## facet_grid by just row (or column)
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(cyl ~ .)

## Exercise:
?facet_wrap

# What does nrow do? What does ncol do? 
# What other options control the layout of the individual panels?

# Answer: The nrow and ncol parameters in facet_wrap control the number of rows 
# and columns of the faceted plots, while other options like scales, 
# strip.position, as.table, drop, and dir control the scales, label positions, 
# layout order, inclusion of unused levels, and wrapping direction of panels.


#----------------------------------------------------#
## Section 1.4: Fitting simple lines ####

# ggplot2 can use a variety of geom objects to represent the data. Here, 
# we might want to use bar plots, line charts, boxplots and so on. 
# Well we can handle this issue in ggplot directly using a different geom to 
# plot the same data. Here, instead of points, we will use a smooth line. 


# To display same data as a smooth line fit through points use geom_smooth().
ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy))

## Question: whey don't we use geom_line() here? What would that look like? 

# Answer: The geom_smooth() function is used to add a smooth line 
# (usually a regression line) that fits through the data points, representing 
# the trend in the data. It provides a statistical summary of the relationship 
# between the variables, often including confidence intervals.

# Using geom_line() in this context would simply connect the points with 
# straight lines in the order they appear in the data set, which might not make 
# sense if the data is not ordered meaningfully. 


## Use of comments 

# We are always trying out different geom types that could be useful for 
# visualization of our data. 
# We can use comments to remember which geom type worked for the data set and 
# which are not. An example would be in this case, 

# ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) # points horrible 
# ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy)) # try smooth line
  
  
## Changing line type

  ggplot(data = mpg) + 
    geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv))

## Grouping
# So far we’ve only made fairly simple plots. But what happens if you want to 
# group objects by a categorical variable (like species or sex or site)? 
# Here we will use the group argument to show that our data is in fact grouped. 
# It won’t add a new legend but can easily be used to vary your plots by the 
# discrete variable.
# Set the group aesthetic to a categorical variable to draw multiple objects.
  
ggplot(data = mpg) +
    geom_smooth(mapping = aes(x = displ, y = hwy, group = drv))
  

## Change line colour based on drv value
  
  ggplot(data = mpg) +
    geom_smooth(
      mapping = aes(x = displ, y = hwy, color = drv),
      show.legend = FALSE,
    )  

## Multiple geoms
  
# Now, let’s increase our complexity even more. Here we will plot multiple 
# geoms on the single plot. All you need to do is to add them together. 
# This one is nice for showing the underlying data and how it relates to the 
# geom_smooth line.
  
ggplot(data = mpg) + 
    geom_point(mapping = aes(x = displ, y = hwy)) +
    geom_smooth(mapping = aes(x = displ, y = hwy))

# A better way to plot the same graph
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()  

# manipulating each geom layer separately
# the above line graph with multiple geoms (points and line) does not make much 
# sense as its giving the overall summary of the data 
# (fuel efficiency vs. engine capacity). If we want to add more details to it, 
# we need to manipulate each geom layer separately to visualize the variations 
# between car types. 

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth()
# this is a better visualization of the same dataset with multiple geoms. 
# now the plot is neat. 

# If you want to specify different data for each layer, we use a filter 
# (class = "subcompact") to select a subset of data and plot only that subset. 
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth(data = filter(mpg, class == "subcompact"), se = FALSE)

## Question: what does the "se = FALSE" do?
## Answer: In the geom_smooth() function, the se parameter stands for 
# "standard error." By default, geom_smooth() includes a shaded region around  
# the smooth line, representing the confidence interval for the fitted values. 
# This shaded region shows the uncertainty around the smooth line, typically at 
# a 95% confidence level. Setting se = FALSE removes this shaded confidence 
# interval from the plot.

## Exercise:
# 1.  What geom would you use to draw line chart? boxplot? histogram? areachart?
# 2.  Run this code in your head and predict what the output will look like. 
# Then, run the code in R and check your predictions.

## Answer: 
# Line chart: Prediction = Will show a line connecting hwy values based on displ.
# If there are multiple hwy values for the same displ, the line might look 
# jagged or unclear".
ggplot(data = mpg) + 
  geom_line(mapping = aes(x = displ, y = hwy))  

# Boxplot: Prediction = Will show the distribution of hwy for each class with 
# boxes representing the interquartile range and whiskers indicating the range 
# of the data, with potential outliers.
ggplot(data = mpg) + 
  geom_boxplot(mapping = aes(x = factor(class), y = hwy)) # boxplot

# Histogram: Prediction = Will show the distribution of displ values with bars 
# representing the frequency of observations within each bin. binwidth can be 
# adjusted to change the granularity.
ggplot(data = mpg) + 
  geom_histogram(mapping = aes(x = displ), binwidth = 0.5) 

# Area chart: Prediction = Will fill the area under the curve defined by displ 
# and hwy, which might not be very informative if the data points are not 
# sequentially ordered or if displ has multiple hwy values.
ggplot(data = mpg) + 
  geom_area(mapping = aes(x = displ, y = hwy)) 

# 3.  Will these two graphs look different? Why/why not?

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

# Answer: two graphs will look identical because both use the same data, 
# mappings, and layers resulting in a scatter plot with a smoothed line overlay.


#----------------------------------------------------#
## Section 1.5: Transformations and Stats ####

# Description: In this section, the transformations are based on the diamonds 
# dataset comes in ggplot2 and contains information about ~54,000 diamonds, 
# including the price, carat, color, clarity, and cut of each diamond.

## Load data
data("diamonds")
glimpse(diamonds)

# basic bar chart 
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut))

# In this case, since we are working on bar charts, we need to set new values to
# compute the statistics of our interest. To do this, we use "stat" function.

ggplot(data = diamonds) + 
  stat_count(mapping = aes(x = cut))

# On the x-axis, the chart displays cut, a variable from the diamonds dataset. 
# On the y-axis, it displays count, but count is not a variable in diamonds! 
# Where does count come from? 
# Many graphs, like scatterplots, plot the raw values of your dataset. 
# Other graphs, like bar charts, calculate new values to plot.

## Overriding defaults
# You might want to override a default stat now that you understand what the 
# defaults are. Change the default stat (which is a count, a summary) to 
# identity (which is the raw value of a variable).

demo <- tribble(
  ~cut,         ~freq,
  "Fair",       1610,
  "Good",       4906,
  "Very Good",  12082,
  "Premium",    13791,
  "Ideal",      21551
)
demo

ggplot(data = demo) +
  geom_bar(mapping = aes(x = cut, y = freq), stat = "identity")

# You can also override a default mapping from transformed variables to 
# aesthetics. For instance, you could display a bar chart of the proportion of
# your total diamond dataset rather than a count.

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = stat(prop), group = 1))

## Plotting statistical details

# You might also want to show a little more about these transformations in your 
# plot, which is good practice to be transparent about uncertainty or any other 
# limitation of your data. 
# You can do this using stat_summary().

ggplot(data = diamonds) + 
  stat_summary(
    mapping = aes(x = cut, y = depth),
    fun.min = min,
    fun.max = max,
    fun = median
  )


#----------------------------------------------------#
## Section 1.6: Aesthetic adjustments ####

# Another way to boost the way you can convey information with plots using 
# ggplot2 is to use aesthetics like colour or fill to change aspects of colours.

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, colour = cut))
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = cut))

# Here it is important to notice that the colour scheme used is not desirable 
# for this dataset, as different colours does not make any sense to the results. 
# It is a critical component that we should focus on, using of different colour 
# schemes is does not add any value to the results. 

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) 

ggplot(data = diamonds, mapping = aes(x = color, y = depth)) + 
  geom_point(mapping = aes(color = cut)) 

## Filling by a variable
# Now try using these aesthetics to colour by another variable like clarity. 
# Notice how the stacking is done automatically. This is done behind the scenes 
# with a position argument.
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity))

## To alter transparency (alpha)
ggplot(data = diamonds, mapping = aes(x = cut, fill = clarity)) + 
  geom_bar(alpha = 1/5, position = "identity")

## To color the bar outlines with no fill color
ggplot(data = diamonds, mapping = aes(x = cut, colour = clarity)) + 
  geom_bar(fill = NA, position = "identity")

## Position adjustments
#  = "fill" works like stacking, but makes each set of stacked bars same height.
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "fill")

## position = "dodge" 
# Places overlapping objects directly beside one another.
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "dodge")

## Jittering
# position = "jitter" adds a small amount of random noise to each point to 
# avoid overplotting when points overlap. This is useful for scatterplots but 
# not barplots.
ggplot(data = mpg) + 
  #geom_point(mapping = aes(x = displ, y = hwy), position = "jitter")
  geom_point(mapping = aes(x = displ, y = hwy))
#----------------------------------------------------#


#----------------------------------------------------#
# Assignment 1: Plot Deconstruction ####
