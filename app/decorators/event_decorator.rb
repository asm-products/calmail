class EventDecorator < Draper::Decorator
  delegate_all

  def attendees_names
    return 'No attendees' if attendees.blank?
    object.attendees.map do |attendee|
      attendee['displayName']
    end.compact.join(', ')
  end

  def held_between_hours
    start_formatted = event.starts_at.strftime("%H:%M")
    end_formatted = event.ends_at.strftime("%H:%M")
    "#{start_formatted} - #{end_formatted}"
  end
end
