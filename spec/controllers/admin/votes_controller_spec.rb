require 'rails_helper'

RSpec.describe Admin::VotesController, type: :controller do
  describe '#update' do
    let (:vote) { FactoryBot.create(:vote) }
    subject { patch :update, params: { tournament_id: vote.tournament.id, id: vote.id } }

    context 'when admin' do
      login_admin

      it 'should change state vote to closed' do
        expect { subject }.to change { vote.reload.aasm_state }.to('closed')
      end

      it 'should redirect to admin tournaments' do
        expect(subject).to redirect_to(admin_tournament_path(vote.tournament))
      end

      it_behaves_like 'controller have variables', 'tournament': Tournament
    end

    it_behaves_like 'user on admin page'
    it_behaves_like 'guest'
  end
end
