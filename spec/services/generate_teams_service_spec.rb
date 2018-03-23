require 'rails_helper'

RSpec.describe GenerateTeamsService do
  context '#initialize' do
    let(:tournament) { FactoryBot.create(:tournament) }
    subject { GenerateTeamsService.new(tournament) }

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

  context '#remove_teams' do
    let(:tournament) { FactoryBot.create(:tournament) }
    subject { GenerateTeamsService.new(tournament).remove_teams }

    it 'should remove associated teams' do
      expect(subject.instance_variable_get(:@tournament).teams).to eq(nil)
      subject.generate
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
    let (:first_member) { FactoryBot.create(:user) }
    let (:second_member) { FactoryBot.create(:user) }
    subject { GenerateTeamsService.new(FactoryBot.create(:tournament))
                                  .generate_team_name(first_member, second_member) }

    it 'should return generated name' do
      expect(subject).to eq("#{first_member.email}_#{second_member.email}")
    end
  end

  context '#create_teams' do
    let(:tournament) { FactoryBot.create(:tournament) }
    subject { GenerateTeamsService.new(User.last(8)).create_teams }

    before do
      8.times { tournament.users << FactoryBot.create(:rating).user }
    end

    it 'should create teams' do
      expect(subject.instance_variable_get(:@users)).not_to eq(User.last(8))
    end
  end
end
