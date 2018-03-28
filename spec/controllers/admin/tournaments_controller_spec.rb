require 'rails_helper'

RSpec.describe Admin::TournamentsController, type: :controller do

  describe '#index' do
    subject { get :index }

      context 'when admin' do
        login_admin

        it_behaves_like 'controller have variables', 'tournaments': ActiveRecord::Relation
      end

      it_behaves_like 'user on admin page'
      it_behaves_like 'guest'
  end

  describe '#show' do
    subject { get :show, params: { id: FactoryBot.create(:tournament).id } }

      context 'when admin' do
        login_admin

        it_behaves_like 'controller have variables', 'tournament': Tournament
      end

      it_behaves_like 'user on admin page'
      it_behaves_like 'guest'
  end

  describe '#new' do
    subject { get :new }

      context 'when admin' do
        login_admin

        it_behaves_like 'controller have variables', 'tournament': Tournament
      end

      it_behaves_like 'user on admin page'
      it_behaves_like 'guest'
  end

  describe '#edit' do
    subject { get :edit, params: { id: FactoryBot.create(:tournament).id } }

      context 'when admin' do
        login_admin

        it_behaves_like 'controller have variables', 'tournament': Tournament
      end

      it_behaves_like 'user on admin page'
      it_behaves_like 'guest'
  end

  describe '#create' do
    let (:tournament_attributes) { FactoryBot.attributes_for(:tournament) }
    subject { post :create, params: { tournament: tournament_attributes } }

    context 'when admin' do
      login_admin

      it 'should create new tournament' do
        expect { subject }.to change{ Tournament.count }.from(0).to(1)
      end

      it_behaves_like 'controller have variables', 'tournament': Tournament
    end

    it_behaves_like 'user on admin page'
    it_behaves_like 'guest'
  end

  describe '#update' do
    let (:tournament) { FactoryBot.create(:tournament) }
    let (:tournament_attributes) { FactoryBot.attributes_for(:tournament) }
    subject { put :update, params: { id: tournament.id, tournament: tournament_attributes } }

      context 'when admin' do
        login_admin

        it 'should update tournament\'s values ' do
          expect { subject }.to change{ Tournament.find(tournament.id).name }         .to(tournament_attributes[:name])
                                change{ Tournament.find(tournament).number_of_rounds }.to(tournament_attributes[:number_of_rounds])
        end

        it_behaves_like 'controller have variables', 'tournament': Tournament
      end

      it_behaves_like 'user on admin page'
      it_behaves_like 'guest'
  end

  describe '#destroy' do
    let! (:tournament) { FactoryBot.create(:tournament) }
    subject { delete :destroy, params: { id: tournament.id } }

    context 'when admin' do
      login_admin

      it 'should delete tournament' do
        expect{ subject }.to change{ Tournament.count }.by(-1)
      end

      it_behaves_like 'redirect to', 'admin_tournaments_path'
    end

    it_behaves_like 'user on admin page'
    it_behaves_like 'guest'
  end

  describe '#done' do
    let! (:tournament) { FactoryBot.create(:tournament) }
    subject { post :done, params: { id: tournament.id } }

    context 'when admin' do
      login_admin

      before do
        tournament.processed!
      end

      it 'should done tournament' do
        expect{ subject }.to change{ tournament.reload.aasm_state }.to('completed')
      end

      it_behaves_like 'redirect to', 'admin_tournaments_path'
    end

    it_behaves_like 'user on admin page'
    it_behaves_like 'guest'
  end
end
