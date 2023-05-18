class Users::Posts::CommentsController < ApplicationController
  load_and_authorize_resource
  def new
    @comment = Comment.new
    @post = Post.find { |post| post.id == params[:post_id].to_i }
    @user = current_user
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author = current_user
    @comment.post = Post.find { |post| post.id == params[:post_id].to_i }

    if @comment.save
      redirect_to user_post_path(user_id: params[:user_id].to_i, id: params[:post_id].to_i)
    else
      render 'new'
    end
  end

  def destroy
    @comment = Comment.includes({ post: :author }).find(params[:id])
    @post = @comment.post
    @user = @post.author
    @post.comments_counter -= 1
    @user.posts_counter -= 1
    @comment.destroy
    @post.save
    @user.save
    flash[:notice] = "Comment #{@comment.id} was successfully deleted for post : #{@post.title}!"
    redirect_to "/users/#{@post.author.id}/posts/#{@post.id}"
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
