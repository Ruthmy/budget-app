class Transaction < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :category_transactions
  has_many :related_categories, through: :category_transactions, source: :related_category

  validates :name, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
end
