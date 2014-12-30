class UserMailerPreview < ActionMailer::Preview
  def daily_digest_email
    user = User.first
    user.events.presence || SyncEventsWorker.perform_async(user.id)
    UserMailer.daily_digest_email(User.first)
  end
end
