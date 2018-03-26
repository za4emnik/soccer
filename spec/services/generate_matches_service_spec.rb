require 'rails_helper'

RSpec.describe GenerateMatchesService do
  context '#initialize' do
    let(:tournament) { FactoryBot.create(:tournament) }
    subject { GenerateMatchesService.new(tournament) }

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

  context '#get_number_of_regular_matches' do
    let(:tournament) { FactoryBot.create(:tournament) }
    subject { GenerateMatchesService.new(tournament) }

    before do
      10.times { tournament.users << FactoryBot.create(:user) }
    end

    it 'should return number of games' do
      expect(subject.get_number_of_regular_matches).to eq(5)
    end

    it 'returns should be integer' do
      expect(subject.get_number_of_regular_matches).to be_a_kind_of(Integer)
    end
  end

  context '#shuffle_teams' do
    let(:tournament) { FactoryBot.create(:tournament) }
    subject { GenerateMatchesService.new(tournament) }

    before do
      10.times { tournament.teams << FactoryBot.create(:team) }
    end

    it 'should shuffle teams' do
      subject.shuffle_teams()
      binding.pry
      expect(subject.instance_variable_get(:@teams)).not_to eq(tournament.teams)
    end
  end

  context '#create_regular_matches' do
    let(:tournament) { FactoryBot.create(:tournament) }
    subject { GenerateMatchesService.new(tournament) }

    before do
      16.times { tournament.teams << FactoryBot.create(:team) }
      allow(subject).to receive(:get_number_of_regular_matches).and_return(8)
    end

    it 'should create matches' do
      binding.pry
      expect { subject.create_regular_matches }.to change{ tournament.matches.count }.by(30)
    end
  end

  context '#create_teams' do
    let (:tournament) { FactoryBot.create(:tournament) }
    subject { GenerateTeamsService.new(tournament) }

    before do
      8.times { tournament.users << FactoryBot.create(:rating).user }
      subject.shuffle_players
    end

    it 'should create teams' do
      subject.create_teams
      expect(tournament.teams).not_to be_empty
    end
  end

  context '#create_team' do
    let (:tournament) { FactoryBot.create(:tournament) }
    let (:first_palyer) { FactoryBot.create(:user) }
    let (:second_player) { FactoryBot.create(:user) }
    subject { GenerateTeamsService.new(tournament).create_team('name', first_palyer, second_player) }

    it 'should create team' do
      expect { subject }.to change{ Team.count }.by(1)
    end

    it 'should create team with passed params' do
      subject
      team = Team.first
      expect(team.name).to eq('name')
      expect(team.first_member).to eq(first_palyer)
      expect(team.second_member).to eq(second_player)
    end
  end
end
