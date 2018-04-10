require 'rails_helper'

RSpec.describe Team, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:first_member) }
    it { should validate_presence_of(:second_member) }
    it { should validate_presence_of(:tournament) }
    it { should validate_length_of(:name).is_at_most(30).is_at_least(3) }
  end

  describe 'associations' do
    it { should belong_to(:first_member) }
    it { should belong_to(:second_member) }
    it { should belong_to(:tournament) }
    it { should have_many(:first_matches) }
    it { should have_many(:second_matches) }
  end

  describe 'scopes' do
    it 'should order by id by default' do
      5.times { FactoryBot.create(:team) }
      expect(Team.all).to eq(Team.all.order(:id))
    end
  end
end
