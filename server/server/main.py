from flask import Flask, jsonify, request
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

app = Flask(__name__)


@app.route("/", methods=["GET"])
def home():
    return "Welcome to i-Learn!"


@app.route("/get-best-hour", methods=["POST"])
def get_best_hour():
    # Get the time series data from the request
    time_series_data = np.array(request.json["time_series_data"])

    # Calculate the mean of each hour
    mean_hourly_values = np.mean(time_series_data.reshape(-1, 24), axis=0)

    # Find the index of the maximum mean hourly value
    best_hour_index = np.argmax(mean_hourly_values)

    # Convert the index to a real hour
    best_hour = (best_hour_index + 1) % 24

    # Return the best hour to the client
    return jsonify({"best_hour": best_hour})


@app.route("/get-best-subject", methods=["POST"])
def get_best_subject():
    time_series_data = pd.DataFrame(request.json["time_series_data"])
    mean_subject_values = time_series_data.mean(axis=0)

    sorted_mean_subject_values = mean_subject_values.sort_values(ascending=False)
    best_subjects = sorted_mean_subject_values.index.to_list()[:5]

    plt.figure(figsize=(10, 6))
    plt.bar(mean_subject_values.index, mean_subject_values.values, color="blue")
    plt.xlabel("Subject")
    plt.ylabel("Mean Value")
    plt.title("Mean Value of Subjects")
    plt.xticks(rotation=45)
    plt.tight_layout()

    plt.savefig("best_subjects_plot.png")

    return jsonify(
        {"best_subjects": best_subjects, "image_path": "best_subjects_plot.png"}
    )


@app.route("/linear_regress", methods=["POST"])
def linear_regression():
    time_series_data = np.array(request.json["time_series_data"])
    x = time_series_data[:, 0]
    y = time_series_data[:, 1]

    mean_x = np.mean(x)
    mean_y = np.mean(y)

    # Calculate the slope (m) and intercept (c)
    m = np.sum((x - mean_x) * (y - mean_y)) / np.sum((x - mean_x) ** 2)
    c = mean_y - m * mean_x

    # Calculate the predicted y values
    predicted_y = m * x + c

    # Calculate the root mean squared error (RMSE)
    rmse = np.sqrt(np.mean((y - predicted_y) ** 2))

    # Visualize the time series data and the linear regression line
    plt.figure(figsize=(10, 6))
    plt.scatter(x, y, color="blue", label="Actual Values")
    plt.plot(x, predicted_y, color="red", label="Predicted Values")
    plt.xlabel("X")
    plt.ylabel("Y")
    plt.title("Linear Regression")
    plt.legend()
    plt.tight_layout()

    # Save the plot as an image
    plt.savefig("linear_regression_plot.png")

    # Return the slope (m), intercept (c), and RMSE to the client
    return jsonify(
        {
            "slope": m,
            "intercept": c,
            "rmse": rmse,
            "image_path": "linear_regression_plot.png",
        }
    )


if __name__ == "__main__":
    app.run(debug=True)
