require 'rails_helper'

RSpec.describe 'Lives', type: :request do
  let!(:live) { create(:live) }

  describe 'GET /lives.json' do
    let(:expected_body) do
      [
        {
          id: live.id,
          name: live.name,
          date: live.date.to_s,
          place: live.place
        }
      ]
    end

    before { get lives_path, as: :json }

    it 'responds with valid json' do
      expect(response).to have_http_status(200)
      expect(response.body).to be_json_as(expected_body)
    end
  end

  describe 'GET /lives/:id.json' do
    let(:song) { create(:song, live: live) }
    let(:user) { create(:user) }
    let!(:playing) { create(:playing, user: user, song: song) }
    let(:expected_body) do
      {
        id: live.id,
        name: live.name,
        date: live.date.to_s,
        place: live.place,
        songs: [
          {
            id: song.id,
            name: song.name,
            artist: song.artist,
            order: song.order,
            time: song.time,
            status: song.status,
            have_video: song.youtube_id.present?
          }
        ]
      }
    end

    before { get live_path(live), as: :json }

    it 'responds with valid json' do
      expect(response).to have_http_status(200)
      expect(response.body).to be_json_as(expected_body)
    end
  end
end
