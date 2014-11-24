#encoding: UTF-8

module Google
  class Calendar
    def tomorrow_events
      start_min = encode_time(Time.now.end_of_day)
      start_max = encode_time(Time.now.tomorrow.end_of_day)
      query = "?timeMin=#{start_min}&timeMax=#{start_max}"
      binding.pry
      find_events(query)
    end
  end
end
