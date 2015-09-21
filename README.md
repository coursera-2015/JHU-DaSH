# Cost of College

[App that DOE already built](https://collegescorecard.ed.gov/)

## Ideas:

- Looking at college as an investment:
  - ROI of different types of degrees (2-year, 4-year, etc)
  - Earnings power across majors and types of degrees (Associates, Bachelors)
- Shiny App:
  - Inputs: Major/cost/salary/lifetime earnings
- Regional cost of education (Choropleth?)
- Cost of Public vs Private Colleges / For-Profit vs Non-Profit
- Relative cost of college majors
- Cost of living at different colleges
- How mush does college actuall cost considering financial aid/ scholarships
- Region of college vs region of employment opportunities
- Sports budget vs tuition/region/cost
- Racial and ethnic demographics across schools


##Earnings Information
From the page:
https://collegescorecard.ed.gov/data/

There are two files under featured downloads:
Post School Earnings (the Treasury CSV) has the earnings data.
Most+Recent+Cohorts+(Treasury+Elements).csv
The fields start with mn_earn_wne*

The costs are in the scorecard csv:
Most+Recent+Cohorts(Scorecard+Elements).csv
In particular, look at the fields:
NPT4_PUB
NPT4_PRIV


##API Information 
Data API signup:
https://api.data.gov/signup

Earnings API:
https://api.data.gov/ed/collegescorecard/v1/schools?fields=school.name,id,2011.aid.median_debt.completers.overall,2011.repayment.1_yr_repayment.completers,2011.earnings.10_yrs_after_entry.working_not_enrolled.mean_earnings&page=100

Note: you must sign up for an API key and then append:
&api_key=<value>
