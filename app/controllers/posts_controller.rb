class PostsController < ApplicationController
   def index
    @user = User.find(params[:user_id])
    @posts = @user.all_posts
  end

   def show
    @post = Post.includes(:comments).find(params[:id])
  end
end
