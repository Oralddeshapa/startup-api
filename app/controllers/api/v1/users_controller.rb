class Api::V1::UsersController < Api::V1::ApiController
  skip_before_action :authorized?, only: %i[authorize, create]
  load_and_authorize_resource

  def index
    @users = User.all
    render json: @users
  end

  def show
    render json: @user
  end

  def authorize
    @user = User.find_by(email: params[:email], password: params[:password])
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
    @user = User.find_by(email: params[:email]) || User.find_by(username: params[:username])
    unless @user
      @user = User.new(user_params)
      if @user.save
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
    if @user.update(user_params)
      render json: @user
    else
      render_errors(user)
    end
  end

  def destroy
    @user.destroy
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :role)
  end
end
