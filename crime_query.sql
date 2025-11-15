select *
from Crime_Data

exec sp_help crime_data

Select 
	Round(LAT,2),
	round(longitude,2)
From Crime_Data

Update Crime_Data
Set 
	LAT =Round(LAT,2),
	longitude= round(longitude,2);

Alter table crime_data
Alter column Time_OCC_2 Time(0);

/*
the next set of codes checks for nulls and updates with neccesary parameters
i will also be using a count and grouping function to find ranges of each necessary header
where i can see any abnormal values i.e vict_age having 0 or 1 for crimes which in reality is impossible.

*/

Select *
From Crime_Data
Where Date_Rptd_1 is Null
	OR DATE_OCC_1 is Null
	OR Time_OCC_2 is Null
	OR AREA is Null
	OR AREA_NAME is Null
	OR Crm_Cd is Null
	OR Crm_Cd_Desc is Null
	OR Vict_Age is Null
	OR Vict_Descent is Null
	OR Vict_Sex is Null
	OR Premis_Cd is Null
	OR Premis_Desc is Null;

Select *
From Crime_Data
Where Date_Rptd_1 is Null

Select
	count(Date_Rptd_1) AS date_rpt,
	Date_Rptd_1
from Crime_Data
group by Date_Rptd_1

Select *
From Crime_Data
Where DATE_OCC_1 is Null

Select
	count(DATE_OCC_1) AS date_occ,
	DATE_OCC_1
from Crime_Data
group by DATE_OCC_1
order by date_occ Desc

Select *
From Crime_Data
Where Time_OCC_2 is Null

Select
	count(Time_OCC_2) AS time_occ,
	Time_OCC_2
from Crime_Data
group by Time_OCC_2
order by time_occ DESC


Select *
From Crime_Data
Where AREA is Null

Select
	count(AREA) AS Area_new,
	AREA
from Crime_Data
group by AREA
order by Area_new DESC

Select *
From Crime_Data
Where AREA_NAME is Null

Select
	count(AREA_NAME) AS Area_names,
	AREA_NAME
from Crime_Data
group by AREA_NAME
order by Area_names DESC

Select *
From Crime_Data
Where Crm_Cd is Null

Select
	count(Crm_Cd) AS crm_cds,
	Crm_Cd
from Crime_Data
group by Crm_Cd
order by crm_cds DESC

Select *
From Crime_Data
Where Crm_Cd_Desc is Null

Select
	count(Crm_Cd_Desc) AS crm_cd_descs,
	Crm_Cd_Desc
from Crime_Data
group by Crm_Cd_Desc
order by crm_cd_descs DESC

Select *
From Crime_Data
Where Vict_Descent is Null

Select *
From Crime_Data
Where Vict_Descent = '-'

update Crime_Data
set Vict_Descent = 'Not Recorded'
where Vict_Descent is Null

update Crime_Data
set Vict_Descent = 'Not Recorded'
where Vict_Descent = '-'

Select
	count(Vict_Descent) AS victim_descent,
	Vict_Descent
from Crime_Data
group by Vict_Descent
order by victim_descent DESC

Select *
From Crime_Data
Where Vict_Age is Null
/*
	at this point i have observed age irregularities, where we have age ranging from (-4 to 17) unreliable data and minors
	also have ages from up to 120years which is quite unrealistic.

*/

Select
	count(Vict_Age) AS victim_age,
	Vict_Age
from Crime_Data
group by Vict_Age
order by Vict_Age 

--this code checks for the group of crimes done by age group (-4 to 17) unreliable data and minors
Select
	Vict_Age,
	Crm_Cd_Desc,
	count(*) AS crm_desc_count
from Crime_Data
where Vict_Age Between -4 and 0
group by Vict_Age, Crm_Cd_Desc
order by Vict_Age, crm_desc_count desc

update Crime_Data
set Vict_Age= Null 
from Crime_Data
where Vict_Age < 0
	or Vict_Age = 0
	or Vict_Age > 120

Select
	count(Vict_Sex) AS victim_sex,
	Vict_Sex
from Crime_Data
group by Vict_Sex
order by Vict_Sex

Select 
	count(Vict_Sex)
From Crime_Data
Where Vict_Sex is Null

Select 
	count(Vict_Sex)
From Crime_Data
Where Vict_Sex ='-'

Select 
	count(Vict_Sex)
From Crime_Data
Where Vict_Sex ='H'

Update Crime_Data
Set Vict_Sex = 'Unknown'
where Vict_Sex is Null
	or Vict_Sex = '-'
	or Vict_Sex = 'H'

Select
	count(Premis_Cd) AS premis_cds,
	Premis_Cd
from Crime_Data
group by Premis_Cd
order by premis_cds

Select
	count(Premis_Desc) AS premis_descs,
	Premis_Desc
from Crime_Data
group by Premis_Desc
order by premis_descs DESC



--this code counts all the null values in our necessary fields
Select 
count (*) as Null_count
From Crime_Data
Where Date_Rptd_1 is Null
	OR DATE_OCC_1 is Null
	OR Time_OCC_2 is Null
	OR AREA is Null
	OR AREA_NAME is Null
	OR Crm_Cd is Null
	OR Crm_Cd_Desc is Null
	OR Vict_Age is Null
	OR Vict_Descent is Null
	OR Vict_Sex is Null
	OR Premis_Cd is Null
	OR Premis_Desc is Null;

select
	DR_NO,
	DATE_OCC_1,
	Date_Rptd_1,
	Time_OCC_2,
	AREA,
	AREA_NAME,
	Crm_Cd,
	Crm_Cd_Desc,
	Vict_Age,
	Vict_Descent,
	Vict_Sex,
	Premis_Cd,
	Premis_Desc
into clean_crime_data
from Crime_Data

select *
from clean_crime_data
where DR_NO is Null
	OR Date_Rptd_1 is Null
	OR DATE_OCC_1 is Null
	OR Time_OCC_2 is Null
	OR AREA is Null
	OR AREA_NAME is Null
	OR Crm_Cd is Null
	OR Crm_Cd_Desc is Null
	OR Vict_Age is Null
	OR Vict_Descent is Null
	OR Vict_Sex is Null
	OR Premis_Cd is Null
	OR Premis_Desc is Null;

--there are null values in premise_cd and premise_desc, this was left to see if editing a new created table is possible
-- just my own little curiosity.

select
	Premis_Cd,
	Premis_Desc,
	count(Premis_Cd) AS premiscode,
	count(Premis_Desc) AS premisdesc
from clean_crime_data
group by Premis_Cd, Premis_Desc
Order by Premis_Cd DESC

Update clean_crime_data
Set Premis_Desc = 'Unknown'
from clean_crime_data
where Premis_Cd is Null

Update clean_crime_data
Set Premis_Desc = 'Unknown'
from clean_crime_data
where Premis_Desc is Null

/* i have noticed 16 rows with null premise_cd and null premise_desc
the desc is easy to change as its a varchar type, however the cd is in int type 
and cannot be changed to a string. 

fix replace null with -1 for cd
*/

Update clean_crime_data
Set Premis_cd = -1
from clean_crime_data
where Premis_Cd is Null

select *
from clean_crime_data
