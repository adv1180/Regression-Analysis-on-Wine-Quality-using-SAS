# 🍷 Regression Analysis of Red Wine Quality using SAS

This repository contains an in-depth regression analysis of the **Red Wine Quality** dataset using **SAS**. The goal is to explore how various physicochemical features influence the quality of red wine and to build a predictive regression model using techniques covered in regression analysis coursework.

---

## 📊 Dataset

The dataset used is the **Red Wine Quality** dataset from the UCI Machine Learning Repository. It contains **1,599** observations of red Portuguese wines with **11 input variables** (physicochemical properties) and **1 output variable** (quality score between 0 and 10).

**Features:**

- `fixed acidity`  
- `volatile acidity`  
- `citric acid`  
- `residual sugar`  
- `chlorides`  
- `free sulfur dioxide`  
- `total sulfur dioxide`  
- `density`  
- `pH`  
- `sulphates`  
- `alcohol`  
- `quality` (target variable)

---

## 🧪 Methodology

This analysis was done using **SAS** and includes the following steps:

1. **Data Exploration and Cleaning**
   - Summary statistics
   - Checking for outliers and missing values

2. **Correlation Analysis**
   - Heatmap and pairwise correlations

3. **Model Building**
   - Simple Linear Regression
   - Multiple Linear Regression
   - Stepwise Variable Selection (Forward, Backward, and Stepwise)

4. **Diagnostics**
   - Residual plots
   - Checking for multicollinearity (VIF)
   - Cook's Distance and Leverage Points

5. **Model Validation**
   - Train-test split
   - Mean Squared Error (MSE)
   - R-squared values
   - Cross-validation (if applicable)
---

## 📈 Key Findings

- `Alcohol`, `volatile acidity`, and `sulphates` showed strong relationships with wine quality.
- Diagnostics indicate the model assumptions were reasonably met.
