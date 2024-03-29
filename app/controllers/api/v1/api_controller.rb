class Api::V1::ApiController < ActionController::API
  before_action :authorized?
  attr_reader :current_user

  def authorized?
    begin
      if params[:token]
        decoded_token = JWT.decode params[:token], Rails.application.credentials.jwt_token, true, { algorithm: 'HS256' }
        decoded_token = decoded_token[0]
        user = User.find_by(email: decoded_token["email"], password: decoded_token["password"])
        @current_user = user
        unless @current_user
          render json: { error: 'wrong email or password' }, status: 401
        end
      end
    rescue JWT::DecodeError
      render json: { error: 'anauthorized request' }, status: 401
    end
  end

  def render_errors(object, status = :bad_request)
    render json: { errors: object.errors }, status: status
  end

end
