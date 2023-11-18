# spec/models/transaction_spec.rb
require 'rails_helper'

RSpec.describe Transaction, type: :model do
  it 'is valid with valid attributes' do
    user = User.create(name: 'Ruth Abreu', email: 'testing@example.com', password: 'password123')
    transaction = Transaction.new(name: 'Grocery', amount: 50.0, author: user)
    expect(transaction).to be_valid
  end

  it 'is not valid without a name' do
    user = User.create(name: 'Ruth Abreu', email: 'testing@example.com', password: 'password123')
    transaction = Transaction.new(amount: 50.0, author: user)
    expect(transaction).not_to be_valid
  end

  it 'is not valid without an amount' do
    user = User.create(name: 'Ruth Abreu', email: 'testing@example.com', password: 'password123')
    transaction = Transaction.new(name: 'Grocery', author: user)
    expect(transaction).not_to be_valid
  end

  it 'is not valid with a non-positive amount' do
    user = User.create(name: 'Ruth Abreu', email: 'testing@example.com', password: 'password123')
    transaction = Transaction.new(name: 'Grocery', amount: -10.0, author: user)
    expect(transaction).not_to be_valid
  end

  it 'is associated with a user' do
    user = User.create(name: 'Ruth Abreu', email: 'testing@example.com', password: 'password123')
    transaction = Transaction.new(name: 'Grocery', amount: 50.0, author: user)
    expect(transaction.author).to eq(user)
  end

  it 'can be associated with categories' do
    user = User.create(name: 'Ruth Abreu', email: 'testing@example.com', password: 'password123')
    category = Category.create(name: 'Food', icon: 'icon.png', author: user)
    transaction = Transaction.new(name: 'Grocery', amount: 50.0, author: user)

    transaction.related_categories << category
    expect(transaction.related_categories).to include(category)
  end
end
