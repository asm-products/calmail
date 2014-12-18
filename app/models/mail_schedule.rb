class MailSchedule < ActiveRecord::Base
  before_save :generate_utc_time

  validate :must_be_valid_preferred_hour, :must_be_valid_preferred_min, :must_be_valid_time_zone

  belongs_to :user

  private

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
