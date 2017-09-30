data <- readLines("https://www.r-bloggers.com/wp-content/uploads/2016/01/vent.txt") # from: http://www.wvgazettemail.com/

df <- data.frame(data)
df
str(df)

textdata <- df[df$data, ]
textdata = gsub("[[:punct:]]", "", textdata)

textdata = gsub("[[:punct:]]", "", textdata)
textdata = gsub("[[:digit:]]", "", textdata)
textdata = gsub("http\\w+", "", textdata)
textdata = gsub("[ \t]{2,}", "", textdata)
textdata = gsub("^\\s+|\\s+$", "", textdata)
try.error = function(x)
{
  y = NA
  try_error = tryCatch(tolower(x), error=function(e) e)
  if (!inherits(try_error, "error"))
    y = tolower(x)
  return(y)
}
textdata = sapply(textdata, try.error)
textdata = textdata[!is.na(textdata)]
names(textdata) = NULL


maxpage <- 112
mrange <- 50000

for(i in 0:maxpage) {
  req = paste("select \"number \", brief_description, open_time from f.table offset ", i, "rows fetch next", mrange, "rows only", sep= " ")
  print(req)
}

a <- c(rep("A", 3), rep("B", 3), rep("C",2),rep("A", 3), rep("B", 3), rep("C",2))
b <- c(1,1,2,4,1,1,2,2)
df <-data.frame(a,b)

duplicated(df)
# [1] FALSE  TRUE FALSE FALSE FALSE  TRUE FALSE  TRUE

df[duplicated(df), ]
# a b
# 2 A 1
# 6 B 1
# 8 C 2

df[!duplicated(df), ]
# a b
# 1 A 1
# 3 A 2
# 4 B 4
# 5 B 1
# 7 C 2

d.f <- data.frame(rating = c("AAA", "A", "A", "AAA", 
                             "BB", "BB", "AAA", "A"))
i <- 1
by <- d.f$rating
sub.data.frame <- d.f[by == unique(by)[i], ]