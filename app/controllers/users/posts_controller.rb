class Users::PostsController < ApplicationController
  def index
    @user = User.includes({ posts: :author }, { posts: { comments: :author } }).find(params[:user_id])
    @posts = @user.posts
  end

  def show
    @post = Post.includes({ comments: :author }, :author).find(params[:id])
  end

  def new
    @post = Post.new
    @user = current_user
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user

    if @post.save
      redirect_to user_posts_path(user_id: params[:user_id].to_i)
    else
      render 'new'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
