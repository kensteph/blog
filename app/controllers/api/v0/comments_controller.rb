class Api::V0::CommentsController < Api::V0::MainController
  skip_before_action :authenticate, only: :index

  def index
    @post = Post.includes(:comments).find(params[:post_id])
    render json: @post.comments
  end

  def create
    auth_token = request.headers['Authorization']
    current_user = User.find_by(user_token: auth_token)
    @new_comment = Comment.new(params.require(:comment).permit(:text))
    @new_comment.author = current_user
    @new_comment.post = Post.find(params[:post_id])
    if @new_comment.save
      render json: @new_comment, status: :created
    else
      render json: @new_comment.errors, status: :unprocessable_entity
    end
  end
end
