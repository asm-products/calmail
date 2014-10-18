class UserMailer < ActionMailer::Base
  default from: 'from@example.com'

  def daily_digest_email(user)
    # TODO: Fetch calendar events
    @user = user
    mail(to: @user.email, subject: 'Calmail Daily Summary')
  end
end
