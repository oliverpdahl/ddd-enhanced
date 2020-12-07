module AccidentseverityHelper

    def getAccidentSeverity
        sql ='SELECT EXTRACT(YEAR FROM Start_Time) as "Year",
        EXTRACT(MONTH FROM Start_Time) as "Month",
        concat(EXTRACT(MONTH FROM Start_Time), concat(\'-\', EXTRACT(YEAR FROM Start_Time))) "Mo-Year",
        ROUND(AVG(SEVERITY), 2) "Average Severity"
    FROM accident_all
    GROUP BY EXTRACT(YEAR FROM Start_Time), EXTRACT(MONTH FROM Start_Time), concat(EXTRACT(MONTH FROM Start_Time), concat(\'-\', EXTRACT(YEAR FROM Start_Time)))
    ORDER BY EXTRACT(YEAR FROM Start_Time), EXTRACT(MONTH FROM Start_Time), concat(EXTRACT(MONTH FROM Start_Time), concat(\'-\', EXTRACT(YEAR FROM Start_Time)))'

        ActiveRecord::Base.connection.exec_query(sql).to_a
    end

    def getAccidentSeverityLowTemp(low)
      sql ='SELECT EXTRACT(YEAR FROM Start_Time) as "Year",
      EXTRACT(MONTH FROM Start_Time) as "Month",
      concat(EXTRACT(MONTH FROM Start_Time), concat(\'-\', EXTRACT(YEAR FROM Start_Time))) "Mo-Year",
      ROUND(AVG(SEVERITY), 2) "Average Severity"
  FROM accident_all
  WHERE Temperature < 0
  GROUP BY EXTRACT(YEAR FROM Start_Time), EXTRACT(MONTH FROM Start_Time), concat(EXTRACT(MONTH FROM Start_Time), concat(\'-\', EXTRACT(YEAR FROM Start_Time)))
  ORDER BY EXTRACT(YEAR FROM Start_Time), EXTRACT(MONTH FROM Start_Time), concat(EXTRACT(MONTH FROM Start_Time), concat(\'-\', EXTRACT(YEAR FROM Start_Time)))'

      ActiveRecord::Base.connection.exec_query(sql).to_a
  end


end
