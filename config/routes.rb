Rails.application.routes.draw do
  get 'pages/zipCodeAccidentGrowth'
  get 'pages/accidentTimeOfDayTrends'
  get 'pages/zipBarChartRace'
  get 'pages/outsideTempSeverityTrend'
  get 'pages/lightsVsRoundAboutsYears'
  root 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
