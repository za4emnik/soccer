require 'rails_helper'

RSpec.describe Admin::MatchesHelper, type: :helper do
  describe '#winner?' do
    let (:score) { FactoryBot.create(:score) }

    it 'should return true if winner' do
      expect(helper.winner?(score.match, score.team)).to be_truthy
    end
  end
end
