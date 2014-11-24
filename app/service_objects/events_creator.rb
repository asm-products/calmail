class EventsCreator

  def initialize(events, user_id)
    self.events = events
    self.user_id = user_id
  end

  def find_or_create_events_for_user
    calendar_events.each do |calendar_event|
      Event.find_or_create_by(google_event_id: calendar_event.id) do |event|
        event.starts_at = calendar_event.start_time.to_datetime
        event.ends_at = calendar_event.end_time.to_datetime
        event.title = calendar_event.title
        event.summary = calendar_event.description
        event.location = calendar_event.location
        event.raw = calendar_event.raw
        event.html_link = calendar_event.html_link
      end.tap do |event|
        user.events << event
      end
    end
  end

  private

  attr_accessor :events, :user_id

  def user
    @user ||= User.find(user_id)
  end
end
