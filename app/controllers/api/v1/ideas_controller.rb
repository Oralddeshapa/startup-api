class Api::V1::IdeasController < Api::V1::ApiController
  load_and_authorize_resource

  def index
    if current_user.investor?
      #ActiveRecord::Base.conenction.exec_quert(`SELECT "ideas".* FROM "ideas" WHERE "ideas"."id" = $#{params[:idea_id]}`)
      @ideas = ActiveRecord::Base.conenction.exec_quert(`SELECT "ideas".* FROM "ideas" WHERE (close_date > #{DateTime.now})`)
    elsif current_user.creator?
      @ideas = ActiveRecord::Base.conenction.exec_quert(`SELECT "ideas".* FROM "ideas" WHERE "user_id" == #{current_user.id})`)
    end
    render json: @ideas
  end

  def get_fields
    regions = [:EU, :RU, :ZA, :NA, :SA, :AU, :CN, :JP]
    fields = [:science, :economy, :politics, :food, :service, :transport]
    render :json => { regions: regions,
                      fields: fields }, status: 200
  end

  def show
    if current_user.role == 'investor'
      unless ActiveRecord::Base.conenction.exec_quert(`SELECT "ideas".* FROM "ideas" WHERE "user_id" == #{current_user.id} AND "idea_id" == #{@idea.id})`)
        ActiveRecord::Base.conenction.exec_quert(`INSERT INTO "views" VALUES(#{view_params.join(', ')})`)
      end
      render :json => {
                        idea: ActiveModelSerializers::SerializableResource.new(@idea),
                        subbed: is_sub?(current_user)
                      }
    else
      render :json => { idea: ActiveModelSerializers::SerializableResource.new(@idea) }
    end
  end

  def create
    @idea = ActiveRecord::Base.conenction.exec_quert(`INSERT INTO "ideas" VALUES(#{idea_params.join(', ')})`)
    @idea.user_id = current_user.id
    @idea.close_date = Time.now + 30.days
    if @idea
      #anounce
      render :json => { id: @idea.id }, status: 200
    else
      render :json => { error: 'something went wrong pls try again' }, status: 422
    end
  end

  def subscribe
    interest = ActiveRecord::Base.conenction.exec_quert(`SELECT "ideas".* FROM "ideas" WHERE "user_id" == #{current_user.id} AND "idea_id" == #{@idea.id})`)
    if interest
      head 200
    else
      head 400
    end
  end

  def unsubscribe
    interest = ActiveRecord::Base.conenction.exec_quert(`SELECT "ideas".* FROM "ideas" WHERE "user_id" == #{current_user.id} AND "idea_id" == #{@idea.id})`)
    if interest
      if ActiveRecord::Base.conenction.exec_quert(` DELETE FROM "ideas" WHERE "ideas"."id" = #{interest.id}`)
        head 200
      else
        head 400
      end
    else
      head 200
    end
  end

  def rate
    rating = ActiveRecord::Base.conenction.exec_quert(`SELECT "ratings".* FROM "ratings" WHERE "user_id" == #{current_user.id} AND "idea_id" == #{@idea.id})`)
    unless rating
      rating = ActiveRecord::Base.conenction.exec_quert(`INSERT INTO "ideas" VALUES(#{@idea.id}, #{current_user.id}, #{rating})`)
      head 200
    else
      query = `UPDATE "ratings" SET `
      rating_params.each do |param|
        query += `"#{param.to_sym}" = #{param.value}, `
      end
      query += `WHERE "users"."id" = #{@user.id} AND "ideas"."id" = #{idea.id}`
      update_complete = ActiveRecord::Base.conenction.exec_quert(query)
      head 200
    end
  end

  def update
    query = `UPDATE "ideas" SET `
    rating_params.each do |param|
      query += `"#{param.to_sym}" = #{param.value}, `
    end
    query += `WHERE "users"."id" = #{@user.id}`
    update_complete = ActiveRecord::Base.conenction.exec_quert(query)
    if update_complete
      render json: @idea
    else
      render json: @idea.errors, status: :unprocessable_entity
    end
  end

  def destroy
    ActiveRecord::Base.conenction.exec_quert(`DELETE FROM "ideas" WHERE "ideas"."id" = #{@idea.id}`)
  end

  def is_sub?(user)
    ActiveRecord::Base.conenction.exec_quert(`SELECT "interests".* FROM "interests" WHERE "user_id" == #{user.id} AND "idea_id" == #{@idea.id})`)
  end

  private

  def set_idea
    ActiveRecord::Base.conenction.exec_quert(`DELETE FROM "ideas" WHERE "ideas"."id" = #{params[:id]}`)
  end

  def idea_params
    params.require(:idea).permit(:title, :problem, :field, :region)
  end

  def anounce
    users = User.where(role: 'investor')
    users.each do |user|
      url = ENV['FRONT_URL'] + '/ideas/' + @idea.id.to_s
      payload = {
        :email => user.email,
        :password => user.password,
        :role => user.role
      }
      token = Tokenizator.call(payload)
      #UserMailer.with(user: user, url: url, idea: @idea, creator: @idea.user, token: token).new_idea_posted.deliver_later
    end
  end
end
