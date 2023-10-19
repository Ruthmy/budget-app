# == Schema Information
#
# Table name: group_payments
#
#  id               :bigint           not null, primary key
#  group_id         :bigint           not null
#  payment_id       :bigint           not null
#  transaction_type :string(50)       not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class GroupPayment < ApplicationRecord
  belongs_to :group, foreign_key: 'group_id'
  belongs_to :payment, foreign_key: 'payment_id'

  validates :transaction_type, presence: true, length: { maximum: 50 }
end
