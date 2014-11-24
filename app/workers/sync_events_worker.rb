class SyncEventsWorker
  include Sidekiq::Worker

  def perform(refresh_token, user_id)
    events = EventsFetcher.fetch(refresh_token)
    EventsCreator.find_or_create_events_for_user(events)
  end
end
