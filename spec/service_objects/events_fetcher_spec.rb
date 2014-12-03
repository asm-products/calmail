require 'rails_helper'

describe EventsFetcher do
  let!(:refresh_token) { 'test_refresh_token' }

  before do
    Timecop.freeze(Time.local(2014, 11, 23))
  end

  after do
    Timecop.return
  end

  it 'gets calendar events for tomorrow' do
    fetcher = EventsFetcher.new(refresh_token)
    tomorrow_events = fetcher.tomorrow_events
    expect(tomorrow_events.last.title).to eq 'Tomorrow event'
    expect(tomorrow_events.count).to eq 4
  end
end
