require 'rails_helper'

describe User do
    it "should save if all fields are valid" do
      Fabricate(:user)
      expect(User.count).to eq(1)
    end
    it "should not save if prefered hour is not valid" do
      User.create(Fabricate.attributes_for(:user, preferred_hour: 26))
      expect(User.count).to eq(0)
    end
  it "should not save if preferred minute is not valid" do
    User.create(Fabricate.attributes_for(:user, preferred_min: 12))
    expect(User.count).to eq(0)
  end
  it "should not save if time zone is not valid" do
    User.create(Fabricate.attributes_for(:user, timezone: "Invalid zone"))
    expect(User.count).to eq(0)
  end
  it "should set the correct utc time" do
    User.create(Fabricate.attributes_for(:user, preferred_hour: 22, preferred_min: 15, timezone: "Etc/GMT-3"))
    expect(User.first.utc_time).to eq "01:15"
  end
end