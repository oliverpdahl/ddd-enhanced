Rails.application.routes.draw do
  get 'pages/zipCodeAccidentGrowth'
  post 'pages/zipCodeAccidentGrowth'
  get 'pages/accidentTimeOfDayTrends'
  post 'pages/accidentTimeOfDayTrends'
  get 'pages/zipBarChartRace'
  post 'pages/zipBarChartRace'
  get 'pages/outsideTempSeverityTrend'
  post 'pages/outsideTempSeverityTrend'
  get 'pages/lightsVsRoundAboutsYears'
  root 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
