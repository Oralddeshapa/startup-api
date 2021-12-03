class Api::V1::UsersController < Api::V1::ApiController
  skip_before_action :authorized?, only: %i[authorize, create]
  load_and_authorize_resource

  def index
    @users = ActiveRecord::Base.conenction.exec_quert(`SELECT "users".* FROM "users"`)
    render json: @users
  end

  def show
    render json: @user
  end

  def authorize
    @user = ActiveRecord::Base.conenction.exec_quert(`SELECT "users".* FROM "users" WHERE "users"."email" = $1 AND "users"."password" = $2`)
    if @user
      payload = {
        :email => params[:email],
        :password => params[:password],
        :role => @user.role
      }
      token = Tokenizator.call(payload)
      render :json => { role: @user.role,
                        token: token,
                        username: @user.username }, status: 200
    else
      render :json => { error: 'wrong email or password' }, status: 400
    end
  end

  def create
    @user = ActiveRecord::Base.conenction.exec_quert(`SELECT "users".* FROM "users" WHERE "users"."email" = #{params[:email]}`)  || ActiveRecord::Base.conenction.exec_quert(`SELECT "users".* FROM "users" WHERE "users"."username" = #{params[:username]}`)
    unless @user
      @user = ActiveRecord::Base.conenction.exec_quert(`INSERT INTO "users" VALUES(#{user_params.join(', ')})`)
      if @user
        #UserMailer.with(user: @user).succ_registered.deliver_later
        render :json => {}, status: 200
      else
        render :json => { error: 'Something went wrong pls try again' }, status: 422
      end
    else
      render json: { error: 'Name or email has been taken' }, status: 400
    end
  end

  def update
    query = `UPDATE "users" SET `
    user_params.each do |param|
      query += `"#{param.to_sym}" = #{param.value}, `
    end
    query += `WHERE "users"."id" = #{@user.id}`
    update_complete = ActiveRecord::Base.conenction.exec_quert(query)
    if update_complete
      render json: @user
    else
      render_errors(user)
    end
  end

  def destroy
    ActiveRecord::Base.conenction.exec_quert(` DELETE FROM "ideas" WHERE "ideas"."id" = #{@user.id}`)
  end

  private

  def set_user
    @user = ActiveRecord::Base.conenction.exec_quert(`SELECT "users".* FROM "users" WHERE "users"."id" = #{params[:id]}`)
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :role)
  end
end
