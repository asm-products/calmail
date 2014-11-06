class UserMailer < ActionMailer::Base
  default from: 'from@example.com'

  def daily_digest_email(user, calendar_events)
    @user = user
    @calendar_events = calendar_events
    mail(
      to: @user.email,
      subject: 'Calmail Daily Summary'
    )
  end
end
