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

  def self.send_daily_emails
    # TODO: Filter to select specific users
    # TODO: Add model to schedule/track emails
    User.all.each { |user| user.send_daily_email }
  end

  def send_daily_email
    UserMailer.daily_digest_email(self).deliver
  end
end
