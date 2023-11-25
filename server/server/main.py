from flask import Flask

app = Flask(__name__)


@app.route("/", methods=["GET"])
def home():
    return "Hello, World!"


@app.route("/get-best-hour", methods=["POST"])
def get_best_hour():
    return "Best Hour!"


@app.route("/get-best-subject", methods=["POST"])
def get_best_subject():
    return "Best Subject!"


@app.route("/linear_regress", methods=["POST"])
def linear_regression():
    return "Linear Regress!"


if __name__ == "__main__":
    app.run(debug=True)
