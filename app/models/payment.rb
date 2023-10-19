# == Schema Information
#
# Table name: payments
#
#  id         :bigint           not null, primary key
#  author_id  :bigint           not null
#  name       :string(100)      not null
#  amount     :float            not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Payment < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_many :group_payments, dependent: :destroy
  has_many :groups, through: :group_payments

  validates :name, presence: true, length: { maximum: 100 }
  validates :amount, presence: true, numericality: { greater_than: 0 }

  def total_amount_by_author(author)
    payments.where(author:).sum(:amount)
  end

  def total_amount_by_author_and_group(author, group)
    payments.where(author:, group_payments: { group: }).sum(:amount)
  end
end
