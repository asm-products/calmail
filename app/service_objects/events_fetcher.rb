class EventsFetcher

  def initialize(refresh_token)
    self.refresh_token = refresh_token
  end

  def tomorrow_events
    calendar.tomorrow_events
  end

  private

  attr_accessor :refresh_token

  def calendar
    @calendar ||= Google::Calendar.new(client_id: ENV['GOOGLE_CLIENT_ID'],
                                     client_secret: ENV['GOOGLE_CLIENT_SECRET'],
                                     calendar: 'primary',
                                     redirect_url: 'urn:ietf:wg:oauth:2.0:oob'
                                    ).tap do |client|
                                      client.login_with_refresh_token(refresh_token)
                                    end
  end
end
