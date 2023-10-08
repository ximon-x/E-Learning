from flask import Flask, request

app = Flask(__name__)


@app.route("/find-best-hour", methods=["POST"])
def find_best_hour():
    user_data = request.get_json()

    return "Hello, World!"


@app.route("/find-weakest-subject", methods=["POST"])
def find_weakest_subject():
    return "Hello, World!"
