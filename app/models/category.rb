class Category < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :category_transactions
  has_many :related_transactions, through: :category_transactions, source: :related_transaction

  validates :name, presence: true
  validates :icon, presence: true

  def total_amount
    related_transactions.sum(:amount)
  end
end
