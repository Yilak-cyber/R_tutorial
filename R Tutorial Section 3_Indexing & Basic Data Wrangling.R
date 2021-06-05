# R tutorial at Harvard Edx Section 
## Section 3: Indexing, Data Wrangling, Plots/
## 3.1 Indexing
library(dslabs)
data("murders")
# defining murder rate as before
murder_rate <- murders$total / murders$population * 100000
# creating a logical vector that specifies if the murder rate in that state is less than or equal to 0.71
index <- murder_rate <= 0.71
head(murders)
str(murders)
# determining which states have murder rates less than or equal to 0.71
murders$state[index]
# calculating how many states have a murder rate less than or equal to 0.71
sum(index)
table(murders$region)
# creating the two logical vectors representing our conditions
west <- murders$region == "West"
safe <- murder_rate <= 1
# defining an index and identifying states with both conditions true
ind <- safe & west
murders$state[index]
sum(ind)
##Indexing Functions
x <- c(FALSE, TRUE, FALSE, TRUE, TRUE, FALSE)
x
which(x)    # returns indices that are TRUE

# to determine the murder rate in Massachusetts we may do the following
index <- which(murders$state == "Massachusetts")
index
murder_rate[index]

# to obtain the indices and subsequent murder rates of New York, Florida, Texas, we do:
c("New York", "Florida", "Texas")
index <- match(c("New York", "Florida", "Texas"), murders$state)
index
murders$state[index]
murder_rate[index]

x <- c("a", "b", "c", "d", "e")
y <- c("a", "d", "f")
y %in% x

# to see if Boston, Dakota, and Washington are states
c("Boston", "Dakota", "Washington") %in% murders$state

## 3.2 Basic Data Wrangling
# installing and loading the dplyr package
install.packages("dplyr")
library(dplyr)

# adding a column with mutate
library(dslabs)
data("murders")

murders <- mutate(murders, rate = total / population * 100000)

# subsetting with filter
filter(murders, rate <= 0.71)

# selecting columns with select
new_table <- select(murders, state, region, rate)
View(new_table)
# using the pipe
murders %>% 
  select(state, region, rate) %>% 
  filter(rate <= 0.71)
## Bonus on dplyr
# tabulate number of states in each region
table(murders$region )
# summarize the data: calculate murder rate for each region 
# dplyr
# dplyr is a grammar of data manipulation, providing a consistent set of verbs 
# that help you solve the most common data manipulation challenges:
# . mutate() adds new variables that are functions of existing variables
# . select() picks variables based on their names.
# . filter() picks cases based on their values.
# . summarise() reduces multiple values down to a single summary.
# . arrange() changes the ordering of the rows.
# These all combine naturally with group_by() which allows you to perform 
# any operation "by group".
# Resource https://dplyr.tidyverse.org/
# Example
new_table %>%
group_by(region)%>%
  summarize(mean_rate= mean(rate))%>%
  arrange(mean_rate)

## Creating Data Frames
# creating a data frame with stringAsFactors = FALSE
grades <- data.frame(names = c("John", "Juan", "Jean", "Yao"), 
                     exam_1 = c(95, 80, 90, 85), 
                     exam_2 = c(90, 85, 85, 90),
                     stringsAsFactors = FALSE)