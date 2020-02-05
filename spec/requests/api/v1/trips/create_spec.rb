RSpec.describe 'POST /api/v1/trips', type: :request do

  describe 'Succesfully adds coords for destination' do
    before do
      post "/api/v1/trips",
      params: { destination: "Stockholm",
                coord_lat: "59.3293",
                coord_lng: "18.0685" }
    end

    it 'returns a 200 response status' do
      expect(response).to have_http_status 200
    end
  end

  describe 'Unsuccesfully when missing coords' do
    before do
      post "/api/v1/trips",
      params: { destination: "Stockholm" }
    end

    it 'returns a 200 response status' do
      expect(response).to have_http_status 422
    end

    it 'returns error message' do
      expect(response_json["error"]).to eq ["Coord lat can't be blank", "Coord lng can't be blank"]
    end
  end

  describe 'Unsuccesfully when missing destination' do
    before do
      post "/api/v1/trips",
      params: { coord_lat: "59.3293",
                coord_lng: "18.0685" }
    end

    it 'returns a 200 response status' do
      expect(response).to have_http_status 422
    end

    it 'returns error message' do
      expect(response_json["error"]).to eq ["Name can't be blank"]
    end
  end

end