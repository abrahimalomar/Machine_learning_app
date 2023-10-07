
import pandas as pd

from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
from fastapi.middleware.cors import CORSMiddleware
#from typing import Union
from fastapi import FastAPI
from sklearn.metrics import mean_absolute_error, mean_squared_error
from sklearn.metrics import r2_score

app = FastAPI()

# Enable CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=['*']
)
#uvicorn main:app --reload
#http: ^0.13.3
# Load the data once
#data = pd.read_csv('dataAvg.csv')

@app.get("/")
def read_root():
    return {"Hello": "World"}






#import warnings

# Suppress scikit-learn warnings
#warnings.filterwarnings('ignore', category=UserWarning)


# Load your cleaned data (replace 'your_data.csv' with your actual file)
data = pd.read_excel('cleaningDataLaptopLast.xlsx')
print(data)
# Define features (X) and target variable (y)
X = data.drop('Computerprice', axis=1)
y = data['Computerprice']

# Split the data into training and testing sets (80% train, 20% test)
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.35, random_state=40)

# Initialize and train the Linear Regression model
model = LinearRegression()
model.fit(X_train, y_train)

# Make predictions on the test data
y_pred = model.predict(X_test)

# Calculate Mean Absolute Error (MAE) and Mean Squared Error (MSE)
mae = mean_absolute_error(y_test, y_pred)
mse = mean_squared_error(y_test, y_pred)

# Print the results
print(f'Mean Absolute Error (MAE): {mae}')
print(f'Mean Squared Error (MSE): {mse}')

# Calculate R-squared (R^2) score
r2 = r2_score(y_test, y_pred)

# Print the R-squared score
print(f'R-squared (R^2) Score: {r2}')

"""
@app.get("/getsum/{v1}/{v2}/{v3}/{v4}/{v5}/{v6}/{v7}")
def getSum(v1: int, v2: int, v3: int, v4: int, v5: int, v6: int, v7: int):
    y=model.predict([[v1	,v2	,v3	,v4	,v5,	v6	,v7]])
    print(y)
    return {'s': y}
"""

# Assuming you have already defined your 'model' elsewhere

@app.get("/getsum/{v1}/{v2}/{v3}/{v4}/{v5}/{v6}/{v7}")
def getSum(v1: int, v2: int, v3: int, v4: int, v5: int, v6: float, v7: int):
    # Assuming 'model.predict' returns a NumPy array
    s = model.predict([[v1, v2, v3, v4, v5, v6, v7]])
    # Convert the NumPy array to a Python list  
    return {'s': s.tolist()}







"""

@app.get("/getsum/{v1}/{v2}/{v3}/{v4}/{v5}/{v6}/{v7}")
def getSum(v1: int, v2: int, v3: int, v4: int, v5: int, v6: int, v7: int):
    s = v1 + v2 + v3 + v4 + v5 + v6 + v7
    return {'s': s}

print('Y: ',y)
#print(X_test)






@app.get("/getData")
def get_data():
    return data.to_dict(orient='records')

# Train the model once
x = np.array(data['X']).reshape(-1, 1)
y = np.array(data['Y']).reshape(-1, 1)
X_train, X_test, y_train, y_test = train_test_split(x, y, test_size=0.33, random_state=42)
lm = LinearRegression(fit_intercept=True, copy_X=True, n_jobs=10)
lm.fit(X_train, y_train)
y = lm.predict([[20]])
print('Y : ',y)

@app.get("/calculate_y/{x}")
def calculate_y(x: float):
    y = lm.predict([[x]])
    
    #return {"x": x, "y": y[0][0]}
    return {'y':y[0][0]}


@app.get("/test")
def Test():
    return "Opration"

@app.put("/tested")
def T():
    return 100



"""
"""
@app.get("/calculate_y/{x}")
def calculate_y(x: float):
    y = x * 2  # يمكنك تغيير هذا الحساب حسب احتياجاتك
    return {"x": x, "y": y}



import pandas as pd
from fastapi import FastAPI

app = FastAPI()

# Read the CSV file and assign it to the data variable
data = pd.read_csv('dataAvg.csv')

@app.get("/getData")
def getdata():
    return data.to_dict(orient='records')  # Convert DataFrame to a dictionary for JSON response

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
"""