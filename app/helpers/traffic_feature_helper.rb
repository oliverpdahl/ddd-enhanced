module TrafficFeatureHelper

  def getAllTrafficFeatures
    sql = 'SELECT EXTRACT(YEAR FROM Start_Time) "YEAR",
    EXTRACT(MONTH FROM Start_Time) "MONTH",
    concat(EXTRACT(MONTH FROM Start_Time), concat(\'-\', EXTRACT(YEAR FROM Start_Time))) "Mo-Year",
    COUNT( CASE WHEN BUMP = \'True\' THEN 1 END)"BUMP",
    COUNT( CASE WHEN CROSSING = \'True\' THEN 1 END)"CROSSING",
    COUNT( CASE WHEN GIVE_WAY = \'True\' THEN 1 END)"GIVE_WAY",
    COUNT( CASE WHEN JUNCTION = \'True\' THEN 1 END)"JUNCTION",
    COUNT( CASE WHEN NO_EXIT = \'True\' THEN 1 END)"NO_EXIT",
    COUNT( CASE WHEN RAILWAY = \'True\' THEN 1 END)"RAILWAY",
    COUNT( CASE WHEN STATION = \'True\' THEN 1 END)"STATION",
    COUNT( CASE WHEN "STOP" = \'True\' THEN 1 END)"STOP",
    COUNT( CASE WHEN TRAFFIC_SIGNAL = \'True\' THEN 1 END)"TRAFFIC_SIGNAL"
FROM accident_all
GROUP BY EXTRACT(YEAR FROM Start_Time), EXTRACT(MONTH FROM Start_Time)
ORDER BY EXTRACT(YEAR FROM Start_Time), EXTRACT(MONTH FROM Start_Time)'

    ActiveRecord::Base.connection.exec_query(sql).to_a
  end
end