require 'google/api_client'

# TODO: Some logic should be on the user
# See http://stackoverflow.com/questions/16453252/rails-omniauth-google-oauth2-google-api-client-moments-insert-401-unautho
class GoogleApi
  def api_client
    api_client ||= begin
      client = Google::APIClient.new(
        :application_name => 'Calmail',
        :application_version => '1.0.0'
      )
      client.authorization.client_id = ENV['GOOGLE_CLIENT_ID']
      client.authorization.client_secret = ENV['GOOGLE_CLIENT_SECRET']
      client.authorization.scope = 'https://www.googleapis.com/auth/calendar'
      client
    end
  end

  def calendar
    calendar ||= api_client.discovered_api('calendar', 'v3')
  end

  # TODO: Clean this up
  def fetch_events(token)
    # page_token = nil
    result = api_client.execute(
      :api_method => calendar.events.list,
      :parameters => {'calendarId' => 'primary'},
      :authorization => authorization(token)
    )
    return result.data.items
    # while true
    #   events = result.data.items
    #   events.each do |e|
    #     if e.summary
    #       print e.summary + "\n"
    #     end
    #   end
    #   if !(page_token = result.data.next_page_token)
    #     break
    #   end
    #   result = api_client.execute(
    #     :api_method => calendar.events.list,
    #     :parameters => {
    #       'calendarId' => 'primary',
    #       'pageToken' => page_token
    #     },
    #     :authorization => authorization(token)
    #   )
    # end
  end

  def authorization(token)
    auth = api_client.authorization.dup
    auth.update_token!(access_token: token)
    auth
  end
end
