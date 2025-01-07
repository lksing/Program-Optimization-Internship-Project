-- Program Usage Queries (Using hotel1 as example)
-- Contents:
-- rate program analysis
------------------------------------------

-- rate program analysis
-- Generate list of rate programs by booking frequency
WITH a AS (
  SELECT agency_cd,agency_nm,agency_nbr,agency_cntrct_cd, grp_nm
  FROM `demo-datalake.temp_latest_agency_code` 
)
SELECT 
  h.Description AS hotel-table_description,
  a.agency_nm AS agency_name,
  a.agency_nbr,
  a.agency_cntrct_cd, 
  a.grp_nm,
  COUNT(CONCAT(r.agency code,r.chain_cd,r.rate_cd)) AS BookingFreq,
  r.agency code AS agency code,
  r.chain_cd AS chain_code,
  r.rate_cd AS rate_code
FROM `demo-datalake.temp_bookings_hotel1` AS r
LEFT JOIN `demo-datalake.hotel1_hotel-table` AS h ON r.chain_cd = h.chain AND r.rate_cd = h.Rate_Code
LEFT JOIN a ON r.agency code = a.agency_cd
GROUP BY
  h.Description,
  a.agency_nm,
  a.agency_nbr,
  a.agency_cntrct_cd, 
  a.grp_nm,
  r.agency code,
  r.chain_cd,
  r.rate_cd
ORDER BY BookingFreq DESC


