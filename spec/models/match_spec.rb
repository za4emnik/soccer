require 'rails_helper'

RSpec.describe Match, type: :model do

  describe 'enum' do
    it do
      should define_enum_for(:match_type).
        with([:regular, :one_eight, :one_four, :one_two, :third_place, :final])
    end
  end

  describe 'validations' do
    %i[first_team second_team].each do |field|
      it { should validate_presence_of(field) }
    end
    it { should validate_numericality_of(:first_team_result).is_less_than(11).on(:update) }
    it { should validate_numericality_of(:second_team_result).is_less_than(11).on(:update) }
  end

  describe 'associations' do
    it { should belong_to(:first_team) }
    it { should belong_to(:second_team) }
    it { should belong_to(:tournament) }
  end

  describe 'scopes' do
    it '#one_eight_matches should return 16 items' do
      17.times { FactoryBot.create(:match, match_type: Match.match_types[:one_eight]) }
      expect(Match.one_eight_matches.size).to eq(16)
    end

    it '#one_four_matches should return 8 items' do
      9.times { FactoryBot.create(:match, match_type: Match.match_types[:one_four]) }
      expect(Match.one_four_matches.size).to eq(8)
    end

    it '#one_two_matches should return 4 items' do
      5.times { FactoryBot.create(:match, match_type: Match.match_types[:one_two]) }
      expect(Match.one_two_matches.size).to eq(4)
    end

    it '#final_match should return 1 item' do
      5.times { FactoryBot.create(:match, match_type: Match.match_types[:final]) }
      expect(Match.final_match).to be_a(Match)
    end

    it 'should default sort by position' do
      5.times { FactoryBot.create(:match) }
      expect(Match.all).to eq(Match.all.order(:position))
    end
  end

  describe '#points_for_victory' do
    it 'should return number of points for victory' do
      expect(Match.points_for_victory).to eq(3)
    end
  end
end
