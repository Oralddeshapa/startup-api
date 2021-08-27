class Api::V1::IdeasController < Api::V1::ApiController
  load_and_authorize_resource

  def index
    if @current_user.investor?
      @ideas = Idea.all
    elsif @current_user.creator?
      @ideas = Idea.where(user_id: @current_user.id)
    end
    render json: @ideas
  end

  def get_fields
    regions = Idea.regions.keys
    fields = Idea.fields.keys
    render :json => { regions: regions,
                      fields: fields }, status: 200
  end

  def show
    render json: @idea
  end

  def create
    @idea = Idea.new(idea_params)
    @idea.user_id = current_user.id
    @idea.rating = 0

    if @idea.save
      render :json => { head: :ok }, status: 200
    else
      render :json => { error: 'something went wrong pls try again' }, status: 422
    end
  end

  def update
    if @idea.update(idea_params)
      render json: @idea
    else
      render json: @idea.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @idea.destroy
  end

  private

  def set_idea
    @idea = Idea.find(params[:id])
  end

  def idea_params
    params.require(:idea).permit(:title, :problem, :field, :region)
  end

  def current_user
    @current_user
  end
end
