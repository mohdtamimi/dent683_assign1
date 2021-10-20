library("here")

library("tidyverse")

library("readxl")


#loading datasets
oh12 <- read_xlsx(path = here("Data","nhanes_ohx_12_18.xlsx"),
                  sheet = "oh2012")

oh14 <- read_xlsx(path = here("Data","nhanes_ohx_12_18.xlsx"),
                  sheet = "oh2014")
oh16 <- read_xlsx(path = here("Data","nhanes_ohx_12_18.xlsx"),
                  sheet = "oh2016")


oh18 <- read_xlsx(path = here("Data","nhanes_ohx_12_18.xlsx"),
                  sheet = "oh2018")

demo12 <- read_xlsx(path = here("Data","nhanes_demo_12_18.xlsx"),
                    sheet = "demo2012")

demo14 <- read_xlsx(path = here("Data","nhanes_demo_12_18.xlsx"),
                    sheet = "demo2014")

demo16 <- read_xlsx(path = here("Data","nhanes_demo_12_18.xlsx"),
                    sheet = "demo2016")

demo18 <- read_xlsx(path = here("Data","nhanes_demo_12_18.xlsx"),
                    sheet = "demo2018")


identical(names(oh12), names(oh14))
identical(names(oh16), names(oh14))
identical(names(oh18), names(oh14))
identical(names(oh16), names(oh18))

#oh12 and oh14 have identical variables names and number
#oh16 and oh18 have identical variables names and number

intersect(names(oh16), names(oh14)) %>% length()
intersect(names(oh18), names(oh12)) %>% length()

#the 110 variables in oh12&oh14 are included in oh16&oh18

oh12 %>% select("SEQN",ends_with("CTC")) %>% sapply(FUN=unique)
oh14 %>% select("SEQN",ends_with("CTC")) %>% sapply(FUN=unique)
oh16 %>% select("SEQN",ends_with("CTC")) %>% sapply(FUN=unique)
oh18 %>% select("SEQN",ends_with("CTC")) %>% sapply(FUN=unique)

oh12_2 <- oh12 %>% filter(OHDDESTS==1, OHDEXSTS==1) %>%
  select("SEQN",ends_with("CTC"))

oh14_2 <- oh14 %>% filter(OHDDESTS==1, OHDEXSTS==1) %>%
  select("SEQN",ends_with("CTC"))

oh16_2 <- oh16 %>% filter(OHDDESTS==1, OHDEXSTS==1) %>%
  select("SEQN",ends_with("CTC"))

oh18_2 <- oh18 %>% filter(OHDDESTS==1, OHDEXSTS==1) %>%
  select("SEQN",ends_with("CTC"))

oh_all <- rbind(oh18_2,oh16_2,oh14_2,oh12_2)

table (duplicated(oh_all$SEQN))
 #no duplicates in sequence numbers of participants

#######################################

#task 6.3
demo12$year=2012
demo14$year=2014
demo16$year=2016
demo18$year=2018

#task 6.4

demo12_1 <- demo12%>% select("SEQN","RIDAGEYR","year")
demo14_1 <- demo14%>% select("SEQN","RIDAGEYR","year")
demo16_1 <- demo16%>% select("SEQN","RIDAGEYR","year")
demo18_1 <- demo18%>% select("SEQN","RIDAGEYR","year")

all_demo <- rbind(demo12_1,demo14_1,demo16_1,demo18_1)

table(duplicated(all_demo$SEQN))

# task 6.5

alldata<- left_join(oh_all,all_demo)



#task 7

write.csv(alldata,file = "C:/Users/hp/OneDrive/dent683_assign1/Data/alldata.csv")

#number of participants each year

table(alldata$year)

