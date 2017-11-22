import pyspark

from pyspark import SparkContext
sc = SparkContext("local", "Simple App")

raw_data = sc.textFile("d:/valbuz/Francais Methodes/Russe/kitchen01-20.txt",
                       use_unicode = True)
                       
parse_data = raw_data.flatMap(lambda x:re.split("\W+",x)).filter(lambda x:x != "").map(lambda x: x.lower())

parse_data.take(3)

livre1 = parse_data.collect()

from collections import Counter

dict_serial1 = (Counter(livre1))

dict_serial1.most_common(10)

print(list(dict_serial1.elements()))

f = codecs.open('d:/outcome2.txt', encoding='utf-8', mode='w+')


[f.write(u"%s,%i\r\n" % (t[0],t[1])) for t in dict_serial1.most_common()]
    
f.close()

