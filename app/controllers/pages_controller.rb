class PagesController < ApplicationController
  def zipCodeAccidentGrowth
  end
  def accidentTimeOfDayTrends
  end
  def zipBarChartRace
  end
  def outsideTempSeverityTrend

    sql = 'SELECT "day"."YEAR",
          "day"."MONTH",
          concat("day"."MONTH", concat(\'-\', "day"."YEAR")) "Mo-Year",
          "day"."Number Of Accidents (DAY)",
          "day"."Average Temperature (DAY)",
          "night"."Number Of Accidents (NIGHT)",
          "night"."Average Temperature (NIGHT)"
      FROM(
          SELECT EXTRACT(YEAR FROM Start_Time) "YEAR",
              EXTRACT(MONTH FROM Start_Time) "MONTH",
              COUNT(accident_all.ID)"Number Of Accidents (DAY)",
              ROUND(AVG(Temperature), 2) "Average Temperature (DAY)"
          FROM accident_all
          GROUP BY EXTRACT(YEAR FROM Start_Time), EXTRACT(MONTH FROM Start_Time), Sunrise_Sunset
          HAVING Sunrise_Sunset = \'Day\'
          ORDER BY EXTRACT(YEAR FROM Start_Time), EXTRACT(MONTH FROM Start_Time)
          ) "day"
      INNER JOIN(
          SELECT EXTRACT(YEAR FROM Start_Time) "YEAR",
              EXTRACT(MONTH FROM Start_Time) "MONTH",
              COUNT(accident_all.ID)"Number Of Accidents (NIGHT)",
              ROUND(AVG(Temperature), 2) "Average Temperature (NIGHT)"
          FROM accident_all
          GROUP BY EXTRACT(YEAR FROM Start_Time), EXTRACT(MONTH FROM Start_Time), Sunrise_Sunset
          HAVING Sunrise_Sunset = \'Night\'
          ORDER BY EXTRACT(YEAR FROM Start_Time), EXTRACT(MONTH FROM Start_Time)
          ) "night" ON "day"."YEAR" = "night"."YEAR" AND "day"."MONTH" = "night"."MONTH"'

    result = ActiveRecord::Base.connection.exec_query(sql).to_a

    @num_accidents_day = result.collect{|i| [i['Mo-Year'],i['Number Of Accidents (DAY)']]}
    @num_accidents_night = result.collect{|i| [i['Mo-Year'],i['Number Of Accidents (NIGHT)']]}


  end
  def lightsVsRoundAboutsYears

    sql = 'SELECT SUM("total count") "Total Tuples"
        FROM((SELECT COUNT(*)"total count"
            FROM area
            UNION
            SELECT COUNT(*) "total count"
            FROM accident_all))'
    
    @result = ActiveRecord::Base.connection.exec_query(sql).to_a

  end
end
