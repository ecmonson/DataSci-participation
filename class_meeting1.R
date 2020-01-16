2 + 2
3 + 4

number <- 3
number
number * 2

number <- 5
number * 2

number

another_number

times <- c(17, 30, 25, 35, 25, 30, 40, 20)
times

mean(times)

time_hours <- times / 60

mean(times)
range(times)
sqrt(times)

times
times > 30
times == 17

which(times > 30)
all(times > 30)
any(times > 30)

help()
?any
?mean

times[3]
times[-3]

3:5
times[3:5]

times[c(2, 4)]
times[-c(2, 4)]
times[times > 30]

times
times[1] <- 47
times

times[times > 30] <- NA
times

times <- c(17, 30, 25, 35, 25, 30, 40, 20)
times[1] <- 47
times
times[times > 30] <-c(0,1)
times

times <- c(17, 30, 25, 35, 25, 30, 40, 20)
times[1] <- 47
times[times > 30] <- NA
times

mean(times)
mean(times,na.rm = TRUE)

# Mean of the values between 20 and 35
times > 20
times < 35
times > 20 & times < 35
times[times > 20 & times < 35]
mean(times[times > 20 & times < 35], na.rm = TRUE)
times > 20 | times < 35

mean(x = times)
mean(times)
mean(times, na.rm = TRUE)
mean(times, trim = .2, na.rm = TRUE)

mtcars
?mtcars
head(mtcars)
tail(mtcars)
str(mtcars)
names(mtcars)
