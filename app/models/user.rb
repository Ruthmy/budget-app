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
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable

  has_many :payments, foreign_key: :author_id, dependent: :destroy
  has_many :groups, foreign_key: :user_id, dependent: :destroy

  validates :name, presence: true, length: { maximum: 50 }
end
