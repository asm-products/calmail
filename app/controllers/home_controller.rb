class HomeController < ApplicationController
  def index
    binding.pry
    if session['devise.google_data']
      puts session['devise.google_data']['credentials']
      token = session['devise.google_data']['credentials']['token']
      @events = GoogleApi.new.fetch_events(token)
    end
  end
end
