WITH impairment_condition_2015 AS (
  SELECT
      consecutive_number AS consecutive_number_2015,
      year_of_crash,
      number_of_drunk_drivers,
      number_of_fatalities
  FROM traffic-fatalities-416820.nhtsa_traffic_fatalities. accident_2015

)
--creates table for 2015 data from main accident form
, impairment_condition_2016 AS (
  SELECT 
      consecutive_number AS consecutive_number_2016,
      year_of_crash,
      number_of_drunk_drivers,
      number_of_fatalities
  
  FROM traffic-fatalities-416820.nhtsa_traffic_fatalities. accident_2016
)
--creates table for 2016 data from main accident form
, driver_info_2015 AS (
  SELECT *

  FROM traffic-fatalities-416820.nhtsa_traffic_fatalities.vehicle_2015 AS driver_2015
  JOIN impairment_condition_2015 AS cond_2015 ON cond_2015.consecutive_number_2015 = driver_2015.consecutive_number
)
--joins table created for 2015 with original Vehicle table
, driver_info_2016 AS (
  SELECT *

  FROM traffic-fatalities-416820.nhtsa_traffic_fatalities.vehicle_2016 AS driver_2016
  JOIN impairment_condition_2016 AS cond_2016 ON cond_2016.consecutive_number_2016 = driver_2016.consecutive_number

)
--joins table created for 2016 with original Vehicle table
, driver_info_tot AS (
  SELECT *

  FROM driver_info_2015
  UNION ALL
  SELECT *
  FROM driver_info_2016
)
-- combines tables for 2015 & 2016
-- END CTE

SELECT 
  DISTINCT(previous_recorded_crashes) AS previous_recorded_crashes,
  
  COUNT (driver_info_tot.consecutive_number) AS number_of_crashes

  FROM driver_info_tot
  WHERE number_of_drunk_drivers NOT IN (0, 99) AND year_of_last_crash_suspension_or_conviction NOT IN (9999,9998) AND previous_recorded_crashes <> 98
  GROUP BY previous_recorded_crashes
  ORDER BY NUMBER_OF_crashes DESC
