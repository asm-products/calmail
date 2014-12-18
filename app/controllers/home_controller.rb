class HomeController < ApplicationController
  def index
    binding.pry

    if session['devise.google_data']
      token = session['devise.google_data']['credentials']['token']
      @events = GoogleApi.new.fetch_events(token)
    end
  end
end
