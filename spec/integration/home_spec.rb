require 'rails_helper'

RSpec.describe 'Home', type: :request do
  include ActionView::Helpers::NumberHelper

  describe 'GET /' do
    context 'when the user is signed in' do
      before do
        @user = User.create(name: 'Ruth Abreu', email: 'testing@example.com', password: 'password123',
                            confirmed_at: Time.now)
        sign_in @user
        @category1 = Category.create(name: 'Food', icon: 'food_icon', author_id: @user.id)
        @category2 = Category.create(name: 'Health', icon: 'favorite', author_id: @user.id)
        @categories = [@category1, @category2]
      end

      it 'displays user-specific content' do
        get root_path

        expect(response.body).to include('Total of all transactions')
        @categories.each do |category|
          expect(response.body).to include(category.name)
          expect(response.body).to include(number_to_currency(category.total_amount, unit: '$', precision: 2))
        end
        expect(response.body).to include('Add a new category')
      end
    end
  end
end
