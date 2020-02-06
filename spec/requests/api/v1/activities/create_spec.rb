# frozen_string_literal: true

RSpec.describe 'POST /api/v1/activities', type: :request do
  let(:trip) { create(:trip) }
  let(:activity_type) { create(:activity_type) }
  let(:activity) do
    3.times do
      create(:activity, activity_type_id: activity_type)
    end
  end

  describe 'Successfully creates activities' do
    before do
      post '/api/v1/activities',
           params: { location: '',
                     type: 'museum',
                     number: 3,
                     activity_type_id: activity_type }
      # google places stub
      let(:activity) do
        (1..number).each do |i|
          create(:activity,
                 name: name[i],
                 address: formatted_address[i],
                 rating: rating[i]
                 lat: lat[i],
                 lng: lng[i],
                 activity_type_id: activity_type)
        end
      end
    end

    it 'returns a 200 response status' do
      expect(response).to have_http_status 200
    end
  end

  describe 'Unsuccesfully when no activities found' do
    before do
      post '/api/v1/activities',
           params: { location: '',
                     type: 'museum',
                     number: 3,
                     activity_type_id: activity_type }
      # google places unsuccessful stub
      let(:activity) do
        (1..number).each do |i|
          create(:activity,
                 name: name[i],
                 address: formatted_address[i],
                 rating: rating[i]
                 lat: lat[i],
                 lng: lng[i],
                 activity_type_id: activity_type)
        end
      end
    end

    it 'returns a 422 response status' do
      expect(response).to have_http_status 422
    end

    it 'returns error message' do
      expect(response_json['error']).to eq ['No activities found']
    end
  end
end
