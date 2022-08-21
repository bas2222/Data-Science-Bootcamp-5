library(tidyverse)
library(sqldf)
library(jsonlite)
library(RSQLite)
library(RPostgreSQL)
library(glue)

View(mtcars)

select(mtcars, 1:5)
select(mtcars, 1:5)
select(mtcars, 1:5)

select(mtcars, mpg, wt, hp)

select(mtcars, starts_with ("a"))
select(mtcars, ends_with ("p"))
select(mtcars, contains ("a"))
select(mtcars, carb, everything())

mtcars$model <- rownames(mtcars)
rownames(mtcars) <- NULL

mtcars <-select(mtcars, model, everything())

select(mtcars, 1:5)

m1 <- mtcars %>%
  select(mpg, hp, wt) %>%
  filter(hp < 100 | wt <2) %>%
  arrange(desc(hp))

mtcars %>%
  select(model, mpg, hp, wt, am) %>%
  filter(between (mpg, 25, 30))

mtcars %>%
  select(model, cyl) %>%
  filter(cyl %in% c(4,6))

mtcars %>%
  select(model, mpg, hp, wt, am) %>%
  filter(grepl("^M", model))

mtcars %>%
  arrange(desc(mpg)) %>%
  head()

m2 <-mtcars %>%
  select(model, mpg, hp, wt, am) %>%
  mutate(hp_segment = if_else(hp<100, "low", "high"),
         hp_segment2 = case_when(
           hp < 100 ~ 'low',
           hp < 200 ~  'medium',
           TRUE ~  'High'
         )) 

mtcars <-mtcars %>%
  mutate(am = if_else(am==0, "Auto", "Manual"),
         vs = if_else(vs==0, "V-Shaped", "Straight"))

m3 <-mtcars %>%
  count(am, vs) %>%
  mutate(percent = n/nrow(mtcars))

write_csv(m3, "summary_mtcars.csv")

rm(m3)

m3<-read_csv("summary_mtcars.csv")
m3 <- as.data.frame(m3)
m3 <- as_tibble(m3)

mtcars <-mtcars %>%
  mutate(vs = as.factor(vs),
         am= as.factor(am)) %>%  
  glimpse()

mtcars %>%
  group_by(am, vs) %>%
  summarise(
    avg_mpg = mean(mpg),
    sum(mpg),
    min(mpg),
    max(mpg),
    var(mpg),
    sd(mpg),
    median(mpg),
    n()
  ) ->result
write_csv(result,"result.csv")

inner_join(band_members, 
           band_instruments,
           by = "name")

left_join(band_members,
          band_instruments,
          by = "name")

right_join(band_members,
           band_instruments,
           by = "name")

full_join(band_members,
          band_instruments,
          by = "name")

band_members %>%
  full_join(band_instruments,
            by= "name") %>%
  filter(name %in% c("John", "Paul")) %>%
  mutate(hello = "OK")

library(nycflights13)

glimpse(flights)

flights %>%
  filter(month == 9) %>%
  count(origin, dest)


df <-flights %>%
  filter(origin == "JFK" & month %in% c(3,4,5)) %>%
  count(carrier) %>%
  arrange(desc(n)) %>%
  left_join(airlines, by = "carrier")

write_csv(df,"requested_data.csv")

students <- data.frame(
  id = 1:5,
  name = c("toy", "joe", "anna", "mary", "kevin"),
  cid = c(1,2,2,3,2),
  uid = c(1,1,1,2,2)
)

courses <- data.frame(
  course_id = 1:3,
  course_name = c ("Data", "R", "Python")
)

students %>%
  left_join (courses, by = c("cid"= "course_id"))%>%
  left_join(university, by = "uid") %>%
  select(studentname=name, 
         course_name, 
         university_name =uname) ->df

university <- data.frame(
  uid = 1:2,
  uname = c("University of London", "Chula University")
)

students %>%
  left_join(courses, by = c("cid", "course_id")) %>%
  left_join(university, by = "uid")

long_worldphones <-WorldPhones %>%
  as.data.frame() %>%
  rownames_to_column(var = "Year") %>%
  pivot_longer(N.Amer: Mid.Amer, 
               names_to = "Region",
               values_to = "Sales")

long_worldphones %>%
  filter(Region == "Asia")

long_worldphones %>%
  group_by(Region) %>%
  summarise (total_sales = sum(Sales))

wide_data <-long_worldphones %>%
  pivot_wider(names_from = "Region",
              values_from = "Sales")

write_csv(wide_data, "data.csv")

wide_data %>% class()

library(RSQLite)
library(RPostgreSQL)

con <- dbConnect(SQLite(), "chinook.db")

dbListTables(con)
dbListFields(con, "customers")

dbGetQuery(con, "
           select 
            firstname, 
            lastname, 
            country 
           from customers
           where country
            in ('France', 'Austria', 'Belgium')")

query01 <- "
  select * from artists
  join albums on artists.artistid = albums.artistid
  join tracks on tracks.albumid = albums.albumid
  "

tracks <-dbGetQuery(con, query01)

tracks %>%
  select(Composer, Milliseconds, Bytes, UnitPrice) %>%
  filter (Milliseconds > 200000,
          grepl("^C", Composer)) %>%
  summarise (
    sum(Bytes),
    sum(UnitPrice)
  )

dbDisconnect(con)
con
nrow(tracks)

tracks %>%
  sample_n(10) %>%
  View()

library(janitor)
tracks_clean <-clean_names(tracks)

View(tracks_clean)

set.seed(1)
tracks_clean %>%
  select(1:2) %>%
  sample_n(10) 
