class UsersController < ApplicationController
  # Authentication
  # Force the user to authenticate
  protect_from_forgery prepend: true
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.includes({ posts: { comments: :author } }).find(params[:id])
    @posts = @user.posts
  end
end
