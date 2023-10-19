require 'rails_helper'

RSpec.describe Group, type: :model do
  before(:all) do
    @group = Group.create(name: 'Group 1', icon: 'icon1')
  end

  describe 'should have db columns' do
    it 'includes id, name, icon, created_at, and updated_at' do
      expect(Group.column_names).to include('id', 'name', 'icon', 'created_at', 'updated_at')
    end
  end

  describe 'attributes' do
    it 'has name' do
      expect(@group.name).to eq('Group 1')
    end

    it 'has icon' do
      expect(@group.icon).to eq('icon1')
    end
  end

  describe 'associations' do
    it 'has and belongs to many payments' do
      expect(@group).to have_and_belong_to_many(:payments)
    end

    it 'belongs to a user' do
      expect(@group).to belong_to(:user)
    end
  end

  describe 'validations' do
    it 'is invalid without a name' do
      group = Group.new(name: nil, icon: 'icon1')
      expect(group).to_not be_valid
    end

    it 'is invalid with a name longer than 50 characters' do
      group = Group.new(name: 'a' * 51, icon: 'icon1')
      expect(group).to_not be_valid
    end

    it 'is invalid without an icon' do
      group = Group.new(name: 'Group 1', icon: nil)
      expect(group).to_not be_valid
    end

    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(50) }
    it { should validate_presence_of(:icon) }
  end
end
