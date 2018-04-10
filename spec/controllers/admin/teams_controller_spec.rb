require 'rails_helper'

RSpec.describe Admin::TeamsController, type: :controller do
  describe '#index' do
    let (:tournament) { FactoryBot.create(:tournament) }
    subject { get :index, params: { tournament_id: tournament.id } }

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

  describe '#update_teams' do
    let(:first_player) { FactoryBot.create(:user) }
    let(:second_player) { FactoryBot.create(:user) }
    let(:third_player) { FactoryBot.create(:user) }
    let(:four_player) { FactoryBot.create(:user) }
    let!(:first_team) { FactoryBot.create(:team, first_member: first_player, second_member: second_player) }
    let!(:second_team) { FactoryBot.create(:team, first_member: third_player, second_member: four_player) }
    let (:tournament) { FactoryBot.create(:tournament) }
    subject { post :update_teams, params: { tournament_id: tournament.id,
                                            teams: { "#{first_team.id}": [third_player.id, four_player.id], "#{second_team.id}": [first_player.id, second_player.id] } } }

      context 'when admin' do
        login_admin

        before do
          tournament.teams << first_team
          tournament.teams << second_team
        end

        it 'should swap players beetwen teams' do
          expect{ subject }.to change{ first_team.reload.first_member }.to(third_player).and \
                               change{ first_team.reload.second_member }.to(four_player).and \
                               change{ second_team.reload.first_member }.to(first_player).and \
                               change{ second_team.reload.second_member }.to(second_player)
        end

        it_behaves_like 'controller have variables', 'tournament': Tournament
      end

      it_behaves_like 'user on admin page'
      it_behaves_like 'guest'
  end
end
