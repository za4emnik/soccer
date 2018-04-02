require 'rails_helper'

RSpec.describe Admin::MatchesHelper, type: :helper do
  describe '#winner?' do
    let (:match) { FactoryBot.create(:match, first_team_result: 10, second_team_result: 0) }

    it 'should return true if winner' do
      expect(helper.winner?(match, match.first_team)).to be_truthy
    end
  end
end
