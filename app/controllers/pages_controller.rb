class PagesController < ApplicationController

  helper TimeofdayHelper
  helper AccidentseverityHelper

  def zipCodeAccidentGrowth

  end

  def accidentTimeOfDayTrends

    @grouping = params[:p]

    if (@grouping == 'year')
      result = helpers.getTimeOfDayByYearQuery()
      @num_accidents_day = result.collect{|i| [i['Year'],i['Number Of Accidents (DAY)']]}
      @num_accidents_night = result.collect{|i| [i['Year'],i['Number Of Accidents (NIGHT)']]}
      @num_accidents_combined = result.collect{|i| [i['Year'],i['Number Of Accidents (DAY)']+i['Number Of Accidents (NIGHT)'],i['Number Of Accidents (DAY)']-i['Number Of Accidents (NIGHT)'],i['Number Of Accidents (DAY)'],i['Number Of Accidents (NIGHT)']]}
    else
      result = helpers.getTimeOfDayByMonthQuery()
      @num_accidents_day = result.collect{|i| [i['Mo-Year'],i['Number Of Accidents (DAY)']]}
      @num_accidents_night = result.collect{|i| [i['Mo-Year'],i['Number Of Accidents (NIGHT)']]}
      @num_accidents_combined = result.collect{|i| [i['Mo-Year'],i['Number Of Accidents (DAY)']+i['Number Of Accidents (NIGHT)'],i['Number Of Accidents (DAY)']-i['Number Of Accidents (NIGHT)'],i['Number Of Accidents (DAY)'],i['Number Of Accidents (NIGHT)']]}
    end

  end

  def zipBarChartRace
 
  end

  def outsideTempSeverityTrend

    result = helpers.getAccidentSeverity()

    @low = helpers.getAccidentSeverityLowTemp()

    @acc_severity = result.collect{|i| [i['Mo-Year'],i['Average Severity']]}

  end

  def lightsVsRoundAboutsYears
  end

end
