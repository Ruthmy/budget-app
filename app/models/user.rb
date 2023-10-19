# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  name       :string(50)       not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
  has_many :payments, foreign_key: :author_id, dependent: :destroy
  has_many :group_payments, through: :payments
  has_many :groups, through: :group_payments

  validates :name, presence: true, length: { maximum: 50 }
end
