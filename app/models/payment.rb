# == Schema Information
#
# Table name: payments
#
#  id         :bigint           not null, primary key
#  author_id  :bigint           not null
#  name       :string(100)      not null
#  amount     :float            not null
#  group_id   :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Payment < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_and_belongs_to_many :groups, foreign_key: 'group_id',
                                   join_table: 'group_payments',
                                   association_foreign_key: 'payment_id'

  validates :name, presence: true, length: { maximum: 100 }
  validates :amount, presence: true, numericality: { greater_than: 0 }
end
