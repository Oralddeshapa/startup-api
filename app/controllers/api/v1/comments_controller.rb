class Api::V1::CommentsController < Api::V1::ApiController
  load_and_authorize_resource
  before_action :attach_idea

  def index
    @comments = @idea.comments
    render json: @comments
  end

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.idea_id = @idea.id
    if @comment.save
      render :json => {}, status: 200
    else
      render :json => { error: 'something went wrong pls try again' }, status: 422
    end
  end

  def destroy
    @comment.destroy
  end

  private

  def attach_idea
    @idea = Idea.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:text, :id)
  end
end
