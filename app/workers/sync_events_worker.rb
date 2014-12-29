class SyncEventsWorker
  include Sidekiq::Worker

  def perform(user_id)
    user = User.find(user_id)
    events = EventsFetcher.new(user.refresh_token).tomorrow_events
    EventsCreator.new(events, user.id).find_or_create_events_for_user
  end
end
