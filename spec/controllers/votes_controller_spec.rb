require 'rails_helper'

RSpec.describe VotesController, type: :controller do

  describe '#show' do
    let (:vote_item) { FactoryBot.create(:vote_item) }
    subject { get :show, params: { tournament_id: vote_item.vote.tournament, id: vote_item.vote.id } }

      context 'when user' do
        login_user

        it_behaves_like 'controller have variables', 'tournament': Tournament
      end

      it_behaves_like 'guest'
  end

  describe '#sort' do
    let (:vote) { FactoryBot.create(:vote) }
    let (:vote_item1) { FactoryBot.create(:vote_item, vote: vote, user: @logged_user || FactoryBot.create(:user)) }
    let (:vote_item2) { FactoryBot.create(:vote_item, vote: vote, user: @logged_user || FactoryBot.create(:user)) }
    let (:vote_item3) { FactoryBot.create(:vote_item, vote: vote, user: @logged_user || FactoryBot.create(:user)) }
    let (:vote_item4) { FactoryBot.create(:vote_item, vote: vote, user: @logged_user || FactoryBot.create(:user)) }
    subject { post :sort, params: { tournament_id: vote.tournament.id, id: vote.id,
                                    user: [vote_item4.vote_user.id, vote_item3.vote_user.id, vote_item2.vote_user.id, vote_item1.vote_user.id ] } }

      context 'when user' do
        login_user

        it 'should create vote items' do
          expect{ subject }.to change{ vote.reload.vote_items.count }.to(4)
        end

        it 'should change vote items values' do
          expect{ subject }.to change{ vote_item1.reload.value }.to(1)
                          .and change{ vote_item2.reload.value }.to(2)
                          .and change{ vote_item3.reload.value }.to(3)
                          .and change{ vote_item4.reload.value }.to(4)
        end

        it_behaves_like 'controller have variables', 'tournament': Tournament
      end

      it_behaves_like 'guest'
  end
end
