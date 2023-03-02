-- Identify the top 10 sites per country, ordered by QoQ (Quarter over Quarter) positive change of visits, including showing the following columns:
-- Site, Country, Last Quarter, Current Quarter, QoQ Change Ratio
-- QoQ positive change of visits means that the site's visits have increased between the last quarter and the current quarter.

--------------------------------------------
-- 1.Create table site_monthly_visits:

create table site_monthly_visits
	(
		site VARCHAR(20);	
		country	INT;
		year INT;	
		month INT;	
		visits FLOAT()
	);
--------------------------------------------
-- 2.Insert values into table:

insert into site_monthly_visits
values (site, country, year, month, visits);

-- edit CSV file in SubLime (Shift+ctrl+L)

---------------------------------------------
-- 3. SQL query:

with top_5 as

	(with QoQ_change_ratio as 

-- 1.calculate last quarter visits

		(with last_quarter as 
			(select site, country, sum(visits) as last_quarter 
			from site_monthly_visits 
			where month in (7,8,9) 
			group by site, country),

-- 2.calculate current quarter visits

		current_quarter as 
			(select site, country, sum(visits) as current_quarter 
			from site_monthly_visits 
			where month in (10,11,12) 
			group by site, country)

-- 3.calculate QoQ_change_ratio by joining current_quarter and last_quarter, use coalesce() to include sites that didn't have visits in previous quarter

		select site, country, coalesce(current_quarter,0) as current_quarter, coalesce(last_quarter,0) as last_quarter, coalesce(current_quarter,0)-coalesce(last_quarter,0) as QoQ_change_ratio
		from current_quarter left join last_quarter using (site, country)
		order by country, QoQ_change_ratio desc)

-- 4.add ranking based on QoQ_change_ratio

	select site, country, current_quarter, last_quarter, QoQ_change_ratio, rank() over (partition by country order by QoQ_change_ratio desc) as top_5
	from QoQ_change_ratio)

-- 5.select top 5 sites in each country

select site, country, current_quarter, last_quarter, QoQ_change_ratio,top_5
from top_5
where top_5<=5;

