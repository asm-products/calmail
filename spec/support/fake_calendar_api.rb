require_relative 'fake_api'

class FakeCalendarApi < FakeApi
  get '/calendar/v3/calendars/primary/events' do
    json_response 200, 'events.json'
  end
end
