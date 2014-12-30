module ApplicationHelper
  def today_formatted
    Time.now.strftime("%B %e, %Y")
  end
end
