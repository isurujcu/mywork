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
# C:/Users/isuru/Desktop/Isuru/0_JCU/Semester_3/MB5370/Module 4_Data science in 
# R/My_analysis_M4/mywork/code/MyworkM4.R

# Description: 
# This script demonstrates data visualization and end to end data analysis in R.
#----------------------------------------------------#


#----------------------------------------------------#
# Workshop 1: Data visulization in R ####


#----------------------------------------------------#
## Section 1: Data visualization in R using an inbuilt data frames in R ####


# Description: 
# This section encompasses the basics of data visualization in R using an 
# inbuilt data set provided by R. Using this data set, plots will be constructed 
# and try out several ways for data visulization to obtain meaningful plots. 

# Install and load tidyverse packages ####
# First we need to install the relevant packages into the R work space. 

# install.packages("tidyverse") # Delete this line once installed
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

library(readxl)
Fishery <- read_excel("C:/Users/isuru/Desktop/Fishery.xlsx")
View(Fishery)
library(ggplot2)
library(tidyr)
library(dplyr)

# Display the data frame structure and summary 
head(Fishery)
glimpse(Fishery)
summary(Fishery)

# Transform the data from wide to long format
fishery_long <- Fishery %>%
  gather(key = "Year", value = "Production", -Fishery, -Source) %>%
  mutate(Year = as.numeric(Year),
         Production = Production / 1e6)  # Convert tons to million tons

# Display the modified data
head(fishery_long)

# Filter the data for the years 1950 to 2022
fishery_long <- fishery_long %>%
  filter(Year >= 1950 & Year <= 2022)

# Calculate the sum of production per year for each fishery type and source
fishery_summary <- fishery_long %>%
  group_by(Year, Fishery, Source) %>%
  summarise(Total_Production = sum(Production, na.rm = TRUE), .groups = 'drop')

# Create a time series point plot
ggplot(data = fishery_summary) + 
  geom_point(mapping = aes(x = Year, y = Total_Production, colour = Fishery)) +
  facet_grid(Source ~ .) +
  labs(title = "Fishery Production Over Years (1950-2022)",
       x = "Year",
       y = "Production (Million Tons)",
       colour = "Fishery") +
  theme_minimal()


# Calculate the sum of production per year for each fishery type and source
fishery_summary <- fishery_long %>%
  group_by(Year, Fishery, Source) %>%
  summarise(Total_Production = sum(Production, na.rm = TRUE), .groups = 'drop')

# Calculate the total production per year for each source (sum of Capture and Aquaculture)
total_summary <- fishery_long %>%
  group_by(Year, Source) %>%
  summarise(Total_Production = sum(Production, na.rm = TRUE), .groups = 'drop')

# Create a time series point plot with trend lines
ggplot(data = fishery_summary) + 
  geom_point(mapping = aes(x = Year, y = Total_Production, colour = Fishery)) +
  geom_line(data = total_summary, mapping = aes(x = Year, y = Total_Production, group = Source), colour = "black", linetype = "dashed") +
  facet_grid(Source ~ .) +
  labs(title = "Fishery Production Over Years (1950-2022)",
       x = "Year",
       y = "Production (Million Tons)",
       colour = "Fishery") +
  theme_minimal()


# Create a time series line plot with trend lines
ggplot(data = fishery_summary) + 
  geom_line(mapping = aes(x = Year, y = Total_Production, colour = Fishery, group = Fishery)) +
  geom_line(data = total_summary, mapping = aes(x = Year, y = Total_Production, group = Source), colour = "black", linetype = "dashed") +
  facet_grid(Source ~ .) +
  labs(title = "Fishery Production Over Years (1950-2022)",
       x = "Year",
       y = "Production (Million Tons)",
       colour = "Fishery") +
  theme_minimal()

ggplot(data = fishery_summary) + 
  geom_line(mapping = aes(x = Year, y = Total_Production, colour = Fishery, group = Fishery)) +
  geom_line(data = total_summary, mapping = aes(x = Year, y = Total_Production, group = Source), colour = "black", linetype = "dashed") +
  facet_grid(Source ~ .) +
  labs(title = "Fishery Production Over Years (1950-2022)",
       x = "Year",
       y = "Production (Million Tons)",
       colour = "Fishery") +
  theme_minimal() +
  theme(
    panel.border = element_blank(),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    axis.line = element_line(colour = "black")
  )

# Plot deconstruction
ggplot(data = fishery_summary) + 
  geom_line(mapping = aes(x = Year, y = Total_Production, colour = Fishery, group = Fishery)) +
  geom_line(data = total_summary, mapping = aes(x = Year, y = Total_Production, group = Source), colour = "black", linetype = "dashed") +
  facet_grid(Source ~ .) +
  labs(
    title = "Fishery Production Over Years (1950-2022)",
    x = "Year",
    y = "Production (Million Tons)",
    colour = "Fishery",
    caption = "Data Source: [FishStatJ, 2023]. This plot shows the production trends of different fishery types (Capture Fisheries and Aquaculture) in Marine and Inland waters from 1950 to 2022. The dashed line represents the total production for each source."
  ) +
  theme_minimal() +
  theme(
    panel.border = element_blank(),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    axis.line.x = element_line(colour = "black"),  # Ensure x-axis line is shown
    axis.line.y = element_line(colour = "black"),  # Ensure y-axis line is shown
    axis.ticks.length = unit(0.15, "cm"),  # Shorten the length of tick marks
    axis.ticks = element_line(colour = "black"),  # Color of tick marks
    axis.ticks.x.bottom = element_line(colour = "black", size = 0.5, linetype = "solid"),  # Bottom x-axis tick marks
    axis.ticks.y.left = element_line(colour = "black", size = 0.5, linetype = "solid"),  # Left y-axis tick marks
    plot.title = element_text(size = 12),  # Reduce the font size of the title
    plot.caption = element_text(size = 10, hjust = 0)  # Adjust caption font size and alignment
  )

# Define significant years and labels for the annotations
significant_years <- data.frame(
  Year = c(1965, 1980, 2000, 2010),
  Source = c("Marine", "Marine", "Inland waters", "Inland waters"),
  Label = c("Increase", "Decrease", "Increase", "Decrease")
)

ggplot(data = fishery_summary) + 
  geom_line(mapping = aes(x = Year, y = Total_Production, colour = Fishery, group = Fishery)) +
  geom_line(data = total_summary, mapping = aes(x = Year, y = Total_Production, group = Source), colour = "black", linetype = "dashed") +
  geom_vline(data = significant_years, aes(xintercept = Year, color = NULL), linetype = "dotted", size = 0.5) +  # Add vertical lines
  geom_text(data = significant_years, aes(x = Year, y = 0, label = Label, vjust = -1), angle = 90, size = 3, color = "red") +  # Add labels
  facet_grid(Source ~ .) +
  labs(
    title = "Fishery Production Over Years (1950-2022)",
    x = "Year",
    y = "Production (Million Tons)",
    colour = "Fishery",
    caption = "Data Source: [Provide the data source here]. This plot shows the production trends of different fishery types (Capture and Aquaculture) in Marine and Inland waters from 1950 to 2022. The dashed line represents the total production for each source. Vertical dotted lines indicate significant changes in production rates."
  ) +
  theme_minimal() +
  theme(
    panel.border = element_blank(),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    axis.line.x = element_line(colour = "black"),  # Ensure x-axis line is shown
    axis.line.y = element_line(colour = "black"),  # Ensure y-axis line is shown
    axis.ticks.length = unit(0.15, "cm"),  # Shorten the length of tick marks
    axis.ticks = element_line(colour = "black"),  # Color of tick marks
    axis.ticks.x.bottom = element_line(colour = "black", size = 0.5, linetype = "solid"),  # Bottom x-axis tick marks
    axis.ticks.y.left = element_line(colour = "black", size = 0.5, linetype = "solid"),  # Left y-axis tick marks
    plot.title = element_text(size = 12),  # Reduce the font size of the title
    plot.caption = element_text(size = 10, hjust = 0)  # Adjust caption font size and alignment
  )


# Define significant years of production escalations
significant_increases <- data.frame(
  Year = c(1991, 1989),  # years where significant increases occurred
  Source = c("Marine", "Inland waters")  # Corresponding sources
)

# Add a column for shapes: 8 for increase (asterisk)
significant_increases$Shape <- 8

# Calculate the y positions for the symbols slightly above the highest production value to avoid overlapping
max_production <- fishery_summary %>% group_by(Source) %>% summarise(Max_Production = max(Total_Production))
significant_increases <- merge(significant_increases, max_production, by = "Source")
significant_increases$Total_Production <- significant_increases$Max_Production * 1.6  # Place the symbols slightly above the maximum production value

# Define breaks for x-axis to ensure 2022 is included
x_breaks <- seq(1950, 2022, by = 10)

ggplot(data = fishery_summary) + 
  geom_line(mapping = aes(x = Year, y = Total_Production, colour = Fishery, group = Fishery), size = 1) +  # Increase line size
  geom_line(data = total_summary, mapping = aes(x = Year, y = Total_Production, group = Source, linetype = "Total Production"), colour = "black", size = 0.8) +  # Increase line size and add to legend
  geom_vline(data = significant_increases, aes(xintercept = Year, color = NULL), linetype = "dotted", size = 0.8) +  # Add vertical dotted lines
  geom_point(data = significant_increases, aes(x = Year, y = Total_Production, shape = "Significant escalation", fill = "Significant escalation"), size = 3, color = "red") +  # Add red symbols for significant increases
  scale_shape_manual(values = c("Significant escalation" = 8), name = NULL) +  # Map shape to asterisk and remove legend title
  scale_fill_manual(values = c("Significant escalation" = "green"), name = NULL) +  # Color for significant escalation and remove legend title
  facet_grid(Source ~ .) +
  labs(
    title = "Global Fishery Production Over Years (1950-2022)",
    x = "Year",
    y = "Production (Mn Tons - Live weight)",
    caption = "Data Source: [FishStatJ, 2024]. \nVariation in the production trends of Capture fisheries and Aquaculture in Marine \nand Inland waters (sources) from 1950 to 2022. The dashed line represents the \ntotal production from both sources. Dotted lines with * indicate the year at which significant increases\nin total production rates were observed."
  ) +
  scale_x_continuous(breaks = seq(1950, 2022, by = 10)) +  # Set breaks for x-axis
  theme_minimal() +
  theme(
    panel.border = element_blank(),
    panel.grid.major.x = element_blank(),  # Remove major vertical gridlines
    panel.grid.minor.x = element_blank(),  # Remove minor vertical gridlines
    panel.grid.major.y = element_line(color = "gray", size = 0.1, linetype = "solid"),  # Make major gridlines light gray with low opacity
    panel.grid.minor = element_blank(),
    axis.line.x = element_line(colour = "black"),  # Ensure x-axis line is shown
    axis.line.y = element_line(colour = "black"),  # Ensure y-axis line is shown
    axis.ticks.length = unit(0.15, "cm"),  # Shorten the length of tick marks
    axis.ticks = element_line(colour = "black"),  # Color of tick marks
    axis.ticks.x.bottom = element_line(colour = "black", size = 0.5, linetype = "solid"),  # Bottom x-axis tick marks
    axis.ticks.y.left = element_line(colour = "black", size = 0.5, linetype = "solid"),  # Left y-axis tick marks
    plot.title = element_text(size = 12, hjust = 0.5),  # Center align and adjust title size
    plot.caption = element_text(size = 8, hjust = 0.5),  # Adjust caption font size and center align
    legend.position = "bottom",  # Move legend to the bottom
    legend.box = "horizontal",  # Arrange legend items horizontally
    legend.box.just = "center",  # Center justify the legend box
    legend.title = element_blank(),  # Remove legend title
    legend.text = element_text(size = 7),  # Reduce the font size of legends
    axis.title.x = element_text(size = 8),  # Adjust x-axis title size
    axis.title.y = element_text(size = 8)   # Adjust y-axis title size
  ) + 
  scale_color_discrete(name = "Fishery", labels = c("Capture Fisheries", "Aquaculture")) +  # Change legend labels for fishery types
  scale_linetype_manual(values = c("Total Production" = "dashed"), name = "Legend")  # Add dashed line to legend
