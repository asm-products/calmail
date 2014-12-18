require 'rails_helper'

describe User do
  it "should save if all fields are valid" do
    Fabricate(:user)
    expect(User.count).to eq(1)
  end
end
