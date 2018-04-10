require 'rails_helper'
require 'cancan/matchers'

RSpec.describe Ability, type: :model do
  describe '#initialize' do
    context 'when admin' do
      subject { Ability.new(FactoryBot.create(:admin)) }

      it { should be_able_to(:manage, :all) }
    end

    context 'when user' do
      subject { Ability.new(user) }
      let (:user) { FactoryBot.create(:user) }
      let (:vote) { FactoryBot.create(:vote, aasm_state: 'new') }
      let (:team_first) { FactoryBot.create(:team, first_member: user) }
      let (:team_second) { FactoryBot.create(:team, second_member: user) }

      it { should be_able_to(:read, Tournament, Match, Team, User) }
      it { should be_able_to(:read, vote) }
      it { should be_able_to([:edit, :update], team_first) }
      it { should be_able_to([:edit, :update], team_second) }
    end
  end
end
