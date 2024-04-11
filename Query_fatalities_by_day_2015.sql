WITH traffic_deaths_2015 AS (
SELECT 
  DISTINCT(left(CAST(timestamp_of_crash AS STRING), 10)) as dates,
  SUM(number_of_fatalities) AS number_of_fatalities


 FROM `traffic-fatalities-416820.nhtsa_traffic_fatalities. accident_2015` 

 WHERE number_of_drunk_drivers > 0 AND number_of_drunk_drivers < 99

 GROUP BY dates
 ORDER BY dates asc
)