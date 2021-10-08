class Api::V1::IdeasController < Api::V1::ApiController
  load_and_authorize_resource

  def index
    if current_user.investor?
      @ideas = Idea.where("close_date > ?", DateTime.now)
    elsif current_user.creator?
      @ideas = current_user.ideas
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
    if current_user.role == 'investor'
      unless @idea.views.find_by(user_id: current_user.id)
        @idea.views.create(user_id: current_user.id, idea_id: @idea.id)
      end
      subbed = @idea.interests.find_by(user_id: current_user.id) ? true : false
      render :json => {
                        idea: ActiveModelSerializers::SerializableResource.new(@idea),
                        subbed: subbed
                      }
    else
      render :json => { idea: ActiveModelSerializers::SerializableResource.new(@idea) }
    end
  end

  def create
    @idea = Idea.new(idea_params)
    @idea.user_id = current_user.id
    @idea.close_date = Time.now + 30.days
    if @idea.save
      anounce()
      render :json => { id: @idea.id }, status: 200
    else
      render :json => { error: 'something went wrong pls try again' }, status: 422
    end
  end

  def subscribe
    interest = @idea.interests.find_by(idea_id: @idea.id, user_id: current_user.id)
    unless interest
      interest = @idea.interests.new(idea_id: @idea.id, user_id: current_user.id)
      if interest.save
        render status: 200
      else
        render status: 400
      end
    else
      interest.destroy
      render status: 400
    end
  end

  def unsubscribe
    interest = @idea.interests.find_by(idea_id: @idea.id, user_id: current_user.id)
    if interest
      if interest.destroy
        render status: 200
      else
        render status: 400
      end
    else
      render status: 200
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

  def anounce
    byebug
    users = User.where(role: 'investor')
    users.each { |user|
      url = ENV['FRONT_URL'] + '/ideas/' + @idea.id.to_s
      UserMailer.with(user: user, url: url, idea: @idea, creator: @idea.user).new_idea_posted.deliver_later
    }

  end
end
