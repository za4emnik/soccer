require 'rails_helper'

RSpec.describe Match, type: :model do
  describe 'associations' do
    it { should belong_to(:first_team) }
    it { should belong_to(:second_team) }
    it { should belong_to(:tournament) }
  end

  describe 'validations' do
    %i[first_team second_team].each do |field|
      it { should validate_presence_of(field) }
    end
    it { should validate_numericality_of(:first_team_result).is_less_than(11).on(:update) }
    it { should validate_numericality_of(:second_team_result).is_less_than(11).on(:update) }
  end
end
