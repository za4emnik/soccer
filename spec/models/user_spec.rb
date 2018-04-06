require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:ratings) }
    it { should have_and_belong_to_many(:tournaments) }
  end

  describe 'before create' do
    subject { FactoryBot.create(:user) }

    it 'should generate rating for new user' do
      expect(subject.initial_rating).not_to be_nil
    end

    it 'should generate rating roughly 70% from all users' do
      allow(Rating).to receive(:average).and_return(10)
      expect(subject.initial_rating).to eq(6)
    end
  end
end
