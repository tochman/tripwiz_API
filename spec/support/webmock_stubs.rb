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
    stub_request(:get, "https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=#{Rails.application.credentials.google_api_token}&location=59.334,18.063&radius=5000&type=museum")
      .to_return(status: 200, body: fixture_response('get_places_museums.json'))
  end

  private

  def fixture_response(filename)
    File.open(File.join(Rails.root, 'spec', 'support', 'fixtures', filename))
  end
end
