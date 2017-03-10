#R for Data Science
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
