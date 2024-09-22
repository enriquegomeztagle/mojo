from python import Python

fn main():
    try:
        var plt = Python.import_module("matplotlib.pyplot")
        var train_test_split = Python.import_module("sklearn.model_selection").train_test_split
        var LinearRegression = Python.import_module("sklearn.linear_model").LinearRegression
        var fetch_california_housing = Python.import_module("sklearn.datasets").fetch_california_housing
        var r2_score = Python.import_module("sklearn.metrics").r2_score

        var california = fetch_california_housing()
        var X = california.data
        var y = california.target 

        var split = train_test_split(X, y, test_size=0.2, random_state=42)
        var X_train = split[0]
        var X_test = split[1]
        var y_train = split[2]
        var y_test = split[3]

        var model = LinearRegression()
        model.fit(X_train, y_train)

        var predictions = model.predict(X_test)

        var score = r2_score(y_test, predictions)
        print("R2 Score: ", score)
        print("Coefficients: ", model.coef_)
        print("Intercept: ", model.intercept_)

        plt.scatter(y_test, predictions, color='red')
        plt.plot(y_test, y_test, color='green')
        plt.xlabel("Actual Prices")
        plt.ylabel("Predicted Prices")
        plt.title("Actual vs Predicted Prices")
        plt.show()

    except Exception:
        print("Error: Failed to load libraries or execute code.")
