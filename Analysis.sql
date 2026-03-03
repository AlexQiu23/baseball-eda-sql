-- Data Cleaning
-- 1) Check for duplicates (traded players)
SELECT playerID, yearID, COUNT(*)
FROM batting
WHERE yearID >= 1990
GROUP BY playerID, yearID
HAVING COUNT(*) > 1;

-- 2) Verify no weird values
SELECT * 
FROM batting 
WHERE yearID >= 1990 AND H > AB;


-- Exploratory Data Analysis (stats up to 2018)
-- 1) All time home run leaders 
SELECT 
    p.nameFirst as First_name,
    p.nameLast as Last_name,
    SUM(b.HR) as total_home_runs
FROM batting as b
JOIN people as p ON b.playerID = p.playerID
GROUP BY b.playerID, p.nameFirst, p.nameLast
ORDER BY total_home_runs DESC
LIMIT 10;

-- 2) Top 10 leaders in batting average from 1990 to 2018
SELECT 
	p.nameFirst as First_name, 
	p.nameLast as Last_name, 
	SUM(b.H) as total_hits,
    SUM(b.AB) as total_at_bats, 
    SUM(b.H) / SUM(b.AB) as batting_average
FROM batting as b
JOIN people as p ON b.playerID = p.playerID
WHERE b.yearID BETWEEN 1990 and 2018
GROUP BY b.playerID, p.nameFirst, p.nameLast
HAVING SUM(b.AB) > 500
ORDER BY batting_average DESC
LIMIT 10;

-- 3) Leaders in strikeouts for each season between 2000 to 2018
WITH season_so as (
    SELECT 
        p.yearID,
        ppl.nameFirst,
        ppl.nameLast,
        SUM(p.SO) as total_strikeouts,
        ROW_NUMBER() OVER (PARTITION BY p.yearID ORDER BY SUM(p.SO) DESC) as row_num
    FROM pitching as p
    JOIN people as ppl 
		ON p.playerID = ppl.playerID
    WHERE p.yearID BETWEEN 2000 AND 2018
	GROUP BY p.yearID, p.playerID
)
SELECT 
    yearID as Season,
    nameFirst as First_name,
    nameLast as Last_name,
    total_strikeouts
FROM season_so
WHERE row_num = 1
ORDER BY Season;

-- 4) Career ERA leaders between 1990 and 2018 with minimum 1500 innings pitched
SELECT 
	ppl.nameFirst as First_name,
    ppl.nameLast as Last_name,
    SUM(p.ER) as total_earned_runs,
    SUM(p.IPouts) / 3 as total_innings_pitched,
    (SUM(p.ER) / (SUM(p.IPouts) / 3)) * 9 as career_ERA
FROM pitching as p
JOIN people as ppl ON p.playerID = ppl.playerID
WHERE p.yearID BETWEEN 1990 and 2018
GROUP BY p.playerID, ppl.nameFirst, ppl.nameLast
HAVING SUM(p.IPouts) / 3 > 1500
ORDER BY career_ERA
LIMIT 10;

-- 5) Teams with most wins in a single season between 1990 and 2018
SELECT 
	t.yearID as Season,
    t.name as Team_name,
    t.W as Wins
FROM teams as t
WHERE t.yearID BETWEEN 1990 and 2018
ORDER BY Wins DESC
LIMIT 10;

-- 6) Teams with most loses in a single season between 1990 and 2018
SELECT 
	t.yearID as Season,
    t.name as Team_name,
    t.L as Loses
FROM teams as t
WHERE t.yearID BETWEEN 1990 and 2018
ORDER BY LOSES DESC
LIMIT 10;

-- 7) Teams that spend the most on payroll between 1990 and 2018
WITH team_payroll as (
	SELECT 
		teamID, 
        yearID,
        SUM(salary) as Payroll
	FROM salaries
    WHERE yearID BETWEEN 1990 and 2018
	GROUP BY teamID, yearID
)
SELECT 
	t.yearID as Season,
	t.name as Team_name,
    tp.Payroll
FROM teams as t 
JOIN team_payroll as tp 
	ON tp.teamID = t.teamID
	AND tp.yearID = t.yearID
ORDER BY Payroll DESC;

-- 8) Do higher payrolls lead to more wins (1990 - 2018)
WITH team_payroll as (
	SELECT 
		teamID, 
        yearID,
        SUM(salary) as Payroll
	FROM salaries
    WHERE yearID BETWEEN 1990 and 2018
	GROUP BY teamID, yearID
)
SELECT 
	t.name as Team_name,
    t.yearID as Season,
    tp.Payroll,
    t.W as Wins,
    t.L as Loses,
    (t.W) / (t.W + t.L) as Win_pct
FROM teams as t
JOIN team_payroll as tp 
	ON tp.teamID = t.teamID
	AND tp.yearID = t.yearID
ORDER BY t.yearID, Win_pct DESC;
-- higher payrolls do not lead to more wins

 -- 9) Did stats spike during the steroid era (1994-2004)
 SELECT 
CASE 
    WHEN yearID BETWEEN 1994 AND 2004 THEN 'Steroid Era'
    WHEN yearID > 2004 THEN 'Post Steroid Era'
    ELSE 'Pre Steroid Era'
END as Era,
    AVG(b.HR) as Avg_home_runs,
    SUM(b.H) / SUM(b.AB) as Batting_average
FROM batting as b
GROUP BY Era
ORDER BY Avg_home_runs DESC;
-- During the steroid era, stats did in fact spike as the number of home runs and batting averages increased








