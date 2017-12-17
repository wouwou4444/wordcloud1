# -*- coding: utf-8 -*-
"""
Created on Sun Dec 17 05:42:58 2017

@author: valer_3w0bq3q
"""

import re



from pyspark import SparkContext
sc.stop()
sc = SparkContext("local", "Simple App")

print(sc)

def parse_edge(s):
    user, follower = s.split("\t")
    return (int(user),int(follower))

def step(item):
    prev_v, prev_d, next_v,old_path = item[0], item[1][0][0], item[1][1], item[1][0][1]
    new_path = list(old_path)
    new_path.extend( [next_v]  )
    return (next_v,(prev_d + 1, new_path))

def complete(item):
    v, old_d, new_d = item[0], item[1][0],item[1][1]
    #v, old_d, new_d, old_path, new_path = item[0], item[1][0][0],item[1][1][0], item[1][0][1:], item[1][1][1:]
    #print("v: ", v, ",old_path: ",old_path, ",new_path: ",new_path)
    return (v, old_d  if old_d is not None else new_d)

edges = sc.textFile("d:/valbuz/wordcloud/twitter_rv.net")
forward_edges = edges.map(parse_edge).map(lambda e: (e[1],e[0])).cache()

x = 22
d = 0
dest = 14  

distances = sc.parallelize([(x,(d,[x]))])
print(distances.collect())

while True:
    candidates1 = distances.join(forward_edges)
    print(candidates1.collect())

    candidates = distances.join(forward_edges).map(step)
    print(candidates.collect())

    new_distances1 = distances.fullOuterJoin(candidates)
    print(new_distances1.collect())

    new_distances = distances.fullOuterJoin(candidates).map(complete)
    print(new_distances.collect())
    count = new_distances.filter(lambda i:i[1][0] == d + 1).count()
    if count > 0:
        d += 1
        distances = new_distances
        print("d= ", d, "count= ", count)
        print(distances.collect())
        found = new_distances.filter(lambda i:i[0] == dest ).count()
        found_item = new_distances.filter(lambda i:i[0] == dest )
        if found > 0:
            print("Found: ", (new_distances.filter(lambda i:i[0] == dest ).map(lambda i:i[1][1]).collect()))
            #print(found_item.map(lambda i:i[1][1:]).flatMap(lambda l: [item for sublist in l for item in sublist]).collect())
            print(found_item.map(lambda i:i[1][1]).flatMap(lambda l: [item for item in l]).collect())
            found_item.map(lambda i:i[1][1]).flatMap(lambda l: [item for item in l]).foreach(print)
            break
        if d == 2:
            break
    else:
        break
