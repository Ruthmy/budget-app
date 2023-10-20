# == Schema Information
#
# Table name: groups
#
#  id         :bigint           not null, primary key
#  name       :string(50)       not null
#  icon       :string           not null
#  user_id    :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Group < ApplicationRecord
  belongs_to :user, foreign_key: 'user_id'
  has_and_belongs_to_many :payments, foreign_key: 'payment_id',
                                     join_table: 'group_payments',
                                     association_foreign_key: 'group_id'

  validates :name, presence: true, length: { maximum: 50 }
  validates :icon, presence: true
end
