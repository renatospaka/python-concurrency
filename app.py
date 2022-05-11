from flask import Flask
from flask_cors import CORS
from flask_cors import cross_origin

app = Flask(__name__)

CORS(app)

app.config["JSON_AS_ASCII"] = False
