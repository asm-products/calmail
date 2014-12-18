require 'rails_helper'

RSpec.describe MailSchedule, :type => :model do
  describe 'validations' do
    it "does not pass if prefered hour is not valid" do
      mail_schedule = Fabricate.build(:mail_schedule, preferred_hour: 26)
      expect(mail_schedule).to_not be_valid
    end

    it "does not pass if preferred minute is not valid" do
      mail_schedule = Fabricate.build(:mail_schedule, preferred_min: 12)
      expect(mail_schedule).to_not be_valid
    end

    it "does not pass if time zone is not valid" do
      mail_schedule = Fabricate.build(:mail_schedule, timezone: "Invalid zone")
      expect(mail_schedule).to_not be_valid
    end

    it "sets the correct utc time" do
      mail_schedule = Fabricate(:mail_schedule, preferred_hour: 22, preferred_min: 15, timezone: "Etc/GMT-3")
      expect(mail_schedule.utc_time).to eq "01:15"
    end
  end
end
