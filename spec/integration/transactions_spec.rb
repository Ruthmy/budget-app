# spec/requests/transactions_spec.rb

require 'rails_helper'

RSpec.describe 'Transactions', type: :request do
  before do
    @user = User.create(name: 'Ruth Abreu', email: 'testing@example.com', password: 'password123',
                        confirmed_at: Time.now)
    @category = Category.create(name: 'Food', icon: 'food_icon', author_id: @user.id)
    sign_in @user
  end

  describe 'GET /categories/:category_id/transactions' do
    it 'displays a list of transactions for a category' do
      transaction1 = Transaction.create(name: 'Transaction 1', amount: 10.00, author_id: @user.id)
      CategoryTransaction.create(category_id: @category.id, transaction_id: transaction1.id)

      get category_transactions_path(@category)

      expect(response.body).to include('Transaction 1')
    end
  end

  describe 'GET /categories/:category_id/transactions/new' do
    it 'displays the new transaction form' do
      get new_category_transaction_path(@category)

      expect(response.body).to include('Add a new transaction')
    end
  end

  describe 'POST /categories/:category_id/transactions' do
    context 'with valid parameters' do
      it 'creates a new transaction and redirects to the transactions list' do
        transaction_params = {
          name: 'New Transaction',
          amount: 15.00,
          related_categories: [@category.id]
        }

        post category_transactions_path(@category), params: { transaction: transaction_params }
        get category_transactions_path(@category)

        expect(response.body).to include('New Transaction')
      end
    end
  end

  context 'with invalid parameters' do
    it 'does not create a new transaction and displays an error message' do
      transaction_params = {
        name: '',
        amount: 15.00,
        related_categories: []
      }

      post category_transactions_path(@category), params: { transaction: transaction_params }

      expect(response).to render_template(:new)
    end
  end
end
