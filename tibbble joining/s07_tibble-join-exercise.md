---
title: "s07 Exercises: Tibble Joins"
output: 
  html_document:
    keep_md: true
    theme: paper
---

## Requirements

You will need data from Joey Bernhardt's `singer` R package for this exercise. 

You can download the singer data from the `USF-Psych-DlassroomataSci/C` repo:

``` 
songs <- read_csv("https://github.com/USF-Psych-DataSci/Classroom/raw/master/data/singer/songs.csv", na = c("NA"))
locations <- read_csv("https://github.com/USF-Psych-DataSci/Classroom/raw/master/data/singer/loc.csv")
```

If you want, you could instead install the `singer` package itself. To do that,
you'll need to install `devtools`. Running this code in your console should do 
the trick:

```r
# update.packages(ask = FALSE)
```



Load required packages:



<!-- The following chunk allows errors when knitting -->



## Exercise 1: `singer`

The package `singer` comes with two smallish data frames about songs. 
Let's take a look at them (after minor modifications by renaming and shuffling):


```r
(time <- as_tibble(songs) %>% 
   rename(song = title))
```

```
## Error in as_tibble(songs): object 'songs' not found
```


```r
(album <- as_tibble(locations) %>% 
   select(title, everything()) %>% 
   rename(album = release,
          song  = title))
```

```
## Error in as_tibble(locations): object 'locations' not found
```


1. We really care about the songs in `time`. But, for which of those songs do we 
   know its corresponding album?


```r
time %>% 
  inner_join(album, by = c("song", "artist_name"))
```

```
## Error in UseMethod("inner_join"): no applicable method for 'inner_join' applied to an object of class "function"
```

2. Go ahead and add the corresponding albums to the `time` tibble, being sure to 
   preserve rows even if album info is not readily available.


```r
time %>% 
  left_join(album, by = c("song", "artist_name"))
```

```
## Error in UseMethod("left_join"): no applicable method for 'left_join' applied to an object of class "function"
```

3. Which songs do we have "year", but not album info?


```r
time %>% 
  anti_join(album, by = c("song", "artist_name"))
```

```
## Error in UseMethod("anti_join"): no applicable method for 'anti_join' applied to an object of class "function"
```

4. Which artists are in `time`, but not in `album`?


```r
time %>% 
  anti_join(album, by = "artist_name")
```

```
## Error in UseMethod("anti_join"): no applicable method for 'anti_join' applied to an object of class "function"
```


5. You've come across these two tibbles, and just wish all the info was 
   available in one tibble. What would you do?


```r
time %>% 
  full_join(album, by = c("song", "artist_name"))
```

```
## Error in UseMethod("full_join"): no applicable method for 'full_join' applied to an object of class "function"
```

```r
# or

time %>% 
  full_join(select(album, -artist_name), by = "song")
```

```
## Error in UseMethod("full_join"): no applicable method for 'full_join' applied to an object of class "function"
```


## Exercise 2: LOTR

Load in three tibbles of data on the Lord of the Rings:


```r
fell <- read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Fellowship_Of_The_Ring.csv")
```

```
## Parsed with column specification:
## cols(
##   Film = col_character(),
##   Race = col_character(),
##   Female = col_double(),
##   Male = col_double()
## )
```

```r
ttow <- read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Two_Towers.csv")
```

```
## Parsed with column specification:
## cols(
##   Film = col_character(),
##   Race = col_character(),
##   Female = col_double(),
##   Male = col_double()
## )
```

```r
retk <- read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Return_Of_The_King.csv")
```

```
## Parsed with column specification:
## cols(
##   Film = col_character(),
##   Race = col_character(),
##   Female = col_double(),
##   Male = col_double()
## )
```

1. Combine these into a single tibble.


```r
bind_rows(fell, ttow, retk)
```

```
## # A tibble: 9 x 4
##   Film                       Race   Female  Male
##   <chr>                      <chr>   <dbl> <dbl>
## 1 The Fellowship Of The Ring Elf      1229   971
## 2 The Fellowship Of The Ring Hobbit     14  3644
## 3 The Fellowship Of The Ring Man         0  1995
## 4 The Two Towers             Elf       331   513
## 5 The Two Towers             Hobbit      0  2463
## 6 The Two Towers             Man       401  3589
## 7 The Return Of The King     Elf       183   510
## 8 The Return Of The King     Hobbit      2  2673
## 9 The Return Of The King     Man       268  2459
```

2. Which races are present in "The Fellowship of the Ring" (`fell`), but not in 
   any of the other ones?


```r
fell %>% 
  anti_join(ttow, by = "Race") %>% 
  anti_join(retk, by = "Race")
```

```
## # A tibble: 0 x 4
## # ... with 4 variables: Film <chr>, Race <chr>, Female <dbl>, Male <dbl>
```

```r
# or

setdiff(fell$race, ttow$race)
```

```
## NULL
```


## Exercise 3: Set Operations

Let's use three set functions: `intersect`, `union` and `setdiff`. We'll work 
with two toy tibbles named `y` and `z`, similar to Data Wrangling Cheatsheet


```r
(y <-  tibble(x1 = LETTERS[1:3], x2 = 1:3))
```

```
## # A tibble: 3 x 2
##   x1       x2
##   <chr> <int>
## 1 A         1
## 2 B         2
## 3 C         3
```

```r
(z <- tibble(x1 = c("B", "C", "D"), x2 = 2:4))
```

```
## # A tibble: 3 x 2
##   x1       x2
##   <chr> <int>
## 1 B         2
## 2 C         3
## 3 D         4
```

1. Rows that appear in both `y` and `z`


```r
intersect(y, z)
```

```
## # A tibble: 2 x 2
##   x1       x2
##   <chr> <int>
## 1 B         2
## 2 C         3
```

2. You collected the data in `y` on Day 1, and `z` in Day 2. 
   Make a data set to reflect that.


```r
union(
  mutate(y, day = "Day 1"),
  mutate(z, day = "Day 2")
)
```

```
## # A tibble: 6 x 3
##   x1       x2 day  
##   <chr> <int> <chr>
## 1 A         1 Day 1
## 2 B         2 Day 1
## 3 C         3 Day 1
## 4 B         2 Day 2
## 5 C         3 Day 2
## 6 D         4 Day 2
```

3. The rows contained in `z` are bad! Remove those rows from `y`.


```r
setdiff(y, z)
```

```
## # A tibble: 1 x 2
##   x1       x2
##   <chr> <int>
## 1 A         1
```


## Exercise 4: Flight Extra

```r
# install.packages("nycflights13")
library(nycflights13)
```


```r
flights %>% 
  left_join(weather, by = c("year", "month", "day", "origin", "hour", "time_hour")) %>% 
  left_join(planes, by = "tailnum") %>% 
  left_join(airports, c("dest" = "faa")) %>% 
  left_join(airlines, b = c("carrier" = "name"))
```

```
## # A tibble: 336,776 x 44
##    year.x month   day dep_time sched_dep_time dep_delay arr_time sched_arr_time
##     <int> <int> <int>    <int>          <int>     <dbl>    <int>          <int>
##  1   2013     1     1      517            515         2      830            819
##  2   2013     1     1      533            529         4      850            830
##  3   2013     1     1      542            540         2      923            850
##  4   2013     1     1      544            545        -1     1004           1022
##  5   2013     1     1      554            600        -6      812            837
##  6   2013     1     1      554            558        -4      740            728
##  7   2013     1     1      555            600        -5      913            854
##  8   2013     1     1      557            600        -3      709            723
##  9   2013     1     1      557            600        -3      838            846
## 10   2013     1     1      558            600        -2      753            745
## # ... with 336,766 more rows, and 36 more variables: arr_delay <dbl>,
## #   carrier <chr>, flight <int>, tailnum <chr>, origin <chr>, dest <chr>,
## #   air_time <dbl>, distance <dbl>, hour <dbl>, minute <dbl>, time_hour <dttm>,
## #   temp <dbl>, dewp <dbl>, humid <dbl>, wind_dir <dbl>, wind_speed <dbl>,
## #   wind_gust <dbl>, precip <dbl>, pressure <dbl>, visib <dbl>, year.y <int>,
## #   type <chr>, manufacturer <chr>, model <chr>, engines <int>, seats <int>,
## #   speed <int>, engine <chr>, name <chr>, lat <dbl>, lon <dbl>, alt <dbl>,
## #   tz <dbl>, dst <chr>, tzone <chr>, carrier.y <chr>
```

