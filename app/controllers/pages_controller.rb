class PagesController < ApplicationController
  def zipCodeAccidentGrowth
  end
  def accidentTimeOfDayTrends
  end
  def zipBarChartRace
  end
  def outsideTempSeverityTrend
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
