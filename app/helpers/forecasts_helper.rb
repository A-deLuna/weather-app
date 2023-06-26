module ForecastsHelper
  def weekday date
    date.strftime("%A")
  end

  def month_and_day date
    date.strftime("%B %d")
  end

  def weekday_month_and_day date
    date.strftime("%A %B %d")
  end
end
