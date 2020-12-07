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

    @inputs = params[:p]
    @low = 0
    @high = 100
    @min = 0
    @min = 0

    if (@inputs.present?)
      if(@inputs.values.present?)
        if(@inputs.values[0].present?)
          @low = @inputs.values[0]
        end
        if(@inputs.values[1].present?)
          @high = @inputs.values[1]
        end
          result = helpers.getAccidentSeverityLowTemp(@low, @high)
      else
        result = helpers.getAccidentSeverity()
      end
    else
      result = helpers.getAccidentSeverity()
    end

    @acc_severity = result.collect{|i| [i['Mo-Year'],i['Average Severity']]}

    if !@acc_severity.blank?
      @min = @acc_severity[0][1]
      @max = @acc_severity[0][1]
      for i in 0..(@acc_severity.length()-1)
        if @acc_severity[i][1] < @min 
          @min = @acc_severity[i][1]
        elsif @acc_severity[i][1] > @max 
          @max = @acc_severity[i][1]
        end
      end
    end
  end

  def lightsVsRoundAboutsYears
  end

end
