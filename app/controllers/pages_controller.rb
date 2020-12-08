class PagesController < ApplicationController

  helper TimeofdayHelper
  helper AccidentseverityHelper
  helper TrafficFeatureHelper
  helper WeatherHelper
  helper ZipcodeHelper

  def zipCodeAccidentGrowth

    @zip_params = params[:p]
    if (@zip_params.present?)
      if(!@zip_params.values[0].blank?)
        @zipcode = @zip_params.values[0]
      end
    else
      @zipcode = 92521
    end

    result = helpers.getZipcodeAccidentGrowthByQuarterQuery(@zipcode)
    @accidents_per_capita = result.collect{|i| [i['Qt-Year'],i['Accidents Per Capita']]}
    @accidents_per_capita_table = result.collect{|i| [i['Year'],i['Quarter'],i['Accidents Per Capita']]}

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
    @light_snow = @result.select { |hash| hash["weather_condition"] == "Light Snow" }.collect{|i| [i['Mo-Year'],i['Total']]}
    @rain = @result.select { |hash| hash["weather_condition"] == "Rain" }.collect{|i| [i['Mo-Year'],i['Total']]}
    @thunder = @result.select { |hash| hash["weather_condition"] == "Thunder" }.collect{|i| [i['Mo-Year'],i['Total']]}
    @drizzle = @result.select { |hash| hash["weather_condition"] == "Drizzle" }.collect{|i| [i['Mo-Year'],i['Total']]}
    @heavy_snow = @result.select { |hash| hash["weather_condition"] == "Heavy Snow" }.collect{|i| [i['Mo-Year'],i['Total']]}
    @fog = @result.select { |hash| hash["weather_condition"] == "Fog" }.collect{|i| [i['Mo-Year'],i['Total']]}
    @haze = @result.select { |hash| hash["weather_condition"] == "Haze" }.collect{|i| [i['Mo-Year'],i['Total']]}
    @light_rain = @result.select { |hash| hash["weather_condition"] == "Light Rain" }.collect{|i| [i['Mo-Year'],i['Total']]}
    @heavy_rain = @result.select { |hash| hash["weather_condition"] == "Heavy Rain" }.collect{|i| [i['Mo-Year'],i['Total']]}
    @tableResult = @result.collect{|i| [i['Mo-Year'],i['weather_condition'],i['Total']]}
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
