module ApplicationHelper
  def relative_time(time)
    "#{distance_of_time_in_words_to_now time} ago"
  end
end
