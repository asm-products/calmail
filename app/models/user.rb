class User < ActiveRecord::Base
  devise :omniauthable, :omniauth_providers => [:google_oauth2]

  has_many :user_events
  has_many :events, through: :user_events
  has_one :mail_schedule

  def self.create_or_update_for_google_oauth2(omniauth, signed_in_resource=nil)
    data = omniauth.info
    user = User.find_or_initialize_by(email: data['email'])

    user.token = omniauth['credentials']['token']
    user.refresh_token = omniauth['credentials']['refresh_token']
    user.name = data['name']
    user.first_name = data['first_name']
    user.save

    user
  end

  def self.send_daily_emails_by_time(time)
    User.where(utc_time: time).each { |user| user.send_daily_email! }
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
