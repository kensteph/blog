require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /' do
    it 'response 200' do
      get users_path
      expect(response).to have_http_status(200)
    end

    it 'index template was rendered' do
      get users_path

      expect(response).to render_template(:index)
    end

    it "response body includes the text 'index'" do
      get users_path
      expect(response.body).to include('index')
    end
  end

  describe 'GET /show' do
    let!(:user) { User.create(name: 'Kender', posts_counter: 0) }

    it 'response 200' do
      get user_path(user.id)

      expect(response.status).to eq(200)
    end

    it 'render show' do
      get user_path(user.id)

      expect(response).to render_template(:show)
    end

    it "response body includes the text 'show user'" do
      get user_path(user.id)
      expect(response.body).to include('show user')
    end
  end
end
