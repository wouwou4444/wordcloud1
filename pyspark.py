D:\valbuz\download\hadoop\hadoop-2.7.3\bin\winutils.exe chmod 777 e:\tmp\hive

E:\Programs\spark-2.2.0\bin>pyspark
Python 3.5.2 |Anaconda 4.2.0 (64-bit)| (default, Jul  5 2016, 11:41:13) [MSC v.1900 64 bit (AMD64)] on win32
Type "help", "copyright", "credits" or "license" for more information.
Using Spark's default log4j profile: org/apache/spark/log4j-defaults.properties
Setting default log level to "WARN".
To adjust logging level use sc.setLogLevel(newLevel). For SparkR, use setLogLevel(newLevel).
17/11/20 22:49:53 WARN ObjectStore: Failed to get database global_temp, returning NoSuchObjectException
Welcome to
____              __
/ __/__  ___ _____/ /__
_\ \/ _ \/ _ `/ __/  '_/
   /__ / .__/\_,_/_/ /_/\_\   version 2.2.0
      /_/

Using Python version 3.5.2 (default, Jul  5 2016 11:41:13)
SparkSession available as 'spark'.
>>> sc
<SparkContext master=local[*] appName=PySparkShell>
>>> sc.parallelize([1,2,3,4,5])
ParallelCollectionRDD[0] at parallelize at PythonRDD.scala:480
>>> a = sc.parallelize([1,2,3,4,5])
>>> a
ParallelCollectionRDD[1] at parallelize at PythonRDD.scala:480
>>> b = a.filtet(lambda x:x%2==0)
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
AttributeError: 'RDD' object has no attribute 'filtet'
>>> b = a.filter(lambda x:x%2==0)
>>> b
PythonRDD[2] at RDD at PythonRDD.scala:48
>>> a
ParallelCollectionRDD[1] at parallelize at PythonRDD.scala:480
>>> a.collect()
[1, 2, 3, 4, 5]
>>>
