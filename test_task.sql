-- Identify the top 10 sites per country, ordered by QoQ (Quarter over Quarter) positive change of visits, including showing the following columns:
-- Site
-- Country
-- Last Quarter
-- Current Quarter
-- QoQ Change Ratio
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
		)
	;

-- 2.Insert values into table:

insert into site_monthly_visits
values (site, country, year, month, visits);


