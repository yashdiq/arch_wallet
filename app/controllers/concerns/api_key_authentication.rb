module ApiKeyAuthentication
  extend ActiveSupport::Concern

  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ActionController::HttpAuthentication::Token::ControllerMethods

  attr_reader :current_api_key
  attr_reader :current_bearer

  def authenticate_with_api_key!
    @current_bearer = authenticate_or_request_with_http_token &method(:authenticator)
  end

  def authenticate_with_api_key
    @current_bearer = authenticate_with_http_token &method(:authenticator)
  end

  private

  attr_writer :current_api_key
  attr_writer :current_bearer

  def authenticator(http_token, options)
    @current_api_key = ApiKey.find_by token: http_token

    current_api_key&.bearer
  end
end
