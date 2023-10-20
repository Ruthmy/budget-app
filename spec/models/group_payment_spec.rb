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
require 'rails_helper'

RSpec.describe GroupPayment, type: :model do
  before(:all) do
    @group_payment = GroupPayment.create(group_id: 1, payment_id: 1, transaction_type: 'payment')
  end

  describe 'should have db columns' do
    it 'includes id, group_id, payment_id, transaction_type, created_at, and updated_at' do
      expect(GroupPayment.column_names).to include('id', 'group_id', 'payment_id', 'transaction_type', 'created_at',
                                                   'updated_at')
    end
  end

  describe 'attributes' do
    it 'has group_id' do
      expect(@group_payment.group_id).to eq(1)
    end

    it 'has payment_id' do
      expect(@group_payment.payment_id).to eq(1)
    end

    it 'has transaction_type' do
      expect(@group_payment.transaction_type).to eq('payment')
    end
  end

  describe 'associations' do
    it { should belong_to(:group) }
    it { should belong_to(:payment) }
  end

  describe 'validations' do
    it 'is invalid without a group_id' do
      group_payment = GroupPayment.new(group_id: nil)
      expect(group_payment).to_not be_valid
    end

    it 'is invalid without a payment_id' do
      group_payment = GroupPayment.new(payment_id: nil)
      expect(group_payment).to_not be_valid
    end

    it 'is invalid without a transaction_type' do
      group_payment = GroupPayment.new(transaction_type: nil)
      expect(group_payment).to_not be_valid
    end

    it 'is invalid with a transaction_type longer than 50 characters' do
      group_payment = GroupPayment.new(transaction_type: 'a' * 51)
      expect(group_payment).to_not be_valid
    end

    it { should validate_presence_of(:group_id) }
    it { should validate_presence_of(:payment_id) }
    it { should validate_presence_of(:transaction_type) }
    it { should validate_length_of(:transaction_type).is_at_most(50) }
  end
end
