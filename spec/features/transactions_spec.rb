require 'rails_helper'

RSpec.feature 'Transaction', type: :feature do
  include ActionView::Helpers::NumberHelper

  scenario 'user can add a new transaction' do
    user = User.create(name: 'Ruth Abreu', email: 'testing@example.com', password: 'password123',
                       confirmed_at: Time.now)
    category = Category.create(name: 'Food', icon: 'food_icon', author_id: user.id)
    sign_in user

    visit category_transactions_path(category)

    expect(page).to have_link('Add a new transaction')
    click_link('Add a new transaction')

    fill_in 'transaction[name]', with: 'New Transaction Name'
    fill_in 'transaction[amount]', with: 20
    check 'transaction[related_categories][]'

    click_button 'Save'

    expect(page).to have_current_path(category_transactions_path(category))
    expect(page).to have_content('New Transaction Name')
    expect(page).to have_content(number_to_currency(20, unit: '$', precision: 2))
  end
end
