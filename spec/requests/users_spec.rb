require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let!(:user) { create(:user, public: true) }

  describe 'GET /members.json' do
    let(:expected_body) do
      [
        {
          id: user.id,
          joined: user.joined,
          public: user.public,
          name: user.handle
        }
      ]
    end

    before { get users_path, as: :json }

    it 'responds with valid json' do
      expect(response).to have_http_status(200)
      expect(response.body).to be_json_as(expected_body)
    end
  end

  describe 'GET /members/:id.json' do
    let(:live) { create(:live) }
    let(:song) { create(:song, live: live) }
    let!(:playing) { create(:playing, user: user, song: song, inst: 'Gt') }
    let(:expected_body) do
      {
        id: user.id,
        joined: user.joined,
        public: user.public,
        url: user.url,
        intro: user.intro,
        name: user.handle,
        insts: [
          {
            inst: playing.inst,
            count: 1
          }
        ],
        songs: [
          {
            id: song.id,
            name: song.name,
            artist: song.artist,
            order: song.order,
            time: song.time_str,
            youtube_id: '',
            live: {
              id: live.id,
              name: live.name,
              date: live.date.to_s,
              place: live.place
            }
          }
        ]
      }
    end

    before { get user_path(user), as: :json }

    it 'responds with valid json' do
      expect(response).to have_http_status(200)
      expect(response.body).to be_json_as(expected_body)
    end
  end
end
