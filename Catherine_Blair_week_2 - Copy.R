##4.4 Exercises
    ##1. Why does this code not work?

      ##my_variable <- 10
      ##my_variable
      #> Error in eval(expr, envir, enclos): object 'my_variable' not found

      ##Variable is misspelled in the second line
    
    ##2. Tweak each of the following R commands so that they run correctly:
      library(tidyverse)

      ggplot(data = mpg) + 
      geom_point(mapping = aes(x = displ, y = hwy))

      filter(mpg, cyl == 8) ##correct spelling for filter and == needed
      filter(diamonds, carat > 3) ##added an s on the end of diamond
  
  
    ##3. Press Alt + Shift + K. What happens? How can you get to the same place using the menus?
      ##You see keyboard shortcuts
      ##Go to tools --> Keyboard Shortcuts help
##5.2.4 Exercises
##1. Find all flights that

    ## 1.Had an arrival delay of two or more hours
    filter(flights, arr_delay>=120)
    ## 2.Flew to Houston (IAH or HOU)
    filter(flights, dest %in% c('IAH', 'HOU'))
    ## 3.Were operated by United, American, or Delta
    filter(flights, carrier %in% c('UA', 'AA', 'DL'))
    ## 4.Departed in summer (July, August, and September)
    filter(flights, month %in% c(7,8,9))
    ## 5.Arrived more than two hours late, but didn't leave late
    filter(flights, arr_delay > 120, dep_delay <= 0)
    ## 6.Were delayed by at least an hour, but made up over 30 minutes in flight
    filter(flights, dep_delay >= 60, dep_delay-arr_delay > 30)
    ## 7.Departed between midnight and 6am (inclusive)
    filter(flights, dep_time <= 600 | dep_time== 2400)

##2. Another useful dplyr filtering helper is between(). What does it do? Can you use it to simplify the code needed to answer the previous challenges?
   ##Between is a faster way of testing two limits at once, involves less typing 
    ##example
    filter(flights, between(month, 7, 9))
##3.How many flights have a missing dep_time? What other variables are missing? What might these rows represent?
    summary(flights)
    ##dep_time, dep_delay, arr_time, and arr_delay all have NA values
    filter(flights, is.na(dep_time)) ##8,255 flights
    filter(flights, is.na(dep_delay)) ##8,255 flights
    filter(flights, is.na(arr_time)) ##8,713 flights
    filter(flights, is.na(arr_delay)) ##9,430 
    ## Flights that did not depart or arrive or just flights that did not have proper data reocrded 
  
##4.Why is NA ^ 0 not missing? Why is NA | TRUE not missing? Why is FALSE & NA not missing? Can you figure out the general rule? (NA * 0 is a tricky counterexample!)
    ## NA ^ 0 is 1, because anything to the power of 0 is 1. 
    ## With 'NA | TRUE', since the '|' part of the string returns 'TRUE' if either of the terms are true, the whole expression returns true. 
    ## FALSE & NA is not missing because '&' returns TRUE when both parts are true. Therefore, for 'FALSE & NA' since one of the terms is false, the expression returns that same result.
    ## General rule is whenever there is a logical expression, if something can be tested that result should not be 'NA.' Any operation, such as NA * 0, has a result that can be determined, regardless of the numebr, therefore having 'NA' in it does not affet it
    

##5.3.1 Exercises
##1.How could you use arrange() to sort all missing values to the start? (Hint: use is.na()).
    arrange(flights, desc(is.na(dep_time)), dep_time)
##2.Sort flights to find the most delayed flights. Find the flights that left earliest.
    ##Most delayed:HA 51
    arrange(flights, desc(dep_delay))
    ##Earliest flight;B6 97
    arrange(flights, dep_delay)
##3.Sort flights to find the fastest flights.
    arrange(flights, air_time)

##4.Which flights travelled the longest? Which travelled the shortest?
    ##Longest travel: HA 51
    arrange(flights, desc(distance))
    ##Shortest travel: US 1632
    arrange(flights, distance)

##5.4.1 Exercises
    ##2. What happens if you include the name of a variable multiple times in a select() call?
          ##The select() call does not pay attention to duplication; no error message will occur and duplicated values are only included once in the first position in the function they appear
          
    ##3. What does the one_of() function do? Why might it be helpful in conjunction with this vector?
           ##vars <- c("year", "month", "day", "dep_delay", "arr_delay")
          ## one_of() function selects variables using character vector instead of variable names without quotes
          ## It might be helpful in conjunction with this vector becaues it is easer to generate character vectors with variable names than unquotes variable names (typically easier for someone to type out)
    ##4. Does the result of running the following code surprise you? How do the select helpers deal with case by default? How can you change that default?
          ##select(flights, contains("TIME"))
          ##Yes, because up until this point it has been stressed that capitalization does matter in R. And the contains() function seems to igonore case.
          ##The select helpers by default ignore case
          ##Adding ignore.case = FALSE
          select(flights, contains("TIME", ignore.case = FALSE))
