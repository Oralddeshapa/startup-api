class Api::V1::UsersController < Api::V1::ApiController
  before_action :set_user, only: %i[show update destroy]
  before_action :is_authorized?, only: %i[index]
  skip_before_action :is_authorized?, only: %i[authorize]

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
        "email" => params[:email],
        "password" => params[:password]
      }
      token = JWT.encode payload, secret, 'HS256'
      correct = true
    else
      token = nil
      correct = false
    end

    render :json => { correct: correct,
                      token:   token }
  end

  def create
    @user = User.find_by(email: params[:email]) || User.find_by(username: params[:username])
    unless @user
      @user = User.new(user_params)

      if @user.save
        #UserMailer.with(user: @user).succ_registered.deliver_later
        render :json => { msg: "Account was successfuly create" }
      else
        render :json => { msg: "Error happened duing account creating try again later" }
      end

    else
      render :json => { msg: "Name or email has already been taken",
                        error_code: "400"}
    end
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
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
    params.require(:user).permit(:username, :email, :password)
  end
end
