RSpec.describe 'POST /api/v1/hotels', type: :request do
  let(:trip) { create(:trip) }

  describe 'User can generate hotel suggestions ' do
    describe 'successfully' do 
      before do
        WebMock.disable!
        
        post '/api/v1/hotels',
          params: { 
            lat: 59.3293,
            lng: 18.0685,
            rating: 5,
            trip_id: 1
            }
      end
      
      it 'returns a 200 response status' do
        expect(response).to have_http_status 200
      end
    end

  end
end


