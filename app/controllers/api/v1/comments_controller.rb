class Api::V1::CommentsController < Api::V1::ApiController
  load_and_authorize_resource
  before_action :attach_idea

  def index
    @comments = ActiveRecord::Base.conenction.exec_quert(`SELECT "comments".* FROM "comments" WHERE "idea_id" == #{@idea.id})`)
    render json: @comments
  end

  def create
    @comment = ActiveRecord::Base.conenction.exec_quert(`INSERT INTO "comments" VALUES(#{comment_params.join(', ')})`)
    if comment
      render :json => {comments: ActiveRecord::Base.conenction.exec_quert(`SELECT "comments".* FROM "comments" WHERE "idea_id" == #{@idea.id})`)}, status: 200
    else
      render :json => { error: 'something went wrong pls try again' }, status: 422
    end
  end

  def destroy
    ActiveRecord::Base.conenction.exec_quert(` DELETE FROM "comments" WHERE "comments"."id" = #{@comment.id}`)
  end

  private

  def attach_idea
    @idea = ActiveRecord::Base.conenction.exec_quert(`SELECT "ideas".* FROM "ideas" WHERE "ideas"."id" = $#{params[:idea_id]}`)
  end

  def comment_params
    params.require(:comment).permit(:text, :idea_id)
  end
end
