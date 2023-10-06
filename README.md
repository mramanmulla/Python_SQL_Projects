# **Bike Shearing Demand Prediction**
We are working with the Seoul Bike Sharing dataset. Demand for bike rentals is increasing, likely due to rising diesel and petrol prices. People are increasingly opting for rental bikes over purchasing new cars or bikes. This trend offers two significant benefits: it helps reduce pollution, and using a bike also contributes to better fitness.
## **Problem statement**
In various bustling cities, bike rental services have become a popular choice to enhance efficient traval and convenience. Ensuring a timely and continuous supply of rental bikes is essential for reducing waiting times and improving the experience for the public. The accurate prediction of hourly bicycle counts plays a significant role in achieving this goal. Bike sharing systems streamline the process of joining, renting, and returning bikes through a network of convenient locations. People have the flexibility to rent bikes from one location and return them to either the same spot or a different one as per their needs. Memberships or requests facilitate the bike rental process, which is efficiently managed through a citywide network of automated stations. Objective of this dataset is to forecast the demand for Seoul's Bike Sharing Program based on historical usage patterns, taking into account factors such as temperature, time, and other relevant data.
## **Hypothesis Testing**
1. HO- No Difference in the number of rented bikes on rainy days compared to non-rainy days.
   H1- Significant difference in the number of rented bikes on rainy days.

   Result : Reject the null hypothesis: There is a significant difference in the number of rented bikes on rainy days.

2. HO- No correlation between solar radiation and the number of rented bikes.
   H1- Significant correlation between higher solar radiation levels and increased bike rentals.

   Result : Reject the null hypothesis: There is a significant difference in the number of rented bikes on Solar_Radiation.

3. HO- No difference in the number of rented bikes on clear days compared to days with low visibility.
   H1- Significant difference in the number of rented bikes on clear days.

   Result : Reject the null hypothesis: There is a significant difference in the number of rented bikes on clear days.

## **ML Model Implementation**
1. ML Model with all Numerical Variable
2. ML Model with Numerical and Categorical Variable
3. ML Model with all Variables(with outliers)
4. knn Regression Model
5. Decision Tree Regression Model
6. ML Model with treatment of outliers.

## **Conclusion**
1. ML Model-1 R-squar for train set is 47.76% and for test set is 46.33%. Lasso Regression for test set of ML Model-1 : 46.50%. Ridge Regression for test set of ML Model-1 : 46.36%.
2. ML Model-2 R squar for train set is 55.43% and for test set is 53.63%. Lasso Regression for test set of ML Model-2 : 53.76%. Ridge Regression for test set of ML Model-2 : 53.67%
3. ML Model 3 R squar for train set is 39.54% and for test set is 37.49%. Lasso Regression for test set of ML Model-3 : 39.27%. Ridge Regression for test set of ML Model-3 : 39.26%.
4. ML Model 4 R squar for train set is 47.88% and for test set is 46.18%. Lasso Regression for test set of ML Model-4 : 39.27%. Ridge Regression for test set of ML Model-4 : 39.26%
5. Training R2 on knn Model : 82.36%,Testing R2 on knn Model: 69.42%.
6. R-squared for Decision Tree Regression Model on train set : 1.00 , R-squared for Decision Tree Regression Model on test set : 59%. After hypertuning -squared for Decision Tree Regression Model on train set : 79% , R-squared for Decision Tree Regression Model on test set : 69%
