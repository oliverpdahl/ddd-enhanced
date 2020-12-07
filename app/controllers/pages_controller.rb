class PagesController < ApplicationController

  helper TimeofdayHelper
  helper AccidentseverityHelper

  def zipCodeAccidentGrowth

  end

  def accidentTimeOfDayTrends

    result = helpers.getTimeOfDayByMonthQuery()
    @num_accidents_day = result.collect{|i| [i['Mo-Year'],i['Number Of Accidents (DAY)']]}
    @num_accidents_night = result.collect{|i| [i['Mo-Year'],i['Number Of Accidents (NIGHT)']]}
    @num_accidents_combined = result.collect{|i| [i['Mo-Year'],i['Number Of Accidents (DAY)']+i['Number Of Accidents (NIGHT)'],i['Number Of Accidents (DAY)']-i['Number Of Accidents (NIGHT)'],i['Number Of Accidents (DAY)'],i['Number Of Accidents (NIGHT)']]}

  end

  def zipBarChartRace
  end

  def outsideTempSeverityTrend

    result = helpers.getAccidentSeverity()

    @acc_severity = result.collect{|i| [i['Mo-Year'],i['Average Severity']]}

  end

  def lightsVsRoundAboutsYears
  end

end
