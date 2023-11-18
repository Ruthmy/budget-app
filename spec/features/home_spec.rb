require 'rails_helper'

RSpec.feature 'Home', type: :feature do
  scenario 'user can add a new category' do
    user = User.create(name: 'Ruth Abreu', email: 'testing@example.com', password: 'password123',
                       confirmed_at: Time.now)
    sign_in user

    visit root_path

    expect(page).to have_link('Add a new category')
    click_link('Add a new category')

    fill_in 'category[name]', with: 'New Category Name'
    select 'favorite', from: 'category[icon]'

    click_button 'Save'

    expect(page).to have_current_path(root_path)
    expect(page).to have_content('New Category Name')
    expect(page).to have_css('.category_icon', text: 'favorite')
  end
end
