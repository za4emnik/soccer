require 'rails_helper'

RSpec.describe Admin::MatchesHelper, type: :helper do
  describe '#winner?' do
    let (:match) { FactoryBot.create(:match, first_team_result: 10, second_team_result: 0) }

    it 'should return true if winner' do
      expect(helper.winner?(match, match.first_team)).to be_truthy
    end
  end

  describe '#winner' do
    let (:match) { FactoryBot.create(:match, first_team_result: 10, second_team_result: 0) }

    it 'should return winner team name' do
      expect(helper.winner(match)).to eq(match.first_team.name)
    end

    it 'should return not playes yet if match not played' do
      match = FactoryBot.create(:match, first_team_result: nil, second_team_result: nil)
      expect(helper.winner(match)).to eq('not played yet')
    end

    it 'should return dead heat if results equal' do
      match = FactoryBot.create(:match, first_team_result: 5, second_team_result: 5)
      expect(helper.winner(match)).to eq('dead heat')
    end
  end
end
