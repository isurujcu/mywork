install.packages("usethis")
library(usethis)
use_git_config(user.name = "isurujcu", user.email = "isuruwmic@gmail.com")
gitcreds::gitcreds_set()
usethis ::use_github()

install.packages("tidyverse")
library(tidyverse)

mpg
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))
ggplot()
ggplot(data = mpg)
