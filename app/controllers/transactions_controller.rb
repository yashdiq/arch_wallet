class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :update, :destroy]
  before_action :set_user, only: [:index, :create, :show]

  def index
    @transactions = @user.transactions
    if @transactions
      render json: @transactions
    else
      render json: { error: 'Transactions not found' }, status: :not_found
    end
  end

  def show
    @transaction = @user.transactions.find_by(id: params[:id])
    if @transaction
      render json: @transaction
    else
      render json: { error: 'Transaction not found or does not belong to the user' }, status: :not_found
    end
  end

  def create
    @transaction = @user.transactions.new(transaction_params)
    if @transaction.save
      render json: @transaction, status: :created
    else
      render json: @transaction.errors, status: :unprocessable_entity
    end
  end

  def update
    if @transaction.update(transaction_params)
      render json: @transaction
    else
      render json: @transaction.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @transaction.destroy
    head :no_content
  end

  private

  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def transaction_params
    params.require(:transaction).permit(:title, :description, :price, :user_id)
  end
end
