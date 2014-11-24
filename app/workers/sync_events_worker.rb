class SyncEventsWorker
  include Sidekiq::Worker

  def perform(refresh_token, user_id)
    events = EventsFetcher.new(refresh_token).tomorrow_events
    EventsCreator.new(events, user_id).find_or_create_events_for_user
  end
end
