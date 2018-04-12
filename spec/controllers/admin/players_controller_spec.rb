require 'rails_helper'

RSpec.describe Admin::PlayersController, type: :controller do
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

      it_behaves_like 'controller have variables', 'players': ActiveRecord::Relation
    end

    it_behaves_like 'user on admin page'
    it_behaves_like 'guest'
  end

  describe '#destroy' do
    let (:tournament) { FactoryBot.create(:tournament) }
    let (:user) { FactoryBot.create(:user) }
    subject { delete :destroy, params: { tournament_id: tournament.id, id: user.id } }

    before do
      tournament.users << user
    end

    context 'when admin' do
      login_admin

      it 'should delete user from current tournament' do
        expect { subject }.to change { tournament.users.count }.from(1).to(0)
      end

      it_behaves_like 'controller have variables', 'tournament': Tournament
    end

    it_behaves_like 'user on admin page'
    it_behaves_like 'guest'
  end

  describe '#create' do
    let (:tournament) { FactoryBot.create(:tournament) }
    let (:user) { FactoryBot.create(:user) }
    subject { post :create, params: { tournament_id: tournament.id, player_id: user.id } }

    context 'when admin' do
      login_admin

      it 'should change number of users in tournament' do
        expect { subject }.to change { tournament.users.count }.from(0).to(1)
      end

      it 'should assign user to curernt tournament' do
        subject
        expect(tournament.users.first).to eq(user)
      end

      it 'should not assign user if user exist' do
        tournament.users << user
        expect { subject }.not_to change { tournament.users.count }
      end

      it_behaves_like 'controller have variables', 'tournament': Tournament
    end

    it_behaves_like 'user on admin page'
    it_behaves_like 'guest'
  end

  # describe '#update_list_of_players' do
  # let (:tournament) { FactoryBot.create(:tournament) }
  # let (:array_of_users) { [FactoryBot.create(:user).id, FactoryBot.create(:user).id] }
  # subject { put :update_list_of_players, params: { tournament_id: tournament.id, users_ids: array_of_users } }

  # context 'when admin' do
  # login_admin

  # it 'should assign users to curernt tournament' do
  # expect { subject }.to change { tournament.users.count }.from(0).to(2)
  # end

  # it_behaves_like 'controller have variables', 'tournament': Tournament
  # end

  # it_behaves_like 'user on admin page'
  # it_behaves_like 'guest'
  # end
end
