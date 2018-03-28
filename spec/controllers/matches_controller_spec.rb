require 'rails_helper'

RSpec.describe MatchesController, type: :controller do

  describe '#index' do
    let (:match) { FactoryBot.create(:match) }
    subject { get :index, params: { tournament_id: match.tournament.id } }

      context 'when user' do
        login_user

        it_behaves_like 'controller have variables', 'tournament': Tournament,
                                                     'matches': ActiveRecord::Relation
      end

      it_behaves_like 'guest'
  end

  describe '#show' do
    let (:match) { FactoryBot.create(:match) }
    subject { get :show, params: { tournament_id: match.tournament.id, id: match.id } }

      context 'when user' do
        login_user

        it_behaves_like 'controller have variables', 'tournament': Tournament,
                                                     'match': Match
      end

      it_behaves_like 'guest'
  end
end
