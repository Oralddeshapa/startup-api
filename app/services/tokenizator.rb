class Tokenizator
  def self.call(payload)
    new(payload).call
  end

  def initialize(payload)
    @payload = payload
  end

  def call
    secret = Rails.application.credentials.jwt_token
    token = JWT.encode @payload, secret, 'HS256'
  end
end
