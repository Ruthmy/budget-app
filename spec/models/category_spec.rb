# spec/models/category_spec.rb

require 'rails_helper'

RSpec.describe Category, type: :model do
  it 'is valid with valid attributes' do
    user = User.create(name: 'Ruth Abreu', email: 'testing@example.com', password: 'password123')
    category = Category.new(name: 'Food', icon: 'icon.png', author: user)
    expect(category).to be_valid
  end

  it 'is not valid without a name' do
    user = User.create(name: 'Ruth Abreu', email: 'testing@example.com', password: 'password123')
    category = Category.new(icon: 'icon.png', author: user)
    expect(category).not_to be_valid
  end

  it 'is not valid without an icon' do
    user = User.create(name: 'Ruth Abreu', email: 'testing@example.com', password: 'password123')
    category = Category.new(name: 'Food', author: user)
    expect(category).not_to be_valid
  end

  it 'is associated with a user' do
    user = User.create(name: 'Ruth Abreu', email: 'testing@example.com', password: 'password123')
    category = Category.create(name: 'Food', icon: 'icon.png', author: user)
    expect(category.author).to eq(user)
  end

  it 'can be associated with transactions' do
    user = User.create(name: 'Ruth Abreu', email: 'testing@example.com', password: 'password123')
    category = Category.create(name: 'Food', icon: 'icon.png', author: user)
    transaction = Transaction.create(name: 'Grocery', amount: 50, author: user)

    CategoryTransaction.create(
      related_category: category,
      related_transaction: transaction
    )

    expect(category.related_transactions).to include(transaction)
  end
end
