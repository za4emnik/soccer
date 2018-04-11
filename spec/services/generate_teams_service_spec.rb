require 'rails_helper'

RSpec.describe GenerateTeamsService do
  context '#initialize' do
    let(:tournament) { FactoryBot.create(:tournament) }
    subject { GenerateTeamsService.new(tournament) }

    it_behaves_like 'controller have variables', 'tournament': Tournament, 'users': ActiveRecord::Relation do
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

  context '#remove_teams' do
    let(:tournament) { FactoryBot.create(:tournament) }
    let (:team) { FactoryBot.create(:team, tournament: tournament) }
    subject { GenerateTeamsService.new(tournament) }

    it 'should remove associated teams' do
      subject.remove_teams
      expect(tournament.teams).to be_empty
    end
  end

  context '#shuffle_players' do
    let(:tournament) { FactoryBot.create(:tournament) }
    subject { GenerateTeamsService.new(tournament).shuffle_players }

    before do
      8.times { tournament.users << FactoryBot.create(:rating).user }
    end

    it 'should prepare array with players' do
      expect(subject.instance_variable_get(:@users)).not_to eq(User.last(8))
    end
  end

  context '#generate_team_name' do
    let (:first_member) { FactoryBot.create(:user, email: 's@s.s') }
    let (:second_member) { FactoryBot.create(:user, email: 'w@w.w') }
    subject do
      GenerateTeamsService.new(FactoryBot.create(:tournament))
                          .generate_team_name(first_member, second_member)
    end

    it 'should return generated name' do
      expect(subject).to eq('s@s.s_w@w.w')
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
      expect { subject }.to change { Team.count }.by(1)
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
