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
end
