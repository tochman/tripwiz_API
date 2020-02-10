# frozen_string_literal: true

module WebmockStubs
  def get_geobytes_success
    stub_request(:get, "http://gd.geobytes.com/GetNearbyCities?Latitude=59.3293&Longitude=18.0685&limit=1&radius='1500'")
      .to_return(status: 200, body: '[["291.42","Stockholm"]]', headers: {})
  end

  def get_geobytes_no_lat_lng
    stub_request(:get, "http://gd.geobytes.com/GetNearbyCities?Latitude=&Longitude=&limit=1&radius='1500'")
      .to_return(status: 200, body: '[["291.42","Stockholm"]]', headers: {})
  end

  def get_geobytes_no_city_nearby
    stub_request(:get, "http://gd.geobytes.com/GetNearbyCities?Latitude=9.3293&Longitude=18.0685&limit=1&radius='1500'")
      .to_return(status: 200, body: '[[]]', headers: {})
  end

  def get_google_places_success
    stub_request(:get, %r{https://maps.googleapis.com/maps/api/place/nearbysearch/})
      .to_return(status: 200, body: fixture_response('get_places_museums.json'))
    end

  def make_amadeus_call
    stub_request(:post, 'https://api.amadeus.com/v1/security/oauth2/token')
      .with(
        body: { 'client_id' => 'EpJ7FkeUMBWnEEta8AO4Ah9GA5cRIwFG', 'client_secret' => 'lvI7Cd2AjV0kkav1', 'grant_type' => 'client_credentials' },
        headers: {
          'Accept' => 'application/json, application/vnd.amadeus+json',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Content-Type' => 'application/x-www-form-urlencoded',
          'Host' => 'api.amadeus.com',
          'User-Agent' => 'amadeus-ruby/3.3.0 ruby/2.5.1'
        }
      )
      .to_return(status: 200, body: fixture_response('suggested_hotels.json'), headers: {})
  end

  private

  def fixture_response(filename)
    File.open(File.join(Rails.root, 'spec', 'support', 'fixtures', filename))
  end
end
