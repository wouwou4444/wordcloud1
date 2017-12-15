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

###### Version 2 with stem algorithm

from nltk.stem import SnowballStemmer
print(" ".join(SnowballStemmer.languages))

stemmer = SnowballStemmer("russian")

parse_data_stem = raw_data.flatMap(lambda x:re.split("\W+",x)).filter(lambda x:x != "").map(lambda x: x.lower()).map(lambda x: stemmer.stem(x))
livre1_stem = parse_data_stem.collect()
dict_serial1_stem = (Counter(livre1_stem))

f = codecs.open('d:/outcome2_stem.txt', encoding='utf-8', mode='w+')


[f.write(u"%s,%i\r\n" % (t[0],t[1])) for t in dict_serial1_stem.most_common()]
    
f.close()

len(list(dict_serial1_stem.elements()))
# 38960 words


###### with stem and without short words len(word) > 2
parse_data_stem4 = raw_data.flatMap(lambda x:re.split("\W+",x)).filter(lambda x:x != "").map(lambda x: x.lower()).map(lambda x: stemmer.stem(x)).filter(lambda x:len(x)>2)
livre1_stem4 = parse_data_stem4.collect()
dict_serial1_stem4 = (Counter(livre1_stem4))

f = codecs.open('d:/outcome2_stem4.txt', encoding='utf-8', mode='w+')


[f.write(u"%s,%i\r\n" % (t[0],t[1])) for t in dict_serial1_stem4.most_common()]
    
f.close()

# version 3
# pip install plotly

from plotly import __version__
from plotly.offline import download_plotlyjs, init_notebook_mode, plot, iplot

print(__version__) # requires version >= 1.9.0



