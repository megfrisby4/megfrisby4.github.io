library(tidyverse)
library(easystats)
mod1 <- mpg %>%
  glm(data=.,
      formula = cty ~ displ)
mod2 <- mpg %>%
  glm(data=.,
      formula = cty ~ displ + drv)
mod3 <- mpg %>%
  glm(data=.,
      formula = cty ~ displ * drv)
mod4 <- mpg %>%
  glm(data=.,
      formula = cty ~ displ + drv + trans)
mod_list <-
  list(mod1=mod1,
       mod2=mod2,
       mod3=mod3,
       mod4=mod4)
# purrr package (for working with lists....functional programming)
map(mod_list,rmse)

#look at different parts of model 
mod1$family$family
#report what the family of your function is 

#list is kinda like a vector BUT the types dont have to be the same 
my_list <- list(item1=c("a", "b", "c"), item2=1:3, item3=mpg)
#whats different
#one element is a character vector (#1)
#one element is a numeric vector 

#element 1s name is item1 clas is character vector 
#item3=mpg

#mod_list put every model into a single list 
#list of lists 

mpg %>% view()
#a data frame is a special list in r 
#each element is same length
#each element must be named 

mod_list
#whats the point of mod list  
#iterating 
#store all things in one object 

#rmse

for (i in mod_list) {print(rmse(i))
  
}

#purrr:: -- working with lists 
#map() function elminates the need for working with forloops 

map(mod_list,rmse)
#does the function on every item in the list 
#makes a list 

#pipe list to unlist or map_

map_dbl(mod_list, rmse)
#makes a numeric vector df 

#you can store plots in list 
plot_list <- list(p1=ggplot(mpg, aes(x=displ, y=cty))+geom_point(), p2=ggplot(mpg, aes(x=displ, y=cty, color=drv))+geom_point())

plot_list$p1$data
plot_list$p1

my_list_2 <- list(mpg, c("a","b","c"))
#plot without names 
names(my_list_2)

my_list_2[[2]][1]
my_list_2[[2]]
#double brackets how you refer to big elements 
#single brackets folowing double brackets refer to a specific place in the element

mpg[[1]]
#same as 
mpg$manufacturer
mpg[1]
#single bracket returns a tibble
#double brackets solely a vector


my_list_2[[1]][[4]] %>% class()
my_list_2[[1]][[4]][81]
#first element in mylist2
#4th element of that element
#double brackets for a vector to access a vector 

#vectors are annoying but really powerful 
#easier to just put names on things 

library(palmerpenguins)
mylist3 <- list(mpg, penguins)
mylist3
map(mylist3, "year")
#map pulls out all the things called year from each item 

#can even do it by position 
map(mylist3, 1)[[1]]
#pulls out first element of each element in the list 
#and the first option 

words <- "the quick brown fox jumped over the lazy dog"
words %>% class()
#class character vector of length one 

#start working with strings 

str_split(words, " ") 
#outputs a list the length is still 1

#make it into a vector 
str_split(words, " ") [[1]] %>% length()
#babam vector of length 9 

# working with character strings str_ 
#see what you can do 
str_split(words, " ") [[1]] %>% str_remove(".")
# . removes single character 

#if i want it to literally remove . 
words <- str_split(words, " ") [[1]] %>% str_remove("//.")
sentences

  
  words1 <- sentences %>%
  str_remove("\\.") %>%
  str_remove(",") %>%
  str_remove("'") %>%
  str_to_lower() %>%
  str_split(" ") %>%
  unlist()



word_freq <- table(words1) %>% as.data.frame() %>% arrange(desc(Freq))

word_freq <- word_freq %>% filter(Freq>10 & Freq<100)
#order by frequency most common 
library(wordcloud)
wordcloud(words = word_freq$words, freq=word_freq$Freq)
