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
require 'rails_helper'

RSpec.describe Payment, type: :model do
  # before all clean the data base
  before(:each) do
    DatabaseCleaner.clean_with(:truncation)
    User.destroy_all
    Payment.destroy_all
    Group.destroy_all
    GroupPayment.destroy_all
  end

  describe 'associations' do
    it { should belong_to(:author).class_name('User').with_foreign_key(:author_id) }
    it { should have_and_belong_to_many(:groups) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(100) }
    it { should validate_presence_of(:amount) }
    it { should validate_numericality_of(:amount).is_greater_than(0) }
  end
end
