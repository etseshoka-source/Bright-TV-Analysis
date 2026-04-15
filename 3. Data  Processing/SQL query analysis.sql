-----------------------------------------------------------------------------------
---Viewing first 100 rows of Viewership dataset
-----------------------------------------------------------------------------------

select * from `case_study`.`bright_tv`.`viewership` limit 100;

-----------------------------------------------------------------------------------
---View the entire table for Viewership
-----------------------------------------------------------------------------------
select * 
from `case_study`.`bright_tv`.`viewership`;

------------------------------------------------------------------------------------
---Viewership data inspection 
------------------------------------------------------------------------------------

select *
from `case_study`.`bright_tv`.`viewership`
where userid4 != UserID0;

select *
from `case_study`.`bright_tv`.`viewership`
where userid4 = UserID0;

----------------------------------------------------------------------------
---Checking the TV channels viewed on Bright TV
---There are 21 channels on Bright TV
----------------------------------------------------------------------------

select distinct Channel2 AS TV_Channels
from `case_study`.`bright_tv`.`viewership`;

select  Channel2,
        count(UserID0) AS TV_Viewers
from `case_study`.`bright_tv`.`viewership`
group by Channel2;

----------------------------------------------------------------------------------------
---Checking date range
---Recorded from 01/01/2016 to 31/03/2016, 3 months duration
----------------------------------------------------------------------------------------
select min(RecordDate2) AS min_date,
       max(RecordDate2) AS max_date
from `case_study`.`bright_tv`.`viewership`;

-----------------------------------------------------------------------------------
---Converting Record date from UTC to SAST
-----------------------------------------------------------------------------------
select 
       UserID0,
       Channel2,
       RecordDate2,
       DATEADD(HOUR, 2, RecordDate2) AS Record_date_sast,
       `Duration 2`
from `case_study`.`bright_tv`.`viewership`;

--------------------------------------------------------------------------------
---Extract Date from Record date
--------------------------------------------------------------------------------

select
    UserID0,
    Channel2,
    RecordDate2,
    DATE(RecordDate2) AS Record_Date
from `case_study`.`bright_tv`.`viewership`;

---------------------------------------------------------------------------------
---Extract converted time from record date
---------------------------------------------------------------------------------

select
    UserID0,
    Channel2,
    RecordDate2,
    DATE_FORMAT(DATEADD(HOUR, 2, RecordDate2), 'HH:mm:ss') AS Converted_Record_Time
from `case_study`.`bright_tv`.`viewership`;

select
    min(DATE_FORMAT(DATEADD(HOUR, 2, RecordDate2), 'HH:mm:ss')) AS Start_Time,
    max(DATE_FORMAT(DATEADD(HOUR, 2, RecordDate2), 'HH:mm:ss')) AS End_Time
from `case_study`.`bright_tv`.`viewership`;  

-------------------------------------------------------------------------------------------------
---Calculating total viewing hours per channel
-------------------------------------------------------------------------------------------------
select
    Channel2,
    ROUND(SUM(HOUR(`Duration 2`) + MINUTE(`Duration 2`)/60 + SECOND(`Duration 2`)/3600)) AS Total_viewing_hours_per_channel
from `case_study`.`bright_tv`.`viewership`
group by Channel2
order by Total_viewing_hours_per_channel desc;
-------------------------------------------------------------------------------------------------
---Calculating total viewing hours
---1523 hours spent within 3 months
-------------------------------------------------------------------------------------------------
select
    ROUND(SUM(HOUR(`Duration 2`) + MINUTE(`Duration 2`)/60 + SECOND(`Duration 2`)/3600)) AS Total_hours
from `case_study`.`bright_tv`.`viewership`;

-------------------------------------------------------------------------------------
---Date range
---Record date started from 01/01/2016 to 01/04/2016 based on South African time
-------------------------------------------------------------------------------------
select 
      min(DATEADD(HOUR, 2, RecordDate2)) AS min_record_date,
      max(DATEADD(HOUR, 2, RecordDate2)) AS max_record_date
from `case_study`.`bright_tv`.`viewership`;

select
    UserID0,
    Channel2,
    DATE_FORMAT(( `Duration 2`), 'HH:mm:ss') AS Duration_time
from `case_study`.`bright_tv`.`viewership`;

select
       min(DATE_FORMAT(( `Duration 2`), 'HH:mm:ss')) AS Shortest_session,
       max(DATE_FORMAT(( `Duration 2`), 'HH:mm:ss')) AS Longest_session
from `case_study`.`bright_tv`.`viewership`;

select 
      Channel2,
      Count( Distinct UserID0) AS Viewers
from `case_study`.`bright_tv`.`viewership`
group by UserID0,
         Channel2
having Viewers >= 1;

-----------------------------------------------------------------------------------
---Checking for nulls
---No nulls found
-----------------------------------------------------------------------------------
select * 
from `case_study`.`bright_tv`.`viewership`
where UserID0 IS NULL
      OR Channel2 IS NULL
      OR RecordDate2 IS NULL
      OR userid4 IS NULL
      AND `Duration 2` IS NULL;

-----------------------------------------------------------------------------------
---User profiles data inspection
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
---Viewing first 100 rows of User profiles dataset
-----------------------------------------------------------------------------------
select * from `case_study`.`bright_tv`.`userprofiles` limit 100;

-----------------------------------------------------------------------------------
select * 
from `case_study`.`bright_tv`.`userprofiles`;
-----------------------------------------------------------------------------------
---Find the lowest and highest age
-----------------------------------------------------------------------------------
select min(Age) AS min_age,
       max(Age) AS max_age
from `case_study`.`bright_tv`.`userprofiles`;
--------------------------------------------------------------------------------------------------
---Capitalize the first letter of Column names with incosistent casing, remove spacing in between ---words and use small letters for Email and Social Medai Handle columns
--------------------------------------------------------------------------------------------------
select 
    UserID,
    INITCAP(Name) AS Name,
    INITCAP(Surname) AS Surname,
    INITCAP(Gender) AS Gender,
    INITCAP(Race) AS Race,
    INITCAP(Province) AS Province,
    LOWER(REPLACE(Email, CHAR(160),'')) AS Email,
    LOWER(REPLACE(`Social Media Handle`, CHAR(160),'')) AS Social_Media_Handle
from `case_study`.`bright_tv`.`userprofiles`;

---------------------------------------------------------------------------------------------------
---View provinces
---There are 9 provinces
---------------------------------------------------------------------------------------------------
select INITCAP(Province) AS Province
from `case_study`.`bright_tv`.`userprofiles`
where Province != 'None' AND Province != ' '
group by Province;

select DISTINCT INITCAP(Province) AS Province
from `case_study`.`bright_tv`.`userprofiles`;

select DISTINCT INITCAP(Gender) AS Gender
from `case_study`.`bright_tv`.`userprofiles`;

select INITCAP(Gender) AS Gender
from `case_study`.`bright_tv`.`userprofiles`
where Gender != 'None' AND Gender != ' '
group by Gender;

select DISTINCT INITCAP(Race) AS Race
from `case_study`.`bright_tv`.`userprofiles`;

select INITCAP(Race) AS Race
from `case_study`.`bright_tv`.`userprofiles`
where Race != 'None' AND Race != ' '
group by Race;

--------------------------------------------------------------------------------------------------
---Checking for nulls
---No nulls found in this dataset
-------------------------------------------------------------------------------------------------

select *
from `case_study`.`bright_tv`.`userprofiles`
where Gender IS NULL 
      OR Province IS NULL 
      OR RACE IS NULL
      OR Age IS NULL
      OR Name IS NULL
      OR Surname IS NULL
      OR UserID IS NULL
      OR `Social Media Handle` IS NULL;

-----------------------------------------------------------------------------------
---Count
---Null count is 0
-----------------------------------------------------------------------------------
select COUNT(*) AS Null_count 
from `case_study`.`bright_tv`.`userprofiles`
where Gender IS NULL 
      OR Province IS NULL 
      OR RACE IS NULL;
------------------------------------------------------------------------------------------
---Check gender count
---There are 3918 males, 537 females, 702 unknown and 218 unspecified
------------------------------------------------------------------------------------------
select 
    Gender, 
    COUNT(UserID) AS Count_by_gender
from `case_study`.`bright_tv`.`userprofiles`
group by Gender;
------------------------------------------------------------------------------------------
---Checking count by Province
------------------------------------------------------------------------------------------
select 
    Province, 
    COUNT(UserID) AS Count_per_province
from `case_study`.`bright_tv`.`userprofiles`
group by Province;
------------------------------------------------------------------------------------------
---Checking count by race
------------------------------------------------------------------------------------------
select 
    Race, 
    COUNT(UserID) AS Count_by_race
from `case_study`.`bright_tv`.`userprofiles`
group by Race;

-----------------------------------------------------------------------------------
---Joining viewship and user profiles table using left join
-----------------------------------------------------------------------------------
select *
from `case_study`.`bright_tv`.`viewership` AS T
left join `case_study`.`bright_tv`.`userprofiles` AS S
ON T.UserID0 = S.UserID;


----------------------------------------------------------------------------------------------------
---Big query
----------------------------------------------------------------------------------------------------
select
    -- Viewership columns
    T.UserID0,
    INITCAP(T.Channel2) AS Channel2,
    T.RecordDate2,
    DATEADD(HOUR, 2, T.RecordDate2) AS Record_date_sast,
    DATE(T.RecordDate2) AS Record_Date,
    DATE_FORMAT(DATEADD(HOUR, 2, T.RecordDate2), 'HH:mm:ss') AS Watch_Time,
    DATE_FORMAT(( `Duration 2`), 'HH:mm:ss') AS Duration_time,
    Dayname(T.RecordDate2) AS Day_name,
    Monthname(T.RecordDate2) AS Month_name,
    Dayofmonth(T.RecordDate2) AS Date_of_month,


    -- User Profile columns
   
    Case 
         When S.Age <= 12 THEN 'Kids'
         When S.Age BETWEEN 13 AND 19 THEN 'Teens'
         When S.Age BETWEEN 20 AND 30 THEN 'Young adult'
         When S.Age BETWEEN 31 AND 40 THEN 'Adult'
         When S.Age BETWEEN 41 AND 60 THEN 'Middle-aged'
         When S.Age > 60 THEN 'Seniors'
         End AS Age_group,

         Case 
         When S.Gender = 'None' OR S.Gender = ' ' THEN 'Unknown'
         Else INITCAP(S.Gender) 
         End AS Gender_group,

         Case 
         When S.Province = 'None' OR S.Province = ' ' THEN 'Not specified'
         Else INITCAP(S.Province)
         End AS Province_Classification,
    Case 
         When S.Race = 'None' OR S.Race = ' ' THEN 'Not specified'
         Else INITCAP(S.Race)
         End AS Ethnicity_group,

    Case
          When Day_name IN ('Sat','Sun') THEN 'Weekend'
          Else 'Weekday'
          End AS Day_classification,

    Case
          When Watch_time BETWEEN '05:00:00' AND '11:59:59' THEN 'Morning'
          When Watch_time BETWEEN '12:00:00' AND '16:59:59' THEN 'Afternoon'
          When Watch_time BETWEEN '17:00:00' AND '23:59:59' THEN 'Evening'
          Else 'Midnight'
          End AS Time_classification,

          Round(Sum(Hour(`Duration 2`) + Minute(`Duration 2`)/60 + Second(`Duration 2`)/3600)) AS Total_hours,
          Count(T.UserID0) AS Viewers

from `case_study`.`bright_tv`.`viewership` AS T
left join `case_study`.`bright_tv`.`userprofiles` AS S
ON T.UserID0 = S.UserID
Where T.userid4 = T.UserID0
GROUP BY T.UserID0,
         T.Channel2,
         T.RecordDate2,
         `Duration 2`,
         S.Gender,
         S.Race,
         S.Province,
         S.Age;
