module Api::V0
  class PostsController < Api::V0::MainController
    skip_before_action :authenticate, only: :index

    def index
      @user = User.includes({ posts: :author }, { posts: { comments: :author } }).find(params[:user_id])
      @posts = @user.posts
      render json: @posts
    end
  end
end
