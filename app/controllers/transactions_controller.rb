class TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category

  def index
    @transactions = @category.related_transactions.order(created_at: :desc)
  end

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = @category.related_transactions.build(transaction_params)
    @transaction.author = current_user

    categories_ids = params[:transaction][:related_categories].reject(&:empty?)

    if categories_ids.present?
      if @transaction.save
        categories_ids.each do |category_id|
          CategoryTransaction.create(category_id:, transaction_id: @transaction.id)
        end
        redirect_to category_transactions_path(@category)
      else
        flash[:alert] = 'Transaction could not be saved.'
        render :new
      end
    else
      flash[:alert] = 'Please select at least one category.'
      render :new
    end
  end

  private

  def set_category
    @category = Category.find(params[:category_id])
  end

  def transaction_params
    params.require(:transaction).permit(:amount, :name)
  end
end
