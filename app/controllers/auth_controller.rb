class AuthController < ApplicationController
  
  def create
    @user = User.find_by(username: params[:username])
    logger.debug("User: #{params[:username]} #{@user}")
    if @user.present? && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      render json: { user: @user, session: session, message: 'Logged in!'}, status: 200
    else
      render json: { error: 'Username or password is invalid!', message: @user }, status: :bad_request
    end
  end
end
