Cost of College
========================================================
author: Presented by: 'Table 5'
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

This presentation introduces a **Cost of College** application that will make it easier for students and parents to figure the true cost of higher education.  The cost is represented as a "Return on Investment (ROI)" and is calculated as a ratio of **mean 10-year earnings** to **average net price**.

This presentation will cover:

* The Data
* The Model
* The Application

(View the source code and other work products on [GitHub](https://github.com/coursera-2015/JHU-DaSH).)

The Data
========================================================

[U.S. Department of Education College Scorecard](https://collegescorecard.ed.gov/data/)

The Model
========================================================


The Application
========================================================

![App](App.png)

The **Cost of College** application can be found here [https://coursera-2015.shinyapps.io/JHU-DaSH](https://coursera-2015.shinyapps.io/JHU-DaSH).  

(NOTE: Initial loading of the application may take several seconds.  If the application is not loaded after ~15 seconds, please refresh the browser.)

* The application allows you to pick several indicators that are used as input to predict the outcome.
* You can choose the prediction model to compare the results.
* The "Predicted ROI" is displayed when the inputs are selected.  This value is the *ratio* of mean 10-year earnings to average net price (higher ratio is better).
