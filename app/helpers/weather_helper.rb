module WeatherHelper

  def getAllWeather
    sql = 'SELECT accident_all.weather_condition,
    EXTRACT(YEAR FROM accident_all.start_time)"YEAR",
    EXTRACT(MONTH FROM accident_all.start_time)"MONTH",
    oncat(EXTRACT(MONTH FROM Start_Time), concat(\'-\', EXTRACT(YEAR FROM Start_Time))) "Mo-Year",
    COUNT(accident_all.id) "Total"
FROM accident_all
WHERE accident_all.weather_condition IS NOT NULL
GROUP BY accident_all.weather_condition, EXTRACT(YEAR FROM accident_all.start_time), EXTRACT(MONTH FROM accident_all.start_time)
ORDER BY EXTRACT(YEAR FROM accident_all.start_time),EXTRACT(MONTH FROM accident_all.start_time);'

    ActiveRecord::Base.connection.exec_query(sql).to_a
  end
end