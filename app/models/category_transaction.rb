class CategoryTransaction < ApplicationRecord
  belongs_to :related_category, class_name: 'Category', foreign_key: 'category_id'
  belongs_to :related_transaction, class_name: 'Transaction', foreign_key: 'transaction_id'
end
