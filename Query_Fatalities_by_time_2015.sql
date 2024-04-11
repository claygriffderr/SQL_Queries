SELECT 
  day_of_crash,
  SUM (num_of_crashes) AS total_num_of_crashes
 FROM  (
  SELECT
        LPAD(CAST(month_of_crash AS STRING), 2, '0') AS month_of_crash,  
          CONCAT(
        LPAD(CAST(month_of_crash AS STRING), 2, '0'), ":",
        LPAD(CAST(day_of_crash AS STRING), 2, '0')
    ) AS day_of_crash,
          CONCAT(
        LPAD(CAST(month_of_crash AS STRING), 2, '0'), ":",
        LPAD(CAST(day_of_crash AS STRING), 2, '0'), ":",
        LPAD(CAST(hour_of_crash AS STRING), 2, '0')
    ) AS hour_of_crash,
      COUNT(consecutive_number) AS num_of_crashes
 FROM `traffic-fatalities-416820.nhtsa_traffic_fatalities. accident_2015` 
WHERE state_name = "Colorado"
 
 GROUP BY month_of_crash, day_of_crash, hour_of_crash) 

GROUP BY day_of_crash
order by total_num_of_crashes DESC