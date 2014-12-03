require_relative 'fake_api'

class FakeOauth < FakeApi
  post '/o/oauth2/token' do
    json_response 200, 'auth.json'
  end
end
