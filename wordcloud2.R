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


