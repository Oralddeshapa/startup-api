class Api::V1::UsersController < Api::V1::ApiController
  before_action :set_user, only: %i[show update destroy]
  skip_before_action :authorized?, only: %i[authorize]

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
      secret = Rails.application.credentials.jwt_token
      payload = {
        :email => params[:email],
        :password => params[:password],
        :role => @user.role
      }
      token = JWT.encode payload, secret, 'HS256'
      render :json => { token: token }, status: 200
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
        render :json => { error: 'something went wrong pls try again' }, status: 422
      end

    else
      render json: { error: 'name or email has been taken' }, status: 400
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
