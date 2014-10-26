class User < ActiveRecord::Base
  devise :omniauthable, :omniauth_providers => [:google_oauth2]
  validate :must_be_valid_preferred_time
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

  def must_be_valid_preferred_time
    unless self.prefered_time.min % 15 == 0
      errors.add(:type, "Prefered time must by an increment of 15 minutes")
    end
  end

  def self.send_daily_emails
    # TODO: Filter to select specific users
    # TODO: Add model to schedule/track emails
    #User.all.each { |user| user.send_daily_email }
    User.where(preferred_time: Time.now).each { |user| user.send_daily_email }
  end

  def send_daily_email
    UserMailer.daily_digest_email(self).deliver
  end
end
