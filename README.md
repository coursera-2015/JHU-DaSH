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

## Data Elements/Attributes/Variable Information

```
## Unit ID for institution : UNITID
## Institution name : INSTNM
## City : City
## State postcode : STABBR
## ZIP code : ZIP
## Accreditor for institution : AccredAgency
## URL for institution's homepage : INSTURL
## Average net price for Title IV institutions (public institutions)  : NPT4_PUB
## Average net price for Title IV institutions (private for-profit and nonprofit institutions) : NPT4_PRIV
## The original amount of the loan principal upon entering repayment	DEBT_MDN				
## Average SAT equivalent score of students admitted for all campuses rolled up to the 6-digit OPE ID	: SAT_AVG_ALL

## Control of institution : Control
  Attibute Lable/Value :
  1	- Public
  2	- Private nonprofit
  3	- Private for-profit

## Region Information : Region
  Variable Name : Region
  Data type : Integer
  Data Source : IPEDS

  Attibute Lable/Value :
    0 - U.S. Service Schools
    1 - New England (CT, ME, MA, NH, RI, VT)
    2 - Mid East (DE, DC, MD, NJ, NY, PA)
    3 - Great Lakes (IL, IN, MI, OH, WI)
    4 - Plains (IA, KS, MN, MO, NE, ND, SD)
    5 - Southeast (AL, AR, FL, GA, KY, LA, MS, NC, SC, TN, VA, WV)
    6 - Southwest (AZ, NM, OK, TX)
    7 - Rocky Mountains (CO, ID, MT, UT, WY)
    8 - Far West (AK, CA, HI, NV, OR, WA)
    9 - Outlying Areas (AS, FM, GU, MH, MP, PR, PW, VI)

## Locale of institution
  Variable Name : LOCALE
  Data type : Integer
  Data Source : IPEDS
  
  Attibute Lable/Value :
    11	City: Large (population of 250,000 or more)
    12	City: Midsize (population of at least 100,000 but less than 250,000)
    13	City: Small (population less than 100,000)
    21	Suburb: Large (outside principal city, in urbanized area with population of 250,000 or more)
    22	Suburb: Midsize (outside principal city, in urbanized area with population of at least 100,000 but less than 250,000)
    23	Suburb: Small (outside principal city, in urbanized area with population less than 100,000)
    31	Town: Fringe (in urban cluster up to 10 miles from an urbanized area)
    32	Town: Distant (in urban cluster more than 10 miles and up to 35 miles from an urbanized area)
    33	Town: Remote (in urban cluster more than 35 miles from an urbanized area)
    41	Rural: Fringe (rural territory up to 5 miles from an urbanized area or up to 2.5 miles from an urban cluster)
    42	Rural: Distant (rural territory more than 5 miles but up to 25 miles from an urbanized area or more than 2.5 and up to   10 miles from an urban cluster)
    43	Rural: Remote (rural territory more than 25 miles from an urbanized area and more than 10 miles from an urban cluster)

```

## Git

How to update your fork: https://gist.github.com/seankross/8249845

