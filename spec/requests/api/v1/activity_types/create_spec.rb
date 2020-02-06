RSpec.describe 'POST /api/v1/activity_type', type: :request do
  let(:trip) { create(:trip) }

  describe 'Successfully creates activity type' do
    before do
      get_google_places_success
      
      post "/api/v1/activity_types",
          params: { activity_type: "museum",
                    number: 3,
                    trip: trip.id
                   }

    end

    it 'returns a 200 response status' do
      expect(response).to have_http_status 200
    end
  end

  describe 'Unsuccesfully when no type' do
    before do
      post "/api/v1/activity_types"
    end

    it 'returns a 422 response status' do
      expect(response).to have_http_status 422
    end

    it 'returns error message' do
      expect(response_json["error"]).to eq ["It must have a type"]
    end
  end

  describe 'Unsuccesfully when Activity did not persist' do
    before do
      post "/api/v1/activity_types",
          params: { type: "museum",
                    trip: trip
                   }
    end

    it 'returns a 422 response status' do
      expect(response).to have_http_status 422
    end

    it 'returns error message' do
      expect(response_json["error"]).to eq ["Failed to create activity."]
    end
  end
end