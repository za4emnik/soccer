require 'rails_helper'

RSpec.describe Tournament, type: :model do
  describe 'associations' do
    it { should have_one(:vote) }
    it { should have_and_belong_to_many(:users) }
    it { should have_many(:teams) }
  end

  describe 'dependent' do
    it { should have_one(:vote).dependent(:destroy) }
    it { should have_and_belong_to_many(:users).dependent(:destroy) }
    it { should have_many(:teams).dependent(:destroy) }
  end
end
