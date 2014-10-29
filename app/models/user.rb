class User < ActiveRecord::Base
  devise :omniauthable, :omniauth_providers => [:google_oauth2]
  def self.find_for_google_oauth2(omniauth, signed_in_resource=nil)
    data = omniauth.info
    user = User.where(:email => data['email']).first

    unless user
      user = User.create(
        token: omniauth['credentials']['token'],
        name: data['name'],
        first_name: data['first_name'],
        email: data['email']
      )
    end

    user
  end

  def self.send_daily_emails!
    # TODO: Filter to select specific users
    User.all.each { |user| user.send_daily_email! }
  end

  def fetch_calendar_events
    return {}
  end

  def send_daily_email!
    calendar_events = fetch_calendar_events
    email = Email.create!(
      user: self,
      data: calendar_events
    )
    UserMailer.daily_digest_email(self, calendar_events).deliver!
    email.update_attributes!(delivered: true)
  end
end
