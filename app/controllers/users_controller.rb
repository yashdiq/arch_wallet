class UsersController < ApplicationController
  include ApiKeyAuthentication

  prepend_before_action :authenticate_with_api_key!, only: [ :index, :show ]

  before_action :set_user, only: [ :show ]

  def index
    @users = User.all
    render json: @users
  end

  def show
    Rails.logger.info "Wallet from #{@user}"
    render json: @user, include: :wallet
  end

  private

  def set_user
    @wallet = Wallet.find_by user_id: params[:id]
    @user = User.find(params[:id])
    @user.wallet = @wallet
  end
end
