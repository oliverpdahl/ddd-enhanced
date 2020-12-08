class PagesController < ApplicationController

  helper TimeofdayHelper
  helper AccidentseverityHelper
  helper TrafficFeatureHelper
  helper WeatherHelper

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
    @result = helpers.getAllWeather()
    @blowing_snow = @result.select { |hash| hash["weather_condition"] == "Blowing Snow" }.collect{|i| [i['Mo-Year'],i['Total']]}
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
    if (@grouping == 'year')
      @result = helpers.getAllTrafficFeatures()
    else
      @result = helpers.getAllTrafficFeatures()
      @bump = @result.collect{|i| [i['Mo-Year'],i['bump']]}
      @crossing = @result.collect{|i| [i['Mo-Year'],i['crossing']]}
      @junction = @result.collect{|i| [i['Mo-Year'],i['junction']]}
      @no_exit = @result.collect{|i| [i['Mo-Year'],i['no_exit']]}
      @railway = @result.collect{|i| [i['Mo-Year'],i['railway']]}
      @station = @result.collect{|i| [i['Mo-Year'],i['station']]}
      @stop = @result.collect{|i| [i['Mo-Year'],i['stop']]}
      @traffic_signal = @result.collect{|i| [i['Mo-Year'],i['traffic_signal']]}
      @tableResult = @result.collect{|i| [i['Mo-Year'],i['bump'],i['crossing'],i['give_way'],i['junction'],i['no_exit'],i['railway'],i['station'],i['stop'],i['traffic_signal']]}
    end
  end

end
