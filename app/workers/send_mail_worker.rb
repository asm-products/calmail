class SendMailWorker
  include Sidekiq::Worker

  def perform(time)
    puts "Running #{time}"
    User.send_daily_emails_by_time(time)
  end
end