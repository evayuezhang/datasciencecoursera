#R for Data Science

library(nycflights13)
library(tidyverse)


#p49-50

#exer 1.a
delay2hrs <- filter(flights,arr_delay>120)

#exer 1.b
fly2Houston <- filter(flights,dest=="IAH"|dest=="HOU")

#exer 1.c
flyUAD <- filter(flights,carrier %in% c("UA","AA","DL"))

#exer 1.d
flysummer <- filter(flights,month %in% c(7,8,9))

#exer 1.e
flyarrlate <- filter(flights, arr_delay>120 & dep_delay<0)

#exer 1.f
flydelaymakeup <- filter(flights, dep_delay>=60 & arr_delay<=30)

#exer 1.g
flyredeye <- filter(flights,dep_time==2400 | dep_time<=600)

#exer 3
flymiss <- filter(flights,is.na(dep_time))

#--------------------------------------------------------------
#p51

#exer 1
arrange(flights,desc(is.na(dep_time)))

#exer 2
arrange(flights,desc(dep_delay))
arrange(flights,dep_delay)

#exer 3
arrange(flights,air_time)

#exer 4
arrange(flights,distance)
arrange(flights,desc(distance))

#--------------------------------------------------------------
#p54

#exer 1
select(flights,dep_time, dep_delay,arr_time, arr_delay)
select(flights,starts_with("dep"), starts_with("arr"))

#exer 2
select(flights,dep_time,dep_time,dep_time)

#exer 3
vars <- c("year","month","day","dep_delay","arr_delay")
select(flights,one_of(vars))

#exer 4
select(flights,contains("TIME"))
select(flights,contains("TIME",FALSE))

#--------------------------------------------------------------
# add new variables
flights_sml <- select(flights,year:day, ends_with("delay"),distance,air_time)
mutate(flights_sml,gain=arr_delay-dep_delay,speed=distance/air_time*60)
mutate(flights_sml,gain=arr_delay-dep_delay, hours=air_time/60, gain_per_hour=gain/hours)
transmute(flights,gain=arr_delay-dep_delay, hours=air_time/60, gain_per_hour=gain/hours)
transmute(flights,dep_time, hours=dep_time %/% 100,minute=dep_time %% 100)

#offsets
x <- 1:10
x
lag(x)
lead(x)
cumsum(x)
cumprod(x)
cummean(x)
#ranking
y <- c(1,2,2,NA,3,4)
y
min_rank(y)
min_rank(desc(y))
row_number(y) #aviod rank NA
dense_rank(y) #count equals
percent_rank(y)
cume_dist(y)

#--------------------------------------------------------------
#p68

#exer 1
transmute(flights,air_time,
          arr_time,
          dep_time, 
          dep_time_minute=(dep_time %/% 100)*60
          +dep_time %% 100,
          sched_dep_time,
          sched_dep_time_minute=(sched_dep_time %/% 100)*60
          +sched_dep_time %% 100
          )

#exer 2

transmute(flights,
          air_time,
          air_time_cal=
            arr_time-dep_time,
          air_time_calmin=
            ((arr_time %/% 100)*60+arr_time %% 100)
          -
            ((dep_time %/% 100)*60+dep_time %% 100)
          )
# the answers: air_time's unit is minite 
# while air_time_cal is a reault of two time variables
# to correcto this inconsistancy, use air_calmin
# however, air_clamin sometimes much smaller than air_time
# because of time zones are different with arr_time and dep_time
# to fix the problem, need a variable of time-zone difference

#exer 3
arrange(flights,dep_time,dep_delay,sched_dep_time)
#the answers: 
#if sched_dep_time+dep+_delay<=2400,
#dep_delay=dep_time-sched_dep_time,
#else,
#dep_delay=dep_time-sched_dep_time+2400.

#exer 4

#--------------------------------------------------------------
#grouped summaries
summarize(flights,delay=mean(dep_delay,na.rm=T))
by_day <- group_by(flights,year,month,day)
summarize(by_day,delay=mean(dep_delay,na.rm=T)) #summarizes the average delay time for a day

#combining multiple perations with the pip
#step 1: group fligths by destination
by_dest <- group_by(flights,dest)

#step 2:summarize to compute #of flights,distance,average delay
delay <- summarize(by_dest,
                   count=n(),
                   dist=mean(distance,na.rm = T),
                   delay=mean(arr_delay,na.rm = T)
                   )

#step 3: filter to remove noisy points and Honolulu airport
#which is almost twice as far away as the next closest airport
delay <- filter(delay,count>20,dest!="HNL")

#step 4: visulize the plot
ggplot(data=delay,mapping=aes(x=dist,y=delay))+
  geom_point(aes(size=count),alpha=1/3)+
  geom_smooth(se=F)

#tackling the same problem with the pipe
# x %>% f(y) means f(x,y)
#na.rm means remove the NAs
delays <- flights %>% #means then
  group_by(dest) %>%
  summarize(
    count=n(),
    dist=mean(distance,na.rm = T),
    delay=mean(arr_delay,na.rm = T)
  )%>%
filter(count>20,dest!="HNL")

#andother way to avoid cancelled flights
#first remove the canclled flights before summaries
not_cancelled <- flights %>%
  filter(!is.na(dep_delay),!is.na(arr_delay))

not_cancelled %>%
  group_by(year,month,day)%>%
  summarize(mean=mean(dep_delay))

#counts
delays <- not_cancelled %>%
  group_by(tailnum) %>%
  summarize(
    delay=mean(arr_delay)
  )
ggplot(data=delays,mapping=aes(x=delay))+
  geom_freqpoly(binwidth=10)

#a scatterplot of # of flights v.s. average delay
delays <- not_cancelled %>%
  group_by(tailnum) %>%
  summarize(
    delay=mean(arr_delay,na.rm=T),
    n=n()
  )
ggplot(data=delays,mapping=aes(x=n,y=delay))+
  geom_point(alpha=1/10)

#filter out extreme values
delays %>%
  filter(n>25)%>%
  ggplot(mapping=aes(x=n,y=delay))+
  geom_point(alpha=1/10)

#baseball case
library(Lahman)
batting <- as_tibble(Batting)
View(batting)

batters <- batting %>%
  group_by(playerID) %>%
  summarize(
    ba=sum(H,na.rm=T)/sum(AB,na.rm=T),
    ab=sum(AB,na.rm=T)
  )
batters %>%
  filter(ab>100) %>%
  ggplot(mapping=aes(x=ab,y=ba))+
    geom_point()+
    geom_smooth(se=F)

batters %>%
  arrange(desc(ba))

#the implication is:
#the people with the best batting averages are clearly lucky, not skilled

#useful summary functions
not_cancelled %>%
  group_by(year,month,day) %>%
  transmute(dep_time, arr_time,r=min_rank(desc(dep_time))) %>%
  filter(r %in% range(r))
#??????

#grouping by multiple variabes
daily <- group_by(flights,year,month,day)
(per_day <- summarize(daily,flight=n()))
(per_month <- summarize(per_day,flights=sum(flights)))
(per_year <- summarize(per_month,flights=sum(flights)))
#get a error message indicating that:
#only defied on a data frame with all numeric variables

#ungroup
daily %>%
  ungroup() %>%
  summarise(flights=n()
            )

      
      
  












