require 'rails_helper'

describe EventsCreator do

  let!(:calendar_events) { EventsFetcher.new('refresh_token').tomorrow_events }
  let!(:user) { Fabricate(:user) }

  context 'creates events' do
    before do
      EventsCreator.new(calendar_events, user.id).find_or_create_events_for_user
    end

    it 'creates events from calendar events' do
      expect(Event.count).to eq(4)
    end
  end
end
