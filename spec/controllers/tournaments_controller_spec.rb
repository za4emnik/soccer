require 'rails_helper'

RSpec.describe TournamentsController, type: :controller do

  describe '#index' do
    let (:team) { FactoryBot.create(:team) }
    subject { get :index, params: { tournament_id: team.tournament.id } }

      context 'when user' do
        login_user

        it_behaves_like 'controller have variables', 'tournaments': ActiveRecord::Relation
      end

      it_behaves_like 'guest'
  end
end
