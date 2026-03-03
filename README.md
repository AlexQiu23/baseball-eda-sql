# baseball-eda-sql
# MLB Baseball Exploratory Data Analysis (1990–2018)

## Project Overview
This project explores over 125 years of MLB baseball data using MySQL. The goal was to uncover trends and patterns in player performance, team success, and the impact of payroll on winning using real historical data from the Lahman Baseball Database.

## Tools Used
- **MySQL** — data cleaning and exploratory data analysis
- **Lahman Baseball Database** — source data

## Dataset
The Lahman Baseball Database is one of the most comprehensive publicly available sports datasets, containing MLB statistics dating back to 1871. This analysis focuses on the 1990–2018 era and uses the following tables:
- `batting` — player batting stats per season
- `pitching` — player pitching stats per season
- `people` — player biographical information
- `teams` — team stats and standings per season
- `salaries` — player salary data per season

## Data Cleaning
Before analysis, the following checks were performed:
- Checked for duplicate records caused by mid-season trades (players appearing more than once in the same season)
- Verified no invalid values existed such as hits exceeding at bats

## Questions Explored
1. Who are the all time home run leaders?
2. Who had the best batting averages from 1990 to 2018 (min. 500 AB)?
3. Who led the league in strikeouts each season from 2000 to 2018?
4. Who had the best career ERA from 1990 to 2018 (min. 1500 innings pitched)?
5. Which teams had the most wins in a single season?
6. Which teams had the most losses in a single season?
7. Which teams spent the most on payroll?
8. Do higher payrolls lead to more wins?
9. Did stats spike during the steroid era (1994–2004)?

## Key Findings
- **Payroll does not correlate with winning.** Despite some teams spending significantly more than others, high payroll did not consistently lead to more wins. Several low payroll teams outperformed high spending ones.
- **Stats spiked during the steroid era.** Home run averages and batting averages were noticeably higher during the 1994–2004 period compared to both the pre and post steroid era, supporting the widely held belief that performance enhancing drugs inflated offensive numbers during this time.

## How to Run This Project
1. Download the Lahman Baseball Database from [https://github.com/WebucatorTraining/lahman-baseball-mysql/blob/master/updated-lahman-mysql.sql]
2. Open `Analysis.sql` and run the queries in order
