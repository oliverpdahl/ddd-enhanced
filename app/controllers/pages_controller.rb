class PagesController < ApplicationController

  helper TimeofdayHelper
  helper AccidentseverityHelper
  helper TrafficFeatureHelper

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

    @inputs = params[:lowIn]
    @lowParams = params[:lowIn]
    @highParams = params[:highIn]
    @min = 0
    @min = 0

    if (@lowParams.present? || @highParams.present?)
        if(!@lowParams.values[0].blank?)
          @low = @lowParams.values[0]
        else
          @low = -100
        end
        if(!@highParams.values[0].blank?)
          @high = @highParams.values[0]
        else
          @high = 100
        end
          result = helpers.getAccidentSeverityLowTemp(@low, @high)
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
    result = helpers.getAllTrafficFeatures()

    if (@grouping == 'year')
      result = helpers.getAllTrafficFeatures()
    else
      result = helpers.getAllTrafficFeatures()
      @bump = result
    end
  end

end
