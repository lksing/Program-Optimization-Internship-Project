-- Program Usage Queries (Using hotel1 as example)
-- Contents:
-- steps to find latest status of program agency codes
-- find rates and pgm table rows to remove

-- NOTE: for confidentiality reasons, all field names, table names, and hotel names have been changed/generalized
---------------------------------

-- Steps to find latest status of program agency codes

-- Find latest agency code of program agency codes
-- 1a. create temp table for latest agency code status
CREATE OR REPLACE TABLE `demo-datalake.temp_latest_agency_code` AS

SELECT ARRAY_AGG(agt ORDER BY agency_status_ts DESC LIMIT 1)[OFFSET(0)].*
FROM `demo-datalake-agency-table` AS agt
GROUP BY agt.agency_cd

-- 1b. validating agency codes in latest agency code temp table
-- retrieve agency code count from temp_latest_agency_code
SELECT COUNT(*) FROM `demo-datalake.temp_latest_agency_code` 

-- retrieve agency code count from agt_travel_arranger
SELECT COUNT(DISTINCT(agency_cd))
FROM `demo-datalake-agency-table` agt

-- Generate list of program table agency code status
-- program table agency code status list with names
WITH vp AS (
  SELECT agency_cd,agency_nm AS AgencyName
  FROM `demo-datalake.temp_latest_agency_code` 
  WHERE active_indicator = TRUE
),
ip AS (
  SELECT agency_cd,agency_nm AS AgencyName
  FROM `demo-datalake.temp_latest_agency_code` 
  WHERE active_indicator = FALSE
)
SELECT
  DISTINCT(pgm.agency_id) AS pgm_agency_code, 
  agency_nm AS AgencyName,
  CASE
    WHEN vp.agency_cd IS NOT NULL
    THEN "VALID"
    WHEN ip.agency_cd IS NOT NULL
    THEN "INVALID"
    ELSE "UNKNOWN"
  END AS agency_code_Status
FROM `demo-datalake.pgm_hotel1` as pgm
LEFT JOIN `demo-datalake.temp_latest_agency_code` AS agc ON pgm.agency_id = agc.agency_cd
LEFT JOIN vp ON pgm.agency_id=vp.agency_cd
LEFT JOIN ip ON pgm.agency_id=ip.agency_cd
ORDER BY pgm.agency_id ASC

-- 4. VALIDATION
-- validate agency codes against original agency table
SELECT agency_cd, agency_nm, active_indicator, agency_status_ts,*
FROM `demo-datalake-agency-table` agt
-- insert agency codes to spot check with
-- check active_indicator for row associated with latest agency_status_ts. Example agency codes:
WHERE agency_cd IN ('AAAA','2222','VVVV')
ORDER BY agt.agency_cd

----------------------------------
-- find rates to remove
-- 1. Prepare booking data for desired period

-- create temp table for bookings using reservation table
-- GCP data starting 2022-08-06

DECLARE from_dt DATE DEFAULT "2022-08-06";
DECLARE to_dt DATE DEFAULT "2024-04-30";

CREATE OR REPLACE TABLE `demo-datalake.temp_bookings_hotel1` AS

-- removed due to confidentiality reasons

-- 2. Generate list of hotel1 rates, filterable on booked or not booked within time period
WITH bookedRates AS (
  SELECT DISTINCT (rate_cd)
  FROM `demo-datalake.temp_bookings_hotel1`
)
SELECT 
DISTINCT(pgm.RATE_CODE) AS pgm_rate_code,
CASE
  WHEN br.rate_cd IS NULL
  THEN "FALSE"
  WHEN br.rate_cd IS NOT NULL
  THEN "TRUE"
END AS book_status
FROM `demo-datalake.hotel1_pgm` AS pgm
LEFT JOIN bookedRates AS br ON pgm.RATE_CODE = br.rate_cd;

-- 3. program table, filterable on rates booked or not booked within time period
WITH bookedRates AS (
  SELECT DISTINCT (rate_cd)
  FROM `demo-datalake.temp_bookings_hotel1`
)
SELECT 
pgm.*,
CASE
  WHEN br.rate_cd IS NULL
  THEN "FALSE"
  WHEN br.rate_cd IS NOT NULL
  THEN "TRUE"
END AS book_status
FROM `demo-datalake.hotel1_pgm` AS pgm
LEFT JOIN bookedRates AS br ON pgm.RATE_CODE = br.rate_cd;

---------------------------------------

-- Program summary

-- hotel1 rate count 
SELECT 
COUNT(DISTINCT(RATE_CODE))
FROM `demo-datalake.hotel1_pgm`

-- hotel1 rates not booked from during 1 year time period
CREATE OR REPLACE TABLE `demo-datalake.temp_hotel1_rates` AS

WITH bookedRates AS (
  SELECT DISTINCT (rate_cd)
  FROM `demo-datalake.temp_bookings_hotel1`
)
SELECT 
DISTINCT(pgm.RATE_CODE) AS pgm_rate_code,
CASE
  WHEN br.rate_cd IS NULL
  THEN "FALSE"
  WHEN br.rate_cd IS NOT NULL
  THEN "TRUE"
END AS book_status
FROM `demo-datalake.hotel1_pgm` AS pgm
LEFT JOIN bookedRates AS br ON pgm.RATE_CODE = br.rate_cd;

SELECT 
COUNT(DISTINCT(pgm_rate_code))
FROM `demo-datalake.temp_hotel1_rates`
WHERE book_status = 'FALSE'


-- Total pgm programs (total rows in pgm table)
SELECT 
COUNT(*)
FROM `demo-datalake.hotel1_pgm` AS pgm

-- Total pgm programs after deletion
-- create temp table to store programs
CREATE OR REPLACE TABLE `demo-datalake.temp_hotel1_programs` AS

WITH bookedRates AS (
  SELECT DISTINCT (rate_cd)
  FROM `demo-datalake.temp_bookings_hotel1`
)
SELECT 
pgm.*,
CASE
  WHEN br.rate_cd IS NULL
  THEN "FALSE"
  WHEN br.rate_cd IS NOT NULL
  THEN "TRUE"
END AS book_status
FROM `demo-datalake.hotel1_pgm` AS pgm
LEFT JOIN bookedRates AS br ON pgm.RATE_CODE = br.rate_cd;

-- count program candidates for deletion (based on rates not booked)
SELECT 
COUNT(*)
FROM `demo-datalake.temp_hotel1_programs`
WHERE book_status = 'FALSE'

-- count pgm table after deletion (based on rates not booked)
SELECT 
COUNT(*)
FROM `demo-datalake.temp_hotel1_programs`
WHERE book_status = 'TRUE'


