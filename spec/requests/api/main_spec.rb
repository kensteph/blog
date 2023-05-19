require 'swagger_helper'

RSpec.describe 'api/main', type: :request do
  path '/api/v0/posts/{post_id}/comments' do

    post 'Creates a comment' do
      tags 'Comment'
      consumes 'application/json'
      parameter name: :post_id, in: :path, type: :string
      parameter name: :text, in: :body, schema: {
        type: :object,
        properties: {
          text: { type: :string }
        },
        required: [ 'text' ]
      }

      response '201', 'Comment created' do
        let(:comment) { { text: 'bar' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:comment) { { text: 'foo' } }
        run_test!
      end
    end
  end

  path '/api/v0/users/{user_id}/posts' do
    get 'Get the posts from a given user' do
      tags 'Posts'
      produces 'application/json'
      parameter name: :user_id, in: :path, type: :string

      response '200', 'Post found' do
        schema type: :array,
          properties: {
            id: { type: :integer },
            title: { type: :string },
            text: { type: :string }
          },
          required: [ 'id', 'title', 'text' ]
        run_test!
      end

      response '404', 'User not found' do
        let(:user_id) { 'invalid' }
        run_test!
      end
    end
  end
end
