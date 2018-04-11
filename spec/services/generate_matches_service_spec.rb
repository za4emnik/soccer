require 'rails_helper'

RSpec.describe GenerateMatchesService do
  context '#initialize' do
    let(:tournament) { FactoryBot.create(:tournament) }
    subject { GenerateMatchesService.new(tournament) }

    it_behaves_like 'controller have variables', 'tournament': Tournament do
      let(:controller) { subject }
    end
  end

  context '#remove_matches' do
    let(:tournament) { FactoryBot.create(:tournament) }
    subject { GenerateMatchesService.new(tournament) }

    before do
      5.times { tournament.matches << FactoryBot.create(:match) }
    end

    it 'should remove all matches' do
      expect { subject.remove_matches }.to change { tournament.matches.count }.to(0)
    end

    it_behaves_like 'controller have variables', 'tournament': Tournament do
      let(:controller) { subject }
    end
  end

  context '#generate' do
    let(:tournament) { FactoryBot.create(:tournament) }
    subject { GenerateTeamsService.new(tournament) }

    it 'should receive remove_teams method' do
      expect(subject).to receive(:remove_teams)
      subject.generate
    end

    it 'should receive shuffle_players method' do
      2.times { FactoryBot.create(:user) }
      subject.instance_variable_set(:@users, User.first(2))
      expect(subject).to receive(:shuffle_players)
      subject.generate
    end

    it 'should receive create_teams method' do
      expect(subject).to receive(:create_teams)
      subject.generate
    end

    it_behaves_like 'controller have variables', 'tournament': Tournament do
      let(:controller) { subject }
    end
  end

  context '#number_of_regular_matches' do
    let(:tournament) { FactoryBot.create(:tournament) }
    subject { GenerateMatchesService.new(tournament) }

    before do
      10.times { tournament.teams << FactoryBot.create(:team, tournament: tournament) }
    end

    it 'should return number of games' do
      expect(subject.number_of_regular_matches).to eq(5)
    end

    it 'returns should be integer' do
      expect(subject.number_of_regular_matches).to be_a_kind_of(Integer)
    end
  end

  context '#shuffle_teams' do
    let(:tournament) { FactoryBot.create(:tournament) }
    subject { GenerateMatchesService.new(tournament) }

    before do
      10.times { tournament.teams << FactoryBot.create(:team) }
    end

    it 'should shuffle teams' do
      subject.shuffle_teams
      expect(subject.instance_variable_get(:@teams)).not_to eq(tournament.teams)
    end
  end

  context '#create_regular_matches' do
    let(:tournament) { FactoryBot.create(:tournament) }
    subject { GenerateMatchesService.new(tournament) }

    before do
      4.times { tournament.teams << FactoryBot.create(:team) }
      allow(subject).to receive(:number_of_regular_matches).and_return(2)
    end

    it 'should create match' do
      matches = tournament.number_of_rounds * 2
      expect { subject.create_regular_matches }.to change { tournament.matches.count }.by(matches)
    end
  end

  context '#create_match' do
    let (:tournament) { FactoryBot.create(:tournament) }
    let (:first_team) { FactoryBot.create(:team) }
    let (:second_team) { FactoryBot.create(:team) }
    subject do
      GenerateMatchesService.new(tournament)
                            .create_match(first_team, second_team)
    end

    it 'should create match with passing params' do
      expect { subject }.to change { Match.count }.by(1)
    end

    it 'should create match with passing params' do
      subject
      match = Match.last
      expect(match.first_team).to eq(first_team)
      expect(match.second_team).to eq(second_team)
      expect(match.tournament).to eq(tournament)
    end
  end
end
