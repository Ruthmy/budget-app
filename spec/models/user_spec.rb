require 'rails_helper'

RSpec.describe User, type: :model do
  before(:all) do
    @user = User.create(name: 'User 1')
  end

  describe 'should have db columns' do
    it 'includes id, name, created_at, and updated_at' do
      expect(User.column_names).to include('id', 'name', 'created_at', 'updated_at')
    end
  end

  describe 'attributes' do
    it 'has name' do
      expect(@user.name).to eq('User 1')
    end
  end

  describe 'associations' do
    it { should have_many(:payments).with_foreign_key(:author_id).dependent(:destroy) }
    it { should have_many(:groups) }
  end

  describe 'validations' do
    it 'is invalid without a name' do
      user = User.new(name: nil)
      expect(user).to_not be_valid
    end

    it 'is invalid with a name longer than 50 characters' do
      user = User.new(name: 'a' * 51)
      expect(user).to_not be_valid
    end

    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(50) }
  end
end
