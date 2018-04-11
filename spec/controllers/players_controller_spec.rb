require 'rails_helper'

RSpec.describe PlayersController, type: :controller do
  describe '#index' do
    let (:match) { FactoryBot.create(:match) }
    subject { get :index, params: { tournament_id: match.tournament.id } }

    context 'when user' do
      login_user

      it_behaves_like 'controller have variables', 'tournament': Tournament
    end

    it_behaves_like 'guest'
  end
end
