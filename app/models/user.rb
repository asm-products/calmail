class User < ActiveRecord::Base
  devise :omniauthable, :omniauth_providers => [:google_oauth2]
  before_save :generate_utc_time
  validate :must_be_valid_preferred_hour, :must_be_valid_preferred_min, :must_be_valid_time_zone
  def self.find_for_google_oauth2(omniauth, signed_in_resource=nil)
    data = omniauth.info
    user = User.where(:email => data['email']).first

    unless user
      user = User.create!(
        token: omniauth['credentials']['token'],
        name: data['name'],
        first_name: data['first_name'],
        email: data['email']
      )
    end

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

  def generate_utc_time
    hour = sprintf '%02d', utc_hour
    minute = sprintf '%02d',preferred_min
    self.utc_time = "#{hour}:#{minute}"
  end

  def utc_hour
    hour = preferred_hour + tz_offset
    if hour > 23
      hour = hour - 24
    end
    hour
  end

  def tz_offset
    tzinfo.current_period.offset.utc_total_offset  / 3600
  end

  def tzinfo
    begin
      TZInfo::Timezone.get(timezone)
    rescue
      false
    end
  end

  def must_be_valid_preferred_hour
    unless (0..23).include?(preferred_hour)
      errors.add(:preferred_hour, "Hour must be between 0 and 23")
    end
  end

  def must_be_valid_preferred_min
    unless [0,15,30,45].include?(preferred_min)
      errors.add(:preferred_min, "Minutes can only be multiples of 15 between 0 and 45")
    end
  end

  def must_be_valid_time_zone
    unless TZInfo::Timezone.all.include?(tzinfo)
      errors.add(:timezone, "Timezone is not valid")
    end
  end
end
