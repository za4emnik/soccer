require 'rails_helper'
require 'aasm/rspec'

RSpec.describe Tournament, type: :model do
  describe 'validations' do
    %i[name number_of_rounds].each do |field|
      it { should validate_presence_of(field) }
    end
    it { should validate_length_of(:name).is_at_most(30).is_at_least(3) }
    it { should validate_numericality_of(:number_of_rounds).is_greater_than(0).is_less_than(5) }
  end

  describe 'associations' do
    it { should have_one(:vote) }
    it { should have_many(:teams) }
    it { should have_many(:matches) }
    it { should have_and_belong_to_many(:users) }
  end

  describe 'dependent' do
    it { should have_one(:vote).dependent(:destroy) }
    it { should have_and_belong_to_many(:users).dependent(:destroy) }
    it { should have_many(:teams).dependent(:destroy) }
    it { should have_many(:matches).dependent(:destroy) }
  end

  describe 'change of states' do
    it { expect(subject).to transition_from(:new).to(:in_process).on_event(:processed) }
    it { expect(subject).to transition_from(:in_process).to(:completed).on_event(:complete) }
  end
end
