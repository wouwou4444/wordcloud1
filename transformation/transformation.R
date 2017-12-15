Orig = c("A","B","A","A","B","A","A","B","A")
Dest = c("B","A","C","B","A","C","B","A","C")
Month = c(1,1,1,2,2,2,3,3,3)
Size = c(30,20,10,10,20,20,30,50,20)
Month1 = c(1,0.2,0,1,0.2,0,1,0.2,0)
Month2 = c(0.6,1,0,0.6,1,0,0.6,1,0)
Month3 = c(0,1,0.6,0,1,0.6,0,1,0.6)
df <- data.frame(Orig,Dest,Month,Size,Month1,Month2,Month3)
df
# 
# Orig Dest Month Size Month1 Month2 Month3
# 1    A    B     1   30    1.0    0.6    0.0
# 2    B    A     1   20    0.2    1.0    1.0
# 3    A    C     1   10    0.0    0.0    0.6
# 4    A    B     2   10    1.0    0.6    0.0
# 5    B    A     2   20    0.2    1.0    1.0
# 6    A    C     2   20    0.0    0.0    0.6
# 7    A    B     3   30    1.0    0.6    0.0
# 8    B    A     3   50    0.2    1.0    1.0
# 9    A    C     3   20    0.0    0.0    0.6

transform(df, NewSize=ifelse(Month==1, Size*Month1, 
                             ifelse(Month==2, Size*Month2, Size*Month3)))

install.packages("data.table")
require(data.table)
setkey(setDT(df), 
       Month)
df[.(mon = 1:3),
              NewSize := Size * get(paste0("Month", mon)), 
              by=.EACHI]                                   

