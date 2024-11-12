class AuthController < ApplicationController
  include ApiKeyAuthentication

  def create
    authenticate_with_http_basic do |username, password|
      @user = User.find_by username: username

      if @user.present? && @user&.authenticate(password)
        api_key = @user.api_keys.create! token: SecureRandom.hex
        render json: { api_key: api_key, message: "Logged in!" }, status: :created and return
      end
    end

    render json: { error: "Username or password is invalid!" }, status: :unauthorized
  end
end
