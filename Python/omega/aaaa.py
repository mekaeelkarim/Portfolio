import pymongo

myclient = pymongo.MongoClient("uri")
mydb = myclient["monopoly"]
mycol = mydb["game"]

myquery = { "user": "ganesh@gmail.com" }

mydoc = mycol.find()

for x in mydoc:
  print(x)
  
print("Done!")