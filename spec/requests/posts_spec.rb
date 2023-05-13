require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let!(:user) { User.create(name: 'Kender', posts_counter: 0) }

  describe 'GET /' do
    it 'response 200' do
      get user_posts_path(user)

      expect(response).to have_http_status(200)
    end

    it 'index template was rendered' do
      get user_posts_path(user)

      expect(response).to render_template(:index)
    end

    it "response body includes the text 'index'" do
      get user_posts_path(user.id)
      expect(response.body).to include('index')
    end
  end

  describe 'GET /show' do
    let!(:post) { Post.create(author: user, title: 'Ruby title', comments_counter: 0, likes_counter: 0) }

    it 'response 200' do
      get user_post_path(user, post)

      expect(response.status).to eq(200)
    end

    it 'render template ' do
      get user_post_path(user, post)

      expect(response).to render_template(:show)
    end

    it "response body includes the text 'show post'" do
      get user_posts_path(user.id, post)
      expect(response.body).to include('index')
    end
  end
end
