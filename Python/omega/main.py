from flask import Flask, render_template, request, redirect, url_for
from flask_pymongo import PyMongo
import pymongo
from pymongo import MongoClient


app = Flask(__name__)
app.debug = True
app.secret_key = "ASK"

# Replace the uri string with your MongoDB deployment's connection string.
conn_str = 'mongodb+srv://mekaeel:testing123@test.kynju.mongodb.net/test?retryWrites=true&w=majority'
# set a 5-second connection timeout
client = pymongo.MongoClient(conn_str, serverSelectionTimeoutMS=5000)
db = client.test
try:
    print(client.server_info())
except Exception:
    print("Unable to connect to the server.")

@app.route('/insertpage', methods=['GET'])
def insertpage():
    return render_template("insert.html")

@app.route('/', methods=['GET', 'POST'])
def index():
    if request.method == 'GET':
        return render_template("index.html")
    else: 
        pass
        

@app.route('/insert', methods=['GET', 'POST'])
def insert():
    if request.method == "POST":
        name = request.form.get("name")
        year20 = request.form.get("year20")
        year19 = request.form.get('year19')
        year18 = request.form.get("year18")
        year17 = request.form.get("year17")
        year16 = request.form.get("year16")
        print(name)
        db.sealcompanydata.insert_one({"name": name, "year20": year20, "year19": year19, "year18": year18, "year17": year17, "year16": year16})
        print(name)
        return redirect(url_for('index'))
    else:
        return render_template('index.html')
    

if __name__ == '__main__':
    app.run()