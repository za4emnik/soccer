require 'rails_helper'

RSpec.describe Admin::MatchesController, type: :controller do
  describe '#index' do
    let (:match) { FactoryBot.create(:match) }
    subject { get :index, params: { tournament_id: match.tournament.id } }

      context 'when admin' do
        login_admin

        it_behaves_like 'controller have variables', 'tournament': Tournament
      end

      it_behaves_like 'user on admin page'
      it_behaves_like 'guest'
  end

  describe '#new' do
    let (:tournament) { FactoryBot.create(:tournament) }
    subject { get :new, params: { tournament_id: tournament.id } }

      context 'when admin' do
        login_admin

        it_behaves_like 'controller have variables', 'tournament': Tournament
      end

      it_behaves_like 'user on admin page'
      it_behaves_like 'guest'
  end

  describe '#generate_teams' do
    let (:tournament) { FactoryBot.create(:tournament) }
    subject { put :generate_teams, params: { tournament_id: tournament.id } }

      context 'when admin' do
        login_admin

        before do
          2.times { tournament.users << FactoryBot.create(:rating).user }
        end

        it 'should generate teams' do
          expect{ subject }.to change{ tournament.teams.count }.by(1)
        end

        it_behaves_like 'controller have variables', 'tournament': Tournament
      end

      it_behaves_like 'user on admin page'
      it_behaves_like 'guest'
  end
end
