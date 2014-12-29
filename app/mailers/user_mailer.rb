class UserMailer < ActionMailer::Base
  default from: 'from@example.com'

  def daily_digest_email(user)
    @user = user
    @events = user.events
    mail(
      to: @user.email,
      subject: 'Calmail Daily Summary'
    )
  end
end
