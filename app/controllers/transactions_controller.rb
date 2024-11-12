class TransactionsController < ApplicationController
  include ApiKeyAuthentication

  prepend_before_action :authenticate_with_api_key!

  before_action :set_transaction, only: [ :show ]
  before_action :set_user, only: [ :index, :create, :show ]

  def index
    @transactions = @user.transactions
    if @transactions
      render json: @transactions
    else
      render json: { error: "Transactions not found" }, status: :not_found
    end
  end

  def show
    @transaction = @user.transactions.find_by(id: params[:id])
    if @transaction
      render json: @transaction
    else
      render json: { error: "Transaction not found or does not belong to the user" }, status: :not_found
    end
  end

  def create
    @transaction = @user.transactions.new(transaction_params)

    if @transaction.save
      @from_wallet = Wallet.find(transaction_params[:wallet_from_id])
      balance_from = @from_wallet.balance - transaction_params[:amount]
      @from_wallet.update balance: balance_from

      @to_wallet = Wallet.find(transaction_params[:wallet_to_id])
      balance_to = @to_wallet.balance + transaction_params[:amount]
      @to_wallet.update balance: balance_to

      render json: @transaction, status: :created
    else
      render json: @transaction.errors, status: :unprocessable_entity
    end
  end

  private

  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

  def set_user
    @user = User.find(params[:user_id])
    @transactions = Transaction.where(wallet_from_id: @user.wallet.id).all
    @user.transactions = @transactions
  end

  def transaction_params
    params.require(:transaction).permit(:amount, :wallet_from_id, :wallet_to_id, :transaction_type, :transaction_status, :pin)
  end
end
