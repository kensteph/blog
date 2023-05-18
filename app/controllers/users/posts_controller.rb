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
    @new_post = Post.new(params.require(:post).permit(:text, :title))
    @new_post.author = current_user
    @new_post.likes_counter = 0
    @new_post.comments_counter = 0
    respond_to do |format|
      if @new_post.save
        format.html { redirect_to "/users/#{current_user.id}/posts", notice: 'Post was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @user = User.find(params[:user_id])
    @post.destroy
    @user.posts_counter -= 1
    @user.save
    flash[:notice] = "Post #{@post.id} was successfully deleted for user : #{@user.name}!"
    redirect_to "/users/#{params[:user_id]}/posts"
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
