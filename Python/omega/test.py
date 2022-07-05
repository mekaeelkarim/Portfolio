from pymongo import MongoClient


from pymongo import MongoClient
client = MongoClient('mongodb+srv://mekaeel:testing123@test.kynju.mongodb.net/test?retryWrites=true&w=majority')
db = client.database
try: db.command("serverStatus")
except Exception as e: print(e)
else: print("You are connected!")
client.close()