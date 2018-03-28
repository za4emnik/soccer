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

  describe '#show' do
    let (:match) { FactoryBot.create(:match) }
    subject { get :show, params: { tournament_id: match.tournament.id, id: match.id } }

      context 'when admin' do
        login_admin

        it_behaves_like 'controller have variables', 'tournament': Tournament,
                                                     'match': Match
      end

      it_behaves_like 'user on admin page'
      it_behaves_like 'guest'
  end

  describe '#new' do
    let (:tournament) { FactoryBot.create(:tournament) }
    subject { get :new, params: { tournament_id: tournament.id } }

      context 'when admin' do
        login_admin

        it_behaves_like 'controller have variables', 'tournament': Tournament,
                                                     'match': Match
      end

      it_behaves_like 'user on admin page'
      it_behaves_like 'guest'
  end

  describe '#edit' do
    let (:match) { FactoryBot.create(:match) }
    subject { get :edit, params: { tournament_id: match.tournament.id, id: match.id } }

      context 'when admin' do
        login_admin

        it_behaves_like 'controller have variables', 'tournament': Tournament,
                                                     'match': Match
      end

      it_behaves_like 'user on admin page'
      it_behaves_like 'guest'
  end

  describe '#create' do
    let (:tournament) { FactoryBot.create(:tournament) }
    let (:first_team) { FactoryBot.create(:team) }
    let (:second_team) { FactoryBot.create(:team) }
    subject { post :create, params: { tournament_id: tournament.id, match: { first_team_id: first_team.id, second_team_id: second_team.id } } }

      context 'when admin' do
        login_admin

        it 'should create match' do
          expect{ subject }.to change{ tournament.matches.count }.from(0).to(1)
        end

        it_behaves_like 'controller have variables', 'tournament': Tournament
      end

      it_behaves_like 'user on admin page'
      it_behaves_like 'guest'
  end

  describe '#update' do
    let (:match) { FactoryBot.create(:match) }
    subject { put :update, params: { tournament_id: match.tournament.id, id: match.id, winner: match.first_team.id } }

      context 'when admin' do
        login_admin

        it 'should update winner' do
          expect { subject }.to change{ match.scores.where(team: match.first_team).count }.from(0).to(1)
        end

        it 'should delete all scores for current match' do
          match.scores << FactoryBot.create(:score, match: match)
          subject
          expect(match.scores.count).to eq(1)
        end

        it_behaves_like 'controller have variables', 'tournament': Tournament
      end

      it_behaves_like 'user on admin page'
      it_behaves_like 'guest'
  end

  describe '#generate_matches' do
    let (:tournament) { FactoryBot.create(:tournament) }
    subject { put :generate_matches, params: { tournament_id: tournament.id } }

      context 'when admin' do
        login_admin

        before do
          2.times { tournament.teams << FactoryBot.create(:team) }
        end

        it 'should generate matches' do
          expect{ subject }.to change{ tournament.matches.count }.by(3)
        end

        it_behaves_like 'controller have variables', 'tournament': Tournament
      end

      it_behaves_like 'user on admin page'
      it_behaves_like 'guest'
  end

  describe '#sort' do
    let (:tournament) { FactoryBot.create(:tournament) }
    let (:first_match) { FactoryBot.create(:match, position: 1) }
    let (:second_match) { FactoryBot.create(:match, position: 2) }
    subject { post :sort, params: { tournament_id: tournament.id, match: [second_match.id, first_match.id] } }

    before do
      tournament.matches << first_match
      tournament.matches << second_match
    end

      context 'when admin' do
        login_admin

        it 'should update positions of matches' do
          expect{ subject }.to change{ first_match.reload.position }.from(1).to(2)
                          .and change{ second_match.reload.position }.from(2).to(1)
        end

        it_behaves_like 'controller have variables', 'tournament': Tournament
      end

      it_behaves_like 'user on admin page'
      it_behaves_like 'guest'
  end
end
