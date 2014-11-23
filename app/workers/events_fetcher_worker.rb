class EventsFetcherWorker
  include Sidekiq::Worker

  def perform_async(token)
    EventsFetcher.fetch(token)
  end
end
