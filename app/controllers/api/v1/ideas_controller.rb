class Api::V1::IdeasController < Api::V1::ApiController
  before_action :set_idea, only: %i[show update destroy]
  before_action :is_authorized?

  def index
    @ideas = Idea.all
    render json: @ideas
  end

  def show
    render json: @idea
  end

  def create
    @idea = Idea.new(idea_params)

    if @idea.save
      render json: @idea, status: :created
    else
      render json: @idea.errors, status: :unprocessable_entity
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
    params.require(:idea).permit(:title, :problem)
  end
end
