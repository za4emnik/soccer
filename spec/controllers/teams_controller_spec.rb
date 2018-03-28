require 'rails_helper'

RSpec.describe TeamsController, type: :controller do

  describe '#index' do
    let (:team) { FactoryBot.create(:team) }
    subject { get :index, params: { tournament_id: team.tournament.id } }

      context 'when user' do
        login_user

        it_behaves_like 'controller have variables', 'tournament': Tournament
      end

      it_behaves_like 'guest'
  end

  describe '#show' do
    let (:team) { FactoryBot.create(:team) }
    subject { get :edit, params: { tournament_id: team.tournament.id, id: team.id } }

      context 'when user' do
        login_user

        it_behaves_like 'controller have variables', 'tournament': Tournament,
                                                     'team': Team
      end

      it_behaves_like 'guest'
  end

  describe '#update' do
    let (:team) { FactoryBot.create(:team, first_member: controller.current_user || FactoryBot.create(:user)) }
    subject { put :update, params: { tournament_id: team.tournament.id, id: team.id, team: { name: 'new name' } } }

      context 'when user' do
        login_user

        it 'should update team name' do
          expect{ subject }.to change{ team.reload.name }.to('new name')
        end

        it_behaves_like 'controller have variables', 'tournament': Tournament,
                                                     'team': Team
      end

      it_behaves_like 'guest'
  end
end
