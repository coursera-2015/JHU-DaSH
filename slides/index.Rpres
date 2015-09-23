Cost of College
========================================================
author: Presented by: Team 'Table 5'
date: September 23, 2015
font-import: http://fonts.googleapis.com/css?family=Permanent+Marker
font-family: 'Permanent Marker'
css: custom.css

Johns Hopkins University Data Science Hackathon  
[JHU DaSH](http://bitly.com/jhudashboard)

Sponsored by: JHU Data Science Lab, JHU Biostatistics, NIH BD2K

Overview
========================================================

According to the College Board, the average cost of tuition and fees for the 2014-2015 school year was **$31,231** at private colleges, **$9,139** for state residents at public colleges, and **$22,958** for out-of-state residents attending public universities.

This presentation introduces a **Cost of College** application that will make it easier for students and parents to figure the true cost of higher education.  The cost is represented as a "Return on Investment (ROI)" and is calculated as a ratio of **mean earnings 10 years out** to **average net price**.

This presentation will cover:

* The Data
* The Model
* The Application

(View the source code and other work products on [GitHub](https://github.com/coursera-2015/JHU-DaSH).)

The Data
========================================================

![Data](Data.png)

The data for this analysis/modeling was obtained from [U.S. Department of Education College Scorecard](https://collegescorecard.ed.gov/data/).  The data was cleaned and made tidy with the following variables used for modeling.

 * __Institution ID__ (UNITID: integer), __Private vs. Public__ (isPublic: boolean), __Name__ (INSTNM: string), __Region__ (REGION: factor, __Locale__ (LOCALE: factor), __Average Net Price__ (NPT4-PUB/PRIV: integer), __Median Loan Debt__ (DEBT-MDN: integer), __Average SAT Score__ (SAT-AVG-ALL: float), __Major__ (PCIP1/.../10: boolean)

The Model
========================================================

Used eXtreme Gradient Boosting [XGBoost](https://github.com/dmlc/xgboost) to model the data.

|Num iterations|RMSD|
|--------------|----|
|100|~3|
|2000|~0.2|

* Pros: This modeling technique is fast.  It also handles potentially deep interactions

* Cons: You need to perform hyperparameter tuning.  It's easy to overfit the data.  

![Model](Model.png)

The Application
========================================================

![App](App.png)

The **Cost of College** application can be found [here](https://dgason.shinyapps.io/shinyApp).  

(NOTE: Initial loading of the application may take several seconds.  If the application is not loaded after ~15 seconds, please refresh the browser.)

* The application allows you to pick several indicators that are used as input to predict the outcome.
* The "Predicted ROI" is displayed when the inputs are selected.  This value is the *ratio* of mean earnings 10 years out to average net price (higher ratio is better).
