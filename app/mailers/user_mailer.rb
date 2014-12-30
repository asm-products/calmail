class UserMailer < ActionMailer::Base
  default from: 'from@example.com'
  add_template_helper ApplicationHelper

  def daily_digest_email(user)
    @user = user
    @events = EventDecorator.decorate_collection(user.events)
    mail(
      to: @user.email,
      subject: 'Calmail Daily Summary'
    )
  end
end
