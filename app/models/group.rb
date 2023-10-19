# == Schema Information
#
# Table name: groups
#
#  id         :bigint           not null, primary key
#  name       :string(50)       not null
#  icon       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Group < ApplicationRecord
  has_many :group_payments, dependent: :destroy
  has_many :payments, through: :group_payments
  belongs_to :author, class_name: 'User'

  validates :name, presence: true, length: { maximum: 50 }
  validates :icon, presence: true
end
