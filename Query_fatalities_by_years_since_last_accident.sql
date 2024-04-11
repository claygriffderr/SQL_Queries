WITH impairment_condition_2015 AS (
  SELECT
      consecutive_number,
      year_of_crash,
      number_of_drunk_drivers,
      number_of_fatalities
  FROM traffic-fatalities-416820.nhtsa_traffic_fatalities. accident_2015

)

, impairment_condition_2016 AS (
  SELECT 
      consecutive_number,
      year_of_crash,
      number_of_drunk_drivers,
      number_of_fatalities
  
  FROM traffic-fatalities-416820.nhtsa_traffic_fatalities. accident_2016
)

, driver_info_2015 AS (
  SELECT *

  FROM traffic-fatalities-416820.nhtsa_traffic_fatalities.vehicle_2015 AS driver_2015
  JOIN impairment_condition_2015 AS cond_2015 ON cond_2015.consecutive_number = driver_2015.consecutive_number
)

, driver_info_2016 AS (
  SELECT *

  FROM traffic-fatalities-416820.nhtsa_traffic_fatalities.vehicle_2016 AS driver_2016
  JOIN impairment_condition_2016 AS cond_2016 ON cond_2016.consecutive_number = driver_2016.consecutive_number

)

, driver_info_tot AS (
  SELECT *

  FROM driver_info_2015
  UNION ALL
  SELECT *
  FROM driver_info_2016
)

-- END CTE

SELECT 
  (year_of_crash - year_of_last_crash_suspension_or_conviction) AS years_since_last_crash,
  SUM (number_of_fatalities) AS number_of_fatalities

  FROM driver_info_tot
  WHERE number_of_drunk_drivers NOT IN (0, 99) AND year_of_last_crash_suspension_or_conviction NOT IN (0, 9999,9998)
  GROUP BY years_since_last_crash 
  ORDER BY NUMBER_OF_FATALITIES DESC

