class Api::V1::ApiController < ActionController::API

  def is_authorized?
    if params[:token]
      decoded_token = JWT.decode params[:token], Rails.application.credentials.jwt_token, true, { algorithm: 'HS256' }
      d_t = decoded_token[0]
      user = User.find_by(email: d_t[:email], password: d_t[:password])
      if user
        @current_user = user
      end
    end
  end
end
