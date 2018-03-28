require 'rails_helper'
require 'aasm/rspec'

RSpec.describe Tournament, type: :model do
  describe 'associations' do
    it { should have_one(:vote) }
    it { should have_and_belong_to_many(:users) }
    it { should have_many(:teams) }
    it { should have_many(:matches) }
  end

  describe 'dependent' do
    it { should have_one(:vote).dependent(:destroy) }
    it { should have_and_belong_to_many(:users).dependent(:destroy) }
    it { should have_many(:teams).dependent(:destroy) }
  end

  describe 'change of states' do
    it { expect(subject).to transition_from(:new).to(:in_process).on_event(:processed) }
    it { expect(subject).to transition_from(:in_process).to(:completed).on_event(:complete) }
  end
end
