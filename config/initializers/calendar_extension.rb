module Google
  class Calendar
    def tomorrow_events
      start_min = encode_time(Time.now.end_of_day)
      start_max = encode_time(Time.now.tomorrow.end_of_day)
      options = { 'timeMin' => start_min, 'timeMax'=> start_max }
      event_lookup(build_query(options))
    end

    private

    def build_query(options)
      "?#{options.to_query}"
    end
  end
end
