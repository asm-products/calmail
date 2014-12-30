class EventDecorator < Draper::Decorator
  delegate_all

  def attendees_names
    object.attendees.map do |attendee|
      attendee['display_name']
    end.join(', ')
  end
end
