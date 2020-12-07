module TimeofdayHelper

    def getTimeOfDayByMonthQuery
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

      ActiveRecord::Base.connection.exec_query(sql).to_a
    end

    def getTimeOfDayByYearQuery

        sql = 'SELECT "day"."YEAR" "Year",
            "day"."Number Of Accidents (DAY)",
            "day"."Average Temperature (DAY)",
            "night"."Number Of Accidents (NIGHT)",
            "night"."Average Temperature (NIGHT)"
        FROM(
            SELECT EXTRACT(YEAR FROM Start_Time) "YEAR",
                COUNT(accident_all.ID)"Number Of Accidents (DAY)",
                ROUND(AVG(Temperature), 2) "Average Temperature (DAY)"
            FROM accident_all
            GROUP BY EXTRACT(YEAR FROM Start_Time), Sunrise_Sunset
            HAVING Sunrise_Sunset = \'Day\'
            ORDER BY EXTRACT(YEAR FROM Start_Time)
            ) "day"
        INNER JOIN(
            SELECT EXTRACT(YEAR FROM Start_Time) "YEAR",
                COUNT(accident_all.ID)"Number Of Accidents (NIGHT)",
                ROUND(AVG(Temperature), 2) "Average Temperature (NIGHT)"
            FROM accident_all
            GROUP BY EXTRACT(YEAR FROM Start_Time), Sunrise_Sunset
            HAVING Sunrise_Sunset = \'Night\'
            ORDER BY EXTRACT(YEAR FROM Start_Time)) "night" ON "day"."YEAR" = "night"."YEAR"'

      ActiveRecord::Base.connection.exec_query(sql).to_a

    end

end
