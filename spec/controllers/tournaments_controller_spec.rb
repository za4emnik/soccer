require 'rails_helper'

RSpec.describe TournamentsController, type: :controller do
  describe '#index' do
    let (:team) { FactoryBot.create(:team) }
    subject { get :index }

    context 'when user' do
      login_user

      it_behaves_like 'controller have variables', 'tournaments': ActiveRecord::Relation
    end

    it_behaves_like 'guest'
  end

  describe '#show' do
    let (:team) { FactoryBot.create(:team) }
    subject { get :show, params: { id: team.tournament.id } }

    context 'when user' do
      login_user

      before do
        team.tournament.matches << FactoryBot.create(:match, first_team: team, match_type: Match.match_types[:one_eight])
        team.tournament.matches << FactoryBot.create(:match, first_team: team, match_type: Match.match_types[:one_four])
        team.tournament.matches << FactoryBot.create(:match, first_team: team, match_type: Match.match_types[:one_two])
        team.tournament.matches << FactoryBot.create(:match, first_team: team, match_type: Match.match_types[:final])
      end

      it_behaves_like 'controller have variables', 'tournament': Tournament, 'regular_teams': ActiveRecord::Relation,
                                                   'one_eight': Array, 'one_four': Array,
                                                   'one_two': Array, 'final': Match
    end

    it_behaves_like 'guest'
  end
end
